/// Settings that determine the Lambda function that Amazon Lex uses for
/// processing user responses.
pub const DialogCodeHookSettings = struct {
    /// Enables the dialog code hook so that it processes user
    /// requests.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
