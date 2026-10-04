/// Configuration for constructing filter expression strings when using the
/// `FILTER_STRING` filter mode.
pub const FilterStringConfiguration = struct {
    /// The query parameter name used to send the constructed filter expression
    /// string in API requests.
    query_parameter_name: []const u8,

    /// The character used to quote values when `QuoteStringValues` is true.
    /// Defaults to double quotes if not specified.
    quote_character: ?[]const u8 = null,

    /// Indicates whether string and date values should be wrapped with a quote
    /// character in the filter expression.
    quote_string_values: ?bool = null,

    pub const json_field_names = .{
        .query_parameter_name = "QueryParameterName",
        .quote_character = "QuoteCharacter",
        .quote_string_values = "QuoteStringValues",
    };
};
