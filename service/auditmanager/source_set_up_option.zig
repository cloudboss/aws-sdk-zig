pub const SourceSetUpOption = enum {
    system_controls_mapping,
    procedural_controls_mapping,

    pub const json_field_names = .{
        .system_controls_mapping = "SYSTEM_CONTROLS_MAPPING",
        .procedural_controls_mapping = "PROCEDURAL_CONTROLS_MAPPING",
    };
};
