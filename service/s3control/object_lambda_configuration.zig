const ObjectLambdaAllowedFeature = @import("object_lambda_allowed_feature.zig").ObjectLambdaAllowedFeature;
const ObjectLambdaTransformationConfiguration = @import("object_lambda_transformation_configuration.zig").ObjectLambdaTransformationConfiguration;

/// A configuration used when creating an Object Lambda Access Point.
pub const ObjectLambdaConfiguration = struct {
    /// A container for allowed features. Valid inputs are `GetObject-Range`,
    /// `GetObject-PartNumber`, `HeadObject-Range`, and
    /// `HeadObject-PartNumber`.
    allowed_features: ?[]const ObjectLambdaAllowedFeature = null,

    /// A container for whether the CloudWatch metrics configuration is enabled.
    cloud_watch_metrics_enabled: bool = false,

    /// Standard access point associated with the Object Lambda Access Point.
    supporting_access_point: []const u8,

    /// A container for transformation configurations for an Object Lambda Access
    /// Point.
    transformation_configurations: []const ObjectLambdaTransformationConfiguration,
};
