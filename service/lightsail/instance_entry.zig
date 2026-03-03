const PortInfoSourceType = @import("port_info_source_type.zig").PortInfoSourceType;

/// Describes the Amazon Elastic Compute Cloud instance and related resources to
/// be created using the
/// `create cloud formation stack` operation.
pub const InstanceEntry = struct {
    /// The Availability Zone for the new Amazon EC2 instance.
    availability_zone: []const u8,

    /// The instance type (`t2.micro`) to use for the new Amazon EC2 instance.
    instance_type: []const u8,

    /// The port configuration to use for the new Amazon EC2 instance.
    ///
    /// The following configuration options are available:
    ///
    /// * `DEFAULT` - Use the default firewall settings from the Lightsail instance
    /// blueprint. If this is specified, then IPv4 and IPv6 will be configured for
    /// the new
    /// instance that is created in Amazon EC2.
    ///
    /// * `INSTANCE` - Use the configured firewall settings from the source
    /// Lightsail instance. If this is specified, the new instance that is created
    /// in Amazon EC2 will
    /// be configured to match the configuration of the source Lightsail instance.
    /// For example,
    /// if the source instance is configured for dual-stack (IPv4 and IPv6), then
    /// IPv4 and IPv6
    /// will be configured for the new instance that is created in Amazon EC2. If
    /// the source instance
    /// is configured for IPv4 only, then only IPv4 will be configured for the new
    /// instance that
    /// is created in Amazon EC2.
    ///
    /// * `NONE` - Use the default Amazon EC2 security group. If this is specified,
    ///   then
    /// only IPv4 will be configured for the new instance that is created in Amazon
    /// EC2.
    ///
    /// * `CLOSED` - All ports closed. If this is specified, then only IPv4 will be
    /// configured for the new instance that is created in Amazon EC2.
    ///
    /// If you configured `lightsail-connect` as a `cidrListAliases` on
    /// your instance, or if you chose to allow the Lightsail browser-based SSH or
    /// RDP clients to
    /// connect to your instance, that configuration is not carried over to your new
    /// Amazon EC2
    /// instance.
    port_info_source: PortInfoSourceType,

    /// The name of the export snapshot record, which contains the exported
    /// Lightsail instance
    /// snapshot that will be used as the source of the new Amazon EC2 instance.
    ///
    /// Use the `get export snapshot records` operation to get a list of export
    /// snapshot records that you can use to create a CloudFormation stack.
    source_name: []const u8,

    /// A launch script you can create that configures a server with additional user
    /// data. For
    /// example, you might want to run `apt-get -y update`.
    ///
    /// Depending on the machine image you choose, the command to get software on
    /// your instance
    /// varies. Amazon Linux and CentOS use `yum`, Debian and Ubuntu use
    /// `apt-get`, and FreeBSD uses `pkg`.
    user_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .instance_type = "instanceType",
        .port_info_source = "portInfoSource",
        .source_name = "sourceName",
        .user_data = "userData",
    };
};
