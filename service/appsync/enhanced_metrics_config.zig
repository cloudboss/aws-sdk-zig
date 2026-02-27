const DataSourceLevelMetricsBehavior = @import("data_source_level_metrics_behavior.zig").DataSourceLevelMetricsBehavior;
const OperationLevelMetricsConfig = @import("operation_level_metrics_config.zig").OperationLevelMetricsConfig;
const ResolverLevelMetricsBehavior = @import("resolver_level_metrics_behavior.zig").ResolverLevelMetricsBehavior;

/// Enables and controls the enhanced metrics feature. Enhanced metrics emit
/// granular data
/// on API usage and performance such as AppSync request and error counts,
/// latency, and cache
/// hits/misses. All enhanced metric data is sent to your CloudWatch account,
/// and you can
/// configure the types of data that will be sent.
///
/// Enhanced metrics can be configured at the resolver, data source, and
/// operation levels.
/// `EnhancedMetricsConfig` contains three required parameters, each controlling
/// one of these categories:
///
/// * `resolverLevelMetricsBehavior`: Controls how resolver metrics will
/// be emitted to CloudWatch. Resolver metrics include:
///
/// * GraphQL errors: The number of GraphQL errors that occurred.
///
/// * Requests: The number of invocations that occurred during a request.
///
/// * Latency: The time to complete a resolver invocation.
///
/// * Cache hits: The number of cache hits during a request.
///
/// * Cache misses: The number of cache misses during a request.
///
/// These metrics can be emitted to CloudWatch per resolver or for all resolvers
/// in
/// the request. Metrics will be recorded by API ID and resolver name.
/// `resolverLevelMetricsBehavior` accepts one of these values at a
/// time:
///
/// * `FULL_REQUEST_RESOLVER_METRICS`: Records and emits metric data
/// for all resolvers in the request.
///
/// * `PER_RESOLVER_METRICS`: Records and emits metric data for
/// resolvers that have the `metricsConfig` value set to
/// `ENABLED`.
///
/// * `dataSourceLevelMetricsBehavior`: Controls how data source metrics
/// will be emitted to CloudWatch. Data source metrics include:
///
/// * Requests: The number of invocations that occured during a
/// request.
///
/// * Latency: The time to complete a data source invocation.
///
/// * Errors: The number of errors that occurred during a data source
/// invocation.
///
/// These metrics can be emitted to CloudWatch per data source or for all data
/// sources
/// in the request. Metrics will be recorded by API ID and data source name.
/// `dataSourceLevelMetricsBehavior` accepts one of these values at a
/// time:
///
/// * `FULL_REQUEST_DATA_SOURCE_METRICS`: Records and emits metric
/// data for all data sources in the request.
///
/// * `PER_DATA_SOURCE_METRICS`: Records and emits metric data for
/// data sources that have the `metricsConfig` value set to
/// `ENABLED`.
///
/// * `operationLevelMetricsConfig`: Controls how operation metrics will
/// be emitted to CloudWatch. Operation metrics include:
///
/// * Requests: The number of times a specified GraphQL operation was
/// called.
///
/// * GraphQL errors: The number of GraphQL errors that occurred during a
/// specified GraphQL operation.
///
/// Metrics will be recorded by API ID and operation name. You can set the value
/// to
/// `ENABLED` or `DISABLED`.
pub const EnhancedMetricsConfig = struct {
    /// Controls how data source metrics will be emitted to CloudWatch. Data source
    /// metrics
    /// include:
    ///
    /// * Requests: The number of invocations that occured during a request.
    ///
    /// * Latency: The time to complete a data source invocation.
    ///
    /// * Errors: The number of errors that occurred during a data source
    /// invocation.
    ///
    /// These metrics can be emitted to CloudWatch per data source or for all data
    /// sources in
    /// the request. Metrics will be recorded by API ID and data source name.
    /// `dataSourceLevelMetricsBehavior` accepts one of these values at a
    /// time:
    ///
    /// * `FULL_REQUEST_DATA_SOURCE_METRICS`: Records and emits metric data
    /// for all data sources in the request.
    ///
    /// * `PER_DATA_SOURCE_METRICS`: Records and emits metric data for data
    /// sources that have the `metricsConfig` value set to
    /// `ENABLED`.
    data_source_level_metrics_behavior: DataSourceLevelMetricsBehavior,

    /// Controls how operation metrics will be emitted to CloudWatch. Operation
    /// metrics
    /// include:
    ///
    /// * Requests: The number of times a specified GraphQL operation was
    /// called.
    ///
    /// * GraphQL errors: The number of GraphQL errors that occurred during a
    ///   specified
    /// GraphQL operation.
    ///
    /// Metrics will be recorded by API ID and operation name. You can set the value
    /// to
    /// `ENABLED` or `DISABLED`.
    operation_level_metrics_config: OperationLevelMetricsConfig,

    /// Controls how resolver metrics will be emitted to CloudWatch. Resolver
    /// metrics
    /// include:
    ///
    /// * GraphQL errors: The number of GraphQL errors that occurred.
    ///
    /// * Requests: The number of invocations that occurred during a request.
    ///
    /// * Latency: The time to complete a resolver invocation.
    ///
    /// * Cache hits: The number of cache hits during a request.
    ///
    /// * Cache misses: The number of cache misses during a request.
    ///
    /// These metrics can be emitted to CloudWatch per resolver or for all resolvers
    /// in the
    /// request. Metrics will be recorded by API ID and resolver name.
    /// `resolverLevelMetricsBehavior` accepts one of these values at a time:
    ///
    /// * `FULL_REQUEST_RESOLVER_METRICS`: Records and emits metric data for
    /// all resolvers in the request.
    ///
    /// * `PER_RESOLVER_METRICS`: Records and emits metric data for resolvers
    /// that have the `metricsConfig` value set to `ENABLED`.
    resolver_level_metrics_behavior: ResolverLevelMetricsBehavior,

    pub const json_field_names = .{
        .data_source_level_metrics_behavior = "dataSourceLevelMetricsBehavior",
        .operation_level_metrics_config = "operationLevelMetricsConfig",
        .resolver_level_metrics_behavior = "resolverLevelMetricsBehavior",
    };
};
