/// Specify the codec profile for this output. Choose High, 8-bit, 4:2:0 (HIGH)
/// or High, 10-bit, 4:2:2 (HIGH_422). These profiles are specified in ITU-T
/// H.264.
pub const Xavc4kProfileCodecProfile = enum {
    high,
    high_422,

    pub const json_field_names = .{
        .high = "HIGH",
        .high_422 = "HIGH_422",
    };
};
