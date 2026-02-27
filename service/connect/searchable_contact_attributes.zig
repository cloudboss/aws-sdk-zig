const SearchableContactAttributesCriteria = @import("searchable_contact_attributes_criteria.zig").SearchableContactAttributesCriteria;
const SearchContactsMatchType = @import("search_contacts_match_type.zig").SearchContactsMatchType;

/// A structure that defines search criteria based on user-defined contact
/// attributes that are configured for
/// contact search.
pub const SearchableContactAttributes = struct {
    /// The list of criteria based on user-defined contact attributes that are
    /// configured for contact search.
    criteria: []const SearchableContactAttributesCriteria,

    /// The match type combining search criteria using multiple searchable contact
    /// attributes.
    match_type: ?SearchContactsMatchType,

    pub const json_field_names = .{
        .criteria = "Criteria",
        .match_type = "MatchType",
    };
};
