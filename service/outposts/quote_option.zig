const QuoteCapacity = @import("quote_capacity.zig").QuoteCapacity;
const CapacitySummary = @import("capacity_summary.zig").CapacitySummary;
const PricingOption = @import("pricing_option.zig").PricingOption;
const QuoteSpecification = @import("quote_specification.zig").QuoteSpecification;

/// A configuration and pricing option for a quote. Each option includes the
/// capacity
/// breakdown, physical specifications for the racks or servers, and pricing
/// details.
pub const QuoteOption = struct {
    /// The capacities included in this quote option.
    capacities: ?[]const QuoteCapacity = null,

    /// A summary of the existing, final, and changed capacity for this quote
    /// option.
    capacity_summary: ?CapacitySummary = null,

    /// The pricing options for this quote option.
    pricing_options: ?[]const PricingOption = null,

    /// The ID of the quote option.
    quote_option_identifier: ?[]const u8 = null,

    /// The physical specifications for the racks or servers in this quote option.
    specifications: ?[]const QuoteSpecification = null,

    pub const json_field_names = .{
        .capacities = "Capacities",
        .capacity_summary = "CapacitySummary",
        .pricing_options = "PricingOptions",
        .quote_option_identifier = "QuoteOptionIdentifier",
        .specifications = "Specifications",
    };
};
