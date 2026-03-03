const FleetAmountCapability = @import("fleet_amount_capability.zig").FleetAmountCapability;
const FleetAttributeCapability = @import("fleet_attribute_capability.zig").FleetAttributeCapability;

/// The amounts and attributes of fleets.
pub const FleetCapabilities = struct {
    /// Amount capabilities of the fleet.
    amounts: ?[]const FleetAmountCapability = null,

    /// Attribute capabilities of the fleet.
    attributes: ?[]const FleetAttributeCapability = null,

    pub const json_field_names = .{
        .amounts = "amounts",
        .attributes = "attributes",
    };
};
