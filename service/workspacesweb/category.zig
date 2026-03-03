const std = @import("std");

pub const Category = enum {
    cults,
    gambling,
    nudity,
    pornography,
    sex_education,
    tasteless,
    violence,
    download_sites,
    image_sharing,
    peer_to_peer,
    streaming_media_and_downloads,
    generative_ai,
    criminal_activity,
    hacking,
    hate_and_intolerance,
    illegal_drug,
    illegal_software,
    school_cheating,
    self_harm,
    weapons,
    chat,
    games,
    instant_messaging,
    professional_network,
    social_networking,
    web_based_email,
    parked_domains,

    pub const json_field_names = .{
        .cults = "Cults",
        .gambling = "Gambling",
        .nudity = "Nudity",
        .pornography = "Pornography",
        .sex_education = "SexEducation",
        .tasteless = "Tasteless",
        .violence = "Violence",
        .download_sites = "DownloadSites",
        .image_sharing = "ImageSharing",
        .peer_to_peer = "PeerToPeer",
        .streaming_media_and_downloads = "StreamingMediaAndDownloads",
        .generative_ai = "GenerativeAI",
        .criminal_activity = "CriminalActivity",
        .hacking = "Hacking",
        .hate_and_intolerance = "HateAndIntolerance",
        .illegal_drug = "IllegalDrug",
        .illegal_software = "IllegalSoftware",
        .school_cheating = "SchoolCheating",
        .self_harm = "SelfHarm",
        .weapons = "Weapons",
        .chat = "Chat",
        .games = "Games",
        .instant_messaging = "InstantMessaging",
        .professional_network = "ProfessionalNetwork",
        .social_networking = "SocialNetworking",
        .web_based_email = "WebBasedEmail",
        .parked_domains = "ParkedDomains",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cults => "Cults",
            .gambling => "Gambling",
            .nudity => "Nudity",
            .pornography => "Pornography",
            .sex_education => "SexEducation",
            .tasteless => "Tasteless",
            .violence => "Violence",
            .download_sites => "DownloadSites",
            .image_sharing => "ImageSharing",
            .peer_to_peer => "PeerToPeer",
            .streaming_media_and_downloads => "StreamingMediaAndDownloads",
            .generative_ai => "GenerativeAI",
            .criminal_activity => "CriminalActivity",
            .hacking => "Hacking",
            .hate_and_intolerance => "HateAndIntolerance",
            .illegal_drug => "IllegalDrug",
            .illegal_software => "IllegalSoftware",
            .school_cheating => "SchoolCheating",
            .self_harm => "SelfHarm",
            .weapons => "Weapons",
            .chat => "Chat",
            .games => "Games",
            .instant_messaging => "InstantMessaging",
            .professional_network => "ProfessionalNetwork",
            .social_networking => "SocialNetworking",
            .web_based_email => "WebBasedEmail",
            .parked_domains => "ParkedDomains",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
