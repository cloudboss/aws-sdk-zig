const VpcConnectorStatus = @import("vpc_connector_status.zig").VpcConnectorStatus;

/// Describes an App Runner VPC connector resource. A VPC connector describes
/// the Amazon Virtual Private Cloud (Amazon VPC) that an App Runner service is
/// associated with, and the subnets and security group that are used.
///
/// Multiple revisions of a connector might have the same `Name` and different
/// `Revision` values.
///
/// At this time, App Runner supports only one revision per name.
pub const VpcConnector = struct {
    /// The time when the VPC connector was created. It's in Unix time stamp format.
    created_at: ?i64 = null,

    /// The time when the VPC connector was deleted. It's in Unix time stamp format.
    deleted_at: ?i64 = null,

    /// A list of IDs of security groups that App Runner uses for access to Amazon
    /// Web Services resources under the specified subnets. If not specified, App
    /// Runner uses the default
    /// security group of the Amazon VPC. The default security group allows all
    /// outbound traffic.
    security_groups: ?[]const []const u8 = null,

    /// The current state of the VPC connector. If the status of a connector
    /// revision is `INACTIVE`, it was deleted and can't be
    /// used. Inactive connector revisions are permanently removed some time after
    /// they are deleted.
    status: ?VpcConnectorStatus = null,

    /// A list of IDs of subnets that App Runner uses for your service. All IDs are
    /// of subnets of a single Amazon VPC.
    subnets: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of this VPC connector.
    vpc_connector_arn: ?[]const u8 = null,

    /// The customer-provided VPC connector name.
    vpc_connector_name: ?[]const u8 = null,

    /// The revision of this VPC connector. It's unique among all the active
    /// connectors (`"Status": "ACTIVE"`) that share the same
    /// `Name`.
    ///
    /// At this time, App Runner supports only one revision per name.
    vpc_connector_revision: i32 = 0,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .deleted_at = "DeletedAt",
        .security_groups = "SecurityGroups",
        .status = "Status",
        .subnets = "Subnets",
        .vpc_connector_arn = "VpcConnectorArn",
        .vpc_connector_name = "VpcConnectorName",
        .vpc_connector_revision = "VpcConnectorRevision",
    };
};
