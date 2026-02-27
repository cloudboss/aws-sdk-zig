/// Information about a quota increase request.
pub const ServiceQuotaIncreaseRequestInTemplate = struct {
    /// The Amazon Web Services Region.
    aws_region: ?[]const u8,

    /// The new, increased value of the quota.
    desired_value: ?f64,

    /// Indicates whether the quota is global.
    global_quota: bool = false,

    /// Specifies the quota identifier. To find the quota code for a specific
    /// quota, use the ListServiceQuotas operation, and look for the
    /// `QuotaCode` response in the output for the quota you want.
    quota_code: ?[]const u8,

    /// Specifies the quota name.
    quota_name: ?[]const u8,

    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: ?[]const u8,

    /// Specifies the service name.
    service_name: ?[]const u8,

    /// The unit of measurement.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .desired_value = "DesiredValue",
        .global_quota = "GlobalQuota",
        .quota_code = "QuotaCode",
        .quota_name = "QuotaName",
        .service_code = "ServiceCode",
        .service_name = "ServiceName",
        .unit = "Unit",
    };
};
