/// The capacity usage for a fairshare scheduling job queue.
pub const FairshareCapacityUsage = struct {
    /// The unit of measure for the capacity usage. For compute jobs, this is
    /// `VCPU` for Amazon EC2 and `cpu` for Amazon EKS. For service jobs, this is
    /// the instance type.
    capacity_unit: ?[]const u8 = null,

    /// The quantity of capacity being used, measured in the units specified by
    /// `capacityUnit`.
    quantity: ?f64 = null,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .quantity = "quantity",
    };
};
