const ReprocessingStatus = @import("reprocessing_status.zig").ReprocessingStatus;

/// Information about pipeline reprocessing.
pub const ReprocessingSummary = struct {
    /// The time the pipeline reprocessing was created.
    creation_time: ?i64,

    /// The `reprocessingId` returned by `StartPipelineReprocessing`.
    id: ?[]const u8,

    /// The status of the pipeline reprocessing.
    status: ?ReprocessingStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .id = "id",
        .status = "status",
    };
};
