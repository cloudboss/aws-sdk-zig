/// Video Description Respond To Afd
pub const VideoDescriptionRespondToAfd = enum {
    none,
    passthrough,
    respond,

    pub const json_field_names = .{
        .none = "NONE",
        .passthrough = "PASSTHROUGH",
        .respond = "RESPOND",
    };
};
