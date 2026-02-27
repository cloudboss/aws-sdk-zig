/// Specify the XAVC 4k (Long GOP) Bitrate Class to set the bitrate of your
/// output. Outputs of the same class have similar image quality over the
/// operating points that are valid for that class.
pub const Xavc4kProfileBitrateClass = enum {
    bitrate_class_100,
    bitrate_class_140,
    bitrate_class_200,

    pub const json_field_names = .{
        .bitrate_class_100 = "BITRATE_CLASS_100",
        .bitrate_class_140 = "BITRATE_CLASS_140",
        .bitrate_class_200 = "BITRATE_CLASS_200",
    };
};
