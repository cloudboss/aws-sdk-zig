const PostDialogCodeHookInvocationSpecification = @import("post_dialog_code_hook_invocation_specification.zig").PostDialogCodeHookInvocationSpecification;

/// Settings that specify the dialog code hook that is
/// called by Amazon Lex at a step of the conversation.
pub const DialogCodeHookInvocationSetting = struct {
    /// Determines whether a dialog code hook is used when the intent is
    /// activated.
    active: bool,

    /// Indicates whether a Lambda function should be invoked
    /// for the dialog.
    enable_code_hook_invocation: bool,

    /// A label that indicates the dialog step from which the dialog code
    /// hook is happening.
    invocation_label: ?[]const u8 = null,

    /// Contains the responses and actions that Amazon Lex takes
    /// after the Lambda function is complete.
    post_code_hook_specification: PostDialogCodeHookInvocationSpecification,

    pub const json_field_names = .{
        .active = "active",
        .enable_code_hook_invocation = "enableCodeHookInvocation",
        .invocation_label = "invocationLabel",
        .post_code_hook_specification = "postCodeHookSpecification",
    };
};
