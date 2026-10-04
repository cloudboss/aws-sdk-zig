const RouteEngineType = @import("route_engine_type.zig").RouteEngineType;
const RouteTaxiMode = @import("route_taxi_mode.zig").RouteTaxiMode;

/// Transport mode details for the taxi leg.
pub const RouteTaxiTransportModeDetails = struct {
    /// Number of available seats in the vehicle.
    available_seats: ?i32 = null,

    /// Human readable transport category.
    category: ?[]const u8 = null,

    /// Color of the transport polyline and background for the transport name.
    color: ?[]const u8 = null,

    /// Vehicle engine type.
    engine: ?RouteEngineType = null,

    /// Vehicle license plate number.
    license_plate: ?[]const u8 = null,

    /// Mode of the taxi transport.
    mode: RouteTaxiMode,

    /// Vehicle model.
    model: ?[]const u8 = null,

    /// Vehicle name or mobility provider name.
    name: ?[]const u8 = null,

    /// Color of the transport name text.
    text_color: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_seats = "AvailableSeats",
        .category = "Category",
        .color = "Color",
        .engine = "Engine",
        .license_plate = "LicensePlate",
        .mode = "Mode",
        .model = "Model",
        .name = "Name",
        .text_color = "TextColor",
    };
};
