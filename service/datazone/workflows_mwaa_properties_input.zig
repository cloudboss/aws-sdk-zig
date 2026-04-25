/// The Amazon MWAA properties.
pub const WorkflowsMwaaPropertiesInput = struct {
    /// The MWAA environment name.
    mwaa_environment_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .mwaa_environment_name = "mwaaEnvironmentName",
    };
};
