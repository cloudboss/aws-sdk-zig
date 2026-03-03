/// Contains the GraphQL operation to be parsed and executed, if the event
/// target is an
/// AppSync API.
pub const AppSyncParameters = struct {
    /// The GraphQL operation; that is, the query, mutation, or subscription to be
    /// parsed and
    /// executed by the GraphQL service.
    ///
    /// For more information, see
    /// [Operations](https://docs.aws.amazon.com/appsync/latest/devguide/graphql-architecture.html#graphql-operations) in the *AppSync User Guide*.
    graph_ql_operation: ?[]const u8 = null,

    pub const json_field_names = .{
        .graph_ql_operation = "GraphQLOperation",
    };
};
