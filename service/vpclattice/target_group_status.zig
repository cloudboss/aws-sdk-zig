pub const TargetGroupStatus = enum {
    /// TargetGroup creation in progress
    create_in_progress,
    /// TargetGroup is active
    active,
    /// TargetGroup deletion in progress
    delete_in_progress,
    /// TargetGroup creation failed.
    create_failed,
    /// TargetGroup deletion failed
    delete_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .active = "ACTIVE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
