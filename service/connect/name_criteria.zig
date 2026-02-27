const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;

/// The search criteria based on the contact name
pub const NameCriteria = struct {
    /// The match type combining name search criteria using multiple search texts in
    /// a name criteria.
    match_type: SearchContactsMatchType,

    /// The words or phrases used to match the contact name.
    search_text: []const []const u8,

    pub const json_field_names = .{
        .match_type = "MatchType",
        .search_text = "SearchText",
    };
};
