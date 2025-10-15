import 'package:flutter/material.dart';

// Custom Header Widget - Có thể tái sử dụng
class CustomAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? userAvatarUrl;
  final String? userName;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSettingsTap;
  final bool showNotificationBadge;
  final int notificationCount;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;
  final bool showGreeting;
  final String? customGreeting;

  const CustomAppHeader({
    super.key,
    this.userAvatarUrl,
    this.userName,
    this.onAvatarTap,
    this.onNotificationTap,
    this.onSettingsTap,
    this.showNotificationBadge = false,
    this.notificationCount = 0,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.elevation = 1.0,
    this.showGreeting = true,
    this.customGreeting,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Avatar và greeting section
              Expanded(
                child: GestureDetector(
                  onTap: onAvatarTap,
                  child: Row(
                    children: [
                      // Avatar với decoration
                      _buildAvatar(),
                      const SizedBox(width: 12),
                      
                      // Greeting section
                      if (showGreeting) _buildGreetingSection(),
                    ],
                  ),
                ),
              ),
              
              // Action buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey[200],
        backgroundImage: userAvatarUrl != null 
          ? NetworkImage(userAvatarUrl!) 
          : null,
        child: userAvatarUrl == null
          ? Icon(
              Icons.person,
              size: 26,
              color: Colors.grey[600],
            )
          : null,
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customGreeting ?? _getGreeting(),
            style: TextStyle(
              fontSize: 12,
              color: textColor?.withOpacity(0.6) ?? Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          if (userName != null) ...[
            const SizedBox(height: 2),
            Text(
              userName!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Notification button
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: textColor,
              ),
              onPressed: onNotificationTap,
            ),
            // Notification badge
            if (showNotificationBadge && notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    notificationCount > 99 ? '99+' : notificationCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        
        // Settings button
        IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: textColor,
          ),
          onPressed: onSettingsTap,
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Chào buổi sáng';
    } else if (hour < 17) {
      return 'Chào buổi chiều'; 
    } else {
      return 'Chào buổi tối';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);
}