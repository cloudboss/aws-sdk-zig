/// The override parameters for a single VPC connection that is imported.
pub const AssetBundleImportJobVPCConnectionOverrideParameters = struct {
    /// An optional override of DNS resolvers to be used by the VPC connection.
    dns_resolvers: ?[]const []const u8 = null,

    /// A new name for the VPC connection.
    name: ?[]const u8 = null,

    /// An optional override of the role ARN to be used by the VPC connection.
    role_arn: ?[]const u8 = null,

    /// A new security group ID for the VPC connection you are importing. This field
    /// is required
    /// if you are importing the VPC connection from another Amazon Web Services
    /// account or
    /// Region.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of new subnet IDs for the VPC connection you are importing. This
    /// field is
    /// required if you are importing the VPC connection from another Amazon Web
    /// Services account or
    /// Region.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC Connection to apply overrides to.
    vpc_connection_id: []const u8,

    pub const json_field_names = .{
        .dns_resolvers = "DnsResolvers",
        .name = "Name",
        .role_arn = "RoleArn",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_connection_id = "VPCConnectionId",
    };
};
