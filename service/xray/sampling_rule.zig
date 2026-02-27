const aws = @import("aws");

const SamplingRateBoost = @import("sampling_rate_boost.zig").SamplingRateBoost;

/// A sampling rule that services use to decide whether to instrument a request.
/// Rule
/// fields can match properties of the service, or properties of a request. The
/// service can ignore
/// rules that don't match its properties.
pub const SamplingRule = struct {
    /// Matches attributes derived from the request.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The percentage of matching requests to instrument, after the reservoir is
    /// exhausted.
    fixed_rate: f64 = 0,

    /// Matches the hostname from a request URL.
    host: []const u8,

    /// Matches the HTTP method of a request.
    http_method: []const u8,

    /// The priority of the sampling rule.
    priority: i32,

    /// A fixed number of matching requests to instrument per second, prior to
    /// applying the
    /// fixed rate. The reservoir is not used directly by services, but applies to
    /// all services using the rule collectively.
    reservoir_size: i32 = 0,

    /// Matches the ARN of the Amazon Web Services resource on which the service
    /// runs.
    resource_arn: []const u8,

    /// The ARN of the sampling rule. Specify a rule by either name or ARN, but not
    /// both.
    rule_arn: ?[]const u8,

    /// The name of the sampling rule. Specify a rule by either name or ARN, but not
    /// both.
    rule_name: ?[]const u8,

    /// Specifies the multiplier applied to the base sampling rate.
    /// This boost allows you to temporarily increase sampling without changing the
    /// rule's configuration.
    sampling_rate_boost: ?SamplingRateBoost,

    /// Matches the `name` that the service uses to identify itself in segments.
    service_name: []const u8,

    /// Matches the `origin` that the service uses to identify its type in segments.
    service_type: []const u8,

    /// Matches the path from a request URL.
    url_path: []const u8,

    /// The version of the sampling rule format (`1`).
    version: i32,

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
        .version = "Version",
    };
};
