class Videosres {
  Videosres({
    required this.videos,
    required this.q,
    required this.status,
  });
  late final List<Videos> videos;
  late final String q;
  late final String status;
  
  Videosres.fromJson(Map<String, dynamic> json){
    videos = List.from(json['videos']).map((e)=>Videos.fromJson(e)).toList();
    q = json['q'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['videos'] = videos.map((e)=>e.toJson()).toList();
    _data['q'] = q;
    _data['status'] = status;
    return _data;
  }
}

class Videos {
  Videos({
    required this.type,
    required this.title,
    required this.id,
    required this.url,
    required this.bestThumbnail,
    required this.thumbnails,
    required this.isUpcoming,
     this.upcoming,
    required this.isLive,
    required this.badges,
    required this.author,
     this.description,
    required this.views,
     this.duration,
     this.uploadedAt,
  });
  late final String type;
  late final String title;
  late final String id;
  late final String url;
  late final BestThumbnail bestThumbnail;
  late final List<Thumbnails> thumbnails;
  late final bool isUpcoming;
  late final bool? upcoming;
  late final bool isLive;
  late final List<String> badges;
  late final Author author;
  late final String? description;
  late final int views;
  late final String? duration;
  late final String? uploadedAt;
  
  Videos.fromJson(Map<String, dynamic> json){
    type = json['type'];
    title = json['title'];
    id = json['id'];
    url = json['url'];
    bestThumbnail = BestThumbnail.fromJson(json['bestThumbnail']);
    thumbnails = List.from(json['thumbnails']).map((e)=>Thumbnails.fromJson(e)).toList();
    isUpcoming = json['isUpcoming'];
    upcoming = null;
    isLive = json['isLive'];
    badges = List.from(json['badges']);
    author = Author.fromJson(json['author']);
    description = null;
    views = json['views'];
    duration = null;
    uploadedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['title'] = title;
    _data['id'] = id;
    _data['url'] = url;
    _data['bestThumbnail'] = bestThumbnail.toJson();
    _data['thumbnails'] = thumbnails.map((e)=>e.toJson()).toList();
    _data['isUpcoming'] = isUpcoming;
    _data['upcoming'] = upcoming;
    _data['isLive'] = isLive;
    _data['badges'] = badges;
    _data['author'] = author.toJson();
    _data['description'] = description;
    _data['views'] = views;
    _data['duration'] = duration;
    _data['uploadedAt'] = uploadedAt;
    return _data;
  }
}

class BestThumbnail {
  BestThumbnail({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;
  
  BestThumbnail.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Thumbnails {
  Thumbnails({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;
  
  Thumbnails.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Author {
  Author({
    required this.name,
    required this.channelID,
    required this.url,
    required this.bestAvatar,
    required this.avatars,
    required this.ownerBadges,
    required this.verified,
  });
  late final String name;
  late final String channelID;
  late final String url;
  late final BestAvatar bestAvatar;
  late final List<Avatars> avatars;
  late final List<String> ownerBadges;
  late final bool verified;
  
  Author.fromJson(Map<String, dynamic> json){
    name = json['name'];
    channelID = json['channelID'];
    url = json['url'];
    bestAvatar = BestAvatar.fromJson(json['bestAvatar']);
    avatars = List.from(json['avatars']).map((e)=>Avatars.fromJson(e)).toList();
    ownerBadges = List.castFrom<dynamic, String>(json['ownerBadges']);
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['channelID'] = channelID;
    _data['url'] = url;
    _data['bestAvatar'] = bestAvatar.toJson();
    _data['avatars'] = avatars.map((e)=>e.toJson()).toList();
    _data['ownerBadges'] = ownerBadges;
    _data['verified'] = verified;
    return _data;
  }
}

class BestAvatar {
  BestAvatar({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;
  
  BestAvatar.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Avatars {
  Avatars({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;
  
  Avatars.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}