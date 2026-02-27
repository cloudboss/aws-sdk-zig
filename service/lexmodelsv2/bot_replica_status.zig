/// The status of the operation to replicate the bot. Values: Enabling, Enabled,
/// Deleting, Failed.
pub const BotReplicaStatus = enum {
    enabling,
    enabled,
    deleting,
    failed,

    pub const json_field_names = .{
        .enabling = "Enabling",
        .enabled = "Enabled",
        .deleting = "Deleting",
        .failed = "Failed",
    };
};
