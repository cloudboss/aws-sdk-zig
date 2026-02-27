pub const ScanDirection = enum {
    forward,
    backward,

    pub const json_field_names = .{
        .forward = "FORWARD",
        .backward = "BACKWARD",
    };
};
