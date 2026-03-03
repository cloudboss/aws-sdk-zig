const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;
const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;

/// Represents a virtual computing instance that runs game server processes and
/// hosts game
/// sessions. In Amazon GameLift Servers, one or more instances make up a
/// managed EC2 fleet.
pub const Instance = struct {
    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64 = null,

    /// The DNS identifier assigned to the instance that is running the game
    /// session. Values have
    /// the following format:
    ///
    /// * TLS-enabled fleets: `..amazongamelift.com`.
    ///
    /// * Non-TLS-enabled fleets: `ec2-.compute.amazonaws.com`. (See
    /// [Amazon EC2 Instance IP
    /// Addressing](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses).)
    ///
    /// When connecting to a game session that is running on a TLS-enabled fleet,
    /// you must use the DNS name, not the IP address.
    dns_name: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that the instance belongs to.
    fleet_id: ?[]const u8 = null,

    /// A unique identifier for the instance.
    instance_id: ?[]const u8 = null,

    /// IP address that is assigned to the instance.
    ip_address: ?[]const u8 = null,

    /// The fleet location of the instance, expressed as an Amazon Web Services
    /// Region code, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// Operating system that is running on this EC2 instance.
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in
    /// the [Amazon Linux 2
    /// FAQs](http://aws.amazon.com/aws.amazon.com/amazon-linux-2/faqs/).
    /// For game servers
    /// that are hosted on AL2 and use server SDK version 4.x for Amazon GameLift
    /// Servers, first update the
    /// game server build to server SDK 5.x, and then deploy to AL2023 instances.
    /// See
    /// [
    /// Migrate to server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ?OperatingSystem = null,

    /// Current status of the instance. Possible statuses include the following:
    ///
    /// * **PENDING** -- The instance is in the process of
    /// being created and launching server processes as defined in the fleet's
    /// run-time
    /// configuration.
    ///
    /// * **ACTIVE** -- The instance has been successfully
    /// created and at least one server process has successfully launched and
    /// reported
    /// back to Amazon GameLift Servers that it is ready to host a game session. The
    /// instance is now
    /// considered ready to host game sessions.
    ///
    /// * **TERMINATING** -- The instance is in the process
    /// of shutting down. This may happen to reduce capacity during a scaling down
    /// event
    /// or to recycle resources in the event of a problem.
    status: ?InstanceStatus = null,

    /// EC2 instance type that defines the computing resources of this instance.
    @"type": ?EC2InstanceType = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dns_name = "DnsName",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .instance_id = "InstanceId",
        .ip_address = "IpAddress",
        .location = "Location",
        .operating_system = "OperatingSystem",
        .status = "Status",
        .@"type" = "Type",
    };
};
