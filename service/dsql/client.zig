const aws = @import("aws");
const std = @import("std");

const create_cluster = @import("create_cluster.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_cluster_policy = @import("delete_cluster_policy.zig");
const get_cluster = @import("get_cluster.zig");
const get_cluster_policy = @import("get_cluster_policy.zig");
const get_vpc_endpoint_service_name = @import("get_vpc_endpoint_service_name.zig");
const list_clusters = @import("list_clusters.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_cluster_policy = @import("put_cluster_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cluster = @import("update_cluster.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DSQL";

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
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a cluster in Amazon Aurora DSQL.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy attached to a cluster. This removes all
    /// access permissions defined by the policy, reverting to default access
    /// controls.
    pub fn deleteClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_policy.DeleteClusterPolicyInput, options: delete_cluster_policy.Options) !delete_cluster_policy.DeleteClusterPolicyOutput {
        return delete_cluster_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about a cluster.
    pub fn getCluster(self: *Self, allocator: std.mem.Allocator, input: get_cluster.GetClusterInput, options: get_cluster.Options) !get_cluster.GetClusterOutput {
        return get_cluster.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy document attached to a cluster. This
    /// policy defines the access permissions and conditions for the cluster.
    pub fn getClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: get_cluster_policy.GetClusterPolicyInput, options: get_cluster_policy.Options) !get_cluster_policy.GetClusterPolicyOutput {
        return get_cluster_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the VPC endpoint service name.
    pub fn getVpcEndpointServiceName(self: *Self, allocator: std.mem.Allocator, input: get_vpc_endpoint_service_name.GetVpcEndpointServiceNameInput, options: get_vpc_endpoint_service_name.Options) !get_vpc_endpoint_service_name.GetVpcEndpointServiceNameOutput {
        return get_vpc_endpoint_service_name.execute(self, allocator, input, options);
    }

    /// Retrieves information about a list of clusters.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Lists all of the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to a cluster. This policy defines access
    /// permissions and conditions for the cluster, allowing you to control which
    /// principals can perform actions on the cluster.
    pub fn putClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: put_cluster_policy.PutClusterPolicyInput, options: put_cluster_policy.Options) !put_cluster_policy.PutClusterPolicyOutput {
        return put_cluster_policy.execute(self, allocator, input, options);
    }

    /// Tags a resource with a map of key and value pairs.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
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
    /// Permission to remove peer clusters. The *dsql:RemovePeerCluster* permission
    /// uses a wildcard ARN pattern to simplify permission management during
    /// updates.
    ///
    /// Resources: `arn:aws:dsql:*:*account-id*:cluster/*`
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
    /// * The witness region specified in `multiRegionProperties.witnessRegion`
    ///   cannot be the same as the cluster's Region.
    /// * When updating clusters with peer relationships, permissions are checked
    ///   for both adding and removing peers.
    /// * The `dsql:RemovePeerCluster` permission uses a wildcard ARN pattern to
    ///   simplify permission management during updates.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
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
};
