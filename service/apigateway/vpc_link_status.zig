pub const VpcLinkStatus = enum {
    available,
    pending,
    deleting,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
