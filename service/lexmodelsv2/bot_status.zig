pub const BotStatus = enum {
    creating,
    available,
    inactive,
    deleting,
    failed,
    versioning,
    importing,
    updating,

    pub const json_field_names = .{
        .creating = "Creating",
        .available = "Available",
        .inactive = "Inactive",
        .deleting = "Deleting",
        .failed = "Failed",
        .versioning = "Versioning",
        .importing = "Importing",
        .updating = "Updating",
    };
};
