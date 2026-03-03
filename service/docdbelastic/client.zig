const aws = @import("aws");
const std = @import("std");

const apply_pending_maintenance_action = @import("apply_pending_maintenance_action.zig");
const copy_cluster_snapshot = @import("copy_cluster_snapshot.zig");
const create_cluster = @import("create_cluster.zig");
const create_cluster_snapshot = @import("create_cluster_snapshot.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_cluster_snapshot = @import("delete_cluster_snapshot.zig");
const get_cluster = @import("get_cluster.zig");
const get_cluster_snapshot = @import("get_cluster_snapshot.zig");
const get_pending_maintenance_action = @import("get_pending_maintenance_action.zig");
const list_cluster_snapshots = @import("list_cluster_snapshots.zig");
const list_clusters = @import("list_clusters.zig");
const list_pending_maintenance_actions = @import("list_pending_maintenance_actions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const restore_cluster_from_snapshot = @import("restore_cluster_from_snapshot.zig");
const start_cluster = @import("start_cluster.zig");
const stop_cluster = @import("stop_cluster.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cluster = @import("update_cluster.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DocDB Elastic";

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

    /// The type of pending maintenance action to be applied to the resource.
    pub fn applyPendingMaintenanceAction(self: *Self, allocator: std.mem.Allocator, input: apply_pending_maintenance_action.ApplyPendingMaintenanceActionInput, options: apply_pending_maintenance_action.Options) !apply_pending_maintenance_action.ApplyPendingMaintenanceActionOutput {
        return apply_pending_maintenance_action.execute(self, allocator, input, options);
    }

    /// Copies a snapshot of an elastic cluster.
    pub fn copyClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_cluster_snapshot.CopyClusterSnapshotInput, options: copy_cluster_snapshot.Options) !copy_cluster_snapshot.CopyClusterSnapshotOutput {
        return copy_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon DocumentDB elastic cluster and returns its cluster
    /// structure.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of an elastic cluster.
    pub fn createClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_cluster_snapshot.CreateClusterSnapshotInput, options: create_cluster_snapshot.Options) !create_cluster_snapshot.CreateClusterSnapshotOutput {
        return create_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Delete an elastic cluster.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Delete an elastic cluster snapshot.
    pub fn deleteClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_snapshot.DeleteClusterSnapshotInput, options: delete_cluster_snapshot.Options) !delete_cluster_snapshot.DeleteClusterSnapshotOutput {
        return delete_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Returns information about a specific elastic cluster.
    pub fn getCluster(self: *Self, allocator: std.mem.Allocator, input: get_cluster.GetClusterInput, options: get_cluster.Options) !get_cluster.GetClusterOutput {
        return get_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about a specific elastic cluster snapshot
    pub fn getClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_cluster_snapshot.GetClusterSnapshotInput, options: get_cluster_snapshot.Options) !get_cluster_snapshot.GetClusterSnapshotOutput {
        return get_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Retrieves all maintenance actions that are pending.
    pub fn getPendingMaintenanceAction(self: *Self, allocator: std.mem.Allocator, input: get_pending_maintenance_action.GetPendingMaintenanceActionInput, options: get_pending_maintenance_action.Options) !get_pending_maintenance_action.GetPendingMaintenanceActionOutput {
        return get_pending_maintenance_action.execute(self, allocator, input, options);
    }

    /// Returns information about snapshots for a specified elastic cluster.
    pub fn listClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_cluster_snapshots.ListClusterSnapshotsInput, options: list_cluster_snapshots.Options) !list_cluster_snapshots.ListClusterSnapshotsOutput {
        return list_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about provisioned Amazon DocumentDB elastic clusters.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all maintenance actions that are pending.
    pub fn listPendingMaintenanceActions(self: *Self, allocator: std.mem.Allocator, input: list_pending_maintenance_actions.ListPendingMaintenanceActionsInput, options: list_pending_maintenance_actions.Options) !list_pending_maintenance_actions.ListPendingMaintenanceActionsOutput {
        return list_pending_maintenance_actions.execute(self, allocator, input, options);
    }

    /// Lists all tags on a elastic cluster resource
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Restores an elastic cluster from a snapshot.
    pub fn restoreClusterFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_cluster_from_snapshot.RestoreClusterFromSnapshotInput, options: restore_cluster_from_snapshot.Options) !restore_cluster_from_snapshot.RestoreClusterFromSnapshotOutput {
        return restore_cluster_from_snapshot.execute(self, allocator, input, options);
    }

    /// Restarts the stopped elastic cluster that is specified by `clusterARN`.
    pub fn startCluster(self: *Self, allocator: std.mem.Allocator, input: start_cluster.StartClusterInput, options: start_cluster.Options) !start_cluster.StartClusterOutput {
        return start_cluster.execute(self, allocator, input, options);
    }

    /// Stops the running elastic cluster that is specified by `clusterArn`.
    /// The elastic cluster must be in the *available* state.
    pub fn stopCluster(self: *Self, allocator: std.mem.Allocator, input: stop_cluster.StopClusterInput, options: stop_cluster.Options) !stop_cluster.StopClusterOutput {
        return stop_cluster.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to an elastic cluster resource
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from an elastic cluster resource
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies an elastic cluster. This includes updating admin-username/password,
    /// upgrading the API version, and setting up a backup window and maintenance
    /// window
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    pub fn listClusterSnapshotsPaginator(self: *Self, params: list_cluster_snapshots.ListClusterSnapshotsInput) paginator.ListClusterSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPendingMaintenanceActionsPaginator(self: *Self, params: list_pending_maintenance_actions.ListPendingMaintenanceActionsInput) paginator.ListPendingMaintenanceActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
