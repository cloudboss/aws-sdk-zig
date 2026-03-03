/// Configuration for Amazon Web Services Lambda functions used in a Region
/// switch plan.
pub const Lambdas = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function.
    arn: ?[]const u8 = null,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
    };
};
