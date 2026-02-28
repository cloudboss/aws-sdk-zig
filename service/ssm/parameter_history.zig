const ParameterInlinePolicy = @import("parameter_inline_policy.zig").ParameterInlinePolicy;
const ParameterTier = @import("parameter_tier.zig").ParameterTier;
const ParameterType = @import("parameter_type.zig").ParameterType;

/// Information about parameter usage.
pub const ParameterHistory = struct {
    /// Parameter names can include the following letters and symbols.
    ///
    /// a-zA-Z0-9_.-
    allowed_pattern: ?[]const u8,

    /// The data type of the parameter, such as `text` or `aws:ec2:image`. The
    /// default is `text`.
    data_type: ?[]const u8,

    /// Information about the parameter.
    description: ?[]const u8,

    /// The alias of the Key Management Service (KMS) key used to encrypt the
    /// parameter. Applies to `SecureString` parameters only
    key_id: ?[]const u8,

    /// Labels assigned to the parameter version.
    labels: ?[]const []const u8,

    /// Date the parameter was last changed or updated.
    last_modified_date: ?i64,

    /// Amazon Resource Name (ARN) of the Amazon Web Services user who last changed
    /// the parameter.
    last_modified_user: ?[]const u8,

    /// The name of the parameter.
    name: ?[]const u8,

    /// Information about the policies assigned to a parameter.
    ///
    /// [Assigning parameter
    /// policies](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html) in the *Amazon Web Services Systems Manager User Guide*.
    policies: ?[]const ParameterInlinePolicy,

    /// The parameter tier.
    tier: ?ParameterTier,

    /// The type of parameter used.
    @"type": ?ParameterType,

    /// The parameter value.
    value: ?[]const u8,

    /// The parameter version.
    version: i64 = 0,

    pub const json_field_names = .{
        .allowed_pattern = "AllowedPattern",
        .data_type = "DataType",
        .description = "Description",
        .key_id = "KeyId",
        .labels = "Labels",
        .last_modified_date = "LastModifiedDate",
        .last_modified_user = "LastModifiedUser",
        .name = "Name",
        .policies = "Policies",
        .tier = "Tier",
        .@"type" = "Type",
        .value = "Value",
        .version = "Version",
    };
};
