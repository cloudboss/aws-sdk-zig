/// Service-level usage details by account.
pub const ServiceLevelAccountUsage = struct {
    /// The service code for which to return Support-eligible spend data.
    service_code: ?[]const u8 = null,

    /// The total support-eligible spend for the service.
    total_support_eligible_spend: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_code = "serviceCode",
        .total_support_eligible_spend = "totalSupportEligibleSpend",
    };
};
