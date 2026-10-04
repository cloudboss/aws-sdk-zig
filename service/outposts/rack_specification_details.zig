const EC2Capacity = @import("ec2_capacity.zig").EC2Capacity;
const RackUnitHeight = @import("rack_unit_height.zig").RackUnitHeight;
const QuoteRackUseType = @import("quote_rack_use_type.zig").QuoteRackUseType;

/// The physical specification details for a rack in a quote option.
pub const RackSpecificationDetails = struct {
    /// The Amazon EC2 capacities for the rack.
    ec2_capacities: ?[]const EC2Capacity = null,

    /// The depth of the rack in inches.
    rack_depth_inches: ?f32 = null,

    /// The height of the rack in inches.
    rack_height_inches: ?f32 = null,

    /// The ID of the rack.
    rack_id: ?[]const u8 = null,

    /// The maximum power draw of the rack in kVA.
    rack_power_draw_kva: ?f32 = null,

    /// The rack unit height.
    ///
    /// * `HEIGHT_42U` - 42 rack units.
    ///
    /// * `HEIGHT_2U` - 2 rack units.
    ///
    /// * `HEIGHT_1U` - 1 rack unit.
    rack_unit_height: ?RackUnitHeight = null,

    /// The use of the rack. Valid values are `COMPUTE` and
    /// `NETWORKING`.
    rack_use: ?QuoteRackUseType = null,

    /// The weight of the rack in pounds.
    rack_weight_lbs: ?f32 = null,

    /// The width of the rack in inches.
    rack_width_inches: ?f32 = null,

    pub const json_field_names = .{
        .ec2_capacities = "EC2Capacities",
        .rack_depth_inches = "RackDepthInches",
        .rack_height_inches = "RackHeightInches",
        .rack_id = "RackId",
        .rack_power_draw_kva = "RackPowerDrawKva",
        .rack_unit_height = "RackUnitHeight",
        .rack_use = "RackUse",
        .rack_weight_lbs = "RackWeightLbs",
        .rack_width_inches = "RackWidthInches",
    };
};
