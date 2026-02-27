const JourneyRunStatus = @import("journey_run_status.zig").JourneyRunStatus;

/// Provides information from a specified run of a journey.
pub const JourneyRunResponse = struct {
    /// The time when the journey run was created or scheduled, in ISO 8601 format.
    creation_time: []const u8,

    /// The last time the journey run was updated, in ISO 8601 format..
    last_update_time: []const u8,

    /// The unique identifier for the run.
    run_id: []const u8,

    /// The current status of the journey run.
    status: JourneyRunStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_update_time = "LastUpdateTime",
        .run_id = "RunId",
        .status = "Status",
    };
};
