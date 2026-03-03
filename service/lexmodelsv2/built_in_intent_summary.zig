/// Provides summary information about a built-in intent for the [
/// ListBuiltInIntents
/// ](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListBuiltInIntents.html) operation.
pub const BuiltInIntentSummary = struct {
    /// The description of the intent.
    description: ?[]const u8 = null,

    /// The signature of the built-in intent. Use this to specify the parent
    /// intent of a derived intent.
    intent_signature: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .intent_signature = "intentSignature",
    };
};
