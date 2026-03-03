const aws = @import("aws");
const std = @import("std");

const create_cluster = @import("create_cluster.zig");
const create_parameter_group = @import("create_parameter_group.zig");
const create_subnet_group = @import("create_subnet_group.zig");
const decrease_replication_factor = @import("decrease_replication_factor.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_parameter_group = @import("delete_parameter_group.zig");
const delete_subnet_group = @import("delete_subnet_group.zig");
const describe_clusters = @import("describe_clusters.zig");
const describe_default_parameters = @import("describe_default_parameters.zig");
const describe_events = @import("describe_events.zig");
const describe_parameter_groups = @import("describe_parameter_groups.zig");
const describe_parameters = @import("describe_parameters.zig");
const describe_subnet_groups = @import("describe_subnet_groups.zig");
const increase_replication_factor = @import("increase_replication_factor.zig");
const list_tags = @import("list_tags.zig");
const reboot_node = @import("reboot_node.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cluster = @import("update_cluster.zig");
const update_parameter_group = @import("update_parameter_group.zig");
const update_subnet_group = @import("update_subnet_group.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DAX";

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

    /// Creates a DAX cluster. All nodes in the cluster run the same DAX caching
    /// software.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new parameter group. A parameter group is a collection of
    /// parameters that
    /// you apply to all of the nodes in a DAX cluster.
    pub fn createParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_parameter_group.CreateParameterGroupInput, options: create_parameter_group.Options) !create_parameter_group.CreateParameterGroupOutput {
        return create_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new subnet group.
    pub fn createSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_subnet_group.CreateSubnetGroupInput, options: create_subnet_group.Options) !create_subnet_group.CreateSubnetGroupOutput {
        return create_subnet_group.execute(self, allocator, input, options);
    }

    /// Removes one or more nodes from a DAX cluster.
    ///
    /// You cannot use `DecreaseReplicationFactor` to remove the last node
    /// in a DAX cluster. If you need to do this, use
    /// `DeleteCluster` instead.
    pub fn decreaseReplicationFactor(self: *Self, allocator: std.mem.Allocator, input: decrease_replication_factor.DecreaseReplicationFactorInput, options: decrease_replication_factor.Options) !decrease_replication_factor.DecreaseReplicationFactorOutput {
        return decrease_replication_factor.execute(self, allocator, input, options);
    }

    /// Deletes a previously provisioned DAX cluster.
    /// *DeleteCluster* deletes all associated nodes, node endpoints and
    /// the DAX cluster itself. When you receive a successful response from this
    /// action, DAX immediately begins deleting the cluster; you cannot cancel or
    /// revert this action.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified parameter group. You cannot delete a parameter group
    /// if it is
    /// associated with any DAX clusters.
    pub fn deleteParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_parameter_group.DeleteParameterGroupInput, options: delete_parameter_group.Options) !delete_parameter_group.DeleteParameterGroupOutput {
        return delete_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a subnet group.
    ///
    /// You cannot delete a subnet group if it is associated with any DAX
    /// clusters.
    pub fn deleteSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_subnet_group.DeleteSubnetGroupInput, options: delete_subnet_group.Options) !delete_subnet_group.DeleteSubnetGroupOutput {
        return delete_subnet_group.execute(self, allocator, input, options);
    }

    /// Returns information about all provisioned DAX clusters if no cluster
    /// identifier is
    /// specified, or about a specific DAX cluster if a cluster identifier is
    /// supplied.
    ///
    /// If the cluster is in the CREATING state, only cluster level information will
    /// be
    /// displayed until all of the nodes are successfully provisioned.
    ///
    /// If the cluster is in the DELETING state, only cluster level information will
    /// be
    /// displayed.
    ///
    /// If nodes are currently being added to the DAX cluster, node endpoint
    /// information
    /// and creation time for the additional nodes will not be displayed until they
    /// are
    /// completely provisioned. When the DAX cluster state is
    /// *available*, the cluster is ready for use.
    ///
    /// If nodes are currently being removed from the DAX cluster, no
    /// endpoint information for the removed nodes is displayed.
    pub fn describeClusters(self: *Self, allocator: std.mem.Allocator, input: describe_clusters.DescribeClustersInput, options: describe_clusters.Options) !describe_clusters.DescribeClustersOutput {
        return describe_clusters.execute(self, allocator, input, options);
    }

    /// Returns the default system parameter information for the DAX caching
    /// software.
    pub fn describeDefaultParameters(self: *Self, allocator: std.mem.Allocator, input: describe_default_parameters.DescribeDefaultParametersInput, options: describe_default_parameters.Options) !describe_default_parameters.DescribeDefaultParametersOutput {
        return describe_default_parameters.execute(self, allocator, input, options);
    }

    /// Returns events related to DAX clusters and parameter groups. You can
    /// obtain events specific to a particular DAX cluster or parameter group by
    /// providing the name as a parameter.
    ///
    /// By default, only the events occurring within the last 24 hours are returned;
    /// however, you can retrieve up to 14 days' worth of events if necessary.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns a list of parameter group descriptions. If a parameter group name is
    /// specified, the list will contain only the descriptions for that group.
    pub fn describeParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_parameter_groups.DescribeParameterGroupsInput, options: describe_parameter_groups.Options) !describe_parameter_groups.DescribeParameterGroupsOutput {
        return describe_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular parameter group.
    pub fn describeParameters(self: *Self, allocator: std.mem.Allocator, input: describe_parameters.DescribeParametersInput, options: describe_parameters.Options) !describe_parameters.DescribeParametersOutput {
        return describe_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of subnet group descriptions. If a subnet group name is
    /// specified,
    /// the list will contain only the description of that group.
    pub fn describeSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_subnet_groups.DescribeSubnetGroupsInput, options: describe_subnet_groups.Options) !describe_subnet_groups.DescribeSubnetGroupsOutput {
        return describe_subnet_groups.execute(self, allocator, input, options);
    }

    /// Adds one or more nodes to a DAX cluster.
    pub fn increaseReplicationFactor(self: *Self, allocator: std.mem.Allocator, input: increase_replication_factor.IncreaseReplicationFactorInput, options: increase_replication_factor.Options) !increase_replication_factor.IncreaseReplicationFactorOutput {
        return increase_replication_factor.execute(self, allocator, input, options);
    }

    /// List all of the tags for a DAX cluster. You can call
    /// `ListTags` up to 10 times per second, per account.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: list_tags.Options) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Reboots a single node of a DAX cluster. The reboot action takes
    /// place as soon as possible. During the reboot, the node status is set to
    /// REBOOTING.
    ///
    /// `RebootNode` restarts the DAX engine process and does not remove the
    /// contents of the cache.
    pub fn rebootNode(self: *Self, allocator: std.mem.Allocator, input: reboot_node.RebootNodeInput, options: reboot_node.Options) !reboot_node.RebootNodeOutput {
        return reboot_node.execute(self, allocator, input, options);
    }

    /// Associates a set of tags with a DAX resource.
    /// You can call `TagResource` up to
    /// 5 times per second, per account.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the association of tags from a DAX resource. You can call
    /// `UntagResource` up to 5 times per second, per account.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a DAX cluster. You can use this action to
    /// change one or more cluster configuration parameters by specifying the
    /// parameters and the
    /// new values.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a parameter group. You can modify up to 20
    /// parameters in
    /// a single request by submitting a list parameter name and value pairs.
    pub fn updateParameterGroup(self: *Self, allocator: std.mem.Allocator, input: update_parameter_group.UpdateParameterGroupInput, options: update_parameter_group.Options) !update_parameter_group.UpdateParameterGroupOutput {
        return update_parameter_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing subnet group.
    pub fn updateSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: update_subnet_group.UpdateSubnetGroupInput, options: update_subnet_group.Options) !update_subnet_group.UpdateSubnetGroupOutput {
        return update_subnet_group.execute(self, allocator, input, options);
    }
};
