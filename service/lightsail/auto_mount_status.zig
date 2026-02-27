pub const AutoMountStatus = enum {
    failed,
    pending,
    mounted,
    not_mounted,

    pub const json_field_names = .{
        .failed = "Failed",
        .pending = "Pending",
        .mounted = "Mounted",
        .not_mounted = "NotMounted",
    };
};
