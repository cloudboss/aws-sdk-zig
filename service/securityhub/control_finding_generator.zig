pub const ControlFindingGenerator = enum {
    standard_control,
    security_control,

    pub const json_field_names = .{
        .standard_control = "STANDARD_CONTROL",
        .security_control = "SECURITY_CONTROL",
    };
};
