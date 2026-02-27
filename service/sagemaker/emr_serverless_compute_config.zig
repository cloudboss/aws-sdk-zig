/// This data type is intended for use exclusively by SageMaker Canvas and
/// cannot be used in other contexts at the moment.
///
/// Specifies the compute configuration for the EMR Serverless job.
pub const EmrServerlessComputeConfig = struct {
    /// The ARN of the IAM role granting the AutoML job V2 the necessary permissions
    /// access policies to list, connect to, or manage EMR Serverless jobs. For
    /// detailed information about the required permissions of this role, see "How
    /// to configure AutoML to initiate a remote job on EMR Serverless for large
    /// datasets" in [Create a regression or classification job for tabular data
    /// using the AutoML
    /// API](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-automate-model-development-create-experiment.html) or [Create an AutoML job for time-series forecasting using the API](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-create-experiment-timeseries-forecasting.html#timeseries-forecasting-api-optional-params).
    execution_role_arn: []const u8,

    pub const json_field_names = .{
        .execution_role_arn = "ExecutionRoleARN",
    };
};
