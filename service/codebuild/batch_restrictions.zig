/// Specifies restrictions for the batch build.
pub const BatchRestrictions = struct {
    /// An array of strings that specify the compute types that are allowed for the
    /// batch
    /// build. See [Build environment
    /// compute
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html) in the *CodeBuild User Guide* for these values.
    compute_types_allowed: ?[]const []const u8 = null,

    /// An array of strings that specify the fleets that are allowed
    /// for the batch build. See [Run builds on reserved capacity
    /// fleets](https://docs.aws.amazon.com/codebuild/latest/userguide/fleets.html)
    /// in the *CodeBuild User Guide*
    /// for more information.
    fleets_allowed: ?[]const []const u8 = null,

    /// Specifies the maximum number of builds allowed.
    maximum_builds_allowed: ?i32 = null,

    pub const json_field_names = .{
        .compute_types_allowed = "computeTypesAllowed",
        .fleets_allowed = "fleetsAllowed",
        .maximum_builds_allowed = "maximumBuildsAllowed",
    };
};
