pub const LosslessStorageFormat = enum {
    htj2_k,
    jpeg_2000_lossless,

    pub const json_field_names = .{
        .htj2_k = "HTJ2K",
        .jpeg_2000_lossless = "JPEG_2000_LOSSLESS",
    };
};
