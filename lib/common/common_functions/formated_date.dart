import 'package:intl/intl.dart';

String formatDuration(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  if (now == dateTime) {
    return 'Just Now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '${months == 1 ? 'one month' : '$months months'} ago';
  } else {
    final years = difference.inDays ~/ 365;
    return '${years == 1 ? 'one year' : '$years years'} ago';
  }
}

String formatMessageDate(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  if (now == dateTime) {
    return 'Just Now';
  }
  // else if (difference.inMinutes < 60) {
  //   final formatter = DateFormat('mm');
  //   return '${formatter.format(dateTime)} min'; //'${difference.inMinutes} minutes ago';
  // }
  else if (difference.inHours < 24) {
    return DateFormat('h:mm a').format(dateTime);
  } else if (difference.inDays < 30) {
    return DateFormat('d, h a').format(dateTime);
  } else if (difference.inDays < 365) {
    return DateFormat('d, MM').format(dateTime);
  } else {
    // final years = difference.inDays ~/ 365;
    return DateFormat('MM.yyyy').format(dateTime);
  }
}

String formatDate(DateTime dateTime) {
  final formatter = DateFormat('MMMM d, yyyy');
  return formatter.format(dateTime);
}

String formatDateAndTime(DateTime dateTime) {
  final formatter = DateFormat('d.MM.yyyy h:mm');
  return formatter.format(dateTime);
}

String formatPublishedDate(DateTime dateTime) {
  final formatter = DateFormat('d MMMM yyyy');
  return formatter.format(dateTime);
}

String formatDayOnly(DateTime dateTime) {
  final formatter = DateFormat('E');
  return formatter.format(dateTime);
}

String formatDateOnly(DateTime dateTime) {
  final formatter = DateFormat('d');
  return formatter.format(dateTime);
}

String formatMonthOnly(DateTime dateTime) {
  final formatter = DateFormat('MMMM');
  return formatter.format(dateTime);
}

String formatTime(DateTime dateTime) {
  final formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}

String formatAudioMessageDuration(Duration? duration) {
  if (duration == null) return "00:00";

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  // String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inMinutes)}:$twoDigitSeconds";
}

// String formatTimeSecond(int seconds) {
//   final minutes = (seconds / 60).floor();
//   final remainingSeconds = seconds % 60;
//   return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
// }
///please write the code for the function formatTimeSecond hours, minutes and seconds
String formatTimeSecond(int seconds) {
  final hours = (seconds / 3600).floor();
  final minutes = ((seconds % 3600) / 60).floor();
  final remainingSeconds = seconds % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
