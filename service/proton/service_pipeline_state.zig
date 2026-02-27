/// The detailed data about the current state of the service pipeline.
pub const ServicePipelineState = struct {
    /// The service spec that was used to create the service pipeline.
    spec: ?[]const u8,

    /// The major version of the service template that was used to create the
    /// service
    /// pipeline.
    template_major_version: []const u8,

    /// The minor version of the service template that was used to create the
    /// service
    /// pipeline.
    template_minor_version: []const u8,

    /// The name of the service template that was used to create the service
    /// pipeline.
    template_name: []const u8,

    pub const json_field_names = .{
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};
