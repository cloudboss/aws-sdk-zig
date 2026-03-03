const InputTags = @import("input_tags.zig").InputTags;
const ConfigurationOwner = @import("configuration_owner.zig").ConfigurationOwner;

/// Account enforced guardrail output configuration.
pub const AccountEnforcedGuardrailOutputConfiguration = struct {
    /// Unique ID for the account enforced configuration.
    config_id: ?[]const u8 = null,

    /// Timestamp.
    created_at: ?i64 = null,

    /// The ARN of the role used to update the configuration.
    created_by: ?[]const u8 = null,

    /// ARN representation for the guardrail.
    guardrail_arn: ?[]const u8 = null,

    /// Unique ID for the guardrail.
    guardrail_id: ?[]const u8 = null,

    /// Numerical guardrail version.
    guardrail_version: ?[]const u8 = null,

    /// Whether to honor or ignore input tags at runtime.
    input_tags: ?InputTags = null,

    /// Configuration owner type.
    owner: ?ConfigurationOwner = null,

    /// Timestamp.
    updated_at: ?i64 = null,

    /// The ARN of the role used to update the configuration.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_id = "configId",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .guardrail_arn = "guardrailArn",
        .guardrail_id = "guardrailId",
        .guardrail_version = "guardrailVersion",
        .input_tags = "inputTags",
        .owner = "owner",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
