const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const UserContext = @import("user_context.zig").UserContext;

/// Provides the configuration information for the document fields/attributes
/// that you want
/// to base query suggestions on.
pub const AttributeSuggestionsGetConfig = struct {
    /// The list of additional document field/attribute keys or field names to
    /// include in the
    /// response. You can use additional fields to provide extra information in the
    /// response.
    /// Additional fields are not used to based suggestions on.
    additional_response_attributes: ?[]const []const u8,

    /// Filters the search results based on document fields/attributes.
    attribute_filter: ?AttributeFilter,

    /// The list of document field/attribute keys or field names to use for query
    /// suggestions.
    /// If the content within any of the fields match what your user starts typing
    /// as their query,
    /// then the field content is returned as a query suggestion.
    suggestion_attributes: ?[]const []const u8,

    /// Applies user context filtering so that only users who are given access to
    /// certain
    /// documents see these document in their search results.
    user_context: ?UserContext,

    pub const json_field_names = .{
        .additional_response_attributes = "AdditionalResponseAttributes",
        .attribute_filter = "AttributeFilter",
        .suggestion_attributes = "SuggestionAttributes",
        .user_context = "UserContext",
    };
};
