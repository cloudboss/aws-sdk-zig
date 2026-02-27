/// The state of a VPC connection.
pub const VpcConnectionState = enum {
    creating,
    available,
    inactive,
    deactivating,
    deleting,
    failed,
    rejected,
    rejecting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .inactive = "INACTIVE",
        .deactivating = "DEACTIVATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .rejected = "REJECTED",
        .rejecting = "REJECTING",
    };
};
