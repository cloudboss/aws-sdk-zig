const PosixUser = @import("posix_user.zig").PosixUser;
const RunAs = @import("run_as.zig").RunAs;
const WindowsUser = @import("windows_user.zig").WindowsUser;

/// Identifies the user for a job.
pub const JobRunAsUser = struct {
    /// The user and group that the jobs in the queue run as.
    posix: ?PosixUser,

    /// Specifies whether the job should run using the queue's system user or if the
    /// job should run using the worker agent system user.
    run_as: RunAs,

    /// Identifies a Microsoft Windows user.
    windows: ?WindowsUser,

    pub const json_field_names = .{
        .posix = "posix",
        .run_as = "runAs",
        .windows = "windows",
    };
};
