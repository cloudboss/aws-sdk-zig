/// The status of the VPC link.
pub const VpcLinkStatus = enum {
    pending,
    available,
    deleting,
    failed,
    inactive,

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .inactive = "INACTIVE",
    };
};
