const ListCustomLineItemFlatChargeDetails = @import("list_custom_line_item_flat_charge_details.zig").ListCustomLineItemFlatChargeDetails;
const LineItemFilter = @import("line_item_filter.zig").LineItemFilter;
const ListCustomLineItemPercentageChargeDetails = @import("list_custom_line_item_percentage_charge_details.zig").ListCustomLineItemPercentageChargeDetails;
const CustomLineItemType = @import("custom_line_item_type.zig").CustomLineItemType;

/// A representation of the charge details of a custom line item.
pub const ListCustomLineItemChargeDetails = struct {
    /// A `ListCustomLineItemFlatChargeDetails` that describes the charge details of
    /// a flat custom line item.
    flat: ?ListCustomLineItemFlatChargeDetails,

    /// A representation of the line item filter.
    line_item_filters: ?[]const LineItemFilter,

    /// A `ListCustomLineItemPercentageChargeDetails` that describes the charge
    /// details of a percentage custom line item.
    percentage: ?ListCustomLineItemPercentageChargeDetails,

    /// The type of the custom line item that indicates whether the charge is a
    /// `fee` or `credit`.
    type: CustomLineItemType,

    pub const json_field_names = .{
        .flat = "Flat",
        .line_item_filters = "LineItemFilters",
        .percentage = "Percentage",
        .type = "Type",
    };
};
