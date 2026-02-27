/// An Amazon Elastic Compute Cloud launch
/// template that contains configuration settings and game server code to be
/// deployed to all
/// instances in a game server group. The launch template is specified when
/// creating a new
/// game server group.
pub const LaunchTemplateSpecification = struct {
    /// A unique identifier for an existing Amazon EC2 launch template.
    launch_template_id: ?[]const u8,

    /// A readable identifier for an existing Amazon EC2 launch template.
    launch_template_name: ?[]const u8,

    /// The version of the Amazon EC2 launch template to use. If no version is
    /// specified, the
    /// default version will be used. With Amazon EC2, you can specify a default
    /// version for a launch
    /// template. If none is set, the default is the first version created.
    version: ?[]const u8,

    pub const json_field_names = .{
        .launch_template_id = "LaunchTemplateId",
        .launch_template_name = "LaunchTemplateName",
        .version = "Version",
    };
};
