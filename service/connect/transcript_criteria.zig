const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;

/// A structure that defines search criteria base on words or phrases,
/// participants in the Contact Lens
/// conversational analytics transcript.
pub const TranscriptCriteria = struct {
    /// The match type combining search criteria using multiple search texts in a
    /// transcript criteria.
    match_type: SearchContactsMatchType,

    /// The participant role in a transcript
    participant_role: ParticipantRole,

    /// The words or phrases used to search within a transcript.
    search_text: []const []const u8,

    pub const json_field_names = .{
        .match_type = "MatchType",
        .participant_role = "ParticipantRole",
        .search_text = "SearchText",
    };
};
