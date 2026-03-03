const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Time series forecast settings for the SageMaker Canvas application.
pub const TimeSeriesForecastingSettings = struct {
    /// The IAM role that Canvas passes to Amazon Forecast for time series
    /// forecasting. By default, Canvas uses the execution role specified in the
    /// `UserProfile` that launches the Canvas application. If an execution role is
    /// not specified in the `UserProfile`, Canvas uses the execution role specified
    /// in the Domain that owns the `UserProfile`. To allow time series forecasting,
    /// this IAM role should have the [
    /// AmazonSageMakerCanvasForecastAccess](https://docs.aws.amazon.com/sagemaker/latest/dg/security-iam-awsmanpol-canvas.html#security-iam-awsmanpol-AmazonSageMakerCanvasForecastAccess) policy attached and `forecast.amazonaws.com` added in the trust relationship as a service principal.
    amazon_forecast_role_arn: ?[]const u8 = null,

    /// Describes whether time series forecasting is enabled or disabled in the
    /// Canvas application.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .amazon_forecast_role_arn = "AmazonForecastRoleArn",
        .status = "Status",
    };
};
