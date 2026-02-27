const ReactStartCodegenJobData = @import("react_start_codegen_job_data.zig").ReactStartCodegenJobData;

/// Describes the configuration information for rendering the UI component
/// associated with the code generation job.
pub const CodegenJobRenderConfig = union(enum) {
    /// The name of the `ReactStartCodegenJobData` object.
    react: ?ReactStartCodegenJobData,

    pub const json_field_names = .{
        .react = "react",
    };
};
