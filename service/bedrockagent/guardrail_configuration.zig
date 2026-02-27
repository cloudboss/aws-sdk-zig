/// Details about a guardrail associated with a resource.
pub const GuardrailConfiguration = struct {
    /// The unique identifier of the guardrail.
    guardrail_identifier: ?[]const u8,

    /// The version of the guardrail.
    guardrail_version: ?[]const u8,

    pub const json_field_names = .{
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
    };
};
