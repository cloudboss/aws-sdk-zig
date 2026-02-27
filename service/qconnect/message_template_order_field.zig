const Order = @import("order.zig").Order;

/// The message template fields to order the message template query results by.
/// The following is the list of supported field names:
///
/// * name
/// * description
/// * channel
/// * channelSubtype
/// * language
/// * qualifier
/// * createdTime
/// * lastModifiedTime
/// * lastModifiedBy
/// * groupingConfiguration.criteria
/// * groupingConfiguration.values
pub const MessageTemplateOrderField = struct {
    /// The name of the message template.
    name: []const u8,

    /// The order at which the message templates are sorted by.
    order: ?Order,

    pub const json_field_names = .{
        .name = "name",
        .order = "order",
    };
};
