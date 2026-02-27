const HostEnvironment = @import("host_environment.zig").HostEnvironment;

/// Describes a gateway object.
pub const GatewayInfo = struct {
    /// Date after which this gateway will not receive software updates for new
    /// features and bug
    /// fixes.
    deprecation_date: ?[]const u8,

    /// The ID of the Amazon EC2 instance that was used to launch the gateway.
    ec_2_instance_id: ?[]const u8,

    /// The Amazon Web Services Region where the Amazon EC2 instance is located.
    ec_2_instance_region: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the gateway. Use the ListGateways
    /// operation to return a list of gateways for your account and Amazon Web
    /// Services Region.
    gateway_arn: ?[]const u8,

    /// The unique identifier assigned to your gateway during activation. This ID
    /// becomes part
    /// of the gateway Amazon Resource Name (ARN), which you use as input for other
    /// operations.
    gateway_id: ?[]const u8,

    /// The name of the gateway.
    gateway_name: ?[]const u8,

    /// The state of the gateway.
    ///
    /// Valid Values: `DISABLED` | `ACTIVE`
    gateway_operational_state: ?[]const u8,

    /// The type of the gateway.
    ///
    /// Amazon FSx File Gateway is no longer available to new customers. Existing
    /// customers of FSx File Gateway can continue to use the service normally. For
    /// capabilities similar to FSx File Gateway, visit [this blog
    /// post](https://aws.amazon.com/blogs/storage/switch-your-file-share-access-from-amazon-fsx-file-gateway-to-amazon-fsx-for-windows-file-server/).
    gateway_type: ?[]const u8,

    /// The type of hardware or software platform on which the gateway is running.
    ///
    /// Tape Gateway is no longer available on Snow Family devices.
    host_environment: ?HostEnvironment,

    /// A unique identifier for the specific instance of the host platform running
    /// the gateway.
    /// This value is only available for certain host environments, and its format
    /// depends on the
    /// host environment type.
    host_environment_id: ?[]const u8,

    /// The version number of the software running on the gateway appliance.
    software_version: ?[]const u8,

    pub const json_field_names = .{
        .deprecation_date = "DeprecationDate",
        .ec_2_instance_id = "Ec2InstanceId",
        .ec_2_instance_region = "Ec2InstanceRegion",
        .gateway_arn = "GatewayARN",
        .gateway_id = "GatewayId",
        .gateway_name = "GatewayName",
        .gateway_operational_state = "GatewayOperationalState",
        .gateway_type = "GatewayType",
        .host_environment = "HostEnvironment",
        .host_environment_id = "HostEnvironmentId",
        .software_version = "SoftwareVersion",
    };
};
