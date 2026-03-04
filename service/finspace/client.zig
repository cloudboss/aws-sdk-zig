const aws = @import("aws");
const std = @import("std");

const create_environment = @import("create_environment.zig");
const create_kx_changeset = @import("create_kx_changeset.zig");
const create_kx_cluster = @import("create_kx_cluster.zig");
const create_kx_database = @import("create_kx_database.zig");
const create_kx_dataview = @import("create_kx_dataview.zig");
const create_kx_environment = @import("create_kx_environment.zig");
const create_kx_scaling_group = @import("create_kx_scaling_group.zig");
const create_kx_user = @import("create_kx_user.zig");
const create_kx_volume = @import("create_kx_volume.zig");
const delete_environment = @import("delete_environment.zig");
const delete_kx_cluster = @import("delete_kx_cluster.zig");
const delete_kx_cluster_node = @import("delete_kx_cluster_node.zig");
const delete_kx_database = @import("delete_kx_database.zig");
const delete_kx_dataview = @import("delete_kx_dataview.zig");
const delete_kx_environment = @import("delete_kx_environment.zig");
const delete_kx_scaling_group = @import("delete_kx_scaling_group.zig");
const delete_kx_user = @import("delete_kx_user.zig");
const delete_kx_volume = @import("delete_kx_volume.zig");
const get_environment = @import("get_environment.zig");
const get_kx_changeset = @import("get_kx_changeset.zig");
const get_kx_cluster = @import("get_kx_cluster.zig");
const get_kx_connection_string = @import("get_kx_connection_string.zig");
const get_kx_database = @import("get_kx_database.zig");
const get_kx_dataview = @import("get_kx_dataview.zig");
const get_kx_environment = @import("get_kx_environment.zig");
const get_kx_scaling_group = @import("get_kx_scaling_group.zig");
const get_kx_user = @import("get_kx_user.zig");
const get_kx_volume = @import("get_kx_volume.zig");
const list_environments = @import("list_environments.zig");
const list_kx_changesets = @import("list_kx_changesets.zig");
const list_kx_cluster_nodes = @import("list_kx_cluster_nodes.zig");
const list_kx_clusters = @import("list_kx_clusters.zig");
const list_kx_databases = @import("list_kx_databases.zig");
const list_kx_dataviews = @import("list_kx_dataviews.zig");
const list_kx_environments = @import("list_kx_environments.zig");
const list_kx_scaling_groups = @import("list_kx_scaling_groups.zig");
const list_kx_users = @import("list_kx_users.zig");
const list_kx_volumes = @import("list_kx_volumes.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_environment = @import("update_environment.zig");
const update_kx_cluster_code_configuration = @import("update_kx_cluster_code_configuration.zig");
const update_kx_cluster_databases = @import("update_kx_cluster_databases.zig");
const update_kx_database = @import("update_kx_database.zig");
const update_kx_dataview = @import("update_kx_dataview.zig");
const update_kx_environment = @import("update_kx_environment.zig");
const update_kx_environment_network = @import("update_kx_environment_network.zig");
const update_kx_user = @import("update_kx_user.zig");
const update_kx_volume = @import("update_kx_volume.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "finspace";

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

    /// Create a new FinSpace environment.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: CallOptions) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Creates a changeset for a kdb database. A changeset allows you to add and
    /// delete existing files by using an ordered list of change requests.
    pub fn createKxChangeset(self: *Self, allocator: std.mem.Allocator, input: create_kx_changeset.CreateKxChangesetInput, options: CallOptions) !create_kx_changeset.CreateKxChangesetOutput {
        return create_kx_changeset.execute(self, allocator, input, options);
    }

    /// Creates a new kdb cluster.
    pub fn createKxCluster(self: *Self, allocator: std.mem.Allocator, input: create_kx_cluster.CreateKxClusterInput, options: CallOptions) !create_kx_cluster.CreateKxClusterOutput {
        return create_kx_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new kdb database in the environment.
    pub fn createKxDatabase(self: *Self, allocator: std.mem.Allocator, input: create_kx_database.CreateKxDatabaseInput, options: CallOptions) !create_kx_database.CreateKxDatabaseOutput {
        return create_kx_database.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of kdb database with tiered storage capabilities and a
    /// pre-warmed cache, ready for mounting on kdb clusters. Dataviews are only
    /// available for clusters running on a scaling group. They are not supported on
    /// dedicated clusters.
    pub fn createKxDataview(self: *Self, allocator: std.mem.Allocator, input: create_kx_dataview.CreateKxDataviewInput, options: CallOptions) !create_kx_dataview.CreateKxDataviewOutput {
        return create_kx_dataview.execute(self, allocator, input, options);
    }

    /// Creates a managed kdb environment for the account.
    pub fn createKxEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_kx_environment.CreateKxEnvironmentInput, options: CallOptions) !create_kx_environment.CreateKxEnvironmentOutput {
        return create_kx_environment.execute(self, allocator, input, options);
    }

    /// Creates a new scaling group.
    pub fn createKxScalingGroup(self: *Self, allocator: std.mem.Allocator, input: create_kx_scaling_group.CreateKxScalingGroupInput, options: CallOptions) !create_kx_scaling_group.CreateKxScalingGroupOutput {
        return create_kx_scaling_group.execute(self, allocator, input, options);
    }

    /// Creates a user in FinSpace kdb environment with an associated IAM role.
    pub fn createKxUser(self: *Self, allocator: std.mem.Allocator, input: create_kx_user.CreateKxUserInput, options: CallOptions) !create_kx_user.CreateKxUserOutput {
        return create_kx_user.execute(self, allocator, input, options);
    }

    /// Creates a new volume with a specific amount of throughput and storage
    /// capacity.
    pub fn createKxVolume(self: *Self, allocator: std.mem.Allocator, input: create_kx_volume.CreateKxVolumeInput, options: CallOptions) !create_kx_volume.CreateKxVolumeOutput {
        return create_kx_volume.execute(self, allocator, input, options);
    }

    /// Delete an FinSpace environment.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: CallOptions) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deletes a kdb cluster.
    pub fn deleteKxCluster(self: *Self, allocator: std.mem.Allocator, input: delete_kx_cluster.DeleteKxClusterInput, options: CallOptions) !delete_kx_cluster.DeleteKxClusterOutput {
        return delete_kx_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified nodes from a cluster.
    pub fn deleteKxClusterNode(self: *Self, allocator: std.mem.Allocator, input: delete_kx_cluster_node.DeleteKxClusterNodeInput, options: CallOptions) !delete_kx_cluster_node.DeleteKxClusterNodeOutput {
        return delete_kx_cluster_node.execute(self, allocator, input, options);
    }

    /// Deletes the specified database and all of its associated data. This action
    /// is irreversible. You must copy any data out of the database before deleting
    /// it if the data is to be retained.
    pub fn deleteKxDatabase(self: *Self, allocator: std.mem.Allocator, input: delete_kx_database.DeleteKxDatabaseInput, options: CallOptions) !delete_kx_database.DeleteKxDatabaseOutput {
        return delete_kx_database.execute(self, allocator, input, options);
    }

    /// Deletes the specified dataview. Before deleting a dataview, make sure that
    /// it is not in use by any cluster.
    pub fn deleteKxDataview(self: *Self, allocator: std.mem.Allocator, input: delete_kx_dataview.DeleteKxDataviewInput, options: CallOptions) !delete_kx_dataview.DeleteKxDataviewOutput {
        return delete_kx_dataview.execute(self, allocator, input, options);
    }

    /// Deletes the kdb environment. This action is irreversible. Deleting a kdb
    /// environment will remove all the associated data and any services running in
    /// it.
    pub fn deleteKxEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_kx_environment.DeleteKxEnvironmentInput, options: CallOptions) !delete_kx_environment.DeleteKxEnvironmentOutput {
        return delete_kx_environment.execute(self, allocator, input, options);
    }

    /// Deletes the specified scaling group. This action is irreversible. You cannot
    /// delete a scaling group until all the clusters running on it have been
    /// deleted.
    pub fn deleteKxScalingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_kx_scaling_group.DeleteKxScalingGroupInput, options: CallOptions) !delete_kx_scaling_group.DeleteKxScalingGroupOutput {
        return delete_kx_scaling_group.execute(self, allocator, input, options);
    }

    /// Deletes a user in the specified kdb environment.
    pub fn deleteKxUser(self: *Self, allocator: std.mem.Allocator, input: delete_kx_user.DeleteKxUserInput, options: CallOptions) !delete_kx_user.DeleteKxUserOutput {
        return delete_kx_user.execute(self, allocator, input, options);
    }

    /// Deletes a volume. You can only delete a volume if it's not attached to a
    /// cluster or a dataview. When a volume is deleted, any data on the volume is
    /// lost. This action is irreversible.
    pub fn deleteKxVolume(self: *Self, allocator: std.mem.Allocator, input: delete_kx_volume.DeleteKxVolumeInput, options: CallOptions) !delete_kx_volume.DeleteKxVolumeOutput {
        return delete_kx_volume.execute(self, allocator, input, options);
    }

    /// Returns the FinSpace environment object.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: CallOptions) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Returns information about a kdb changeset.
    pub fn getKxChangeset(self: *Self, allocator: std.mem.Allocator, input: get_kx_changeset.GetKxChangesetInput, options: CallOptions) !get_kx_changeset.GetKxChangesetOutput {
        return get_kx_changeset.execute(self, allocator, input, options);
    }

    /// Retrieves information about a kdb cluster.
    pub fn getKxCluster(self: *Self, allocator: std.mem.Allocator, input: get_kx_cluster.GetKxClusterInput, options: CallOptions) !get_kx_cluster.GetKxClusterOutput {
        return get_kx_cluster.execute(self, allocator, input, options);
    }

    /// Retrieves a connection string for a user to connect to a kdb cluster. You
    /// must call this API using the same role that you have defined while creating
    /// a user.
    pub fn getKxConnectionString(self: *Self, allocator: std.mem.Allocator, input: get_kx_connection_string.GetKxConnectionStringInput, options: CallOptions) !get_kx_connection_string.GetKxConnectionStringOutput {
        return get_kx_connection_string.execute(self, allocator, input, options);
    }

    /// Returns database information for the specified environment ID.
    pub fn getKxDatabase(self: *Self, allocator: std.mem.Allocator, input: get_kx_database.GetKxDatabaseInput, options: CallOptions) !get_kx_database.GetKxDatabaseOutput {
        return get_kx_database.execute(self, allocator, input, options);
    }

    /// Retrieves details of the dataview.
    pub fn getKxDataview(self: *Self, allocator: std.mem.Allocator, input: get_kx_dataview.GetKxDataviewInput, options: CallOptions) !get_kx_dataview.GetKxDataviewOutput {
        return get_kx_dataview.execute(self, allocator, input, options);
    }

    /// Retrieves all the information for the specified kdb environment.
    pub fn getKxEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_kx_environment.GetKxEnvironmentInput, options: CallOptions) !get_kx_environment.GetKxEnvironmentOutput {
        return get_kx_environment.execute(self, allocator, input, options);
    }

    /// Retrieves details of a scaling group.
    pub fn getKxScalingGroup(self: *Self, allocator: std.mem.Allocator, input: get_kx_scaling_group.GetKxScalingGroupInput, options: CallOptions) !get_kx_scaling_group.GetKxScalingGroupOutput {
        return get_kx_scaling_group.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified kdb user.
    pub fn getKxUser(self: *Self, allocator: std.mem.Allocator, input: get_kx_user.GetKxUserInput, options: CallOptions) !get_kx_user.GetKxUserOutput {
        return get_kx_user.execute(self, allocator, input, options);
    }

    /// Retrieves the information about the volume.
    pub fn getKxVolume(self: *Self, allocator: std.mem.Allocator, input: get_kx_volume.GetKxVolumeInput, options: CallOptions) !get_kx_volume.GetKxVolumeOutput {
        return get_kx_volume.execute(self, allocator, input, options);
    }

    /// A list of all of your FinSpace environments.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: CallOptions) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Returns a list of all the changesets for a database.
    pub fn listKxChangesets(self: *Self, allocator: std.mem.Allocator, input: list_kx_changesets.ListKxChangesetsInput, options: CallOptions) !list_kx_changesets.ListKxChangesetsOutput {
        return list_kx_changesets.execute(self, allocator, input, options);
    }

    /// Lists all the nodes in a kdb cluster.
    pub fn listKxClusterNodes(self: *Self, allocator: std.mem.Allocator, input: list_kx_cluster_nodes.ListKxClusterNodesInput, options: CallOptions) !list_kx_cluster_nodes.ListKxClusterNodesOutput {
        return list_kx_cluster_nodes.execute(self, allocator, input, options);
    }

    /// Returns a list of clusters.
    pub fn listKxClusters(self: *Self, allocator: std.mem.Allocator, input: list_kx_clusters.ListKxClustersInput, options: CallOptions) !list_kx_clusters.ListKxClustersOutput {
        return list_kx_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of all the databases in the kdb environment.
    pub fn listKxDatabases(self: *Self, allocator: std.mem.Allocator, input: list_kx_databases.ListKxDatabasesInput, options: CallOptions) !list_kx_databases.ListKxDatabasesOutput {
        return list_kx_databases.execute(self, allocator, input, options);
    }

    /// Returns a list of all the dataviews in the database.
    pub fn listKxDataviews(self: *Self, allocator: std.mem.Allocator, input: list_kx_dataviews.ListKxDataviewsInput, options: CallOptions) !list_kx_dataviews.ListKxDataviewsOutput {
        return list_kx_dataviews.execute(self, allocator, input, options);
    }

    /// Returns a list of kdb environments created in an account.
    pub fn listKxEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_kx_environments.ListKxEnvironmentsInput, options: CallOptions) !list_kx_environments.ListKxEnvironmentsOutput {
        return list_kx_environments.execute(self, allocator, input, options);
    }

    /// Returns a list of scaling groups in a kdb environment.
    pub fn listKxScalingGroups(self: *Self, allocator: std.mem.Allocator, input: list_kx_scaling_groups.ListKxScalingGroupsInput, options: CallOptions) !list_kx_scaling_groups.ListKxScalingGroupsOutput {
        return list_kx_scaling_groups.execute(self, allocator, input, options);
    }

    /// Lists all the users in a kdb environment.
    pub fn listKxUsers(self: *Self, allocator: std.mem.Allocator, input: list_kx_users.ListKxUsersInput, options: CallOptions) !list_kx_users.ListKxUsersOutput {
        return list_kx_users.execute(self, allocator, input, options);
    }

    /// Lists all the volumes in a kdb environment.
    pub fn listKxVolumes(self: *Self, allocator: std.mem.Allocator, input: list_kx_volumes.ListKxVolumesInput, options: CallOptions) !list_kx_volumes.ListKxVolumesOutput {
        return list_kx_volumes.execute(self, allocator, input, options);
    }

    /// A list of all tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to a FinSpace resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from a FinSpace resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update your FinSpace environment.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: CallOptions) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// Allows you to update code configuration on a running cluster. By using this
    /// API you can update the code, the initialization script path, and the command
    /// line arguments for a specific cluster.
    /// The configuration that you want to update will override any existing
    /// configurations on the cluster.
    pub fn updateKxClusterCodeConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_kx_cluster_code_configuration.UpdateKxClusterCodeConfigurationInput, options: CallOptions) !update_kx_cluster_code_configuration.UpdateKxClusterCodeConfigurationOutput {
        return update_kx_cluster_code_configuration.execute(self, allocator, input, options);
    }

    /// Updates the databases mounted on a kdb cluster, which includes the
    /// `changesetId` and all the dbPaths to be cached. This API does not allow you
    /// to change a database name or add a database if you created a cluster without
    /// one.
    ///
    /// Using this API you can point a cluster to a different changeset and modify a
    /// list of partitions being cached.
    pub fn updateKxClusterDatabases(self: *Self, allocator: std.mem.Allocator, input: update_kx_cluster_databases.UpdateKxClusterDatabasesInput, options: CallOptions) !update_kx_cluster_databases.UpdateKxClusterDatabasesOutput {
        return update_kx_cluster_databases.execute(self, allocator, input, options);
    }

    /// Updates information for the given kdb database.
    pub fn updateKxDatabase(self: *Self, allocator: std.mem.Allocator, input: update_kx_database.UpdateKxDatabaseInput, options: CallOptions) !update_kx_database.UpdateKxDatabaseOutput {
        return update_kx_database.execute(self, allocator, input, options);
    }

    /// Updates the specified dataview. The dataviews get automatically updated when
    /// any new changesets are ingested. Each update of the dataview creates a new
    /// version, including changeset details and cache configurations
    pub fn updateKxDataview(self: *Self, allocator: std.mem.Allocator, input: update_kx_dataview.UpdateKxDataviewInput, options: CallOptions) !update_kx_dataview.UpdateKxDataviewOutput {
        return update_kx_dataview.execute(self, allocator, input, options);
    }

    /// Updates information for the given kdb environment.
    pub fn updateKxEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_kx_environment.UpdateKxEnvironmentInput, options: CallOptions) !update_kx_environment.UpdateKxEnvironmentOutput {
        return update_kx_environment.execute(self, allocator, input, options);
    }

    /// Updates environment network to connect to your internal network by using a
    /// transit gateway. This API supports request to create a transit gateway
    /// attachment from FinSpace VPC to your transit gateway ID and create a custom
    /// Route-53 outbound resolvers.
    ///
    /// Once you send a request to update a network, you cannot change it again.
    /// Network update might require termination of any clusters that are running in
    /// the existing network.
    pub fn updateKxEnvironmentNetwork(self: *Self, allocator: std.mem.Allocator, input: update_kx_environment_network.UpdateKxEnvironmentNetworkInput, options: CallOptions) !update_kx_environment_network.UpdateKxEnvironmentNetworkOutput {
        return update_kx_environment_network.execute(self, allocator, input, options);
    }

    /// Updates the user details. You can only update the IAM role associated with a
    /// user.
    pub fn updateKxUser(self: *Self, allocator: std.mem.Allocator, input: update_kx_user.UpdateKxUserInput, options: CallOptions) !update_kx_user.UpdateKxUserOutput {
        return update_kx_user.execute(self, allocator, input, options);
    }

    /// Updates the throughput or capacity of a volume. During the update process,
    /// the filesystem
    /// might be unavailable for a few minutes. You can retry any operations after
    /// the update is complete.
    pub fn updateKxVolume(self: *Self, allocator: std.mem.Allocator, input: update_kx_volume.UpdateKxVolumeInput, options: CallOptions) !update_kx_volume.UpdateKxVolumeOutput {
        return update_kx_volume.execute(self, allocator, input, options);
    }

    pub fn listKxChangesetsPaginator(self: *Self, params: list_kx_changesets.ListKxChangesetsInput) paginator.ListKxChangesetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKxClusterNodesPaginator(self: *Self, params: list_kx_cluster_nodes.ListKxClusterNodesInput) paginator.ListKxClusterNodesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKxDatabasesPaginator(self: *Self, params: list_kx_databases.ListKxDatabasesInput) paginator.ListKxDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKxDataviewsPaginator(self: *Self, params: list_kx_dataviews.ListKxDataviewsInput) paginator.ListKxDataviewsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKxEnvironmentsPaginator(self: *Self, params: list_kx_environments.ListKxEnvironmentsInput) paginator.ListKxEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listKxScalingGroupsPaginator(self: *Self, params: list_kx_scaling_groups.ListKxScalingGroupsInput) paginator.ListKxScalingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
