const LaunchParameters = @import("launch_parameters.zig").LaunchParameters;

/// The source of the launch template configuration for a capacity provider. The
/// `launchParameters` member specifies the operating system, instance
/// requirements, and other settings used to launch instances.
pub const LaunchTemplateSource = union(enum) {
    /// The parameters that AgentCore uses to create the launch template.
    launch_parameters: ?LaunchParameters,

    pub const json_field_names = .{
        .launch_parameters = "launchParameters",
    };
};
