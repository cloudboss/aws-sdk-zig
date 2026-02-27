const UpdateCustomLineItemFlatChargeDetails = @import("update_custom_line_item_flat_charge_details.zig").UpdateCustomLineItemFlatChargeDetails;
const LineItemFilter = @import("line_item_filter.zig").LineItemFilter;
const UpdateCustomLineItemPercentageChargeDetails = @import("update_custom_line_item_percentage_charge_details.zig").UpdateCustomLineItemPercentageChargeDetails;

/// A representation of the new charge details of a custom line item. This
/// should contain only one of `Flat` or `Percentage`.
pub const UpdateCustomLineItemChargeDetails = struct {
    /// An `UpdateCustomLineItemFlatChargeDetails` that describes the new charge
    /// details of a flat custom line item.
    flat: ?UpdateCustomLineItemFlatChargeDetails,

    /// A representation of the line item filter.
    line_item_filters: ?[]const LineItemFilter,

    /// An `UpdateCustomLineItemPercentageChargeDetails` that describes the new
    /// charge details of a percentage custom line item.
    percentage: ?UpdateCustomLineItemPercentageChargeDetails,

    pub const json_field_names = .{
        .flat = "Flat",
        .line_item_filters = "LineItemFilters",
        .percentage = "Percentage",
    };
};
