/// The VPC configuration provisioned for the host.
pub const VpcConfiguration = struct {
    /// The ID of the security group or security groups associated with the Amazon
    /// VPC connected
    /// to the infrastructure where your provider type is installed.
    security_group_ids: []const []const u8,

    /// The ID of the subnet or subnets associated with the Amazon VPC connected to
    /// the
    /// infrastructure where your provider type is installed.
    subnet_ids: []const []const u8,

    /// The value of the Transport Layer Security (TLS) certificate associated with
    /// the infrastructure where your provider type is installed.
    tls_certificate: ?[]const u8,

    /// The ID of the Amazon VPC connected to the infrastructure where your provider
    /// type is
    /// installed.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .tls_certificate = "TlsCertificate",
        .vpc_id = "VpcId",
    };
};
