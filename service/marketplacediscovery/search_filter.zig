const SearchFilterType = @import("search_filter_type.zig").SearchFilterType;

/// A filter used to narrow search results by attribute, such as category,
/// pricing model, or fulfillment type.
pub const SearchFilter = struct {
    /// The type of filter to apply.
    filter_type: SearchFilterType,

    /// The values to filter by. Term filters accept multiple values (OR logic).
    /// Range filters (MIN/MAX_AVERAGE_CUSTOMER_RATING) accept a single value
    /// between 0.0 and 5.0.
    filter_values: []const []const u8,

    pub const json_field_names = .{
        .filter_type = "filterType",
        .filter_values = "filterValues",
    };
};
