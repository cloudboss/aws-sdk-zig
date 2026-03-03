/// Provides summary information about an VPC Ingress Connection, which includes
/// its VPC Ingress Connection ARN and its associated Service ARN.
pub const VpcIngressConnectionSummary = struct {
    /// The Amazon Resource Name (ARN) of the service associated with the VPC
    /// Ingress Connection.
    service_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the VPC Ingress Connection.
    vpc_ingress_connection_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_arn = "ServiceArn",
        .vpc_ingress_connection_arn = "VpcIngressConnectionArn",
    };
};
