/// The fleet amount and attribute capabilities.
pub const FleetAmountCapability = struct {
    /// The maximum amount of the fleet worker capability.
    max: ?f32,

    /// The minimum amount of fleet worker capability.
    min: f32,

    /// The name of the fleet capability.
    name: []const u8,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
        .name = "name",
    };
};
