/// Defines the capacity limit for a quota share, or the type and maximum
/// quantity of a particular resource that can be allocated to jobs in the quota
/// share
/// without borrowing.
pub const QuotaShareCapacityLimit = struct {
    /// The unit of compute capacity for the capacityLimit. For example,
    /// `ml.m5.large`.
    capacity_unit: []const u8,

    /// The maximum capacity available for the quota share. This value represents
    /// the maximum quantity of a resource that can be allocated to jobs in the
    /// quota share
    /// without borrowing.
    max_capacity: i32,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .max_capacity = "maxCapacity",
    };
};
