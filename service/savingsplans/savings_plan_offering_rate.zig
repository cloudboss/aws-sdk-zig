const SavingsPlanProductType = @import("savings_plan_product_type.zig").SavingsPlanProductType;
const SavingsPlanOfferingRateProperty = @import("savings_plan_offering_rate_property.zig").SavingsPlanOfferingRateProperty;
const ParentSavingsPlanOffering = @import("parent_savings_plan_offering.zig").ParentSavingsPlanOffering;
const SavingsPlanRateServiceCode = @import("savings_plan_rate_service_code.zig").SavingsPlanRateServiceCode;
const SavingsPlanRateUnit = @import("savings_plan_rate_unit.zig").SavingsPlanRateUnit;

/// Information about a Savings Plan offering rate.
pub const SavingsPlanOfferingRate = struct {
    /// The specific Amazon Web Services operation for the line item in the billing
    /// report.
    operation: ?[]const u8,

    /// The product type.
    product_type: ?SavingsPlanProductType,

    /// The properties.
    properties: ?[]const SavingsPlanOfferingRateProperty,

    /// The Savings Plan rate.
    rate: ?[]const u8,

    /// The Savings Plan offering.
    savings_plan_offering: ?ParentSavingsPlanOffering,

    /// The service.
    service_code: ?SavingsPlanRateServiceCode,

    /// The unit.
    unit: ?SavingsPlanRateUnit,

    /// The usage details of the line item in the billing report.
    usage_type: ?[]const u8,

    pub const json_field_names = .{
        .operation = "operation",
        .product_type = "productType",
        .properties = "properties",
        .rate = "rate",
        .savings_plan_offering = "savingsPlanOffering",
        .service_code = "serviceCode",
        .unit = "unit",
        .usage_type = "usageType",
    };
};
