const CustomLineItemFlatChargeDetails = @import("custom_line_item_flat_charge_details.zig").CustomLineItemFlatChargeDetails;
const LineItemFilter = @import("line_item_filter.zig").LineItemFilter;
const CustomLineItemPercentageChargeDetails = @import("custom_line_item_percentage_charge_details.zig").CustomLineItemPercentageChargeDetails;
const CustomLineItemType = @import("custom_line_item_type.zig").CustomLineItemType;

/// The charge details of a custom line item. It should contain only one of
/// `Flat` or `Percentage`.
pub const CustomLineItemChargeDetails = struct {
    /// A `CustomLineItemFlatChargeDetails` that describes the charge details of a
    /// flat custom line item.
    flat: ?CustomLineItemFlatChargeDetails = null,

    /// A representation of the line item filter.
    line_item_filters: ?[]const LineItemFilter = null,

    /// A `CustomLineItemPercentageChargeDetails` that describes the charge details
    /// of a percentage custom line item.
    percentage: ?CustomLineItemPercentageChargeDetails = null,

    /// The type of the custom line item that indicates whether the charge is a fee
    /// or credit.
    @"type": CustomLineItemType,

    pub const json_field_names = .{
        .flat = "Flat",
        .line_item_filters = "LineItemFilters",
        .percentage = "Percentage",
        .@"type" = "Type",
    };
};
