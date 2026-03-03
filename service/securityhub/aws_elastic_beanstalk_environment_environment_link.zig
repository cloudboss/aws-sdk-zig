/// Contains information about a link to another environment that is in the same
/// group.
pub const AwsElasticBeanstalkEnvironmentEnvironmentLink = struct {
    /// The name of the linked environment.
    environment_name: ?[]const u8 = null,

    /// The name of the environment link.
    link_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_name = "EnvironmentName",
        .link_name = "LinkName",
    };
};
