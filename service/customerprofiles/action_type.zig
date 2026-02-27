pub const ActionType = enum {
    added_profile_key,
    deleted_profile_key,
    created,
    updated,
    ingested,
    deleted_by_customer,
    expired,
    merged,
    deleted_by_merge,

    pub const json_field_names = .{
        .added_profile_key = "ADDED_PROFILE_KEY",
        .deleted_profile_key = "DELETED_PROFILE_KEY",
        .created = "CREATED",
        .updated = "UPDATED",
        .ingested = "INGESTED",
        .deleted_by_customer = "DELETED_BY_CUSTOMER",
        .expired = "EXPIRED",
        .merged = "MERGED",
        .deleted_by_merge = "DELETED_BY_MERGE",
    };
};
