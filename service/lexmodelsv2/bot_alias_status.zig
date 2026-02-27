pub const BotAliasStatus = enum {
    creating,
    available,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .available = "Available",
        .deleting = "Deleting",
        .failed = "Failed",
    };
};
