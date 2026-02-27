/// Specify the XAVC HD (Long GOP) Bitrate Class to set the bitrate of your
/// output. Outputs of the same class have similar image quality over the
/// operating points that are valid for that class.
pub const XavcHdProfileBitrateClass = enum {
    bitrate_class_25,
    bitrate_class_35,
    bitrate_class_50,

    pub const json_field_names = .{
        .bitrate_class_25 = "BITRATE_CLASS_25",
        .bitrate_class_35 = "BITRATE_CLASS_35",
        .bitrate_class_50 = "BITRATE_CLASS_50",
    };
};
