const ResourceConfiguration = @import("resource_configuration.zig").ResourceConfiguration;
const Variable = @import("variable.zig").Variable;

/// Information required to run the `containerAction` to produce dataset
/// contents.
pub const ContainerDatasetAction = struct {
    /// The ARN of the role that gives permission to the system to access required
    /// resources to
    /// run the `containerAction`. This includes, at minimum, permission to retrieve
    /// the
    /// dataset contents that are the input to the containerized application.
    execution_role_arn: []const u8,

    /// The ARN of the Docker container stored in your account. The Docker container
    /// contains an
    /// application and required support libraries and is used to generate dataset
    /// contents.
    image: []const u8,

    /// Configuration of the resource that executes the `containerAction`.
    resource_configuration: ResourceConfiguration,

    /// The values of variables used in the context of the execution of the
    /// containerized
    /// application (basically, parameters passed to the application). Each variable
    /// must have a name
    /// and a value given by one of `stringValue`, `datasetContentVersionValue`,
    /// or `outputFileUriValue`.
    variables: ?[]const Variable,

    pub const json_field_names = .{
        .execution_role_arn = "executionRoleArn",
        .image = "image",
        .resource_configuration = "resourceConfiguration",
        .variables = "variables",
    };
};
