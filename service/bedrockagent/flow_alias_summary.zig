const FlowAliasConcurrencyConfiguration = @import("flow_alias_concurrency_configuration.zig").FlowAliasConcurrencyConfiguration;
const FlowAliasRoutingConfigurationListItem = @import("flow_alias_routing_configuration_list_item.zig").FlowAliasRoutingConfigurationListItem;

/// Contains information about an alias of a flow.
///
/// This data type is used in the following API operations:
///
/// * [ListFlowAliases
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_ListFlowAliases.html#API_agent_ListFlowAliases_ResponseSyntax)
pub const FlowAliasSummary = struct {
    /// The Amazon Resource Name (ARN) of the alias.
    arn: []const u8,

    /// The configuration that specifies how nodes in the flow are executed
    /// concurrently.
    concurrency_configuration: ?FlowAliasConcurrencyConfiguration,

    /// The time at which the alias was created.
    created_at: i64,

    /// A description of the alias.
    description: ?[]const u8,

    /// The unique identifier of the flow.
    flow_id: []const u8,

    /// The unique identifier of the alias of the flow.
    id: []const u8,

    /// The name of the alias.
    name: []const u8,

    /// A list of configurations about the versions that the alias maps to.
    /// Currently, you can only specify one.
    routing_configuration: []const FlowAliasRoutingConfigurationListItem,

    /// The time at which the alias was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .concurrency_configuration = "concurrencyConfiguration",
        .created_at = "createdAt",
        .description = "description",
        .flow_id = "flowId",
        .id = "id",
        .name = "name",
        .routing_configuration = "routingConfiguration",
        .updated_at = "updatedAt",
    };
};
