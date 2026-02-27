const DurationUnits = @import("duration_units.zig").DurationUnits;
const PriceUnits = @import("price_units.zig").PriceUnits;
const ResourceSpecification = @import("resource_specification.zig").ResourceSpecification;

/// A savings plan that reserves a certain amount of outbound bandwidth usage at
/// a discounted rate each month over a period of time.
pub const Offering = struct {
    /// The type of currency that is used for billing. The currencyCode used for all
    /// reservations is US dollars.
    currency_code: []const u8,

    /// The length of time that your reservation would be active.
    duration: i32,

    /// The unit of measurement for the duration of the offering.
    duration_units: DurationUnits,

    /// The Amazon Resource Name (ARN) that MediaConnect assigns to the offering.
    offering_arn: []const u8,

    /// A description of the offering.
    offering_description: []const u8,

    /// The cost of a single unit. This value, in combination with priceUnits, makes
    /// up the rate.
    price_per_unit: []const u8,

    /// The unit of measurement that is used for billing. This value, in combination
    /// with pricePerUnit, makes up the rate.
    price_units: PriceUnits,

    /// A definition of the amount of outbound bandwidth that you would be reserving
    /// if you purchase the offering.
    resource_specification: ResourceSpecification,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .duration_units = "DurationUnits",
        .offering_arn = "OfferingArn",
        .offering_description = "OfferingDescription",
        .price_per_unit = "PricePerUnit",
        .price_units = "PriceUnits",
        .resource_specification = "ResourceSpecification",
    };
};
