pub const ScanCategory = enum {
    full_scan,
    incremental_scan,

    pub const json_field_names = .{
        .full_scan = "FULL_SCAN",
        .incremental_scan = "INCREMENTAL_SCAN",
    };
};
