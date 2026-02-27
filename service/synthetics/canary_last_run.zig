const CanaryRun = @import("canary_run.zig").CanaryRun;

/// This structure contains information about the most recent run of a single
/// canary.
pub const CanaryLastRun = struct {
    /// The name of the canary.
    canary_name: ?[]const u8,

    /// The results from this canary's most recent run.
    last_run: ?CanaryRun,

    pub const json_field_names = .{
        .canary_name = "CanaryName",
        .last_run = "LastRun",
    };
};
