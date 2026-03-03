const aws = @import("aws");

const SamplingRateBoost = @import("sampling_rate_boost.zig").SamplingRateBoost;

/// A document specifying changes to a sampling rule's configuration.
pub const SamplingRuleUpdate = struct {
    /// Matches attributes derived from the request.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The percentage of matching requests to instrument, after the reservoir is
    /// exhausted.
    fixed_rate: ?f64 = null,

    /// Matches the hostname from a request URL.
    host: ?[]const u8 = null,

    /// Matches the HTTP method of a request.
    http_method: ?[]const u8 = null,

    /// The priority of the sampling rule.
    priority: ?i32 = null,

    /// A fixed number of matching requests to instrument per second, prior to
    /// applying the
    /// fixed rate. The reservoir is not used directly by services, but applies to
    /// all services using the rule collectively.
    reservoir_size: ?i32 = null,

    /// Matches the ARN of the Amazon Web Services resource on which the service
    /// runs.
    resource_arn: ?[]const u8 = null,

    /// The ARN of the sampling rule. Specify a rule by either name or ARN, but not
    /// both.
    rule_arn: ?[]const u8 = null,

    /// The name of the sampling rule. Specify a rule by either name or ARN, but not
    /// both.
    rule_name: ?[]const u8 = null,

    /// Specifies the multiplier applied to the base sampling rate.
    /// This boost allows you to temporarily increase sampling without changing the
    /// rule's configuration.
    sampling_rate_boost: ?SamplingRateBoost = null,

    /// Matches the `name` that the service uses to identify itself in segments.
    service_name: ?[]const u8 = null,

    /// Matches the `origin` that the service uses to identify its type in segments.
    service_type: ?[]const u8 = null,

    /// Matches the path from a request URL.
    url_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .fixed_rate = "FixedRate",
        .host = "Host",
        .http_method = "HTTPMethod",
        .priority = "Priority",
        .reservoir_size = "ReservoirSize",
        .resource_arn = "ResourceARN",
        .rule_arn = "RuleARN",
        .rule_name = "RuleName",
        .sampling_rate_boost = "SamplingRateBoost",
        .service_name = "ServiceName",
        .service_type = "ServiceType",
        .url_path = "URLPath",
    };
};
