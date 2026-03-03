const ParameterInlinePolicy = @import("parameter_inline_policy.zig").ParameterInlinePolicy;
const ParameterTier = @import("parameter_tier.zig").ParameterTier;
const ParameterType = @import("parameter_type.zig").ParameterType;

/// Metadata includes information like the Amazon Resource Name (ARN) of the
/// last user to update
/// the parameter and the date and time the parameter was last used.
pub const ParameterMetadata = struct {
    /// A parameter name can include only the following letters and symbols.
    ///
    /// a-zA-Z0-9_.-
    allowed_pattern: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the parameter.
    arn: ?[]const u8 = null,

    /// The data type of the parameter, such as `text` or `aws:ec2:image`. The
    /// default is `text`.
    data_type: ?[]const u8 = null,

    /// Description of the parameter actions.
    description: ?[]const u8 = null,

    /// The alias of the Key Management Service (KMS) key used to encrypt the
    /// parameter. Applies to `SecureString` parameters only.
    key_id: ?[]const u8 = null,

    /// Date the parameter was last changed or updated.
    last_modified_date: ?i64 = null,

    /// Amazon Resource Name (ARN) of the Amazon Web Services user who last changed
    /// the parameter.
    last_modified_user: ?[]const u8 = null,

    /// The parameter name.
    name: ?[]const u8 = null,

    /// A list of policies associated with a parameter.
    policies: ?[]const ParameterInlinePolicy = null,

    /// The parameter tier.
    tier: ?ParameterTier = null,

    /// The type of parameter. Valid parameter types include the following:
    /// `String`,
    /// `StringList`, and `SecureString`.
    @"type": ?ParameterType = null,

    /// The parameter version.
    version: i64 = 0,

    pub const json_field_names = .{
        .allowed_pattern = "AllowedPattern",
        .arn = "ARN",
        .data_type = "DataType",
        .description = "Description",
        .key_id = "KeyId",
        .last_modified_date = "LastModifiedDate",
        .last_modified_user = "LastModifiedUser",
        .name = "Name",
        .policies = "Policies",
        .tier = "Tier",
        .@"type" = "Type",
        .version = "Version",
    };
};
