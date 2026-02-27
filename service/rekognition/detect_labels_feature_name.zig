pub const DetectLabelsFeatureName = enum {
    general_labels,
    image_properties,

    pub const json_field_names = .{
        .general_labels = "GENERAL_LABELS",
        .image_properties = "IMAGE_PROPERTIES",
    };
};
