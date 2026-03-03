/// Information about a quota's utilization, including the quota code, service
/// information,
/// current usage, and applied limits.
pub const QuotaUtilizationInfo = struct {
    /// Indicates whether the quota value can be increased.
    adjustable: bool = false,

    /// The applied value of the quota, which may be higher than the default value
    /// if a quota
    /// increase has been requested and approved.
    applied_value: ?f64 = null,

    /// The default value of the quota.
    default_value: ?f64 = null,

    /// The namespace of the metric used to track quota usage.
    namespace: ?[]const u8 = null,

    /// The quota identifier.
    quota_code: ?[]const u8 = null,

    /// The quota name.
    quota_name: ?[]const u8 = null,

    /// The service identifier.
    service_code: ?[]const u8 = null,

    /// The service name.
    service_name: ?[]const u8 = null,

    /// The utilization percentage of the quota, calculated as (current usage /
    /// applied value) × 100.
    /// Values range from 0.0 to 100.0 or higher if usage exceeds the quota limit.
    utilization: ?f64 = null,

    pub const json_field_names = .{
        .adjustable = "Adjustable",
        .applied_value = "AppliedValue",
        .default_value = "DefaultValue",
        .namespace = "Namespace",
        .quota_code = "QuotaCode",
        .quota_name = "QuotaName",
        .service_code = "ServiceCode",
        .service_name = "ServiceName",
        .utilization = "Utilization",
    };
};
