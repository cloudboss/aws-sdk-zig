/// A representation of the charge details that are associated with a flat
/// custom line item.
pub const CustomLineItemFlatChargeDetails = struct {
    /// The custom line item's fixed charge value in USD.
    charge_value: f64,

    pub const json_field_names = .{
        .charge_value = "ChargeValue",
    };
};
