/// The capacity usage for a job, including the unit of measure
/// and quantity of resources being used.
pub const JobCapacityUsageSummary = struct {
    /// The unit of measure for the capacity usage. This is
    /// `VCPU` for Amazon EC2 and `cpu` for Amazon EKS.
    capacity_unit: ?[]const u8 = null,

    /// The quantity of capacity being used by the job, measured in the units
    /// specified by
    /// `capacityUnit`.
    quantity: ?f64 = null,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .quantity = "quantity",
    };
};
