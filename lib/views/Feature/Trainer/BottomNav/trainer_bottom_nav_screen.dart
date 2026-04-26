import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/AppColor/app_colors.dart';
import '../Schedule/schedule_screen.dart';

class TrainerBottomNavScreen extends StatefulWidget {
  final int initialIndex;
  const TrainerBottomNavScreen({super.key, this.initialIndex = 0});

  @override
  State<TrainerBottomNavScreen> createState() => _TrainerBottomNavScreenState();
}

class CustomNotchedRectangle extends NotchedShape {
  final double margin;
  const CustomNotchedRectangle(this.margin);

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest != null) {
      guest = guest.shift(Offset(-margin, 0));
    }
    return const CircularNotchedRectangle().getOuterPath(host, guest);
  }
}

class _TrainerBottomNavScreenState extends State<TrainerBottomNavScreen> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Placeholder pages for demonstration
  final List<Widget> _pages = [
    const Scaffold(body: Center(child: Text("Home"))),
    const Scaffold(body: Center(child: Text("Classes"))),
    const ScheduleScreen(),
    const Scaffold(body: Center(child: Text("Groups"))),
    const Scaffold(body: Center(child: Text("Trainer Profile"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      extendBody: true,
      body: _pages[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.actionPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => _onItemTapped(2),
        child: const Icon(Icons.event_available, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: BottomAppBar(
              elevation: 0,
              color: Colors.white,
              shape: CustomNotchedRectangle(16.w),
              notchMargin: 10,
              child: SizedBox(
                height: 75.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(icon: Icons.home_filled, index: 0),
                    _buildNavItem(icon: Icons.fitness_center_rounded, index: 1),
                    SizedBox(width: 48.w),
                    _buildNavItem(icon: Icons.people_rounded, index: 3),
                    _buildNavItem(icon: Icons.person_rounded, index: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.actionPrimary.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: isSelected ? AppColors.actionPrimary : Colors.grey.shade500,
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 24.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.actionPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
