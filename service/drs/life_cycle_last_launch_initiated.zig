const LastLaunchType = @import("last_launch_type.zig").LastLaunchType;

/// An object containing information regarding the initiation of the last launch
/// of a Source Server.
pub const LifeCycleLastLaunchInitiated = struct {
    /// The date and time the last Source Server launch was initiated.
    api_call_date_time: ?[]const u8,

    /// The ID of the Job that was used to last launch the Source Server.
    job_id: ?[]const u8,

    /// The Job type that was used to last launch the Source Server.
    type: ?LastLaunchType,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
        .job_id = "jobID",
        .type = "type",
    };
};
