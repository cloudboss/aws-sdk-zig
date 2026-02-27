const RouteTollPrice = @import("route_toll_price.zig").RouteTollPrice;
const RouteTollPass = @import("route_toll_pass.zig").RouteTollPass;
const RouteTollPaymentMethod = @import("route_toll_payment_method.zig").RouteTollPaymentMethod;
const RouteTransponder = @import("route_transponder.zig").RouteTransponder;

/// The toll rate.
pub const RouteTollRate = struct {
    /// Time when the rate is valid.
    applicable_times: ?[]const u8,

    /// Price in the converted currency as specified in the request.
    converted_price: ?RouteTollPrice,

    /// The Toll rate Id.
    id: []const u8,

    /// Price in the local regional currency.
    local_price: RouteTollPrice,

    /// The name of the toll.
    name: []const u8,

    /// Details if the toll rate can be a pass that supports multiple trips.
    pass: ?RouteTollPass,

    /// Accepted payment methods at the toll.
    payment_methods: []const RouteTollPaymentMethod,

    /// Transponders for which this toll can be applied.
    transponders: []const RouteTransponder,

    pub const json_field_names = .{
        .applicable_times = "ApplicableTimes",
        .converted_price = "ConvertedPrice",
        .id = "Id",
        .local_price = "LocalPrice",
        .name = "Name",
        .pass = "Pass",
        .payment_methods = "PaymentMethods",
        .transponders = "Transponders",
    };
};
