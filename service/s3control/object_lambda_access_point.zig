const ObjectLambdaAccessPointAlias = @import("object_lambda_access_point_alias.zig").ObjectLambdaAccessPointAlias;

/// An access point with an attached Lambda function used to access transformed
/// data from an Amazon S3
/// bucket.
pub const ObjectLambdaAccessPoint = struct {
    /// The alias of the Object Lambda Access Point.
    alias: ?ObjectLambdaAccessPointAlias,

    /// The name of the Object Lambda Access Point.
    name: []const u8,

    /// Specifies the ARN for the Object Lambda Access Point.
    object_lambda_access_point_arn: ?[]const u8,
};
