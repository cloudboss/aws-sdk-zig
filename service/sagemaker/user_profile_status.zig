pub const UserProfileStatus = enum {
    deleting,
    failed,
    in_service,
    pending,
    updating,
    update_failed,
    delete_failed,

    pub const json_field_names = .{
        .deleting = "Deleting",
        .failed = "Failed",
        .in_service = "InService",
        .pending = "Pending",
        .updating = "Updating",
        .update_failed = "Update_Failed",
        .delete_failed = "Delete_Failed",
    };
};
