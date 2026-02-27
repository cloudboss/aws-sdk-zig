pub const MappingType = enum {
    framework,
    common_control,
    related_control,

    pub const json_field_names = .{
        .framework = "FRAMEWORK",
        .common_control = "COMMON_CONTROL",
        .related_control = "RELATED_CONTROL",
    };
};
