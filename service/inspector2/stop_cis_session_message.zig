const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const StopCisMessageProgress = @import("stop_cis_message_progress.zig").StopCisMessageProgress;
const StopCisSessionStatus = @import("stop_cis_session_status.zig").StopCisSessionStatus;

/// The stop CIS session message.
pub const StopCisSessionMessage = struct {
    /// The message benchmark profile.
    benchmark_profile: ?[]const u8,

    /// The message benchmark version.
    benchmark_version: ?[]const u8,

    /// The message compute platform.
    compute_platform: ?ComputePlatform,

    /// The progress of the message.
    progress: StopCisMessageProgress,

    /// The reason for the message.
    reason: ?[]const u8,

    /// The status of the message.
    status: StopCisSessionStatus,

    pub const json_field_names = .{
        .benchmark_profile = "benchmarkProfile",
        .benchmark_version = "benchmarkVersion",
        .compute_platform = "computePlatform",
        .progress = "progress",
        .reason = "reason",
        .status = "status",
    };
};
