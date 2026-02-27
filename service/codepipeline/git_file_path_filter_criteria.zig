/// The Git repository file paths specified as filter criteria to start the
/// pipeline.
pub const GitFilePathFilterCriteria = struct {
    /// The list of patterns of Git repository file paths that, when a commit is
    /// pushed,
    /// are to be excluded from starting the pipeline.
    excludes: ?[]const []const u8,

    /// The list of patterns of Git repository file paths that, when a commit is
    /// pushed,
    /// are to be included as criteria that starts the pipeline.
    includes: ?[]const []const u8,

    pub const json_field_names = .{
        .excludes = "excludes",
        .includes = "includes",
    };
};
