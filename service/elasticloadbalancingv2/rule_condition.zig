const HostHeaderConditionConfig = @import("host_header_condition_config.zig").HostHeaderConditionConfig;
const HttpHeaderConditionConfig = @import("http_header_condition_config.zig").HttpHeaderConditionConfig;
const HttpRequestMethodConditionConfig = @import("http_request_method_condition_config.zig").HttpRequestMethodConditionConfig;
const PathPatternConditionConfig = @import("path_pattern_condition_config.zig").PathPatternConditionConfig;
const QueryStringConditionConfig = @import("query_string_condition_config.zig").QueryStringConditionConfig;
const SourceIpConditionConfig = @import("source_ip_condition_config.zig").SourceIpConditionConfig;

/// Information about a condition for a rule.
///
/// Each rule can optionally include up to one of each of the following
/// conditions:
/// `http-request-method`, `host-header`, `path-pattern`, and
/// `source-ip`. Each rule can also optionally include one or more of each of
/// the
/// following conditions: `http-header` and `query-string`. Note that the
/// value for a condition can't be empty.
///
/// For more information, see [Quotas for your
/// Application Load
/// Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-limits.html).
pub const RuleCondition = struct {
    /// The field in the HTTP request. The following are the possible values:
    ///
    /// * `http-header`
    ///
    /// * `http-request-method`
    ///
    /// * `host-header`
    ///
    /// * `path-pattern`
    ///
    /// * `query-string`
    ///
    /// * `source-ip`
    field: ?[]const u8 = null,

    /// Information for a host header condition. Specify only when `Field` is
    /// `host-header`.
    host_header_config: ?HostHeaderConditionConfig = null,

    /// Information for an HTTP header condition. Specify only when `Field` is
    /// `http-header`.
    http_header_config: ?HttpHeaderConditionConfig = null,

    /// Information for an HTTP method condition. Specify only when `Field` is
    /// `http-request-method`.
    http_request_method_config: ?HttpRequestMethodConditionConfig = null,

    /// Information for a path pattern condition. Specify only when `Field` is
    /// `path-pattern`.
    path_pattern_config: ?PathPatternConditionConfig = null,

    /// Information for a query string condition. Specify only when `Field` is
    /// `query-string`.
    query_string_config: ?QueryStringConditionConfig = null,

    /// The regular expressions to match against the condition field. The maximum
    /// length of each string is 128 characters.
    /// Specify only when `Field` is `http-header`, `host-header`, or
    /// `path-pattern`.
    regex_values: ?[]const []const u8 = null,

    /// Information for a source IP condition. Specify only when `Field` is
    /// `source-ip`.
    source_ip_config: ?SourceIpConditionConfig = null,

    /// The condition value. Specify only when `Field` is `host-header` or
    /// `path-pattern`. Alternatively, to specify multiple host names or multiple
    /// path
    /// patterns, use `HostHeaderConfig` or `PathPatternConfig`.
    ///
    /// If `Field` is `host-header` and you are not using
    /// `HostHeaderConfig`, you can specify a single host name (for example,
    /// my.example.com) in `Values`. A host name is case insensitive, can be up to
    /// 128
    /// characters in length, and can contain any of the following characters.
    ///
    /// * A-Z, a-z, 0-9
    ///
    /// * - .
    ///
    /// * * (matches 0 or more characters)
    ///
    /// * ? (matches exactly 1 character)
    ///
    /// If `Field` is `path-pattern` and you are not using
    /// `PathPatternConfig`, you can specify a single path pattern (for example,
    /// /img/*)
    /// in `Values`. A path pattern is case-sensitive, can be up to 128 characters
    /// in
    /// length, and can contain any of the following characters.
    ///
    /// * A-Z, a-z, 0-9
    ///
    /// * _ - . $ / ~ " ' @ : +
    ///
    /// * & (using &)
    ///
    /// * * (matches 0 or more characters)
    ///
    /// * ? (matches exactly 1 character)
    values: ?[]const []const u8 = null,
};
