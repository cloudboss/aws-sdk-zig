const aws = @import("aws");
const std = @import("std");

const create_db_cluster = @import("create_db_cluster.zig");
const create_db_instance = @import("create_db_instance.zig");
const create_db_parameter_group = @import("create_db_parameter_group.zig");
const delete_db_cluster = @import("delete_db_cluster.zig");
const delete_db_instance = @import("delete_db_instance.zig");
const get_db_cluster = @import("get_db_cluster.zig");
const get_db_instance = @import("get_db_instance.zig");
const get_db_parameter_group = @import("get_db_parameter_group.zig");
const list_db_clusters = @import("list_db_clusters.zig");
const list_db_instances = @import("list_db_instances.zig");
const list_db_instances_for_cluster = @import("list_db_instances_for_cluster.zig");
const list_db_parameter_groups = @import("list_db_parameter_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reboot_db_cluster = @import("reboot_db_cluster.zig");
const reboot_db_instance = @import("reboot_db_instance.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_db_cluster = @import("update_db_cluster.zig");
const update_db_instance = @import("update_db_instance.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Timestream InfluxDB";

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

    /// Creates a new Timestream for InfluxDB cluster.
    pub fn createDbCluster(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster.CreateDbClusterInput, options: create_db_cluster.Options) !create_db_cluster.CreateDbClusterOutput {
        return create_db_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new Timestream for InfluxDB DB instance.
    pub fn createDbInstance(self: *Self, allocator: std.mem.Allocator, input: create_db_instance.CreateDbInstanceInput, options: create_db_instance.Options) !create_db_instance.CreateDbInstanceOutput {
        return create_db_instance.execute(self, allocator, input, options);
    }

    /// Creates a new Timestream for InfluxDB DB parameter group to associate with
    /// DB instances.
    pub fn createDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_parameter_group.CreateDbParameterGroupInput, options: create_db_parameter_group.Options) !create_db_parameter_group.CreateDbParameterGroupOutput {
        return create_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a Timestream for InfluxDB cluster.
    pub fn deleteDbCluster(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster.DeleteDbClusterInput, options: delete_db_cluster.Options) !delete_db_cluster.DeleteDbClusterOutput {
        return delete_db_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a Timestream for InfluxDB DB instance.
    pub fn deleteDbInstance(self: *Self, allocator: std.mem.Allocator, input: delete_db_instance.DeleteDbInstanceInput, options: delete_db_instance.Options) !delete_db_instance.DeleteDbInstanceOutput {
        return delete_db_instance.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Timestream for InfluxDB cluster.
    pub fn getDbCluster(self: *Self, allocator: std.mem.Allocator, input: get_db_cluster.GetDbClusterInput, options: get_db_cluster.Options) !get_db_cluster.GetDbClusterOutput {
        return get_db_cluster.execute(self, allocator, input, options);
    }

    /// Returns a Timestream for InfluxDB DB instance.
    pub fn getDbInstance(self: *Self, allocator: std.mem.Allocator, input: get_db_instance.GetDbInstanceInput, options: get_db_instance.Options) !get_db_instance.GetDbInstanceOutput {
        return get_db_instance.execute(self, allocator, input, options);
    }

    /// Returns a Timestream for InfluxDB DB parameter group.
    pub fn getDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: get_db_parameter_group.GetDbParameterGroupInput, options: get_db_parameter_group.Options) !get_db_parameter_group.GetDbParameterGroupOutput {
        return get_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Returns a list of Timestream for InfluxDB DB clusters.
    pub fn listDbClusters(self: *Self, allocator: std.mem.Allocator, input: list_db_clusters.ListDbClustersInput, options: list_db_clusters.Options) !list_db_clusters.ListDbClustersOutput {
        return list_db_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of Timestream for InfluxDB DB instances.
    pub fn listDbInstances(self: *Self, allocator: std.mem.Allocator, input: list_db_instances.ListDbInstancesInput, options: list_db_instances.Options) !list_db_instances.ListDbInstancesOutput {
        return list_db_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of Timestream for InfluxDB clusters.
    pub fn listDbInstancesForCluster(self: *Self, allocator: std.mem.Allocator, input: list_db_instances_for_cluster.ListDbInstancesForClusterInput, options: list_db_instances_for_cluster.Options) !list_db_instances_for_cluster.ListDbInstancesForClusterOutput {
        return list_db_instances_for_cluster.execute(self, allocator, input, options);
    }

    /// Returns a list of Timestream for InfluxDB DB parameter groups.
    pub fn listDbParameterGroups(self: *Self, allocator: std.mem.Allocator, input: list_db_parameter_groups.ListDbParameterGroupsInput, options: list_db_parameter_groups.Options) !list_db_parameter_groups.ListDbParameterGroupsOutput {
        return list_db_parameter_groups.execute(self, allocator, input, options);
    }

    /// A list of tags applied to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Reboots a Timestream for InfluxDB cluster.
    pub fn rebootDbCluster(self: *Self, allocator: std.mem.Allocator, input: reboot_db_cluster.RebootDbClusterInput, options: reboot_db_cluster.Options) !reboot_db_cluster.RebootDbClusterOutput {
        return reboot_db_cluster.execute(self, allocator, input, options);
    }

    /// Reboots a Timestream for InfluxDB instance.
    pub fn rebootDbInstance(self: *Self, allocator: std.mem.Allocator, input: reboot_db_instance.RebootDbInstanceInput, options: reboot_db_instance.Options) !reboot_db_instance.RebootDbInstanceOutput {
        return reboot_db_instance.execute(self, allocator, input, options);
    }

    /// Tags are composed of a Key/Value pairs. You can use tags to categorize and
    /// track your Timestream for InfluxDB resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the tag from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a Timestream for InfluxDB cluster.
    pub fn updateDbCluster(self: *Self, allocator: std.mem.Allocator, input: update_db_cluster.UpdateDbClusterInput, options: update_db_cluster.Options) !update_db_cluster.UpdateDbClusterOutput {
        return update_db_cluster.execute(self, allocator, input, options);
    }

    /// Updates a Timestream for InfluxDB DB instance.
    pub fn updateDbInstance(self: *Self, allocator: std.mem.Allocator, input: update_db_instance.UpdateDbInstanceInput, options: update_db_instance.Options) !update_db_instance.UpdateDbInstanceOutput {
        return update_db_instance.execute(self, allocator, input, options);
    }

    pub fn listDbClustersPaginator(self: *Self, params: list_db_clusters.ListDbClustersInput) paginator.ListDbClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDbInstancesPaginator(self: *Self, params: list_db_instances.ListDbInstancesInput) paginator.ListDbInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDbInstancesForClusterPaginator(self: *Self, params: list_db_instances_for_cluster.ListDbInstancesForClusterInput) paginator.ListDbInstancesForClusterPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDbParameterGroupsPaginator(self: *Self, params: list_db_parameter_groups.ListDbParameterGroupsInput) paginator.ListDbParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
