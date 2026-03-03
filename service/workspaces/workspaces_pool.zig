const ApplicationSettingsResponse = @import("application_settings_response.zig").ApplicationSettingsResponse;
const CapacityStatus = @import("capacity_status.zig").CapacityStatus;
const WorkspacesPoolError = @import("workspaces_pool_error.zig").WorkspacesPoolError;
const PoolsRunningMode = @import("pools_running_mode.zig").PoolsRunningMode;
const WorkspacesPoolState = @import("workspaces_pool_state.zig").WorkspacesPoolState;
const TimeoutSettings = @import("timeout_settings.zig").TimeoutSettings;

/// Describes a pool of WorkSpaces.
pub const WorkspacesPool = struct {
    /// The persistent application settings for users of the pool.
    application_settings: ?ApplicationSettingsResponse = null,

    /// The identifier of the bundle used by the pool.
    bundle_id: []const u8,

    /// The capacity status for the pool
    capacity_status: CapacityStatus,

    /// The time the pool was created.
    created_at: i64,

    /// The description of the pool.
    description: ?[]const u8 = null,

    /// The identifier of the directory used by the pool.
    directory_id: []const u8,

    /// The pool errors.
    errors: ?[]const WorkspacesPoolError = null,

    /// The Amazon Resource Name (ARN) for the pool.
    pool_arn: []const u8,

    /// The identifier of a pool.
    pool_id: []const u8,

    /// The name of the pool.
    pool_name: []const u8,

    /// The running mode of the pool.
    running_mode: PoolsRunningMode = "AUTO_STOP",

    /// The current state of the pool.
    state: WorkspacesPoolState,

    /// The amount of time that a pool session remains active after users
    /// disconnect.
    /// If they try to reconnect to the pool session after a disconnection or
    /// network interruption
    /// within this time interval, they are connected to their previous session.
    /// Otherwise, they are connected to a new session with a new pool instance.
    timeout_settings: ?TimeoutSettings = null,

    pub const json_field_names = .{
        .application_settings = "ApplicationSettings",
        .bundle_id = "BundleId",
        .capacity_status = "CapacityStatus",
        .created_at = "CreatedAt",
        .description = "Description",
        .directory_id = "DirectoryId",
        .errors = "Errors",
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
        .pool_name = "PoolName",
        .running_mode = "RunningMode",
        .state = "State",
        .timeout_settings = "TimeoutSettings",
    };
};
