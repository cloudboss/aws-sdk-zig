const ServiceConnectAccessLoggingFormat = @import("service_connect_access_logging_format.zig").ServiceConnectAccessLoggingFormat;
const ServiceConnectIncludeQueryParameters = @import("service_connect_include_query_parameters.zig").ServiceConnectIncludeQueryParameters;

/// Configuration for Service Connect access logging. Access logs provide
/// detailed information about requests made to your service, including request
/// patterns, response codes, and timing data for debugging and monitoring
/// purposes.
///
/// To enable access logs, you must also specify a `logConfiguration` in the
/// `serviceConnectConfiguration`.
pub const ServiceConnectAccessLogConfiguration = struct {
    /// The format for Service Connect access log output. Choose TEXT for
    /// human-readable logs or JSON for structured data that integrates well with
    /// log analysis tools.
    format: ServiceConnectAccessLoggingFormat,

    /// Specifies whether to include query parameters in Service Connect access
    /// logs.
    ///
    /// When enabled, query parameters from HTTP requests are included in the access
    /// logs. Consider security and privacy implications when enabling this feature,
    /// as query parameters may contain sensitive information such as request IDs
    /// and tokens. By default, this parameter is `DISABLED`.
    include_query_parameters: ?ServiceConnectIncludeQueryParameters = null,

    pub const json_field_names = .{
        .format = "format",
        .include_query_parameters = "includeQueryParameters",
    };
};
