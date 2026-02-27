pub const ServiceNetworkVpcAssociationStatus = enum {
    /// ServiceNetwork and Vpc association creation in progress
    create_in_progress,
    /// ServiceNetwork and Vpc association is active
    active,
    /// ServiceNetwork and Vpc association update in progress
    update_in_progress,
    /// ServiceNetwork and Vpc association deletion in progress
    delete_in_progress,
    /// ServiceNetwork and Vpc association creation failed.
    create_failed,
    /// ServiceNetwork and Vpc association deletion failed
    delete_failed,
    /// ServiceNetwork and Vpc association update failed
    update_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .active = "ACTIVE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
        .update_failed = "UPDATE_FAILED",
    };
};
