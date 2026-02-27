pub const VariantPropertyType = enum {
    desired_instance_count,
    desired_weight,
    data_capture_config,

    pub const json_field_names = .{
        .desired_instance_count = "DesiredInstanceCount",
        .desired_weight = "DesiredWeight",
        .data_capture_config = "DataCaptureConfig",
    };
};
