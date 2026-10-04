const EC2Capacity = @import("ec2_capacity.zig").EC2Capacity;
const RackUnitHeight = @import("rack_unit_height.zig").RackUnitHeight;

/// The physical specification details for a server in a quote option.
pub const ServerSpecificationDetails = struct {
    /// The Amazon EC2 capacities for the server.
    ec2_capacities: ?[]const EC2Capacity = null,

    /// The rack unit height of the server.
    ///
    /// * `HEIGHT_2U` - 2 rack units.
    ///
    /// * `HEIGHT_1U` - 1 rack unit.
    rack_unit_height: ?RackUnitHeight = null,

    /// The depth of the server in inches.
    server_depth_inches: ?f32 = null,

    /// The height of the server in inches.
    server_height_inches: ?f32 = null,

    /// The maximum power draw of the server in kVA.
    server_power_draw_kva: ?f32 = null,

    /// The weight of the server in pounds.
    server_weight_lbs: ?f32 = null,

    /// The width of the server in inches.
    server_width_inches: ?f32 = null,

    pub const json_field_names = .{
        .ec2_capacities = "EC2Capacities",
        .rack_unit_height = "RackUnitHeight",
        .server_depth_inches = "ServerDepthInches",
        .server_height_inches = "ServerHeightInches",
        .server_power_draw_kva = "ServerPowerDrawKva",
        .server_weight_lbs = "ServerWeightLbs",
        .server_width_inches = "ServerWidthInches",
    };
};
