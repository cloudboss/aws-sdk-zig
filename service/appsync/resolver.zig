const CachingConfig = @import("caching_config.zig").CachingConfig;
const ResolverKind = @import("resolver_kind.zig").ResolverKind;
const ResolverLevelMetricsConfig = @import("resolver_level_metrics_config.zig").ResolverLevelMetricsConfig;
const PipelineConfig = @import("pipeline_config.zig").PipelineConfig;
const AppSyncRuntime = @import("app_sync_runtime.zig").AppSyncRuntime;
const SyncConfig = @import("sync_config.zig").SyncConfig;

/// Describes a resolver.
pub const Resolver = struct {
    /// The caching configuration for the resolver.
    caching_config: ?CachingConfig,

    /// The `resolver` code that contains the request and response functions. When
    /// code is used, the `runtime` is required. The `runtime` value must be
    /// `APPSYNC_JS`.
    code: ?[]const u8,

    /// The resolver data source name.
    data_source_name: ?[]const u8,

    /// The resolver field name.
    field_name: ?[]const u8,

    /// The resolver type.
    ///
    /// * **UNIT**: A UNIT resolver type. A UNIT resolver is
    /// the default resolver type. You can use a UNIT resolver to run a GraphQL
    /// query against
    /// a single data source.
    ///
    /// * **PIPELINE**: A PIPELINE resolver type. You can
    /// use a PIPELINE resolver to invoke a series of `Function` objects in a
    /// serial manner. You can use a pipeline resolver to run a GraphQL query
    /// against
    /// multiple data sources.
    kind: ?ResolverKind,

    /// The maximum batching size for a resolver.
    max_batch_size: i32 = 0,

    /// Enables or disables enhanced resolver metrics for specified resolvers. Note
    /// that
    /// `metricsConfig` won't be used unless the
    /// `resolverLevelMetricsBehavior` value is set to
    /// `PER_RESOLVER_METRICS`. If the `resolverLevelMetricsBehavior` is
    /// set to `FULL_REQUEST_RESOLVER_METRICS` instead, `metricsConfig` will
    /// be ignored. However, you can still set its value.
    ///
    /// `metricsConfig` can be `ENABLED` or `DISABLED`.
    metrics_config: ?ResolverLevelMetricsConfig,

    /// The `PipelineConfig`.
    pipeline_config: ?PipelineConfig,

    /// The request mapping template.
    request_mapping_template: ?[]const u8,

    /// The resolver Amazon Resource Name (ARN).
    resolver_arn: ?[]const u8,

    /// The response mapping template.
    response_mapping_template: ?[]const u8,

    runtime: ?AppSyncRuntime,

    /// The `SyncConfig` for a resolver attached to a versioned data source.
    sync_config: ?SyncConfig,

    /// The resolver type name.
    type_name: ?[]const u8,

    pub const json_field_names = .{
        .caching_config = "cachingConfig",
        .code = "code",
        .data_source_name = "dataSourceName",
        .field_name = "fieldName",
        .kind = "kind",
        .max_batch_size = "maxBatchSize",
        .metrics_config = "metricsConfig",
        .pipeline_config = "pipelineConfig",
        .request_mapping_template = "requestMappingTemplate",
        .resolver_arn = "resolverArn",
        .response_mapping_template = "responseMappingTemplate",
        .runtime = "runtime",
        .sync_config = "syncConfig",
        .type_name = "typeName",
    };
};
