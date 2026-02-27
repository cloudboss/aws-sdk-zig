/// A named expression that can be evaluated at search time. Can be used to sort
/// the search results, define other expressions, or return computed information
/// in the search results.
pub const Expression = struct {
    expression_name: []const u8,

    expression_value: []const u8,
};
