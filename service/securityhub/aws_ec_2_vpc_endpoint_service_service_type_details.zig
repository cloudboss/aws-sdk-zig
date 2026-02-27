/// The service type information for a VPC endpoint service.
pub const AwsEc2VpcEndpointServiceServiceTypeDetails = struct {
    /// The type of service.
    service_type: ?[]const u8,

    pub const json_field_names = .{
        .service_type = "ServiceType",
    };
};
