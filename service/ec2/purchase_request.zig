/// Describes a request to purchase Scheduled Instances.
pub const PurchaseRequest = struct {
    /// The number of instances.
    instance_count: i32,

    /// The purchase token.
    purchase_token: []const u8,
};
