/// Settings that specify the dialog code hook that is called by Amazon Lex
/// between eliciting slot values.
pub const ElicitationCodeHookInvocationSetting = struct {
    /// Indicates whether a Lambda function should be invoked
    /// for the dialog.
    enable_code_hook_invocation: bool,

    /// A label that indicates the dialog step from which the dialog code
    /// hook is happening.
    invocation_label: ?[]const u8,

    pub const json_field_names = .{
        .enable_code_hook_invocation = "enableCodeHookInvocation",
        .invocation_label = "invocationLabel",
    };
};
