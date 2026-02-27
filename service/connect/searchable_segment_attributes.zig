const SearchableSegmentAttributesCriteria = @import("searchable_segment_attributes_criteria.zig").SearchableSegmentAttributesCriteria;
const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;

/// The search criteria based on searchable segment attributes of a contact
pub const SearchableSegmentAttributes = struct {
    /// The list of criteria based on searchable segment attributes.
    criteria: []const SearchableSegmentAttributesCriteria,

    /// The match type combining search criteria using multiple searchable segment
    /// attributes.
    match_type: ?SearchContactsMatchType,

    pub const json_field_names = .{
        .criteria = "Criteria",
        .match_type = "MatchType",
    };
};
