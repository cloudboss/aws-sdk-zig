const OrderBy = @import("order_by.zig").OrderBy;
const PropertyFilter = @import("property_filter.zig").PropertyFilter;

/// The tabular conditions.
pub const TabularConditions = struct {
    /// Filter criteria that orders the output. It can be sorted in ascending or
    /// descending
    /// order.
    order_by: ?[]const OrderBy = null,

    /// You can filter the request using various logical operators and a key-value
    /// format. For
    /// example:
    ///
    /// `{"key": "serverType", "value": "webServer"}`
    property_filters: ?[]const PropertyFilter = null,

    pub const json_field_names = .{
        .order_by = "orderBy",
        .property_filters = "propertyFilters",
    };
};
