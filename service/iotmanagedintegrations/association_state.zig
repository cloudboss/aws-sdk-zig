pub const AssociationState = enum {
    association_in_progress,
    association_failed,
    association_succeeded,
    association_deleting,
    refresh_token_expired,

    pub const json_field_names = .{
        .association_in_progress = "ASSOCIATION_IN_PROGRESS",
        .association_failed = "ASSOCIATION_FAILED",
        .association_succeeded = "ASSOCIATION_SUCCEEDED",
        .association_deleting = "ASSOCIATION_DELETING",
        .refresh_token_expired = "REFRESH_TOKEN_EXPIRED",
    };
};
