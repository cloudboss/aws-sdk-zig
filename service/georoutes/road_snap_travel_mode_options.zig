const RoadSnapTruckOptions = @import("road_snap_truck_options.zig").RoadSnapTruckOptions;

/// Travel mode related options for the provided travel mode.
pub const RoadSnapTravelModeOptions = struct {
    /// Travel mode options when the provided travel mode is "Truck".
    truck: ?RoadSnapTruckOptions = null,

    pub const json_field_names = .{
        .truck = "Truck",
    };
};
