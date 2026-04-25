/// The capacity usage for a quota share, including units of compute capacity
/// and quantity of resources being used.
pub const QuotaShareCapacityUsage = struct {
    /// The unit of compute capacity for the capacity usage.
    capacity_unit: ?[]const u8 = null,

    /// The quantity of capacity being used.
    quantity: ?f64 = null,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .quantity = "quantity",
    };
};
