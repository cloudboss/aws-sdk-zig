const ValidatorType = @import("validator_type.zig").ValidatorType;

/// A validator provides a syntactic or semantic check to ensure the
/// configuration that you
/// want to deploy functions as intended. To validate your application
/// configuration data, you
/// provide a schema or an Amazon Web Services Lambda function that runs against
/// the configuration. The
/// configuration deployment or update can only proceed when the configuration
/// data is valid.
/// For more information, see [About
/// validators](https://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-creating-configuration-profile.html#appconfig-creating-configuration-and-profile-validators) in the *AppConfig User Guide*.
pub const Validator = struct {
    /// Either the JSON Schema content or the Amazon Resource Name (ARN) of an
    /// Lambda
    /// function.
    content: []const u8,

    /// AppConfig supports validators of type `JSON_SCHEMA` and
    /// `LAMBDA`
    @"type": ValidatorType,

    pub const json_field_names = .{
        .content = "Content",
        .@"type" = "Type",
    };
};
