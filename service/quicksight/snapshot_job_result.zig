const AnonymousUserSnapshotJobResult = @import("anonymous_user_snapshot_job_result.zig").AnonymousUserSnapshotJobResult;
const RegisteredUserSnapshotJobResult = @import("registered_user_snapshot_job_result.zig").RegisteredUserSnapshotJobResult;

/// An object that provides information on the result of a snapshot job. This
/// object provides information about the job, the job status, and the location
/// of the generated file.
pub const SnapshotJobResult = struct {
    /// A list of `AnonymousUserSnapshotJobResult` objects that contain information
    /// on anonymous users and their user configurations. This data provided by you
    /// when you make a `StartDashboardSnapshotJob` API call.
    anonymous_users: ?[]const AnonymousUserSnapshotJobResult,

    /// A list of `RegisteredUserSnapshotJobResult` objects that contain information
    /// about files that are requested for registered user during a
    /// `StartDashboardSnapshotJob` API call.
    registered_users: ?[]const RegisteredUserSnapshotJobResult,

    pub const json_field_names = .{
        .anonymous_users = "AnonymousUsers",
        .registered_users = "RegisteredUsers",
    };
};
