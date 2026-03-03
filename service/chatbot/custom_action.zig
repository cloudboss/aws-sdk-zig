const CustomActionAttachment = @import("custom_action_attachment.zig").CustomActionAttachment;
const CustomActionDefinition = @import("custom_action_definition.zig").CustomActionDefinition;

/// Represents a parameterized command that can be invoked as an alias or as a
/// notification button in the chat client.
pub const CustomAction = struct {
    /// The name of the custom action that is included in the ARN.
    action_name: ?[]const u8 = null,

    /// The name used to invoke this action in the chat channel. For example, `@aws
    /// run my-alias`.
    alias_name: ?[]const u8 = null,

    /// Defines when this custom action button should be attached to a notification.
    attachments: ?[]const CustomActionAttachment = null,

    /// The fully defined Amazon Resource Name (ARN) of the custom action.
    custom_action_arn: []const u8,

    /// The definition of the command to run when invoked an alias or as an action
    /// button.
    definition: CustomActionDefinition,

    pub const json_field_names = .{
        .action_name = "ActionName",
        .alias_name = "AliasName",
        .attachments = "Attachments",
        .custom_action_arn = "CustomActionArn",
        .definition = "Definition",
    };
};
