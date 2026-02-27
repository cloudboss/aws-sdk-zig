/// Information about a consumable resource required to run a job.
pub const ConsumableResourceRequirement = struct {
    /// The name or ARN of the consumable resource.
    consumable_resource: ?[]const u8,

    /// The quantity of the consumable resource that is needed.
    quantity: ?i64,

    pub const json_field_names = .{
        .consumable_resource = "consumableResource",
        .quantity = "quantity",
    };
};
