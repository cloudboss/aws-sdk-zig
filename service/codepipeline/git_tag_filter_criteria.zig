/// The Git tags specified as filter criteria for whether a Git tag repository
/// event
/// will start the pipeline.
pub const GitTagFilterCriteria = struct {
    /// The list of patterns of Git tags that, when pushed, are to be excluded from
    /// starting the pipeline.
    excludes: ?[]const []const u8,

    /// The list of patterns of Git tags that, when pushed, are to be included as
    /// criteria
    /// that starts the pipeline.
    includes: ?[]const []const u8,

    pub const json_field_names = .{
        .excludes = "excludes",
        .includes = "includes",
    };
};
