/// The Match group object.
pub const MatchItem = struct {
    /// A number between 0 and 1, where a higher score means higher similarity.
    /// Examining match
    /// confidence scores lets you distinguish between groups of similar records in
    /// which the
    /// system is highly confident (which you may decide to merge), groups of
    /// similar records about
    /// which the system is uncertain (which you may decide to have reviewed by a
    /// human), and
    /// groups of similar records that the system deems to be unlikely (which you
    /// may decide to
    /// reject). Given confidence scores vary as per the data input, it should not
    /// be used an
    /// absolute measure of matching quality.
    confidence_score: ?f64,

    /// The unique identifiers for this group of profiles that match.
    match_id: ?[]const u8,

    /// A list of identifiers for profiles that match.
    profile_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .confidence_score = "ConfidenceScore",
        .match_id = "MatchId",
        .profile_ids = "ProfileIds",
    };
};
