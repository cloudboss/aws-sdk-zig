pub const FlexibleTimeWindowMode = enum {
    off,
    flexible,

    pub const json_field_names = .{
        .off = "OFF",
        .flexible = "FLEXIBLE",
    };
};
