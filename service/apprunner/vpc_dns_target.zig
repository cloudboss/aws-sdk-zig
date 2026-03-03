/// DNS Target record for a custom domain of this Amazon VPC.
pub const VpcDNSTarget = struct {
    /// The domain name of your target DNS that is associated with the Amazon VPC.
    domain_name: ?[]const u8 = null,

    /// The ID of the Amazon VPC that is associated with the custom domain name of
    /// the target DNS.
    vpc_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the VPC Ingress Connection that is
    /// associated with your service.
    vpc_ingress_connection_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .vpc_id = "VpcId",
        .vpc_ingress_connection_arn = "VpcIngressConnectionArn",
    };
};
