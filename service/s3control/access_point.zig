const NetworkOrigin = @import("network_origin.zig").NetworkOrigin;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// An access point used to access a bucket.
pub const AccessPoint = struct {
    /// The ARN for the access point.
    access_point_arn: ?[]const u8 = null,

    /// The name or alias of the access point.
    alias: ?[]const u8 = null,

    /// The name of the bucket associated with this access point.
    bucket: []const u8,

    /// The Amazon Web Services account ID associated with the S3 bucket associated
    /// with this access point.
    bucket_account_id: ?[]const u8 = null,

    /// A unique identifier for the data source of the access point.
    data_source_id: ?[]const u8 = null,

    /// The type of the data source that the access point is attached to.
    data_source_type: ?[]const u8 = null,

    /// The name of this access point.
    name: []const u8,

    /// Indicates whether this access point allows access from the public internet.
    /// If
    /// `VpcConfiguration` is specified for this access point, then
    /// `NetworkOrigin` is `VPC`, and the access point doesn't allow access from
    /// the public internet. Otherwise, `NetworkOrigin` is `Internet`, and
    /// the access point allows access from the public internet, subject to the
    /// access point and bucket access
    /// policies.
    network_origin: NetworkOrigin,

    /// The virtual private cloud (VPC) configuration for this access point, if one
    /// exists.
    ///
    /// This element is empty if this access point is an Amazon S3 on Outposts
    /// access point that is used by other
    /// Amazon Web Services services.
    vpc_configuration: ?VpcConfiguration = null,
};
