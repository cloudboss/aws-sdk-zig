const UpdateWebAppVpcConfig = @import("update_web_app_vpc_config.zig").UpdateWebAppVpcConfig;

/// Contains the endpoint configuration details for updating a web app,
/// including VPC settings for endpoints hosted within a VPC.
pub const UpdateWebAppEndpointDetails = union(enum) {
    /// The VPC configuration details for updating a web app endpoint hosted within
    /// a VPC. This includes the subnet IDs for endpoint deployment.
    vpc: ?UpdateWebAppVpcConfig,

    pub const json_field_names = .{
        .vpc = "Vpc",
    };
};
