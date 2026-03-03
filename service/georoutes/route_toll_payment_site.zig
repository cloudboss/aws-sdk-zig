/// Locations or sites where the toll fare is collected.
pub const RouteTollPaymentSite = struct {
    /// Name of the payment site.
    name: ?[]const u8 = null,

    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    pub const json_field_names = .{
        .name = "Name",
        .position = "Position",
    };
};
