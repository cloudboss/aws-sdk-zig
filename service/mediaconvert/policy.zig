const InputPolicy = @import("input_policy.zig").InputPolicy;

/// A policy configures behavior that you allow or disallow for your account.
/// For information about MediaConvert policies, see the user guide at
/// http://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
pub const Policy = struct {
    /// Allow or disallow jobs that specify HTTP inputs.
    http_inputs: ?InputPolicy = null,

    /// Allow or disallow jobs that specify HTTPS inputs.
    https_inputs: ?InputPolicy = null,

    /// Allow or disallow jobs that specify Amazon S3 inputs.
    s3_inputs: ?InputPolicy = null,

    pub const json_field_names = .{
        .http_inputs = "HttpInputs",
        .https_inputs = "HttpsInputs",
        .s3_inputs = "S3Inputs",
    };
};
