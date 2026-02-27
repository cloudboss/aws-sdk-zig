const InputTags = @import("input_tags.zig").InputTags;
const ConfigurationOwner = @import("configuration_owner.zig").ConfigurationOwner;

/// Account enforced guardrail output configuration.
pub const AccountEnforcedGuardrailOutputConfiguration = struct {
    /// Unique ID for the account enforced configuration.
    config_id: ?[]const u8,

    /// Timestamp.
    created_at: ?i64,

    /// The ARN of the role used to update the configuration.
    created_by: ?[]const u8,

    /// ARN representation for the guardrail.
    guardrail_arn: ?[]const u8,

    /// Unique ID for the guardrail.
    guardrail_id: ?[]const u8,

    /// Numerical guardrail version.
    guardrail_version: ?[]const u8,

    /// Whether to honor or ignore input tags at runtime.
    input_tags: ?InputTags,

    /// Configuration owner type.
    owner: ?ConfigurationOwner,

    /// Timestamp.
    updated_at: ?i64,

    /// The ARN of the role used to update the configuration.
    updated_by: ?[]const u8,

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
