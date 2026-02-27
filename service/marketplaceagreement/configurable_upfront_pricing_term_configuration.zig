const Dimension = @import("dimension.zig").Dimension;

/// Defines a prepaid payment model that allows buyers to configure the
/// entitlements they want to purchase and the duration.
pub const ConfigurableUpfrontPricingTermConfiguration = struct {
    /// Defines the dimensions that the acceptor has purchased from the overall set
    /// of dimensions presented in the rate card.
    dimensions: []const Dimension,

    /// Defines the length of time for which the particular pricing/dimension is
    /// being purchased by the acceptor.
    selector_value: []const u8,

    pub const json_field_names = .{
        .dimensions = "dimensions",
        .selector_value = "selectorValue",
    };
};
