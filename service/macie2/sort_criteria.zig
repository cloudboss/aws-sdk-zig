const OrderBy = @import("order_by.zig").OrderBy;

/// Specifies criteria for sorting the results of a request for findings.
pub const SortCriteria = struct {
    /// The name of the property to sort the results by. Valid values are: count,
    /// createdAt, policyDetails.action.apiCallDetails.firstSeen,
    /// policyDetails.action.apiCallDetails.lastSeen, resourcesAffected,
    /// severity.score, type, and updatedAt.
    attribute_name: ?[]const u8,

    /// The sort order to apply to the results, based on the value for the property
    /// specified by the attributeName property. Valid values are: ASC, sort the
    /// results in ascending order; and, DESC, sort the results in descending order.
    order_by: ?OrderBy,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .order_by = "orderBy",
    };
};
