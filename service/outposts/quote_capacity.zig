const QuoteCapacityType = @import("quote_capacity_type.zig").QuoteCapacityType;

/// A capacity requirement for a quote. Specifies the type of capacity, the
/// unit, and the
/// quantity.
pub const QuoteCapacity = struct {
    /// The quantity of the specified capacity unit. For Amazon EC2, this is the
    /// number of
    /// additional instances to add to the Outpost. For Amazon EBS and Amazon S3,
    /// this is the total
    /// desired end-state capacity of the Outpost.
    quantity: ?f32 = null,

    /// The type of capacity. Valid values are `EC2`, `EBS`, and
    /// `S3`.
    quote_capacity_type: ?QuoteCapacityType = null,

    /// The unit of measurement for the capacity. For Amazon EC2, this is the
    /// instance type (for
    /// example, `c5.24xlarge`). For Amazon EBS and Amazon S3, this is the storage
    /// unit (for
    /// example, `TiB` for tebibytes).
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .quantity = "Quantity",
        .quote_capacity_type = "QuoteCapacityType",
        .unit = "Unit",
    };
};
