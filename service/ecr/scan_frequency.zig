pub const ScanFrequency = enum {
    scan_on_push,
    continuous_scan,
    manual,

    pub const json_field_names = .{
        .scan_on_push = "SCAN_ON_PUSH",
        .continuous_scan = "CONTINUOUS_SCAN",
        .manual = "MANUAL",
    };
};
