/// Summary information about a particular command resource.
pub const CommandSummary = struct {
    /// The Amazon Resource Name (ARN) of the command.
    command_arn: ?[]const u8,

    /// The unique identifier of the command.
    command_id: ?[]const u8,

    /// The timestamp, when the command was created.
    created_at: ?i64,

    /// Indicates whether the command has been deprecated.
    deprecated: ?bool,

    /// The display name of the command.
    display_name: ?[]const u8,

    /// The timestamp, when the command was last updated.
    last_updated_at: ?i64,

    /// Indicates whether the command is pending deletion.
    pending_deletion: ?bool,

    pub const json_field_names = .{
        .command_arn = "commandArn",
        .command_id = "commandId",
        .created_at = "createdAt",
        .deprecated = "deprecated",
        .display_name = "displayName",
        .last_updated_at = "lastUpdatedAt",
        .pending_deletion = "pendingDeletion",
    };
};
