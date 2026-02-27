/// Information about the Amazon Q intent.
pub const IntentInputData = struct {
    /// The identifier of the Amazon Q intent.
    intent_id: []const u8,

    pub const json_field_names = .{
        .intent_id = "intentId",
    };
};
