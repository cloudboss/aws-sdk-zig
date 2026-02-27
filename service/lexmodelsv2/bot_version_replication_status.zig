/// The status of the operation to replicate the bot version. Values: Creating,
/// Available, Deleting, Failed.
pub const BotVersionReplicationStatus = enum {
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
