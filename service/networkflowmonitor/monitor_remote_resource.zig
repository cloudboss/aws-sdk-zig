const MonitorRemoteResourceType = @import("monitor_remote_resource_type.zig").MonitorRemoteResourceType;

/// A remote resource is the other endpoint in a network flow. That is, one
/// endpoint is the local resource and the other is the remote resource. The
/// values you can specify are the following:
///
/// * For a VPC or subnet, this identifier is the VPC Amazon Resource Name (ARN)
///   or subnet ARN.
/// * For a service, this identifier is one of the following strings: `S3` or
///   `DynamoDB`.
/// * For an Availability Zone, this identifier is the AZ name, for example,
///   us-west-2b.
/// * For a Region, this identifier is the Region name, for example, us-west-2.
///
/// When a remote resource is an Amazon Web Services Region, Network Flow
/// Monitor provides network performance measurements up to the edge of the
/// Region that you specify.
pub const MonitorRemoteResource = struct {
    /// The identifier of the remote resource. For a VPC or subnet, this identifier
    /// is the VPC Amazon Resource Name (ARN) or subnet ARN. For an Availability
    /// Zone, this identifier is the AZ name, for example, us-west-2b. For an Amazon
    /// Web Services Region , this identifier is the Region name, for example,
    /// us-west-2.
    identifier: []const u8,

    /// The type of the remote resource. Valid values are `AWS::EC2::VPC`
    /// `AWS::AvailabilityZone`, `AWS::EC2::Subnet`, `AWS::AWSService`, or
    /// `AWS::Region`.
    @"type": MonitorRemoteResourceType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .@"type" = "type",
    };
};
