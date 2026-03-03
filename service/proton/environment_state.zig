/// The detailed data about the current state of the environment.
pub const EnvironmentState = struct {
    /// The environment spec that was used to create the environment.
    spec: ?[]const u8 = null,

    /// The major version of the environment template that was used to create the
    /// environment.
    template_major_version: []const u8,

    /// The minor version of the environment template that was used to create the
    /// environment.
    template_minor_version: []const u8,

    /// The name of the environment template that was used to create the
    /// environment.
    template_name: []const u8,

    pub const json_field_names = .{
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
