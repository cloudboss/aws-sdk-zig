const DescribedWebAppVpcConfig = @import("described_web_app_vpc_config.zig").DescribedWebAppVpcConfig;

/// Contains the endpoint configuration details for a web app, including VPC
/// configuration when the endpoint is hosted within a VPC.
pub const DescribedWebAppEndpointDetails = union(enum) {
    /// The VPC configuration details when the web app endpoint is hosted within a
    /// VPC. This includes the VPC ID, subnet IDs, and VPC endpoint ID.
    vpc: ?DescribedWebAppVpcConfig,

    pub const json_field_names = .{
        .vpc = "Vpc",
    };
};
