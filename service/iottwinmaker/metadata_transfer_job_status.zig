const ErrorDetails = @import("error_details.zig").ErrorDetails;
const MetadataTransferJobState = @import("metadata_transfer_job_state.zig").MetadataTransferJobState;

/// The metadata transfer job status.
pub const MetadataTransferJobStatus = struct {
    /// The metadata transfer job error.
    @"error": ?ErrorDetails = null,

    /// The queued position.
    queued_position: ?i32 = null,

    /// The metadata transfer job state.
    state: ?MetadataTransferJobState = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .queued_position = "queuedPosition",
        .state = "state",
    };
};
