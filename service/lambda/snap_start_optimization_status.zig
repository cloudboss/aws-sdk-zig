pub const SnapStartOptimizationStatus = enum {
    on,
    off,

    pub const json_field_names = .{
        .on = "On",
        .off = "Off",
    };
};
