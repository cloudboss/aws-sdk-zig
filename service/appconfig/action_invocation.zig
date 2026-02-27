/// An extension that was invoked as part of a deployment event.
pub const ActionInvocation = struct {
    /// The name of the action.
    action_name: ?[]const u8,

    /// The error code when an extension invocation fails.
    error_code: ?[]const u8,

    /// The error message when an extension invocation fails.
    error_message: ?[]const u8,

    /// The name, the ID, or the Amazon Resource Name (ARN) of the extension.
    extension_identifier: ?[]const u8,

    /// A system-generated ID for this invocation.
    invocation_id: ?[]const u8,

    /// An Amazon Resource Name (ARN) for an Identity and Access Management assume
    /// role.
    role_arn: ?[]const u8,

    /// The extension URI associated to the action point in the extension
    /// definition. The URI
    /// can be an Amazon Resource Name (ARN) for one of the following: an Lambda
    /// function, an Amazon Simple Queue Service queue, an Amazon Simple
    /// Notification Service topic, or the Amazon EventBridge default event bus.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .action_name = "ActionName",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .extension_identifier = "ExtensionIdentifier",
        .invocation_id = "InvocationId",
        .role_arn = "RoleArn",
        .uri = "Uri",
    };
};
