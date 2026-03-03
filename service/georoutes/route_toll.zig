const RouteTollPaymentSite = @import("route_toll_payment_site.zig").RouteTollPaymentSite;
const RouteTollRate = @import("route_toll_rate.zig").RouteTollRate;

/// Provides details about toll information along a route, including the payment
/// sites, applicable toll rates, toll systems, and the country associated with
/// the toll collection.
pub const RouteToll = struct {
    /// The alpha-2 or alpha-3 character code for the country.
    country: ?[]const u8 = null,

    /// Locations or sites where the toll fare is collected.
    payment_sites: []const RouteTollPaymentSite,

    /// Toll rates that need to be paid to travel this leg of the route.
    rates: []const RouteTollRate,

    /// Toll systems are authorities that collect payments for the toll.
    systems: []const i32,

    pub const json_field_names = .{
        .country = "Country",
        .payment_sites = "PaymentSites",
        .rates = "Rates",
        .systems = "Systems",
    };
};
