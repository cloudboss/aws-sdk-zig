/// Statistics about the Identity Resolution Job.
pub const JobStats = struct {
    /// The number of matches found.
    number_of_matches_found: i64 = 0,

    /// The number of merges completed.
    number_of_merges_done: i64 = 0,

    /// The number of profiles reviewed.
    number_of_profiles_reviewed: i64 = 0,

    pub const json_field_names = .{
        .number_of_matches_found = "NumberOfMatchesFound",
        .number_of_merges_done = "NumberOfMergesDone",
        .number_of_profiles_reviewed = "NumberOfProfilesReviewed",
    };
};
