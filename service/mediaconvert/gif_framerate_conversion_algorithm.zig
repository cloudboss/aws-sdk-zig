/// Optional. Specify how the transcoder performs framerate conversion. The
/// default behavior is to use Drop duplicate (DUPLICATE_DROP) conversion. When
/// you choose Interpolate (INTERPOLATE) instead, the conversion produces
/// smoother motion.
pub const GifFramerateConversionAlgorithm = enum {
    duplicate_drop,
    interpolate,

    pub const json_field_names = .{
        .duplicate_drop = "DUPLICATE_DROP",
        .interpolate = "INTERPOLATE",
    };
};
