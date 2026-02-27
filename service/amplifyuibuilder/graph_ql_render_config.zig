/// Describes the GraphQL configuration for an API for a code generation job.
pub const GraphQLRenderConfig = struct {
    /// The path to the GraphQL fragments file, relative to the component output
    /// directory.
    fragments_file_path: []const u8,

    /// The path to the GraphQL mutations file, relative to the component output
    /// directory.
    mutations_file_path: []const u8,

    /// The path to the GraphQL queries file, relative to the component output
    /// directory.
    queries_file_path: []const u8,

    /// The path to the GraphQL subscriptions file, relative to the component output
    /// directory.
    subscriptions_file_path: []const u8,

    /// The path to the GraphQL types file, relative to the component output
    /// directory.
    types_file_path: []const u8,

    pub const json_field_names = .{
        .fragments_file_path = "fragmentsFilePath",
        .mutations_file_path = "mutationsFilePath",
        .queries_file_path = "queriesFilePath",
        .subscriptions_file_path = "subscriptionsFilePath",
        .types_file_path = "typesFilePath",
    };
};
