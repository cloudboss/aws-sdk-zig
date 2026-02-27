pub const ServiceNetworkServiceAssociationStatus = enum {
    /// ServiceNetwork and Service association creation in progress
    create_in_progress,
    /// ServiceNetwork and Service association is active
    active,
    /// ServiceNetwork and Service association deletion in progress
    delete_in_progress,
    /// ServiceNetwork and Service association creation failed.
    create_failed,
    /// ServiceNetwork and Service association deletion failed
    delete_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .active = "ACTIVE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
