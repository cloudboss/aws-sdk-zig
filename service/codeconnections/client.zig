const aws = @import("aws");
const std = @import("std");

const create_connection = @import("create_connection.zig");
const create_host = @import("create_host.zig");
const create_repository_link = @import("create_repository_link.zig");
const create_sync_configuration = @import("create_sync_configuration.zig");
const delete_connection = @import("delete_connection.zig");
const delete_host = @import("delete_host.zig");
const delete_repository_link = @import("delete_repository_link.zig");
const delete_sync_configuration = @import("delete_sync_configuration.zig");
const get_connection = @import("get_connection.zig");
const get_host = @import("get_host.zig");
const get_repository_link = @import("get_repository_link.zig");
const get_repository_sync_status = @import("get_repository_sync_status.zig");
const get_resource_sync_status = @import("get_resource_sync_status.zig");
const get_sync_blocker_summary = @import("get_sync_blocker_summary.zig");
const get_sync_configuration = @import("get_sync_configuration.zig");
const list_connections = @import("list_connections.zig");
const list_hosts = @import("list_hosts.zig");
const list_repository_links = @import("list_repository_links.zig");
const list_repository_sync_definitions = @import("list_repository_sync_definitions.zig");
const list_sync_configurations = @import("list_sync_configurations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_host = @import("update_host.zig");
const update_repository_link = @import("update_repository_link.zig");
const update_sync_blocker = @import("update_sync_blocker.zig");
const update_sync_configuration = @import("update_sync_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeConnections";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a connection that can then be given to other Amazon Web Services
    /// services like CodePipeline so
    /// that it can access third-party code repositories. The connection is in
    /// pending status until
    /// the third-party connection handshake is completed from the console.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: create_connection.Options) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Creates a resource that represents the infrastructure where a third-party
    /// provider is
    /// installed. The host is used when you create connections to an installed
    /// third-party provider
    /// type, such as GitHub Enterprise Server. You create one host for all
    /// connections to that
    /// provider.
    ///
    /// A host created through the CLI or the SDK is in `PENDING` status by
    /// default. You can make its status `AVAILABLE` by setting up the host in the
    /// console.
    pub fn createHost(self: *Self, allocator: std.mem.Allocator, input: create_host.CreateHostInput, options: create_host.Options) !create_host.CreateHostOutput {
        return create_host.execute(self, allocator, input, options);
    }

    /// Creates a link to a specified external Git repository. A repository link
    /// allows Git sync to monitor and sync changes to files in a specified Git
    /// repository.
    pub fn createRepositoryLink(self: *Self, allocator: std.mem.Allocator, input: create_repository_link.CreateRepositoryLinkInput, options: create_repository_link.Options) !create_repository_link.CreateRepositoryLinkOutput {
        return create_repository_link.execute(self, allocator, input, options);
    }

    /// Creates a sync configuration which allows Amazon Web Services to sync
    /// content from a Git
    /// repository to update a specified Amazon Web Services resource. Parameters
    /// for the sync
    /// configuration are determined by the sync type.
    pub fn createSyncConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_sync_configuration.CreateSyncConfigurationInput, options: create_sync_configuration.Options) !create_sync_configuration.CreateSyncConfigurationOutput {
        return create_sync_configuration.execute(self, allocator, input, options);
    }

    /// The connection to be deleted.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// The host to be deleted. Before you delete a host, all connections associated
    /// to the host must be deleted.
    ///
    /// A host cannot be deleted if it is in the VPC_CONFIG_INITIALIZING or
    /// VPC_CONFIG_DELETING state.
    pub fn deleteHost(self: *Self, allocator: std.mem.Allocator, input: delete_host.DeleteHostInput, options: delete_host.Options) !delete_host.DeleteHostOutput {
        return delete_host.execute(self, allocator, input, options);
    }

    /// Deletes the association between your connection and a specified external Git
    /// repository.
    pub fn deleteRepositoryLink(self: *Self, allocator: std.mem.Allocator, input: delete_repository_link.DeleteRepositoryLinkInput, options: delete_repository_link.Options) !delete_repository_link.DeleteRepositoryLinkOutput {
        return delete_repository_link.execute(self, allocator, input, options);
    }

    /// Deletes the sync configuration for a specified repository and connection.
    pub fn deleteSyncConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_sync_configuration.DeleteSyncConfigurationInput, options: delete_sync_configuration.Options) !delete_sync_configuration.DeleteSyncConfigurationOutput {
        return delete_sync_configuration.execute(self, allocator, input, options);
    }

    /// Returns the connection ARN and details such as status, owner, and provider
    /// type.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: get_connection.Options) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Returns the host ARN and details such as status, provider type, endpoint,
    /// and, if
    /// applicable, the VPC configuration.
    pub fn getHost(self: *Self, allocator: std.mem.Allocator, input: get_host.GetHostInput, options: get_host.Options) !get_host.GetHostOutput {
        return get_host.execute(self, allocator, input, options);
    }

    /// Returns details about a repository link. A repository link allows Git sync
    /// to monitor
    /// and sync changes from files in a specified Git repository.
    pub fn getRepositoryLink(self: *Self, allocator: std.mem.Allocator, input: get_repository_link.GetRepositoryLinkInput, options: get_repository_link.Options) !get_repository_link.GetRepositoryLinkOutput {
        return get_repository_link.execute(self, allocator, input, options);
    }

    /// Returns details about the sync status for a repository. A repository sync
    /// uses Git sync
    /// to push and pull changes from your remote repository.
    pub fn getRepositorySyncStatus(self: *Self, allocator: std.mem.Allocator, input: get_repository_sync_status.GetRepositorySyncStatusInput, options: get_repository_sync_status.Options) !get_repository_sync_status.GetRepositorySyncStatusOutput {
        return get_repository_sync_status.execute(self, allocator, input, options);
    }

    /// Returns the status of the sync with the Git repository for a specific Amazon
    /// Web Services
    /// resource.
    pub fn getResourceSyncStatus(self: *Self, allocator: std.mem.Allocator, input: get_resource_sync_status.GetResourceSyncStatusInput, options: get_resource_sync_status.Options) !get_resource_sync_status.GetResourceSyncStatusOutput {
        return get_resource_sync_status.execute(self, allocator, input, options);
    }

    /// Returns a list of the most recent sync blockers.
    pub fn getSyncBlockerSummary(self: *Self, allocator: std.mem.Allocator, input: get_sync_blocker_summary.GetSyncBlockerSummaryInput, options: get_sync_blocker_summary.Options) !get_sync_blocker_summary.GetSyncBlockerSummaryOutput {
        return get_sync_blocker_summary.execute(self, allocator, input, options);
    }

    /// Returns details about a sync configuration, including the sync type and
    /// resource name. A sync configuration allows the configuration to sync (push
    /// and pull) changes from the remote repository for a specified branch in a Git
    /// repository.
    pub fn getSyncConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_sync_configuration.GetSyncConfigurationInput, options: get_sync_configuration.Options) !get_sync_configuration.GetSyncConfigurationOutput {
        return get_sync_configuration.execute(self, allocator, input, options);
    }

    /// Lists the connections associated with your account.
    pub fn listConnections(self: *Self, allocator: std.mem.Allocator, input: list_connections.ListConnectionsInput, options: list_connections.Options) !list_connections.ListConnectionsOutput {
        return list_connections.execute(self, allocator, input, options);
    }

    /// Lists the hosts associated with your account.
    pub fn listHosts(self: *Self, allocator: std.mem.Allocator, input: list_hosts.ListHostsInput, options: list_hosts.Options) !list_hosts.ListHostsOutput {
        return list_hosts.execute(self, allocator, input, options);
    }

    /// Lists the repository links created for connections in your account.
    pub fn listRepositoryLinks(self: *Self, allocator: std.mem.Allocator, input: list_repository_links.ListRepositoryLinksInput, options: list_repository_links.Options) !list_repository_links.ListRepositoryLinksOutput {
        return list_repository_links.execute(self, allocator, input, options);
    }

    /// Lists the repository sync definitions for repository links in your account.
    pub fn listRepositorySyncDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_repository_sync_definitions.ListRepositorySyncDefinitionsInput, options: list_repository_sync_definitions.Options) !list_repository_sync_definitions.ListRepositorySyncDefinitionsOutput {
        return list_repository_sync_definitions.execute(self, allocator, input, options);
    }

    /// Returns a list of sync configurations for a specified repository.
    pub fn listSyncConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_sync_configurations.ListSyncConfigurationsInput, options: list_sync_configurations.Options) !list_sync_configurations.ListSyncConfigurationsOutput {
        return list_sync_configurations.execute(self, allocator, input, options);
    }

    /// Gets the set of key-value pairs (metadata) that are used to manage the
    /// resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata that
    /// can be used
    /// to manage a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an Amazon Web Services resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a specified host with the provided configurations.
    pub fn updateHost(self: *Self, allocator: std.mem.Allocator, input: update_host.UpdateHostInput, options: update_host.Options) !update_host.UpdateHostOutput {
        return update_host.execute(self, allocator, input, options);
    }

    /// Updates the association between your connection and a specified external Git
    /// repository.
    /// A repository link allows Git sync to monitor and sync changes to files in a
    /// specified Git
    /// repository.
    pub fn updateRepositoryLink(self: *Self, allocator: std.mem.Allocator, input: update_repository_link.UpdateRepositoryLinkInput, options: update_repository_link.Options) !update_repository_link.UpdateRepositoryLinkOutput {
        return update_repository_link.execute(self, allocator, input, options);
    }

    /// Allows you to update the status of a sync blocker, resolving the blocker and
    /// allowing syncing to continue.
    pub fn updateSyncBlocker(self: *Self, allocator: std.mem.Allocator, input: update_sync_blocker.UpdateSyncBlockerInput, options: update_sync_blocker.Options) !update_sync_blocker.UpdateSyncBlockerOutput {
        return update_sync_blocker.execute(self, allocator, input, options);
    }

    /// Updates the sync configuration for your connection and a specified external
    /// Git repository.
    pub fn updateSyncConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_sync_configuration.UpdateSyncConfigurationInput, options: update_sync_configuration.Options) !update_sync_configuration.UpdateSyncConfigurationOutput {
        return update_sync_configuration.execute(self, allocator, input, options);
    }

    pub fn listConnectionsPaginator(self: *Self, params: list_connections.ListConnectionsInput) paginator.ListConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHostsPaginator(self: *Self, params: list_hosts.ListHostsInput) paginator.ListHostsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositoryLinksPaginator(self: *Self, params: list_repository_links.ListRepositoryLinksInput) paginator.ListRepositoryLinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSyncConfigurationsPaginator(self: *Self, params: list_sync_configurations.ListSyncConfigurationsInput) paginator.ListSyncConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
