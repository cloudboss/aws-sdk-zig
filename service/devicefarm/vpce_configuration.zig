/// Represents an Amazon Virtual Private Cloud (VPC) endpoint configuration.
pub const VPCEConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the VPC endpoint configuration.
    arn: ?[]const u8 = null,

    /// The DNS name that maps to the private IP address of the service you want to
    /// access.
    service_dns_name: ?[]const u8 = null,

    /// An optional description that provides details about your VPC endpoint
    /// configuration.
    vpce_configuration_description: ?[]const u8 = null,

    /// The friendly name you give to your VPC endpoint configuration to manage your
    /// configurations more
    /// easily.
    vpce_configuration_name: ?[]const u8 = null,

    /// The name of the VPC endpoint service running in your AWS account that you
    /// want Device Farm to test.
    vpce_service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .service_dns_name = "serviceDnsName",
        .vpce_configuration_description = "vpceConfigurationDescription",
        .vpce_configuration_name = "vpceConfigurationName",
        .vpce_service_name = "vpceServiceName",
    };
};
