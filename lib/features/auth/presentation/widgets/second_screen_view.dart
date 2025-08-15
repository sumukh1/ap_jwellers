import 'package:flutter/material.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/features/auth/presentation/pages/login_page.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/AppImages.dart';
import 'package:myapp/static/AppNavigator.dart';

class SecondScreenView extends StatefulWidget {
  const SecondScreenView({super.key});

  @override
  State<SecondScreenView> createState() => _SecondScreenViewState();
}

class _SecondScreenViewState extends State<SecondScreenView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_PageData> pages = const [
    _PageData(
      imagePath: AppImages.women,
      title: "Student Management System",
      description:
          "A student-friendly portal to manage attendance, view assignments and fee slips, check results, and stay updated with school announcements—all in one place.",
    ),
    _PageData(
      imagePath: AppImages.work,
      title: "Teacher Management System",
      description:
          "A dedicated platform for teachers to manage classes, track student progress, record attendance, and share academic resources seamlessly.",
    ),
    _PageData(
      imagePath: AppImages.books1,
      title: "Course Management System",
      description:
          "Efficiently manage academic courses, subjects, and lesson content for streamlined teaching and learning.",
    ),
  ];

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) {
          final page = pages[index];

          return Stack(
            children: [
              // Full-screen image
              Positioned.fill(
                child: Image.asset(
                  page.imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // Overlapping white card
              Positioned(
                top: height * 0.60,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: width,
                  padding: EdgeInsets.fromLTRB(
                    width * 0.06,
                    height * 0.03,
                    width * 0.06,
                    MediaQuery.of(context).padding.bottom + 16,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.buttonText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Styles.gap10,
                        Text(
                          page.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Styles.gap20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pages.length,
                            (dotIndex) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotIndex == _currentPage
                                    ? AppColors.buttonText
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        Styles.gap32,
                        Row(
                          children: [
                            if (_currentPage > 0)
                              Expanded(
                                child: TransButton(
                                  label: "Back",
                                  onTap: _previousPage,
                                  backgroundColor: Colors.transparent,
                                  textColor: AppColors.buttonText,
                                  borderColor: AppColors.grey,
                                ),
                              ),
                            if (_currentPage > 0) const SizedBox(width: 12),
                            Expanded(
                              child: Button(
                                label: _currentPage == pages.length - 1
                                    ? "Finish"
                                    : "Next",
                                onTap: () {
                                  if (_currentPage == pages.length - 1) {
                                    AppNavigator.push(
                                        context, LoginPage.route());
                                  } else {
                                    _nextPage();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PageData {
  final String imagePath;
  final String title;
  final String description;

  const _PageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
