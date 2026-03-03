/// Current information about a consumable resource.
pub const ConsumableResourceSummary = struct {
    /// The Amazon Resource Name (ARN) of the consumable resource.
    consumable_resource_arn: []const u8,

    /// The name of the consumable resource.
    consumable_resource_name: []const u8,

    /// The amount of the consumable resource that is currently in use.
    in_use_quantity: ?i64 = null,

    /// Indicates whether the resource is available to be re-used after a job
    /// completes. Can be
    /// one of:
    ///
    /// * `REPLENISHABLE`
    ///
    /// * `NON_REPLENISHABLE`
    resource_type: ?[]const u8 = null,

    /// The total amount of the consumable resource that is available.
    total_quantity: ?i64 = null,

    pub const json_field_names = .{
        .consumable_resource_arn = "consumableResourceArn",
        .consumable_resource_name = "consumableResourceName",
        .in_use_quantity = "inUseQuantity",
        .resource_type = "resourceType",
        .total_quantity = "totalQuantity",
    };
};
