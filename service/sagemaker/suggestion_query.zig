const PropertyNameQuery = @import("property_name_query.zig").PropertyNameQuery;

/// Specified in the
/// [GetSearchSuggestions](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_GetSearchSuggestions.html) request. Limits the property names that are included in the response.
pub const SuggestionQuery = struct {
    /// Defines a property name hint. Only property names that begin with the
    /// specified hint are included in the response.
    property_name_query: ?PropertyNameQuery = null,

    pub const json_field_names = .{
        .property_name_query = "PropertyNameQuery",
    };
};
