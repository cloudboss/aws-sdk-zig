const TestGridVpcConfig = @import("test_grid_vpc_config.zig").TestGridVpcConfig;

/// A Selenium testing project. Projects are used to collect and collate
/// sessions.
pub const TestGridProject = struct {
    /// The ARN for the project.
    arn: ?[]const u8,

    /// When the project was created.
    created: ?i64,

    /// A human-readable description for the project.
    description: ?[]const u8,

    /// A human-readable name for the project.
    name: ?[]const u8,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?TestGridVpcConfig,

    pub const json_field_names = .{
        .arn = "arn",
        .created = "created",
        .description = "description",
        .name = "name",
        .vpc_config = "vpcConfig",
    };
};
