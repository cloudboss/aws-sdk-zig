const AppSyncRuntime = @import("app_sync_runtime.zig").AppSyncRuntime;
const SyncConfig = @import("sync_config.zig").SyncConfig;

/// A function is a reusable entity. You can use multiple functions to compose
/// the resolver
/// logic.
pub const FunctionConfiguration = struct {
    /// The `function` code that contains the request and response functions. When
    /// code is used, the `runtime` is required. The `runtime` value must be
    /// `APPSYNC_JS`.
    code: ?[]const u8 = null,

    /// The name of the `DataSource`.
    data_source_name: ?[]const u8 = null,

    /// The `Function` description.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the `Function` object.
    function_arn: ?[]const u8 = null,

    /// A unique ID representing the `Function` object.
    function_id: ?[]const u8 = null,

    /// The version of the request mapping template. Currently, only the 2018-05-29
    /// version of
    /// the template is supported.
    function_version: ?[]const u8 = null,

    /// The maximum batching size for a resolver.
    max_batch_size: i32 = 0,

    /// The name of the `Function` object.
    name: ?[]const u8 = null,

    /// The `Function` request mapping template. Functions support only the
    /// 2018-05-29 version of the request mapping template.
    request_mapping_template: ?[]const u8 = null,

    /// The `Function` response mapping template.
    response_mapping_template: ?[]const u8 = null,

    runtime: ?AppSyncRuntime = null,

    sync_config: ?SyncConfig = null,

    pub const json_field_names = .{
        .code = "code",
        .data_source_name = "dataSourceName",
        .description = "description",
        .function_arn = "functionArn",
        .function_id = "functionId",
        .function_version = "functionVersion",
        .max_batch_size = "maxBatchSize",
        .name = "name",
        .request_mapping_template = "requestMappingTemplate",
        .response_mapping_template = "responseMappingTemplate",
        .runtime = "runtime",
        .sync_config = "syncConfig",
    };
};
