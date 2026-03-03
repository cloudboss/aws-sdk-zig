const BuildSummary = @import("build_summary.zig").BuildSummary;

/// Contains information about a batch build build group. Build groups are used
/// to combine
/// builds that can run in parallel, while still being able to set dependencies
/// on other
/// build groups.
pub const BuildGroup = struct {
    /// A `BuildSummary` object that contains a summary of the current build
    /// group.
    current_build_summary: ?BuildSummary = null,

    /// An array of strings that contain the identifiers of the build groups that
    /// this build
    /// group depends on.
    depends_on: ?[]const []const u8 = null,

    /// Contains the identifier of the build group.
    identifier: ?[]const u8 = null,

    /// Specifies if failures in this build group can be ignored.
    ignore_failure: bool = false,

    /// An array of `BuildSummary` objects that contain summaries of previous
    /// build groups.
    prior_build_summary_list: ?[]const BuildSummary = null,

    pub const json_field_names = .{
        .current_build_summary = "currentBuildSummary",
        .depends_on = "dependsOn",
        .identifier = "identifier",
        .ignore_failure = "ignoreFailure",
        .prior_build_summary_list = "priorBuildSummaryList",
    };
};
