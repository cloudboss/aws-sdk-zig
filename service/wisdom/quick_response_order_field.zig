const Order = @import("order.zig").Order;

/// The quick response fields to order the quick response query results by.
///
/// The following is the list of supported field names.
///
/// * name
///
/// * description
///
/// * shortcutKey
///
/// * isActive
///
/// * channels
///
/// * language
///
/// * contentType
///
/// * createdTime
///
/// * lastModifiedTime
///
/// * lastModifiedBy
///
/// * groupingConfiguration.criteria
///
/// * groupingConfiguration.values
pub const QuickResponseOrderField = struct {
    /// The name of the attribute to order the quick response query results by.
    name: []const u8,

    /// The order at which the quick responses are sorted by.
    order: ?Order,

    pub const json_field_names = .{
        .name = "name",
        .order = "order",
    };
};
