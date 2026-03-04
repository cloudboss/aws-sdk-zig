const aws = @import("aws");
const std = @import("std");

const create_cluster = @import("create_cluster.zig");
const create_compute_node_group = @import("create_compute_node_group.zig");
const create_queue = @import("create_queue.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_compute_node_group = @import("delete_compute_node_group.zig");
const delete_queue = @import("delete_queue.zig");
const get_cluster = @import("get_cluster.zig");
const get_compute_node_group = @import("get_compute_node_group.zig");
const get_queue = @import("get_queue.zig");
const list_clusters = @import("list_clusters.zig");
const list_compute_node_groups = @import("list_compute_node_groups.zig");
const list_queues = @import("list_queues.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_compute_node_group_instance = @import("register_compute_node_group_instance.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cluster = @import("update_cluster.zig");
const update_compute_node_group = @import("update_compute_node_group.zig");
const update_queue = @import("update_queue.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "PCS";

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

    /// Creates a cluster in your account. PCS creates the cluster controller in a
    /// service-owned account. The cluster controller communicates with the cluster
    /// resources in your account. The subnets and security groups for the cluster
    /// must already exist before you use this API action.
    ///
    /// It takes time for PCS to create the cluster. The cluster is in a `Creating`
    /// state until it is ready to use. There can only be 1 cluster in a `Creating`
    /// state per Amazon Web Services Region per Amazon Web Services account.
    /// `CreateCluster` fails with a `ServiceQuotaExceededException` if there is
    /// already a cluster in a `Creating` state.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: CallOptions) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a managed set of compute nodes. You associate a compute node group
    /// with a cluster through 1 or more PCS queues or as part of the login fleet. A
    /// compute node group includes the definition of the compute properties and
    /// lifecycle management. PCS uses the information you provide to this API
    /// action to launch compute nodes in your account. You can only specify subnets
    /// in the same Amazon VPC as your cluster. You receive billing charges for the
    /// compute nodes that PCS launches in your account. You must already have a
    /// launch template before you call this API. For more information, see [Launch
    /// an instance from a launch
    /// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the *Amazon Elastic Compute Cloud User Guide for Linux Instances*.
    pub fn createComputeNodeGroup(self: *Self, allocator: std.mem.Allocator, input: create_compute_node_group.CreateComputeNodeGroupInput, options: CallOptions) !create_compute_node_group.CreateComputeNodeGroupOutput {
        return create_compute_node_group.execute(self, allocator, input, options);
    }

    /// Creates a job queue. You must associate 1 or more compute node groups with
    /// the queue. You can associate 1 compute node group with multiple queues.
    pub fn createQueue(self: *Self, allocator: std.mem.Allocator, input: create_queue.CreateQueueInput, options: CallOptions) !create_queue.CreateQueueOutput {
        return create_queue.execute(self, allocator, input, options);
    }

    /// Deletes a cluster and all its linked resources. You must delete all queues
    /// and compute node groups associated with the cluster before you can delete
    /// the cluster.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: CallOptions) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a compute node group. You must delete all queues associated with the
    /// compute node group first.
    pub fn deleteComputeNodeGroup(self: *Self, allocator: std.mem.Allocator, input: delete_compute_node_group.DeleteComputeNodeGroupInput, options: CallOptions) !delete_compute_node_group.DeleteComputeNodeGroupOutput {
        return delete_compute_node_group.execute(self, allocator, input, options);
    }

    /// Deletes a job queue. If the compute node group associated with this queue
    /// isn't associated with any other queues, PCS terminates all the compute nodes
    /// for this queue.
    pub fn deleteQueue(self: *Self, allocator: std.mem.Allocator, input: delete_queue.DeleteQueueInput, options: CallOptions) !delete_queue.DeleteQueueOutput {
        return delete_queue.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a running cluster in your account. This
    /// API action provides networking information, endpoint information for
    /// communication with the scheduler, and provisioning status.
    pub fn getCluster(self: *Self, allocator: std.mem.Allocator, input: get_cluster.GetClusterInput, options: CallOptions) !get_cluster.GetClusterOutput {
        return get_cluster.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a compute node group. This API action
    /// provides networking information, EC2 instance type, compute node group
    /// status, and scheduler (such as Slurm) configuration.
    pub fn getComputeNodeGroup(self: *Self, allocator: std.mem.Allocator, input: get_compute_node_group.GetComputeNodeGroupInput, options: CallOptions) !get_compute_node_group.GetComputeNodeGroupOutput {
        return get_compute_node_group.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a queue. The information includes the
    /// compute node groups that the queue uses to schedule jobs.
    pub fn getQueue(self: *Self, allocator: std.mem.Allocator, input: get_queue.GetQueueInput, options: CallOptions) !get_queue.GetQueueOutput {
        return get_queue.execute(self, allocator, input, options);
    }

    /// Returns a list of running clusters in your account.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: CallOptions) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of all compute node groups associated with a cluster.
    pub fn listComputeNodeGroups(self: *Self, allocator: std.mem.Allocator, input: list_compute_node_groups.ListComputeNodeGroupsInput, options: CallOptions) !list_compute_node_groups.ListComputeNodeGroupsOutput {
        return list_compute_node_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of all queues associated with a cluster.
    pub fn listQueues(self: *Self, allocator: std.mem.Allocator, input: list_queues.ListQueuesInput, options: CallOptions) !list_queues.ListQueuesOutput {
        return list_queues.execute(self, allocator, input, options);
    }

    /// Returns a list of all tags on an PCS resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// This API action isn't intended for you to use.
    ///
    /// PCS uses this API action to register the compute nodes it launches in your
    /// account.
    pub fn registerComputeNodeGroupInstance(self: *Self, allocator: std.mem.Allocator, input: register_compute_node_group_instance.RegisterComputeNodeGroupInstanceInput, options: CallOptions) !register_compute_node_group_instance.RegisterComputeNodeGroupInstanceOutput {
        return register_compute_node_group_instance.execute(self, allocator, input, options);
    }

    /// Adds or edits tags on an PCS resource. Each tag consists of a tag key and a
    /// tag value. The tag key and tag value are case-sensitive strings. The tag
    /// value can be an empty (null) string. To add a tag, specify a new tag key and
    /// a tag value. To edit a tag, specify an existing tag key and a new tag value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes tags from an PCS resource. To delete a tag, specify the tag key and
    /// the Amazon Resource Name (ARN) of the PCS resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a cluster configuration. You can modify Slurm scheduler settings,
    /// accounting configuration, and security groups for an existing cluster.
    ///
    /// You can only update clusters that are in `ACTIVE`, `UPDATE_FAILED`, or
    /// `SUSPENDED` state. All associated resources (queues and compute node groups)
    /// must be in `ACTIVE` state before you can update the cluster.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: CallOptions) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Updates a compute node group. You can update many of the fields related to
    /// your compute node group including the configurations for networking, compute
    /// nodes, and settings specific to your scheduler (such as Slurm).
    pub fn updateComputeNodeGroup(self: *Self, allocator: std.mem.Allocator, input: update_compute_node_group.UpdateComputeNodeGroupInput, options: CallOptions) !update_compute_node_group.UpdateComputeNodeGroupOutput {
        return update_compute_node_group.execute(self, allocator, input, options);
    }

    /// Updates the compute node group configuration of a queue. Use this API to
    /// change the compute node groups that the queue can send jobs to.
    pub fn updateQueue(self: *Self, allocator: std.mem.Allocator, input: update_queue.UpdateQueueInput, options: CallOptions) !update_queue.UpdateQueueOutput {
        return update_queue.execute(self, allocator, input, options);
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComputeNodeGroupsPaginator(self: *Self, params: list_compute_node_groups.ListComputeNodeGroupsInput) paginator.ListComputeNodeGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listQueuesPaginator(self: *Self, params: list_queues.ListQueuesInput) paginator.ListQueuesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
