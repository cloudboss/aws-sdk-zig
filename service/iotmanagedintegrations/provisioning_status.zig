pub const ProvisioningStatus = enum {
    unassociated,
    pre_associated,
    discovered,
    activated,
    deletion_failed,
    delete_in_progress,
    isolated,
    deleted,

    pub const json_field_names = .{
        .unassociated = "UNASSOCIATED",
        .pre_associated = "PRE_ASSOCIATED",
        .discovered = "DISCOVERED",
        .activated = "ACTIVATED",
        .deletion_failed = "DELETION_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .isolated = "ISOLATED",
        .deleted = "DELETED",
    };
};
