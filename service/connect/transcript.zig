const TranscriptCriteria = @import("transcript_criteria.zig").TranscriptCriteria;
const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;

/// A structure that defines search criteria and matching logic to search for
/// contacts by matching text with
/// transcripts analyzed by Amazon Connect Contact Lens.
pub const Transcript = struct {
    /// The list of search criteria based on Contact Lens conversational analytics
    /// transcript.
    criteria: []const TranscriptCriteria,

    /// The match type combining search criteria using multiple transcript criteria.
    match_type: ?SearchContactsMatchType,

    pub const json_field_names = .{
        .criteria = "Criteria",
        .match_type = "MatchType",
    };
};
