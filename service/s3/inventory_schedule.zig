const InventoryFrequency = @import("inventory_frequency.zig").InventoryFrequency;

/// Specifies the schedule for generating S3 Inventory results.
pub const InventorySchedule = struct {
    /// Specifies how frequently inventory results are produced.
    frequency: InventoryFrequency,
};
