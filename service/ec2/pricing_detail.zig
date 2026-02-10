/// Describes a Reserved Instance offering.
pub const PricingDetail = struct {
    /// The number of reservations available for the price.
    count: ?i32,

    /// The price per instance.
    price: ?f64,
};
