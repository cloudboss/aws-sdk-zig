const InputContext = @import("input_context.zig").InputContext;
const OutputContext = @import("output_context.zig").OutputContext;

/// Summary information about an intent returned by the
/// `ListIntents` operation.
pub const IntentSummary = struct {
    /// The description of the intent.
    description: ?[]const u8 = null,

    /// The input contexts that must be active for this intent to be
    /// considered for recognition.
    input_contexts: ?[]const InputContext = null,

    /// The display name of the intent.
    intent_display_name: ?[]const u8 = null,

    /// The unique identifier assigned to the intent. Use this ID to get
    /// detailed information about the intent with the
    /// `DescribeIntent` operation.
    intent_id: ?[]const u8 = null,

    /// The name of the intent.
    intent_name: ?[]const u8 = null,

    /// The timestamp of the date and time that the intent was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The output contexts that are activated when this intent is
    /// fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// If this intent is derived from a built-in intent, the name of the
    /// parent intent.
    parent_intent_signature: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .input_contexts = "inputContexts",
        .intent_display_name = "intentDisplayName",
        .intent_id = "intentId",
        .intent_name = "intentName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
    };
};
