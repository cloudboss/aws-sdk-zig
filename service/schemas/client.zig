const aws = @import("aws");
const std = @import("std");

const create_discoverer = @import("create_discoverer.zig");
const create_registry = @import("create_registry.zig");
const create_schema = @import("create_schema.zig");
const delete_discoverer = @import("delete_discoverer.zig");
const delete_registry = @import("delete_registry.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_schema = @import("delete_schema.zig");
const delete_schema_version = @import("delete_schema_version.zig");
const describe_code_binding = @import("describe_code_binding.zig");
const describe_discoverer = @import("describe_discoverer.zig");
const describe_registry = @import("describe_registry.zig");
const describe_schema = @import("describe_schema.zig");
const export_schema = @import("export_schema.zig");
const get_code_binding_source = @import("get_code_binding_source.zig");
const get_discovered_schema = @import("get_discovered_schema.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_discoverers = @import("list_discoverers.zig");
const list_registries = @import("list_registries.zig");
const list_schema_versions = @import("list_schema_versions.zig");
const list_schemas = @import("list_schemas.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_code_binding = @import("put_code_binding.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const search_schemas = @import("search_schemas.zig");
const start_discoverer = @import("start_discoverer.zig");
const stop_discoverer = @import("stop_discoverer.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_discoverer = @import("update_discoverer.zig");
const update_registry = @import("update_registry.zig");
const update_schema = @import("update_schema.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "schemas";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a discoverer.
    pub fn createDiscoverer(self: *Self, allocator: std.mem.Allocator, input: create_discoverer.CreateDiscovererInput, options: CallOptions) !create_discoverer.CreateDiscovererOutput {
        return create_discoverer.execute(self, allocator, input, options);
    }

    /// Creates a registry.
    pub fn createRegistry(self: *Self, allocator: std.mem.Allocator, input: create_registry.CreateRegistryInput, options: CallOptions) !create_registry.CreateRegistryOutput {
        return create_registry.execute(self, allocator, input, options);
    }

    /// Creates a schema definition.
    ///
    /// Inactive schemas will be deleted after two years.
    pub fn createSchema(self: *Self, allocator: std.mem.Allocator, input: create_schema.CreateSchemaInput, options: CallOptions) !create_schema.CreateSchemaOutput {
        return create_schema.execute(self, allocator, input, options);
    }

    /// Deletes a discoverer.
    pub fn deleteDiscoverer(self: *Self, allocator: std.mem.Allocator, input: delete_discoverer.DeleteDiscovererInput, options: CallOptions) !delete_discoverer.DeleteDiscovererOutput {
        return delete_discoverer.execute(self, allocator, input, options);
    }

    /// Deletes a Registry.
    pub fn deleteRegistry(self: *Self, allocator: std.mem.Allocator, input: delete_registry.DeleteRegistryInput, options: CallOptions) !delete_registry.DeleteRegistryOutput {
        return delete_registry.execute(self, allocator, input, options);
    }

    /// Delete the resource-based policy attached to the specified registry.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Delete a schema definition.
    pub fn deleteSchema(self: *Self, allocator: std.mem.Allocator, input: delete_schema.DeleteSchemaInput, options: CallOptions) !delete_schema.DeleteSchemaOutput {
        return delete_schema.execute(self, allocator, input, options);
    }

    /// Delete the schema version definition
    pub fn deleteSchemaVersion(self: *Self, allocator: std.mem.Allocator, input: delete_schema_version.DeleteSchemaVersionInput, options: CallOptions) !delete_schema_version.DeleteSchemaVersionOutput {
        return delete_schema_version.execute(self, allocator, input, options);
    }

    /// Describe the code binding URI.
    pub fn describeCodeBinding(self: *Self, allocator: std.mem.Allocator, input: describe_code_binding.DescribeCodeBindingInput, options: CallOptions) !describe_code_binding.DescribeCodeBindingOutput {
        return describe_code_binding.execute(self, allocator, input, options);
    }

    /// Describes the discoverer.
    pub fn describeDiscoverer(self: *Self, allocator: std.mem.Allocator, input: describe_discoverer.DescribeDiscovererInput, options: CallOptions) !describe_discoverer.DescribeDiscovererOutput {
        return describe_discoverer.execute(self, allocator, input, options);
    }

    /// Describes the registry.
    pub fn describeRegistry(self: *Self, allocator: std.mem.Allocator, input: describe_registry.DescribeRegistryInput, options: CallOptions) !describe_registry.DescribeRegistryOutput {
        return describe_registry.execute(self, allocator, input, options);
    }

    /// Retrieve the schema definition.
    pub fn describeSchema(self: *Self, allocator: std.mem.Allocator, input: describe_schema.DescribeSchemaInput, options: CallOptions) !describe_schema.DescribeSchemaOutput {
        return describe_schema.execute(self, allocator, input, options);
    }

    pub fn exportSchema(self: *Self, allocator: std.mem.Allocator, input: export_schema.ExportSchemaInput, options: CallOptions) !export_schema.ExportSchemaOutput {
        return export_schema.execute(self, allocator, input, options);
    }

    /// Get the code binding source URI.
    pub fn getCodeBindingSource(self: *Self, allocator: std.mem.Allocator, input: get_code_binding_source.GetCodeBindingSourceInput, options: CallOptions) !get_code_binding_source.GetCodeBindingSourceOutput {
        return get_code_binding_source.execute(self, allocator, input, options);
    }

    /// Get the discovered schema that was generated based on sampled events.
    pub fn getDiscoveredSchema(self: *Self, allocator: std.mem.Allocator, input: get_discovered_schema.GetDiscoveredSchemaInput, options: CallOptions) !get_discovered_schema.GetDiscoveredSchemaOutput {
        return get_discovered_schema.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy attached to a given registry.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// List the discoverers.
    pub fn listDiscoverers(self: *Self, allocator: std.mem.Allocator, input: list_discoverers.ListDiscoverersInput, options: CallOptions) !list_discoverers.ListDiscoverersOutput {
        return list_discoverers.execute(self, allocator, input, options);
    }

    /// List the registries.
    pub fn listRegistries(self: *Self, allocator: std.mem.Allocator, input: list_registries.ListRegistriesInput, options: CallOptions) !list_registries.ListRegistriesOutput {
        return list_registries.execute(self, allocator, input, options);
    }

    /// Provides a list of the schema versions and related information.
    pub fn listSchemaVersions(self: *Self, allocator: std.mem.Allocator, input: list_schema_versions.ListSchemaVersionsInput, options: CallOptions) !list_schema_versions.ListSchemaVersionsOutput {
        return list_schema_versions.execute(self, allocator, input, options);
    }

    /// List the schemas.
    pub fn listSchemas(self: *Self, allocator: std.mem.Allocator, input: list_schemas.ListSchemasInput, options: CallOptions) !list_schemas.ListSchemasOutput {
        return list_schemas.execute(self, allocator, input, options);
    }

    /// Get tags for resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Put code binding URI
    pub fn putCodeBinding(self: *Self, allocator: std.mem.Allocator, input: put_code_binding.PutCodeBindingInput, options: CallOptions) !put_code_binding.PutCodeBindingOutput {
        return put_code_binding.execute(self, allocator, input, options);
    }

    /// The name of the policy.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Search the schemas
    pub fn searchSchemas(self: *Self, allocator: std.mem.Allocator, input: search_schemas.SearchSchemasInput, options: CallOptions) !search_schemas.SearchSchemasOutput {
        return search_schemas.execute(self, allocator, input, options);
    }

    /// Starts the discoverer
    pub fn startDiscoverer(self: *Self, allocator: std.mem.Allocator, input: start_discoverer.StartDiscovererInput, options: CallOptions) !start_discoverer.StartDiscovererOutput {
        return start_discoverer.execute(self, allocator, input, options);
    }

    /// Stops the discoverer
    pub fn stopDiscoverer(self: *Self, allocator: std.mem.Allocator, input: stop_discoverer.StopDiscovererInput, options: CallOptions) !stop_discoverer.StopDiscovererOutput {
        return stop_discoverer.execute(self, allocator, input, options);
    }

    /// Add tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the discoverer
    pub fn updateDiscoverer(self: *Self, allocator: std.mem.Allocator, input: update_discoverer.UpdateDiscovererInput, options: CallOptions) !update_discoverer.UpdateDiscovererOutput {
        return update_discoverer.execute(self, allocator, input, options);
    }

    /// Updates a registry.
    pub fn updateRegistry(self: *Self, allocator: std.mem.Allocator, input: update_registry.UpdateRegistryInput, options: CallOptions) !update_registry.UpdateRegistryOutput {
        return update_registry.execute(self, allocator, input, options);
    }

    /// Updates the schema definition
    ///
    /// Inactive schemas will be deleted after two years.
    pub fn updateSchema(self: *Self, allocator: std.mem.Allocator, input: update_schema.UpdateSchemaInput, options: CallOptions) !update_schema.UpdateSchemaOutput {
        return update_schema.execute(self, allocator, input, options);
    }

    pub fn listDiscoverersPaginator(self: *Self, params: list_discoverers.ListDiscoverersInput) paginator.ListDiscoverersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegistriesPaginator(self: *Self, params: list_registries.ListRegistriesInput) paginator.ListRegistriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchemaVersionsPaginator(self: *Self, params: list_schema_versions.ListSchemaVersionsInput) paginator.ListSchemaVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchemasPaginator(self: *Self, params: list_schemas.ListSchemasInput) paginator.ListSchemasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchSchemasPaginator(self: *Self, params: search_schemas.SearchSchemasInput) paginator.SearchSchemasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilCodeBindingExists(self: *Self, params: describe_code_binding.DescribeCodeBindingInput) aws.waiter.WaiterError!void {
        var w = waiters.CodeBindingExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
