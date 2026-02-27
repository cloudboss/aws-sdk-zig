pub const GroupStatus = enum {
    failed,
    succeeded,
    processing,
    deleting,
    deleted,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .processing = "PROCESSING",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
