/// Configuration for Amazon Web Services Lambda functions used in a Region
/// switch plan.
pub const Lambdas = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function.
    arn: ?[]const u8 = null,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The JSON payload to send to the Lambda function invocation. If you don't
    /// specify a payload, Region switch invokes the function with only the
    /// execution metadata.
    ///
    /// If you provide a JSON object, Region switch merges execution metadata keys
    /// (`InvokedBy`, `PlanArn`, `ExecutionId`, `StepName`) into the top level. If
    /// one of your keys has the same name as a metadata key, your key takes
    /// precedence.
    ///
    /// If you provide any other JSON type (string, number, boolean, or array),
    /// Region switch forwards it to the Lambda function unchanged, without adding
    /// metadata.
    payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .payload = "payload",
    };
};
