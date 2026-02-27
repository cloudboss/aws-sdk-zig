pub const ScanType = enum {
    standard,
    express,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .express = "EXPRESS",
    };
};
