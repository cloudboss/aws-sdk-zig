/// The status of the operation to replicate the bot alias. Values: Creating,
/// Updating, Available, Deleting, Failed.
pub const BotAliasReplicationStatus = enum {
    creating,
    updating,
    available,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .updating = "Updating",
        .available = "Available",
        .deleting = "Deleting",
        .failed = "Failed",
    };
};
