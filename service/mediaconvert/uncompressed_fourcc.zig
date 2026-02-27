/// The four character code for the uncompressed video.
pub const UncompressedFourcc = enum {
    i420,
    i422,
    i444,

    pub const json_field_names = .{
        .i420 = "I420",
        .i422 = "I422",
        .i444 = "I444",
    };
};
