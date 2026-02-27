const WebAppVpcConfig = @import("web_app_vpc_config.zig").WebAppVpcConfig;

/// Contains the endpoint configuration for a web app, including VPC settings
/// when the endpoint is hosted within a VPC.
pub const WebAppEndpointDetails = union(enum) {
    /// The VPC configuration for hosting the web app endpoint within a VPC.
    vpc: ?WebAppVpcConfig,

    pub const json_field_names = .{
        .vpc = "Vpc",
    };
};
