import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:tutorial/Controllers/profile_controller.dart';
import '../consts.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.updateUserId(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: const Icon(Icons.person_2_outlined),
              actions: const [
                Icon(
                  Icons.more_horiz,
                  size: 20,
                )
              ],
              title: Text(
                controller.user["name"],
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        ClipOval(
                            child: CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: controller.user["profilePhoto"],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, e) =>
                              const Icon(Icons.error),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.user["followers"],
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user["following"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Following",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user["likes"],
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Likes",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.uid == authController.uuser.uid) {
                          authController.signOut();
                        } else {
                          controller.followUser();
                        }
                      },
                      child: Center(
                        child: Text(
                          widget.uid == authController.uuser.uid
                              ? 'Sign Out'
                              : controller.user['isFollowing']
                                  ? 'Unfollow'
                                  : 'Follow',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      itemCount: controller.user['thumbnail'].length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1, mainAxisSpacing: 5
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String thumbnail = controller.user['thumbnail'][index];
                        return CachedNetworkImage(imageUrl: thumbnail, fit: BoxFit.cover,);
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
