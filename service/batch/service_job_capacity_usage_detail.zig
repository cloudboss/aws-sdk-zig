/// The capacity usage for a service job, including the unit of
/// measure and quantity of resources being consumed.
pub const ServiceJobCapacityUsageDetail = struct {
    /// The unit of measure for the service job capacity usage. For service jobs,
    /// this is the
    /// instance type.
    capacity_unit: ?[]const u8 = null,

    /// The quantity of capacity being used by the service job, measured in the
    /// units
    /// specified by `capacityUnit`.
    quantity: ?f64 = null,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .quantity = "quantity",
    };
};
