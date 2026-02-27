pub const AppStatus = enum {
    deleted,
    deleting,
    failed,
    in_service,
    pending,

    pub const json_field_names = .{
        .deleted = "Deleted",
        .deleting = "Deleting",
        .failed = "Failed",
        .in_service = "InService",
        .pending = "Pending",
    };
};
