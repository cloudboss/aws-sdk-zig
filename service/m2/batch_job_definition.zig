const FileBatchJobDefinition = @import("file_batch_job_definition.zig").FileBatchJobDefinition;
const ScriptBatchJobDefinition = @import("script_batch_job_definition.zig").ScriptBatchJobDefinition;

/// Defines the details of a batch job.
pub const BatchJobDefinition = union(enum) {
    /// Specifies a file containing a batch job definition.
    file_batch_job_definition: ?FileBatchJobDefinition,
    /// A script containing a batch job definition.
    script_batch_job_definition: ?ScriptBatchJobDefinition,

    pub const json_field_names = .{
        .file_batch_job_definition = "fileBatchJobDefinition",
        .script_batch_job_definition = "scriptBatchJobDefinition",
    };
};
