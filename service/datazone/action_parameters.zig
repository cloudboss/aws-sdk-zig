const AwsConsoleLinkParameters = @import("aws_console_link_parameters.zig").AwsConsoleLinkParameters;

/// The parameters of the environment action.
pub const ActionParameters = union(enum) {
    /// The console link specified as part of the environment action.
    aws_console_link: ?AwsConsoleLinkParameters,

    pub const json_field_names = .{
        .aws_console_link = "awsConsoleLink",
    };
};
