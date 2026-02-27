/// A list of source plugin types used in the pipeline configuration (such as
/// `cloudwatch_logs` or `s3`). Currently supports a single source per pipeline,
/// but is structured as a list to accommodate multiple pipelines in the
/// configuration.
pub const Source = struct {
    /// The plugin name of the source, such as `cloudwatch_logs` or `s3`.
    type: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
