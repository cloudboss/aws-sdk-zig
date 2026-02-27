/// Use Level to set the MPEG-2 level for the video output.
pub const Mpeg2CodecLevel = enum {
    auto,
    low,
    main,
    high1440,
    high,

    pub const json_field_names = .{
        .auto = "AUTO",
        .low = "LOW",
        .main = "MAIN",
        .high1440 = "HIGH1440",
        .high = "HIGH",
    };
};
