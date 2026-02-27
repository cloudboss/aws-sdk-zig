const EntitlementUnit = @import("entitlement_unit.zig").EntitlementUnit;

/// Describes a resource entitled for use with a license.
pub const Entitlement = struct {
    /// Indicates whether check-ins are allowed.
    allow_check_in: ?bool,

    /// Maximum entitlement count. Use if the unit is not None.
    max_count: ?i64,

    /// Entitlement name.
    name: []const u8,

    /// Indicates whether overages are allowed.
    overage: ?bool,

    /// Entitlement unit.
    unit: EntitlementUnit,

    /// Entitlement resource. Use only if the unit is None.
    value: ?[]const u8,

    pub const json_field_names = .{
        .allow_check_in = "AllowCheckIn",
        .max_count = "MaxCount",
        .name = "Name",
        .overage = "Overage",
        .unit = "Unit",
        .value = "Value",
    };
};
