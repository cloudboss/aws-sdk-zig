/// An object containing the name of an intent that was invoked.
pub const InvokedIntentSample = struct {
    /// The name of an intent that was invoked.
    intent_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .intent_name = "intentName",
    };
};
