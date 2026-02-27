const GuardrailOrigin = @import("guardrail_origin.zig").GuardrailOrigin;
const GuardrailOwnership = @import("guardrail_ownership.zig").GuardrailOwnership;

/// Details about the specific guardrail that was applied during this
/// assessment, including its identifier, version, ARN, origin, and ownership
/// information.
pub const AppliedGuardrailDetails = struct {
    /// The ARN of the guardrail that was applied.
    guardrail_arn: ?[]const u8,

    /// The unique ID of the guardrail that was applied.
    guardrail_id: ?[]const u8,

    /// The origin of how the guardrail was applied. This can be either requested at
    /// the API level or enforced at the account or organization level as a default
    /// guardrail.
    guardrail_origin: ?[]const GuardrailOrigin,

    /// The ownership type of the guardrail, indicating whether it is owned by the
    /// requesting account or is a cross-account guardrail shared from another AWS
    /// account.
    guardrail_ownership: ?GuardrailOwnership,

    /// The version of the guardrail that was applied.
    guardrail_version: ?[]const u8,

    pub const json_field_names = .{
        .guardrail_arn = "guardrailArn",
        .guardrail_id = "guardrailId",
        .guardrail_origin = "guardrailOrigin",
        .guardrail_ownership = "guardrailOwnership",
        .guardrail_version = "guardrailVersion",
    };
};
