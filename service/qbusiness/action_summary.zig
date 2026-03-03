/// Summary information for an Amazon Q Business plugin action.
pub const ActionSummary = struct {
    /// The identifier of an Amazon Q Business plugin action.
    action_identifier: ?[]const u8 = null,

    /// The description of an Amazon Q Business plugin action.
    description: ?[]const u8 = null,

    /// The display name assigned by Amazon Q Business to a plugin action. You can't
    /// modify this value.
    display_name: ?[]const u8 = null,

    /// An Amazon Q Business suggested prompt and end user can use to invoke a
    /// plugin action. This value can be modified and sent as input to initiate an
    /// action. For example:
    ///
    /// * Create a Jira task
    /// * Create a chat assistant task to find the root cause of a specific incident
    instruction_example: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_identifier = "actionIdentifier",
        .description = "description",
        .display_name = "displayName",
        .instruction_example = "instructionExample",
    };
};
