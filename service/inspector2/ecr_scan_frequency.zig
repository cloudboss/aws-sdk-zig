pub const EcrScanFrequency = enum {
    manual,
    scan_on_push,
    continuous_scan,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .scan_on_push = "SCAN_ON_PUSH",
        .continuous_scan = "CONTINUOUS_SCAN",
    };
};
