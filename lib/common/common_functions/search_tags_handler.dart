

Map<String, dynamic> userSearchTagsHandler({
  required String name,
  required String email,
}) {
  Map<String, dynamic> searchTags = {};

  // Function to generate all permutations of a string
  List<String> generatePermutations(String str) {
    List<String> permutations = [];
    for (int i = 0; i < str.length; i++) {
      for (int j = i + 1; j <= str.length; j++) {
        permutations.add(str.substring(i, j).toLowerCase());
      }
    }
    return permutations;
  }
  if (name.isNotEmpty) {
    name.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (email.isNotEmpty) {
    email.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  return searchTags;
}

Map<String, dynamic> productSearchTagHandler({
  required String productName,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  productName.trim().split(' ').forEach((val) {
    searchTags[val.toLowerCase()] = true;
  });

  return searchTags;
}

// seller service search tags handler

Map<String, dynamic> sellerServiceSearchTagsHandler({
  required String serviceName,
  required String subServiceName,
  required String sellerName,
  required String description,
  required String subServiceDes,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
List<String> generatePermutations(String str) {
    List<String> permutations = [];
    for (int i = 0; i < str.length; i++) {
      for (int j = i + 1; j <= str.length; j++) {
        permutations.add(str.substring(i, j).toLowerCase());
      }
    }
    return permutations;
  }
  if (serviceName.isNotEmpty) {
    serviceName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (subServiceName.isNotEmpty) {
    subServiceName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (sellerName.isNotEmpty) {
    sellerName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (description.isNotEmpty) {
    description.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (subServiceDes.isNotEmpty) {
    subServiceDes.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  return searchTags;
}

Map<String, dynamic> AdSearchTagsHandler({
  required String title,
  required String categoryName,
  required String sellerName,
  required String description,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
List<String> generatePermutations(String str) {
    List<String> permutations = [];
    for (int i = 0; i < str.length; i++) {
      for (int j = i + 1; j <= str.length; j++) {
        permutations.add(str.substring(i, j).toLowerCase());
      }
    }
    return permutations;
  }
  if (title.isNotEmpty) {
    title.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }
  if (categoryName.isNotEmpty) {
    categoryName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }
  if (sellerName.isNotEmpty) {
    sellerName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }
  if (description.isNotEmpty) {
    description.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  return searchTags;
}

Map<String, dynamic> serviceSearchTag({
  required String name,
  required String des,
}) {
  Map<String, dynamic> searchTags = {};

  // Function to generate all permutations of a string
  List<String> generatePermutations(String str) {
    List<String> permutations = [];
    for (int i = 0; i < str.length; i++) {
      for (int j = i + 1; j <= str.length; j++) {
        permutations.add(str.substring(i, j).toLowerCase());
      }
    }
    return permutations;
  }

  if (name.isNotEmpty) {
    name.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (des.isNotEmpty) {
    des.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  return searchTags;
}
