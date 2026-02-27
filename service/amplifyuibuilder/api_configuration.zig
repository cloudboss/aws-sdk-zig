const DataStoreRenderConfig = @import("data_store_render_config.zig").DataStoreRenderConfig;
const GraphQLRenderConfig = @import("graph_ql_render_config.zig").GraphQLRenderConfig;
const NoApiRenderConfig = @import("no_api_render_config.zig").NoApiRenderConfig;

/// Describes the API configuration for a code generation job.
pub const ApiConfiguration = union(enum) {
    /// The configuration for an application using DataStore APIs.
    data_store_config: ?DataStoreRenderConfig,
    /// The configuration for an application using GraphQL APIs.
    graph_ql_config: ?GraphQLRenderConfig,
    /// The configuration for an application with no API being used.
    no_api_config: ?NoApiRenderConfig,

    pub const json_field_names = .{
        .data_store_config = "dataStoreConfig",
        .graph_ql_config = "graphQLConfig",
        .no_api_config = "noApiConfig",
    };
};
