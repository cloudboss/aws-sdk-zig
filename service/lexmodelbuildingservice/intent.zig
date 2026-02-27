/// Identifies the specific version of an intent.
pub const Intent = struct {
    /// The name of the intent.
    intent_name: []const u8,

    /// The version of the intent.
    intent_version: []const u8,

    pub const json_field_names = .{
        .intent_name = "intentName",
        .intent_version = "intentVersion",
    };
};
