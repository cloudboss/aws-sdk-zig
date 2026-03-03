const LastRecorderStatus = @import("last_recorder_status.zig").LastRecorderStatus;
const LastUploaderStatus = @import("last_uploader_status.zig").LastUploaderStatus;

/// An object that contains the latest status details for an edge agent's
/// recorder and uploader jobs. Use this information to determine the current
/// health of an edge agent.
pub const EdgeAgentStatus = struct {
    /// The latest status of a stream’s edge recording job.
    last_recorder_status: ?LastRecorderStatus = null,

    /// The latest status of a stream’s edge to cloud uploader job.
    last_uploader_status: ?LastUploaderStatus = null,

    pub const json_field_names = .{
        .last_recorder_status = "LastRecorderStatus",
        .last_uploader_status = "LastUploaderStatus",
    };
};
