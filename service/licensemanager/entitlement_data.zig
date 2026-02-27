const EntitlementDataUnit = @import("entitlement_data_unit.zig").EntitlementDataUnit;

/// Data associated with an entitlement resource.
pub const EntitlementData = struct {
    /// Entitlement data name.
    name: []const u8,

    /// Entitlement data unit.
    unit: EntitlementDataUnit,

    /// Entitlement data value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .unit = "Unit",
        .value = "Value",
    };
};
