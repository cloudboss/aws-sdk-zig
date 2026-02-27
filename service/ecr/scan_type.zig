pub const ScanType = enum {
    basic,
    enhanced,

    pub const json_field_names = .{
        .basic = "BASIC",
        .enhanced = "ENHANCED",
    };
};
