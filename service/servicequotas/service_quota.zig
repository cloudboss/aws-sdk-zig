const ErrorReason = @import("error_reason.zig").ErrorReason;
const QuotaPeriod = @import("quota_period.zig").QuotaPeriod;
const AppliedLevelEnum = @import("applied_level_enum.zig").AppliedLevelEnum;
const QuotaContextInfo = @import("quota_context_info.zig").QuotaContextInfo;
const MetricInfo = @import("metric_info.zig").MetricInfo;

/// Information about a quota.
pub const ServiceQuota = struct {
    /// Indicates whether the quota value can be increased.
    adjustable: bool = false,

    /// The quota description.
    description: ?[]const u8,

    /// The error code and error reason.
    error_reason: ?ErrorReason,

    /// Indicates whether the quota is global.
    global_quota: bool = false,

    /// The period of time.
    period: ?QuotaPeriod,

    /// Filters the response to return applied quota values for the `ACCOUNT`,
    /// `RESOURCE`, or `ALL` levels. `ACCOUNT` is the default.
    quota_applied_at_level: ?AppliedLevelEnum,

    /// The Amazon Resource Name (ARN) of the quota.
    quota_arn: ?[]const u8,

    /// Specifies the quota identifier. To find the quota code for a specific
    /// quota, use the ListServiceQuotas operation, and look for the
    /// `QuotaCode` response in the output for the quota you want.
    quota_code: ?[]const u8,

    /// The context for this service quota.
    quota_context: ?QuotaContextInfo,

    /// Specifies the quota name.
    quota_name: ?[]const u8,

    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: ?[]const u8,

    /// Specifies the service name.
    service_name: ?[]const u8,

    /// The unit of measurement.
    unit: ?[]const u8,

    /// Information about the measurement.
    usage_metric: ?MetricInfo,

    /// The quota value.
    value: ?f64,

    pub const json_field_names = .{
        .adjustable = "Adjustable",
        .description = "Description",
        .error_reason = "ErrorReason",
        .global_quota = "GlobalQuota",
        .period = "Period",
        .quota_applied_at_level = "QuotaAppliedAtLevel",
        .quota_arn = "QuotaArn",
        .quota_code = "QuotaCode",
        .quota_context = "QuotaContext",
        .quota_name = "QuotaName",
        .service_code = "ServiceCode",
        .service_name = "ServiceName",
        .unit = "Unit",
        .usage_metric = "UsageMetric",
        .value = "Value",
    };
};
