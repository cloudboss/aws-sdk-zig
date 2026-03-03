const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const SavingsPlanProductType = @import("savings_plan_product_type.zig").SavingsPlanProductType;
const SavingsPlanRateProperty = @import("savings_plan_rate_property.zig").SavingsPlanRateProperty;
const SavingsPlanRateServiceCode = @import("savings_plan_rate_service_code.zig").SavingsPlanRateServiceCode;
const SavingsPlanRateUnit = @import("savings_plan_rate_unit.zig").SavingsPlanRateUnit;

/// Information about a Savings Plan rate.
pub const SavingsPlanRate = struct {
    /// The currency.
    currency: ?CurrencyCode = null,

    /// The specific Amazon Web Services operation for the line item in the billing
    /// report.
    operation: ?[]const u8 = null,

    /// The product type.
    product_type: ?SavingsPlanProductType = null,

    /// The properties.
    properties: ?[]const SavingsPlanRateProperty = null,

    /// The rate.
    rate: ?[]const u8 = null,

    /// The service.
    service_code: ?SavingsPlanRateServiceCode = null,

    /// The unit.
    unit: ?SavingsPlanRateUnit = null,

    /// The usage details of the line item in the billing report.
    usage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency = "currency",
        .operation = "operation",
        .product_type = "productType",
        .properties = "properties",
        .rate = "rate",
        .service_code = "serviceCode",
        .unit = "unit",
        .usage_type = "usageType",
    };
};
