pub const CisTargetStatusReason = enum {
    scan_in_progress,
    unsupported_os,
    ssm_unmanaged,

    pub const json_field_names = .{
        .scan_in_progress = "SCAN_IN_PROGRESS",
        .unsupported_os = "UNSUPPORTED_OS",
        .ssm_unmanaged = "SSM_UNMANAGED",
    };
};
