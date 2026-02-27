pub const AudioChannelsOption = enum {
    stereo,
    mono,

    pub const json_field_names = .{
        .stereo = "Stereo",
        .mono = "Mono",
    };
};
