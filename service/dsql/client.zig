const aws = @import("aws");
const std = @import("std");

const create_cluster = @import("create_cluster.zig");
const create_stream = @import("create_stream.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_cluster_policy = @import("delete_cluster_policy.zig");
const delete_stream = @import("delete_stream.zig");
const get_cluster = @import("get_cluster.zig");
const get_cluster_policy = @import("get_cluster_policy.zig");
const get_stream = @import("get_stream.zig");
const get_vpc_endpoint_service_name = @import("get_vpc_endpoint_service_name.zig");
const list_clusters = @import("list_clusters.zig");
const list_streams = @import("list_streams.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_cluster_policy = @import("put_cluster_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cluster = @import("update_cluster.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "DSQL";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// The CreateCluster API allows you to create both single-Region clusters and
    /// multi-Region clusters. With the addition of the *multiRegionProperties*
    /// parameter, you can create a cluster with witness Region support and
    /// establish peer relationships with clusters in other Regions during creation.
    ///
    /// Creating multi-Region clusters requires additional IAM permissions beyond
    /// those needed for single-Region clusters, as detailed in the **Required
    /// permissions** section below.
    ///
    /// **Required permissions**
    ///
    /// **dsql:CreateCluster**
    ///
    /// Required to create a cluster.
    ///
    /// Resources: `arn:aws:dsql:region:account-id:cluster/*`
    ///
    /// **dsql:TagResource**
    ///
    /// Permission to add tags to a resource.
    ///
    /// Resources: `arn:aws:dsql:region:account-id:cluster/*`
    ///
    /// **dsql:PutMultiRegionProperties**
    ///
    /// Permission to configure multi-Region properties for a cluster.
    ///
    /// Resources: `arn:aws:dsql:region:account-id:cluster/*`
    ///
    /// **dsql:AddPeerCluster**
    ///
    /// When specifying `multiRegionProperties.clusters`, permission to add peer
    /// clusters.
    ///
    /// Resources:
    ///
    /// * Local cluster: `arn:aws:dsql:region:account-id:cluster/*`
    /// * Each peer cluster: exact ARN of each specified peer cluster
    ///
    /// **dsql:PutWitnessRegion**
    ///
    /// When specifying `multiRegionProperties.witnessRegion`, permission to set a
    /// witness Region. This permission is checked both in the cluster Region and in
    /// the witness Region.
    ///
    /// Resources: `arn:aws:dsql:region:account-id:cluster/*`
    ///
    /// Condition Keys: `dsql:WitnessRegion` (matching the specified witness region)
    ///
    /// * The witness Region specified in `multiRegionProperties.witnessRegion`
    ///   cannot be the same as the cluster's Region.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: CallOptions) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new change data capture (CDC) stream for a cluster. The stream
    /// captures database changes and delivers them to the specified target
    /// destination.
    ///
    /// **Required permissions**
    ///
    /// **dsql:CreateStream**
    ///
    /// Permission to create a new stream.
    ///
    /// Resources: `arn:aws:dsql:region:account-id:cluster/cluster-id`
    ///
    /// **iam:PassRole**
    ///
    /// Permission to pass the IAM role specified in the target definition to the
    /// service.
    ///
    /// Resources: ARN of the IAM role specified in
    /// `targetDefinition.kinesis.roleArn`
    ///
    /// **kms:Decrypt**
    ///
    /// Required when the cluster uses a customer managed KMS key (CMK). Permission
    /// to decrypt data using the cluster's CMK.
    ///
    /// Resources: ARN of the KMS key used by the cluster
    pub fn createStream(self: *Self, allocator: std.mem.Allocator, input: create_stream.CreateStreamInput, options: CallOptions) !create_stream.CreateStreamOutput {
        return create_stream.execute(self, allocator, input, options);
    }

    /// Deletes a cluster in Amazon Aurora DSQL.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: CallOptions) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy attached to a cluster. This removes all
    /// access permissions defined by the policy, reverting to default access
    /// controls.
    pub fn deleteClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_policy.DeleteClusterPolicyInput, options: CallOptions) !delete_cluster_policy.DeleteClusterPolicyOutput {
        return delete_cluster_policy.execute(self, allocator, input, options);
    }

    /// Deletes a stream from a cluster.
    pub fn deleteStream(self: *Self, allocator: std.mem.Allocator, input: delete_stream.DeleteStreamInput, options: CallOptions) !delete_stream.DeleteStreamOutput {
        return delete_stream.execute(self, allocator, input, options);
    }

    /// Retrieves information about a cluster.
    pub fn getCluster(self: *Self, allocator: std.mem.Allocator, input: get_cluster.GetClusterInput, options: CallOptions) !get_cluster.GetClusterOutput {
        return get_cluster.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy document attached to a cluster. This
    /// policy defines the access permissions and conditions for the cluster.
    pub fn getClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: get_cluster_policy.GetClusterPolicyInput, options: CallOptions) !get_cluster_policy.GetClusterPolicyOutput {
        return get_cluster_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about a stream.
    pub fn getStream(self: *Self, allocator: std.mem.Allocator, input: get_stream.GetStreamInput, options: CallOptions) !get_stream.GetStreamOutput {
        return get_stream.execute(self, allocator, input, options);
    }

    /// Retrieves the VPC endpoint service name.
    pub fn getVpcEndpointServiceName(self: *Self, allocator: std.mem.Allocator, input: get_vpc_endpoint_service_name.GetVpcEndpointServiceNameInput, options: CallOptions) !get_vpc_endpoint_service_name.GetVpcEndpointServiceNameOutput {
        return get_vpc_endpoint_service_name.execute(self, allocator, input, options);
    }

    /// Retrieves information about a list of clusters.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: CallOptions) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Retrieves information about a list of streams for a cluster.
    pub fn listStreams(self: *Self, allocator: std.mem.Allocator, input: list_streams.ListStreamsInput, options: CallOptions) !list_streams.ListStreamsOutput {
        return list_streams.execute(self, allocator, input, options);
    }

    /// Lists all of the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to a cluster. This policy defines access
    /// permissions and conditions for the cluster, allowing you to control which
    /// principals can perform actions on the cluster.
    pub fn putClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: put_cluster_policy.PutClusterPolicyInput, options: CallOptions) !put_cluster_policy.PutClusterPolicyOutput {
        return put_cluster_policy.execute(self, allocator, input, options);
    }

    /// Tags a resource with a map of key and value pairs.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// The *UpdateCluster* API allows you to modify both single-Region and
    /// multi-Region cluster configurations. With the *multiRegionProperties*
    /// parameter, you can add or modify witness Region support and manage peer
    /// relationships with clusters in other Regions.
    ///
    /// Note that updating multi-Region clusters requires additional IAM permissions
    /// beyond those needed for standard cluster updates, as detailed in the
    /// Permissions section.
    ///
    /// **Required permissions**
    ///
    /// **dsql:UpdateCluster**
    ///
    /// Permission to update a DSQL cluster.
    ///
    /// Resources: `arn:aws:dsql:*region*:*account-id*:cluster/*cluster-id* `
    ///
    /// **dsql:PutMultiRegionProperties**
    ///
    /// Permission to configure multi-Region properties for a cluster.
    ///
    /// Resources: `arn:aws:dsql:*region*:*account-id*:cluster/*cluster-id* `
    ///
    /// **dsql:GetCluster**
    ///
    /// Permission to retrieve cluster information.
    ///
    /// Resources: `arn:aws:dsql:*region*:*account-id*:cluster/*cluster-id* `
    ///
    /// **dsql:AddPeerCluster**
    ///
    /// Permission to add peer clusters.
    ///
    /// Resources:
    ///
    /// * Local cluster: `arn:aws:dsql:*region*:*account-id*:cluster/*cluster-id* `
    /// * Each peer cluster: exact ARN of each specified peer cluster
    ///
    /// **dsql:RemovePeerCluster**
    ///
    /// Permission to remove peer clusters. When you list peer clusters in
    /// `multiRegionProperties.clusters`, you need this permission for each current
    /// peer cluster that your list omits.
    ///
    /// Resources:
    ///
    /// * Each removed peer cluster: exact ARN of each removed peer cluster, in its
    ///   own Region
    ///
    /// **dsql:PutWitnessRegion**
    ///
    /// Permission to set a witness Region.
    ///
    /// Resources: `arn:aws:dsql:*region*:*account-id*:cluster/*cluster-id* `
    ///
    /// Condition Keys: dsql:WitnessRegion (matching the specified witness Region)
    ///
    /// **This permission is checked both in the cluster Region and in the witness
    /// Region.**
    ///
    /// * The witness Region specified in `multiRegionProperties.witnessRegion`
    ///   cannot be the same as the cluster's Region.
    /// * When you list peer clusters in `multiRegionProperties.clusters`, you need
    ///   `dsql:AddPeerCluster` for every peer cluster in your request. You need
    ///   `dsql:RemovePeerCluster` only for the peer clusters that the update
    ///   removes.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: CallOptions) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listStreamsPaginator(self: *Self, params: list_streams.ListStreamsInput) paginator.ListStreamsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilClusterActive(self: *Self, params: get_cluster.GetClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterNotExists(self: *Self, params: get_cluster.GetClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterNotExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStreamActive(self: *Self, params: get_stream.GetStreamInput) aws.waiter.WaiterError!void {
        var w = waiters.StreamActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStreamNotExists(self: *Self, params: get_stream.GetStreamInput) aws.waiter.WaiterError!void {
        var w = waiters.StreamNotExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
