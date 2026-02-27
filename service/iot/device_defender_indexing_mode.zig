pub const DeviceDefenderIndexingMode = enum {
    off,
    violations,

    pub const json_field_names = .{
        .off = "OFF",
        .violations = "VIOLATIONS",
    };
};
