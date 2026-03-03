const aws = @import("aws");
const std = @import("std");

const create_connector = @import("create_connector.zig");
const create_custom_plugin = @import("create_custom_plugin.zig");
const create_worker_configuration = @import("create_worker_configuration.zig");
const delete_connector = @import("delete_connector.zig");
const delete_custom_plugin = @import("delete_custom_plugin.zig");
const delete_worker_configuration = @import("delete_worker_configuration.zig");
const describe_connector = @import("describe_connector.zig");
const describe_connector_operation = @import("describe_connector_operation.zig");
const describe_custom_plugin = @import("describe_custom_plugin.zig");
const describe_worker_configuration = @import("describe_worker_configuration.zig");
const list_connector_operations = @import("list_connector_operations.zig");
const list_connectors = @import("list_connectors.zig");
const list_custom_plugins = @import("list_custom_plugins.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_worker_configurations = @import("list_worker_configurations.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connector = @import("update_connector.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "KafkaConnect";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a connector using the specified properties.
    pub fn createConnector(self: *Self, allocator: std.mem.Allocator, input: create_connector.CreateConnectorInput, options: create_connector.Options) !create_connector.CreateConnectorOutput {
        return create_connector.execute(self, allocator, input, options);
    }

    /// Creates a custom plugin using the specified properties.
    pub fn createCustomPlugin(self: *Self, allocator: std.mem.Allocator, input: create_custom_plugin.CreateCustomPluginInput, options: create_custom_plugin.Options) !create_custom_plugin.CreateCustomPluginOutput {
        return create_custom_plugin.execute(self, allocator, input, options);
    }

    /// Creates a worker configuration using the specified properties.
    pub fn createWorkerConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_worker_configuration.CreateWorkerConfigurationInput, options: create_worker_configuration.Options) !create_worker_configuration.CreateWorkerConfigurationOutput {
        return create_worker_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified connector.
    pub fn deleteConnector(self: *Self, allocator: std.mem.Allocator, input: delete_connector.DeleteConnectorInput, options: delete_connector.Options) !delete_connector.DeleteConnectorOutput {
        return delete_connector.execute(self, allocator, input, options);
    }

    /// Deletes a custom plugin.
    pub fn deleteCustomPlugin(self: *Self, allocator: std.mem.Allocator, input: delete_custom_plugin.DeleteCustomPluginInput, options: delete_custom_plugin.Options) !delete_custom_plugin.DeleteCustomPluginOutput {
        return delete_custom_plugin.execute(self, allocator, input, options);
    }

    /// Deletes the specified worker configuration.
    pub fn deleteWorkerConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_worker_configuration.DeleteWorkerConfigurationInput, options: delete_worker_configuration.Options) !delete_worker_configuration.DeleteWorkerConfigurationOutput {
        return delete_worker_configuration.execute(self, allocator, input, options);
    }

    /// Returns summary information about the connector.
    pub fn describeConnector(self: *Self, allocator: std.mem.Allocator, input: describe_connector.DescribeConnectorInput, options: describe_connector.Options) !describe_connector.DescribeConnectorOutput {
        return describe_connector.execute(self, allocator, input, options);
    }

    /// Returns information about the specified connector's operations.
    pub fn describeConnectorOperation(self: *Self, allocator: std.mem.Allocator, input: describe_connector_operation.DescribeConnectorOperationInput, options: describe_connector_operation.Options) !describe_connector_operation.DescribeConnectorOperationOutput {
        return describe_connector_operation.execute(self, allocator, input, options);
    }

    /// A summary description of the custom plugin.
    pub fn describeCustomPlugin(self: *Self, allocator: std.mem.Allocator, input: describe_custom_plugin.DescribeCustomPluginInput, options: describe_custom_plugin.Options) !describe_custom_plugin.DescribeCustomPluginOutput {
        return describe_custom_plugin.execute(self, allocator, input, options);
    }

    /// Returns information about a worker configuration.
    pub fn describeWorkerConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_worker_configuration.DescribeWorkerConfigurationInput, options: describe_worker_configuration.Options) !describe_worker_configuration.DescribeWorkerConfigurationOutput {
        return describe_worker_configuration.execute(self, allocator, input, options);
    }

    /// Lists information about a connector's operation(s).
    pub fn listConnectorOperations(self: *Self, allocator: std.mem.Allocator, input: list_connector_operations.ListConnectorOperationsInput, options: list_connector_operations.Options) !list_connector_operations.ListConnectorOperationsOutput {
        return list_connector_operations.execute(self, allocator, input, options);
    }

    /// Returns a list of all the connectors in this account and Region. The list is
    /// limited to connectors whose name starts with the specified prefix. The
    /// response also includes a description of each of the listed connectors.
    pub fn listConnectors(self: *Self, allocator: std.mem.Allocator, input: list_connectors.ListConnectorsInput, options: list_connectors.Options) !list_connectors.ListConnectorsOutput {
        return list_connectors.execute(self, allocator, input, options);
    }

    /// Returns a list of all of the custom plugins in this account and Region.
    pub fn listCustomPlugins(self: *Self, allocator: std.mem.Allocator, input: list_custom_plugins.ListCustomPluginsInput, options: list_custom_plugins.Options) !list_custom_plugins.ListCustomPluginsOutput {
        return list_custom_plugins.execute(self, allocator, input, options);
    }

    /// Lists all the tags attached to the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of all of the worker configurations in this account and
    /// Region.
    pub fn listWorkerConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_worker_configurations.ListWorkerConfigurationsInput, options: list_worker_configurations.Options) !list_worker_configurations.ListWorkerConfigurationsOutput {
        return list_worker_configurations.execute(self, allocator, input, options);
    }

    /// Attaches tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified connector. For request body, specify only one
    /// parameter: either `capacity` or `connectorConfiguration`.
    pub fn updateConnector(self: *Self, allocator: std.mem.Allocator, input: update_connector.UpdateConnectorInput, options: update_connector.Options) !update_connector.UpdateConnectorOutput {
        return update_connector.execute(self, allocator, input, options);
    }

    pub fn listConnectorOperationsPaginator(self: *Self, params: list_connector_operations.ListConnectorOperationsInput) paginator.ListConnectorOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectorsPaginator(self: *Self, params: list_connectors.ListConnectorsInput) paginator.ListConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomPluginsPaginator(self: *Self, params: list_custom_plugins.ListCustomPluginsInput) paginator.ListCustomPluginsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkerConfigurationsPaginator(self: *Self, params: list_worker_configurations.ListWorkerConfigurationsInput) paginator.ListWorkerConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
