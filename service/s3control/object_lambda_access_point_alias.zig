const ObjectLambdaAccessPointAliasStatus = @import("object_lambda_access_point_alias_status.zig").ObjectLambdaAccessPointAliasStatus;

/// The alias of an Object Lambda Access Point. For more information, see [How
/// to use a
/// bucket-style alias for your S3 bucket Object Lambda Access
/// Point](https://docs.aws.amazon.com/AmazonS3/latest/userguide/olap-use.html#ol-access-points-alias).
pub const ObjectLambdaAccessPointAlias = struct {
    /// The status of the Object Lambda Access Point alias. If the status is
    /// `PROVISIONING`, the Object Lambda Access Point
    /// is provisioning the alias and the alias is not ready for use yet. If the
    /// status is
    /// `READY`, the Object Lambda Access Point alias is successfully provisioned
    /// and ready for
    /// use.
    status: ?ObjectLambdaAccessPointAliasStatus,

    /// The alias value of the Object Lambda Access Point.
    value: ?[]const u8,
};
