const aws = @import("aws");
const std = @import("std");

const batch_update_cluster = @import("batch_update_cluster.zig");
const copy_snapshot = @import("copy_snapshot.zig");
const create_acl = @import("create_acl.zig");
const create_cluster = @import("create_cluster.zig");
const create_multi_region_cluster = @import("create_multi_region_cluster.zig");
const create_parameter_group = @import("create_parameter_group.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_subnet_group = @import("create_subnet_group.zig");
const create_user = @import("create_user.zig");
const delete_acl = @import("delete_acl.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_multi_region_cluster = @import("delete_multi_region_cluster.zig");
const delete_parameter_group = @import("delete_parameter_group.zig");
const delete_snapshot = @import("delete_snapshot.zig");
const delete_subnet_group = @import("delete_subnet_group.zig");
const delete_user = @import("delete_user.zig");
const describe_ac_ls = @import("describe_ac_ls.zig");
const describe_clusters = @import("describe_clusters.zig");
const describe_engine_versions = @import("describe_engine_versions.zig");
const describe_events = @import("describe_events.zig");
const describe_multi_region_clusters = @import("describe_multi_region_clusters.zig");
const describe_multi_region_parameter_groups = @import("describe_multi_region_parameter_groups.zig");
const describe_multi_region_parameters = @import("describe_multi_region_parameters.zig");
const describe_parameter_groups = @import("describe_parameter_groups.zig");
const describe_parameters = @import("describe_parameters.zig");
const describe_reserved_nodes = @import("describe_reserved_nodes.zig");
const describe_reserved_nodes_offerings = @import("describe_reserved_nodes_offerings.zig");
const describe_service_updates = @import("describe_service_updates.zig");
const describe_snapshots = @import("describe_snapshots.zig");
const describe_subnet_groups = @import("describe_subnet_groups.zig");
const describe_users = @import("describe_users.zig");
const failover_shard = @import("failover_shard.zig");
const list_allowed_multi_region_cluster_updates = @import("list_allowed_multi_region_cluster_updates.zig");
const list_allowed_node_type_updates = @import("list_allowed_node_type_updates.zig");
const list_tags = @import("list_tags.zig");
const purchase_reserved_nodes_offering = @import("purchase_reserved_nodes_offering.zig");
const reset_parameter_group = @import("reset_parameter_group.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_acl = @import("update_acl.zig");
const update_cluster = @import("update_cluster.zig");
const update_multi_region_cluster = @import("update_multi_region_cluster.zig");
const update_parameter_group = @import("update_parameter_group.zig");
const update_subnet_group = @import("update_subnet_group.zig");
const update_user = @import("update_user.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MemoryDB";

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

    /// Apply the service update to a list of clusters supplied. For more
    /// information on service updates and applying them, see [Applying the service
    /// updates](https://docs.aws.amazon.com/MemoryDB/latest/devguide/managing-updates.html#applying-updates).
    pub fn batchUpdateCluster(self: *Self, allocator: std.mem.Allocator, input: batch_update_cluster.BatchUpdateClusterInput, options: batch_update_cluster.Options) !batch_update_cluster.BatchUpdateClusterOutput {
        return batch_update_cluster.execute(self, allocator, input, options);
    }

    /// Makes a copy of an existing snapshot.
    pub fn copySnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_snapshot.CopySnapshotInput, options: copy_snapshot.Options) !copy_snapshot.CopySnapshotOutput {
        return copy_snapshot.execute(self, allocator, input, options);
    }

    /// Creates an Access Control List. For more information, see [Authenticating
    /// users with Access Contol Lists
    /// (ACLs)](https://docs.aws.amazon.com/MemoryDB/latest/devguide/clusters.acls.html).
    pub fn createAcl(self: *Self, allocator: std.mem.Allocator, input: create_acl.CreateACLInput, options: create_acl.Options) !create_acl.CreateACLOutput {
        return create_acl.execute(self, allocator, input, options);
    }

    /// Creates a cluster. All nodes in the cluster run the same protocol-compliant
    /// engine software.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new multi-Region cluster.
    pub fn createMultiRegionCluster(self: *Self, allocator: std.mem.Allocator, input: create_multi_region_cluster.CreateMultiRegionClusterInput, options: create_multi_region_cluster.Options) !create_multi_region_cluster.CreateMultiRegionClusterOutput {
        return create_multi_region_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new MemoryDB parameter group. A parameter group is a collection of
    /// parameters and their values that are applied to all of the nodes in any
    /// cluster. For
    /// more information, see [Configuring engine parameters using parameter
    /// groups](https://docs.aws.amazon.com/MemoryDB/latest/devguide/parametergroups.html).
    pub fn createParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_parameter_group.CreateParameterGroupInput, options: create_parameter_group.Options) !create_parameter_group.CreateParameterGroupOutput {
        return create_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a copy of an entire cluster at a specific moment in time.
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: create_snapshot.Options) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a subnet group. A subnet group is a collection of subnets (typically
    /// private) that you can designate for your clusters running in an Amazon
    /// Virtual Private Cloud (VPC) environment.
    ///
    /// When you create a cluster in an Amazon VPC, you must specify a subnet group.
    /// MemoryDB uses that subnet group to choose a subnet and IP addresses within
    /// that subnet to associate with your nodes.
    /// For more information, see [Subnets and subnet
    /// groups](https://docs.aws.amazon.com/MemoryDB/latest/devguide/subnetgroups.html).
    pub fn createSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_subnet_group.CreateSubnetGroupInput, options: create_subnet_group.Options) !create_subnet_group.CreateSubnetGroupOutput {
        return create_subnet_group.execute(self, allocator, input, options);
    }

    /// Creates a MemoryDB user. For more information, see [Authenticating users
    /// with Access Contol Lists
    /// (ACLs)](https://docs.aws.amazon.com/MemoryDB/latest/devguide/clusters.acls.html).
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes an Access Control List. The ACL must first be disassociated from the
    /// cluster before it can be deleted. For more information, see [Authenticating
    /// users with Access Contol Lists
    /// (ACLs)](https://docs.aws.amazon.com/MemoryDB/latest/devguide/clusters.acls.html).
    pub fn deleteAcl(self: *Self, allocator: std.mem.Allocator, input: delete_acl.DeleteACLInput, options: delete_acl.Options) !delete_acl.DeleteACLOutput {
        return delete_acl.execute(self, allocator, input, options);
    }

    /// Deletes a cluster. It also deletes all associated nodes and node endpoints.
    ///
    /// `CreateSnapshot` permission is required to create a final snapshot.
    /// Without this permission, the API call will fail with an `Access Denied`
    /// exception.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes an existing multi-Region cluster.
    pub fn deleteMultiRegionCluster(self: *Self, allocator: std.mem.Allocator, input: delete_multi_region_cluster.DeleteMultiRegionClusterInput, options: delete_multi_region_cluster.Options) !delete_multi_region_cluster.DeleteMultiRegionClusterOutput {
        return delete_multi_region_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified parameter group. You cannot delete a parameter group
    /// if it is associated with any clusters.
    /// You cannot delete the default parameter groups in your account.
    pub fn deleteParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_parameter_group.DeleteParameterGroupInput, options: delete_parameter_group.Options) !delete_parameter_group.DeleteParameterGroupOutput {
        return delete_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes an existing snapshot. When you receive a successful response from
    /// this operation, MemoryDB immediately begins deleting the snapshot; you
    /// cannot cancel or revert this operation.
    pub fn deleteSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot.DeleteSnapshotInput, options: delete_snapshot.Options) !delete_snapshot.DeleteSnapshotOutput {
        return delete_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a subnet group. You cannot delete a default subnet group or one that
    /// is associated with any clusters.
    pub fn deleteSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_subnet_group.DeleteSubnetGroupInput, options: delete_subnet_group.Options) !delete_subnet_group.DeleteSubnetGroupOutput {
        return delete_subnet_group.execute(self, allocator, input, options);
    }

    /// Deletes a user. The user will be removed from all ACLs and in turn removed
    /// from all clusters.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Returns a list of ACLs.
    pub fn describeAcLs(self: *Self, allocator: std.mem.Allocator, input: describe_ac_ls.DescribeACLsInput, options: describe_ac_ls.Options) !describe_ac_ls.DescribeACLsOutput {
        return describe_ac_ls.execute(self, allocator, input, options);
    }

    /// Returns information about all provisioned clusters if no cluster identifier
    /// is specified, or about a specific cluster if a cluster name is supplied.
    pub fn describeClusters(self: *Self, allocator: std.mem.Allocator, input: describe_clusters.DescribeClustersInput, options: describe_clusters.Options) !describe_clusters.DescribeClustersOutput {
        return describe_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of the available Redis OSS engine versions.
    pub fn describeEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_engine_versions.DescribeEngineVersionsInput, options: describe_engine_versions.Options) !describe_engine_versions.DescribeEngineVersionsOutput {
        return describe_engine_versions.execute(self, allocator, input, options);
    }

    /// Returns events related to clusters, security groups, and parameter groups.
    /// You can obtain events specific to a particular cluster, security group, or
    /// parameter group by providing the name as a parameter.
    ///
    /// By default, only the events occurring within the last hour are returned;
    /// however, you can retrieve up to 14 days' worth of events if necessary.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns details about one or more multi-Region clusters.
    pub fn describeMultiRegionClusters(self: *Self, allocator: std.mem.Allocator, input: describe_multi_region_clusters.DescribeMultiRegionClustersInput, options: describe_multi_region_clusters.Options) !describe_multi_region_clusters.DescribeMultiRegionClustersOutput {
        return describe_multi_region_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of multi-region parameter groups.
    pub fn describeMultiRegionParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_multi_region_parameter_groups.DescribeMultiRegionParameterGroupsInput, options: describe_multi_region_parameter_groups.Options) !describe_multi_region_parameter_groups.DescribeMultiRegionParameterGroupsOutput {
        return describe_multi_region_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular multi-region parameter
    /// group.
    pub fn describeMultiRegionParameters(self: *Self, allocator: std.mem.Allocator, input: describe_multi_region_parameters.DescribeMultiRegionParametersInput, options: describe_multi_region_parameters.Options) !describe_multi_region_parameters.DescribeMultiRegionParametersOutput {
        return describe_multi_region_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of parameter group descriptions. If a parameter group name is
    /// specified, the list contains only the descriptions for that group.
    pub fn describeParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_parameter_groups.DescribeParameterGroupsInput, options: describe_parameter_groups.Options) !describe_parameter_groups.DescribeParameterGroupsOutput {
        return describe_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular parameter group.
    pub fn describeParameters(self: *Self, allocator: std.mem.Allocator, input: describe_parameters.DescribeParametersInput, options: describe_parameters.Options) !describe_parameters.DescribeParametersOutput {
        return describe_parameters.execute(self, allocator, input, options);
    }

    /// Returns information about reserved nodes for this account, or about a
    /// specified reserved node.
    pub fn describeReservedNodes(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_nodes.DescribeReservedNodesInput, options: describe_reserved_nodes.Options) !describe_reserved_nodes.DescribeReservedNodesOutput {
        return describe_reserved_nodes.execute(self, allocator, input, options);
    }

    /// Lists available reserved node offerings.
    pub fn describeReservedNodesOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_nodes_offerings.DescribeReservedNodesOfferingsInput, options: describe_reserved_nodes_offerings.Options) !describe_reserved_nodes_offerings.DescribeReservedNodesOfferingsOutput {
        return describe_reserved_nodes_offerings.execute(self, allocator, input, options);
    }

    /// Returns details of the service updates.
    pub fn describeServiceUpdates(self: *Self, allocator: std.mem.Allocator, input: describe_service_updates.DescribeServiceUpdatesInput, options: describe_service_updates.Options) !describe_service_updates.DescribeServiceUpdatesOutput {
        return describe_service_updates.execute(self, allocator, input, options);
    }

    /// Returns information about cluster snapshots. By default, DescribeSnapshots
    /// lists all of your snapshots; it can optionally describe a single snapshot,
    /// or just the snapshots associated with a particular cluster.
    pub fn describeSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_snapshots.DescribeSnapshotsInput, options: describe_snapshots.Options) !describe_snapshots.DescribeSnapshotsOutput {
        return describe_snapshots.execute(self, allocator, input, options);
    }

    /// Returns a list of subnet group descriptions. If a subnet group name is
    /// specified, the list contains only the description of that group.
    pub fn describeSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_subnet_groups.DescribeSubnetGroupsInput, options: describe_subnet_groups.Options) !describe_subnet_groups.DescribeSubnetGroupsOutput {
        return describe_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of users.
    pub fn describeUsers(self: *Self, allocator: std.mem.Allocator, input: describe_users.DescribeUsersInput, options: describe_users.Options) !describe_users.DescribeUsersOutput {
        return describe_users.execute(self, allocator, input, options);
    }

    /// Used to failover a shard. This API is designed for testing the behavior of
    /// your application in case of MemoryDB failover. It is not designed to be used
    /// as a production-level tool for initiating
    /// a failover to overcome a problem you may have with the cluster. Moreover, in
    /// certain conditions such as large scale operational events, Amazon may block
    /// this API.
    pub fn failoverShard(self: *Self, allocator: std.mem.Allocator, input: failover_shard.FailoverShardInput, options: failover_shard.Options) !failover_shard.FailoverShardOutput {
        return failover_shard.execute(self, allocator, input, options);
    }

    /// Lists the allowed updates for a multi-Region cluster.
    pub fn listAllowedMultiRegionClusterUpdates(self: *Self, allocator: std.mem.Allocator, input: list_allowed_multi_region_cluster_updates.ListAllowedMultiRegionClusterUpdatesInput, options: list_allowed_multi_region_cluster_updates.Options) !list_allowed_multi_region_cluster_updates.ListAllowedMultiRegionClusterUpdatesOutput {
        return list_allowed_multi_region_cluster_updates.execute(self, allocator, input, options);
    }

    /// Lists all available node types that you can scale to from your cluster's
    /// current node type.
    ///
    /// When you use the UpdateCluster operation to scale your cluster, the value of
    /// the NodeType parameter must be one of the node types returned by this
    /// operation.
    pub fn listAllowedNodeTypeUpdates(self: *Self, allocator: std.mem.Allocator, input: list_allowed_node_type_updates.ListAllowedNodeTypeUpdatesInput, options: list_allowed_node_type_updates.Options) !list_allowed_node_type_updates.ListAllowedNodeTypeUpdatesOutput {
        return list_allowed_node_type_updates.execute(self, allocator, input, options);
    }

    /// Lists all tags currently on a named resource. A tag is a key-value pair
    /// where the key and value are case-sensitive. You can use tags to categorize
    /// and track your MemoryDB resources. For more information, see [Tagging your
    /// MemoryDB
    /// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/Tagging-Resources.html).
    ///
    /// When you add or remove tags from multi region clusters, you might not
    /// immediately see the latest effective tags in the ListTags API response due
    /// to it being eventually consistent specifically for multi region clusters.
    /// For more information, see [Tagging your MemoryDB
    /// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/Tagging-Resources.html).
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: list_tags.Options) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Allows you to purchase a reserved node offering. Reserved nodes are not
    /// eligible for cancellation and are non-refundable.
    pub fn purchaseReservedNodesOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_nodes_offering.PurchaseReservedNodesOfferingInput, options: purchase_reserved_nodes_offering.Options) !purchase_reserved_nodes_offering.PurchaseReservedNodesOfferingOutput {
        return purchase_reserved_nodes_offering.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a parameter group to the engine or system default
    /// value. You can reset specific parameters by submitting a list of parameter
    /// names. To reset the entire parameter group, specify the AllParameters and
    /// ParameterGroupName parameters.
    pub fn resetParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_parameter_group.ResetParameterGroupInput, options: reset_parameter_group.Options) !reset_parameter_group.ResetParameterGroupOutput {
        return reset_parameter_group.execute(self, allocator, input, options);
    }

    /// Use this operation to add tags to a resource. A tag is a key-value pair
    /// where the key and value are case-sensitive. You can use tags to categorize
    /// and track all your MemoryDB resources. For more information, see [Tagging
    /// your MemoryDB
    /// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/Tagging-Resources.html).
    ///
    /// When you add tags to multi region clusters, you might not immediately see
    /// the latest effective tags in the ListTags API response due to it being
    /// eventually consistent specifically for multi region clusters. For more
    /// information, see [Tagging your MemoryDB
    /// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/Tagging-Resources.html).
    ///
    /// You can specify cost-allocation tags for your MemoryDB resources, Amazon
    /// generates a cost allocation report as a comma-separated value
    /// (CSV) file with your usage and costs aggregated by your tags. You can apply
    /// tags that represent business categories
    /// (such as cost centers, application names, or owners) to organize your costs
    /// across multiple services.
    ///
    /// For more information, see [Using Cost Allocation
    /// Tags](https://docs.aws.amazon.com/MemoryDB/latest/devguide/tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Use this operation to remove tags on a resource. A tag is a key-value pair
    /// where the key and value are case-sensitive. You can use tags to categorize
    /// and track all your MemoryDB resources. For more information, see [Tagging
    /// your MemoryDB
    /// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/Tagging-Resources.html).
    ///
    /// When you remove tags from multi region clusters, you might not immediately
    /// see the latest effective tags in the ListTags API response due to it being
    /// eventually consistent specifically for multi region clusters. For more
    /// information, see [Tagging your MemoryDB
    /// resources](https://docs.aws.amazon.com/MemoryDB/latest/devguide/Tagging-Resources.html).
    ///
    /// You can specify cost-allocation tags for your MemoryDB resources, Amazon
    /// generates a cost allocation report as a comma-separated value
    /// (CSV) file with your usage and costs aggregated by your tags. You can apply
    /// tags that represent business categories
    /// (such as cost centers, application names, or owners) to organize your costs
    /// across multiple services.
    ///
    /// For more information, see [Using Cost Allocation
    /// Tags](https://docs.aws.amazon.com/MemoryDB/latest/devguide/tagging.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Changes the list of users that belong to the Access Control List.
    pub fn updateAcl(self: *Self, allocator: std.mem.Allocator, input: update_acl.UpdateACLInput, options: update_acl.Options) !update_acl.UpdateACLOutput {
        return update_acl.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a cluster. You can use this operation to change
    /// one or more cluster configuration settings by specifying the settings and
    /// the new values.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing multi-Region cluster.
    pub fn updateMultiRegionCluster(self: *Self, allocator: std.mem.Allocator, input: update_multi_region_cluster.UpdateMultiRegionClusterInput, options: update_multi_region_cluster.Options) !update_multi_region_cluster.UpdateMultiRegionClusterOutput {
        return update_multi_region_cluster.execute(self, allocator, input, options);
    }

    /// Updates the parameters of a parameter group. You can modify up to 20
    /// parameters in a single request by submitting a list parameter name and value
    /// pairs.
    pub fn updateParameterGroup(self: *Self, allocator: std.mem.Allocator, input: update_parameter_group.UpdateParameterGroupInput, options: update_parameter_group.Options) !update_parameter_group.UpdateParameterGroupOutput {
        return update_parameter_group.execute(self, allocator, input, options);
    }

    /// Updates a subnet group. For more information, see [Updating a subnet
    /// group](https://docs.aws.amazon.com/MemoryDB/latest/devguide/ubnetGroups.Modifying.html)
    pub fn updateSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: update_subnet_group.UpdateSubnetGroupInput, options: update_subnet_group.Options) !update_subnet_group.UpdateSubnetGroupOutput {
        return update_subnet_group.execute(self, allocator, input, options);
    }

    /// Changes user password(s) and/or access string.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn describeAcLsPaginator(self: *Self, params: describe_ac_ls.DescribeACLsInput) paginator.DescribeACLsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClustersPaginator(self: *Self, params: describe_clusters.DescribeClustersInput) paginator.DescribeClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEngineVersionsPaginator(self: *Self, params: describe_engine_versions.DescribeEngineVersionsInput) paginator.DescribeEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMultiRegionClustersPaginator(self: *Self, params: describe_multi_region_clusters.DescribeMultiRegionClustersInput) paginator.DescribeMultiRegionClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeParameterGroupsPaginator(self: *Self, params: describe_parameter_groups.DescribeParameterGroupsInput) paginator.DescribeParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeParametersPaginator(self: *Self, params: describe_parameters.DescribeParametersInput) paginator.DescribeParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedNodesPaginator(self: *Self, params: describe_reserved_nodes.DescribeReservedNodesInput) paginator.DescribeReservedNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedNodesOfferingsPaginator(self: *Self, params: describe_reserved_nodes_offerings.DescribeReservedNodesOfferingsInput) paginator.DescribeReservedNodesOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeServiceUpdatesPaginator(self: *Self, params: describe_service_updates.DescribeServiceUpdatesInput) paginator.DescribeServiceUpdatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotsPaginator(self: *Self, params: describe_snapshots.DescribeSnapshotsInput) paginator.DescribeSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSubnetGroupsPaginator(self: *Self, params: describe_subnet_groups.DescribeSubnetGroupsInput) paginator.DescribeSubnetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUsersPaginator(self: *Self, params: describe_users.DescribeUsersInput) paginator.DescribeUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
