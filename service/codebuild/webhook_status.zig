pub const WebhookStatus = enum {
    creating,
    create_failed,
    active,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
    };
};
