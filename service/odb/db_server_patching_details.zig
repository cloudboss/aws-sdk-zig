const DbServerPatchingStatus = @import("db_server_patching_status.zig").DbServerPatchingStatus;

/// The scheduling details for the quarterly maintenance window. Patching and
/// system updates take place during the maintenance window.
pub const DbServerPatchingDetails = struct {
    /// Estimated time, in minutes, to patch one database server.
    estimated_patch_duration: ?i32,

    /// The status of the patching operation. Possible values are `SCHEDULED`,
    /// `MAINTENANCE_IN_PROGRESS`, `FAILED`, and `COMPLETE`.
    patching_status: ?DbServerPatchingStatus,

    /// The time when the patching operation ended.
    time_patching_ended: ?[]const u8,

    /// The time when the patching operation started.
    time_patching_started: ?[]const u8,

    pub const json_field_names = .{
        .estimated_patch_duration = "estimatedPatchDuration",
        .patching_status = "patchingStatus",
        .time_patching_ended = "timePatchingEnded",
        .time_patching_started = "timePatchingStarted",
    };
};
