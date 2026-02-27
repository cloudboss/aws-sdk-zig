/// A representation of the charge details that are associated with a percentage
/// custom line item.
pub const ListCustomLineItemPercentageChargeDetails = struct {
    /// The custom line item's percentage value. This will be multiplied against the
    /// combined value of its associated resources to determine its charge value.
    percentage_value: f64,

    pub const json_field_names = .{
        .percentage_value = "PercentageValue",
    };
};
