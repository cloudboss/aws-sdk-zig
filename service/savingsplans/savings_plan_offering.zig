const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const SavingsPlanPaymentOption = @import("savings_plan_payment_option.zig").SavingsPlanPaymentOption;
const SavingsPlanType = @import("savings_plan_type.zig").SavingsPlanType;
const SavingsPlanProductType = @import("savings_plan_product_type.zig").SavingsPlanProductType;
const SavingsPlanOfferingProperty = @import("savings_plan_offering_property.zig").SavingsPlanOfferingProperty;

/// Information about a Savings Plan offering.
pub const SavingsPlanOffering = struct {
    /// The currency.
    currency: ?CurrencyCode,

    /// The description.
    description: ?[]const u8,

    /// The duration, in seconds.
    duration_seconds: i64 = 0,

    /// The ID of the offering.
    offering_id: ?[]const u8,

    /// The specific Amazon Web Services operation for the line item in the billing
    /// report.
    operation: ?[]const u8,

    /// The payment option.
    payment_option: ?SavingsPlanPaymentOption,

    /// The plan type.
    plan_type: ?SavingsPlanType,

    /// The product type.
    product_types: ?[]const SavingsPlanProductType,

    /// The properties.
    properties: ?[]const SavingsPlanOfferingProperty,

    /// The service.
    service_code: ?[]const u8,

    /// The usage details of the line item in the billing report.
    usage_type: ?[]const u8,

    pub const json_field_names = .{
        .currency = "currency",
        .description = "description",
        .duration_seconds = "durationSeconds",
        .offering_id = "offeringId",
        .operation = "operation",
        .payment_option = "paymentOption",
        .plan_type = "planType",
        .product_types = "productTypes",
        .properties = "properties",
        .service_code = "serviceCode",
        .usage_type = "usageType",
    };
};
