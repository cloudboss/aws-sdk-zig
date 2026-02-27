/// The configuration details for the guardrail.
pub const GuardrailConfiguration = struct {
    /// The unique identifier for the guardrail.
    guardrail_id: []const u8,

    /// The version of the guardrail.
    guardrail_version: []const u8,

    pub const json_field_names = .{
        .guardrail_id = "guardrailId",
        .guardrail_version = "guardrailVersion",
    };
};
