/// The pipeline configuration for a resolver of kind `PIPELINE`.
pub const PipelineConfig = struct {
    /// A list of `Function` objects.
    functions: ?[]const []const u8,

    pub const json_field_names = .{
        .functions = "functions",
    };
};
