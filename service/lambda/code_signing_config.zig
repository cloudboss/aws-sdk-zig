const AllowedPublishers = @import("allowed_publishers.zig").AllowedPublishers;
const CodeSigningPolicies = @import("code_signing_policies.zig").CodeSigningPolicies;

/// Details about a [Code signing
/// configuration](https://docs.aws.amazon.com/lambda/latest/dg/configuration-codesigning.html).
pub const CodeSigningConfig = struct {
    /// List of allowed publishers.
    allowed_publishers: AllowedPublishers,

    /// The Amazon Resource Name (ARN) of the Code signing configuration.
    code_signing_config_arn: []const u8,

    /// Unique identifer for the Code signing configuration.
    code_signing_config_id: []const u8,

    /// The code signing policy controls the validation failure action for signature
    /// mismatch or expiry.
    code_signing_policies: CodeSigningPolicies,

    /// Code signing configuration description.
    description: ?[]const u8,

    /// The date and time that the Code signing configuration was last modified, in
    /// ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified: []const u8,

    pub const json_field_names = .{
        .allowed_publishers = "AllowedPublishers",
        .code_signing_config_arn = "CodeSigningConfigArn",
        .code_signing_config_id = "CodeSigningConfigId",
        .code_signing_policies = "CodeSigningPolicies",
        .description = "Description",
        .last_modified = "LastModified",
    };
};
