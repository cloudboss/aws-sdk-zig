const PipelineOutputError = @import("pipeline_output_error.zig").PipelineOutputError;
const Record = @import("record.zig").Record;

/// Contains the output from pipeline test operations, including processed
/// records and any errors encountered.
pub const PipelineOutput = struct {
    /// Any error that occurred during the pipeline test operation for this record.
    @"error": ?PipelineOutputError = null,

    /// The processed record output from the pipeline test operation.
    record: ?Record = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .record = "Record",
    };
};
