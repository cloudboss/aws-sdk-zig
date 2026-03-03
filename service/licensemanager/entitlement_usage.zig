const EntitlementDataUnit = @import("entitlement_data_unit.zig").EntitlementDataUnit;

/// Usage associated with an entitlement resource.
pub const EntitlementUsage = struct {
    /// Resource usage consumed.
    consumed_value: []const u8,

    /// Maximum entitlement usage count.
    max_count: ?[]const u8 = null,

    /// Entitlement usage name.
    name: []const u8,

    /// Entitlement usage unit.
    unit: EntitlementDataUnit,

    pub const json_field_names = .{
        .consumed_value = "ConsumedValue",
        .max_count = "MaxCount",
        .name = "Name",
        .unit = "Unit",
    };
};
