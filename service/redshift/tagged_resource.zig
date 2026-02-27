const Tag = @import("tag.zig").Tag;

/// A tag and its associated resource.
pub const TaggedResource = struct {
    /// The Amazon Resource Name (ARN) with which the tag is associated, for
    /// example:
    /// `arn:aws:redshift:us-east-2:123456789:cluster:t1`.
    resource_name: ?[]const u8,

    /// The type of resource with which the tag is associated. Valid resource types
    /// are:
    ///
    /// * Cluster
    ///
    /// * CIDR/IP
    ///
    /// * EC2 security group
    ///
    /// * Snapshot
    ///
    /// * Cluster security group
    ///
    /// * Subnet group
    ///
    /// * HSM connection
    ///
    /// * HSM certificate
    ///
    /// * Parameter group
    ///
    /// For more information about Amazon Redshift resource types and constructing
    /// ARNs, go to
    /// [Constructing an Amazon Redshift Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-overview.html#redshift-iam-access-control-specify-actions) in the
    /// Amazon Redshift Cluster Management Guide.
    resource_type: ?[]const u8,

    /// The tag for the resource.
    tag: ?Tag,
};
