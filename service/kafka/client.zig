const aws = @import("aws");
const std = @import("std");

const batch_associate_scram_secret = @import("batch_associate_scram_secret.zig");
const batch_disassociate_scram_secret = @import("batch_disassociate_scram_secret.zig");
const create_cluster = @import("create_cluster.zig");
const create_cluster_v2 = @import("create_cluster_v2.zig");
const create_configuration = @import("create_configuration.zig");
const create_replicator = @import("create_replicator.zig");
const create_vpc_connection = @import("create_vpc_connection.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_cluster_policy = @import("delete_cluster_policy.zig");
const delete_configuration = @import("delete_configuration.zig");
const delete_replicator = @import("delete_replicator.zig");
const delete_vpc_connection = @import("delete_vpc_connection.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_cluster_operation = @import("describe_cluster_operation.zig");
const describe_cluster_operation_v2 = @import("describe_cluster_operation_v2.zig");
const describe_cluster_v2 = @import("describe_cluster_v2.zig");
const describe_configuration = @import("describe_configuration.zig");
const describe_configuration_revision = @import("describe_configuration_revision.zig");
const describe_replicator = @import("describe_replicator.zig");
const describe_topic = @import("describe_topic.zig");
const describe_topic_partitions = @import("describe_topic_partitions.zig");
const describe_vpc_connection = @import("describe_vpc_connection.zig");
const get_bootstrap_brokers = @import("get_bootstrap_brokers.zig");
const get_cluster_policy = @import("get_cluster_policy.zig");
const get_compatible_kafka_versions = @import("get_compatible_kafka_versions.zig");
const list_client_vpc_connections = @import("list_client_vpc_connections.zig");
const list_cluster_operations = @import("list_cluster_operations.zig");
const list_cluster_operations_v2 = @import("list_cluster_operations_v2.zig");
const list_clusters = @import("list_clusters.zig");
const list_clusters_v2 = @import("list_clusters_v2.zig");
const list_configuration_revisions = @import("list_configuration_revisions.zig");
const list_configurations = @import("list_configurations.zig");
const list_kafka_versions = @import("list_kafka_versions.zig");
const list_nodes = @import("list_nodes.zig");
const list_replicators = @import("list_replicators.zig");
const list_scram_secrets = @import("list_scram_secrets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_topics = @import("list_topics.zig");
const list_vpc_connections = @import("list_vpc_connections.zig");
const put_cluster_policy = @import("put_cluster_policy.zig");
const reboot_broker = @import("reboot_broker.zig");
const reject_client_vpc_connection = @import("reject_client_vpc_connection.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_broker_count = @import("update_broker_count.zig");
const update_broker_storage = @import("update_broker_storage.zig");
const update_broker_type = @import("update_broker_type.zig");
const update_cluster_configuration = @import("update_cluster_configuration.zig");
const update_cluster_kafka_version = @import("update_cluster_kafka_version.zig");
const update_configuration = @import("update_configuration.zig");
const update_connectivity = @import("update_connectivity.zig");
const update_monitoring = @import("update_monitoring.zig");
const update_rebalancing = @import("update_rebalancing.zig");
const update_replication_info = @import("update_replication_info.zig");
const update_security = @import("update_security.zig");
const update_storage = @import("update_storage.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Kafka";

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

    /// Associates one or more Scram Secrets with an Amazon MSK cluster.
    pub fn batchAssociateScramSecret(self: *Self, allocator: std.mem.Allocator, input: batch_associate_scram_secret.BatchAssociateScramSecretInput, options: batch_associate_scram_secret.Options) !batch_associate_scram_secret.BatchAssociateScramSecretOutput {
        return batch_associate_scram_secret.execute(self, allocator, input, options);
    }

    /// Disassociates one or more Scram Secrets from an Amazon MSK cluster.
    pub fn batchDisassociateScramSecret(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_scram_secret.BatchDisassociateScramSecretInput, options: batch_disassociate_scram_secret.Options) !batch_disassociate_scram_secret.BatchDisassociateScramSecretOutput {
        return batch_disassociate_scram_secret.execute(self, allocator, input, options);
    }

    /// Creates a new MSK cluster.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new MSK cluster.
    pub fn createClusterV2(self: *Self, allocator: std.mem.Allocator, input: create_cluster_v2.CreateClusterV2Input, options: create_cluster_v2.Options) !create_cluster_v2.CreateClusterV2Output {
        return create_cluster_v2.execute(self, allocator, input, options);
    }

    /// Creates a new MSK configuration.
    pub fn createConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_configuration.CreateConfigurationInput, options: create_configuration.Options) !create_configuration.CreateConfigurationOutput {
        return create_configuration.execute(self, allocator, input, options);
    }

    /// Creates the replicator.
    pub fn createReplicator(self: *Self, allocator: std.mem.Allocator, input: create_replicator.CreateReplicatorInput, options: create_replicator.Options) !create_replicator.CreateReplicatorOutput {
        return create_replicator.execute(self, allocator, input, options);
    }

    /// Creates a new MSK VPC connection.
    pub fn createVpcConnection(self: *Self, allocator: std.mem.Allocator, input: create_vpc_connection.CreateVpcConnectionInput, options: create_vpc_connection.Options) !create_vpc_connection.CreateVpcConnectionOutput {
        return create_vpc_connection.execute(self, allocator, input, options);
    }

    /// Deletes the MSK cluster specified by the Amazon Resource Name (ARN) in the
    /// request.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the MSK cluster policy specified by the Amazon Resource Name (ARN)
    /// in the request.
    pub fn deleteClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_cluster_policy.DeleteClusterPolicyInput, options: delete_cluster_policy.Options) !delete_cluster_policy.DeleteClusterPolicyOutput {
        return delete_cluster_policy.execute(self, allocator, input, options);
    }

    /// Deletes an MSK Configuration.
    pub fn deleteConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_configuration.DeleteConfigurationInput, options: delete_configuration.Options) !delete_configuration.DeleteConfigurationOutput {
        return delete_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a replicator.
    pub fn deleteReplicator(self: *Self, allocator: std.mem.Allocator, input: delete_replicator.DeleteReplicatorInput, options: delete_replicator.Options) !delete_replicator.DeleteReplicatorOutput {
        return delete_replicator.execute(self, allocator, input, options);
    }

    /// Deletes a MSK VPC connection.
    pub fn deleteVpcConnection(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_connection.DeleteVpcConnectionInput, options: delete_vpc_connection.Options) !delete_vpc_connection.DeleteVpcConnectionOutput {
        return delete_vpc_connection.execute(self, allocator, input, options);
    }

    /// Returns a description of the MSK cluster whose Amazon Resource Name (ARN) is
    /// specified in the request.
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// Returns a description of the cluster operation specified by the ARN.
    pub fn describeClusterOperation(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_operation.DescribeClusterOperationInput, options: describe_cluster_operation.Options) !describe_cluster_operation.DescribeClusterOperationOutput {
        return describe_cluster_operation.execute(self, allocator, input, options);
    }

    /// Returns a description of the cluster operation specified by the ARN.
    pub fn describeClusterOperationV2(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_operation_v2.DescribeClusterOperationV2Input, options: describe_cluster_operation_v2.Options) !describe_cluster_operation_v2.DescribeClusterOperationV2Output {
        return describe_cluster_operation_v2.execute(self, allocator, input, options);
    }

    /// Returns a description of the MSK cluster whose Amazon Resource Name (ARN) is
    /// specified in the request.
    pub fn describeClusterV2(self: *Self, allocator: std.mem.Allocator, input: describe_cluster_v2.DescribeClusterV2Input, options: describe_cluster_v2.Options) !describe_cluster_v2.DescribeClusterV2Output {
        return describe_cluster_v2.execute(self, allocator, input, options);
    }

    /// Returns a description of this MSK configuration.
    pub fn describeConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_configuration.DescribeConfigurationInput, options: describe_configuration.Options) !describe_configuration.DescribeConfigurationOutput {
        return describe_configuration.execute(self, allocator, input, options);
    }

    /// Returns a description of this revision of the configuration.
    pub fn describeConfigurationRevision(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_revision.DescribeConfigurationRevisionInput, options: describe_configuration_revision.Options) !describe_configuration_revision.DescribeConfigurationRevisionOutput {
        return describe_configuration_revision.execute(self, allocator, input, options);
    }

    /// Describes a replicator.
    pub fn describeReplicator(self: *Self, allocator: std.mem.Allocator, input: describe_replicator.DescribeReplicatorInput, options: describe_replicator.Options) !describe_replicator.DescribeReplicatorOutput {
        return describe_replicator.execute(self, allocator, input, options);
    }

    /// Returns topic details of this topic on a MSK cluster.
    pub fn describeTopic(self: *Self, allocator: std.mem.Allocator, input: describe_topic.DescribeTopicInput, options: describe_topic.Options) !describe_topic.DescribeTopicOutput {
        return describe_topic.execute(self, allocator, input, options);
    }

    /// Returns partition details of this topic on a MSK cluster.
    pub fn describeTopicPartitions(self: *Self, allocator: std.mem.Allocator, input: describe_topic_partitions.DescribeTopicPartitionsInput, options: describe_topic_partitions.Options) !describe_topic_partitions.DescribeTopicPartitionsOutput {
        return describe_topic_partitions.execute(self, allocator, input, options);
    }

    /// Returns a description of this MSK VPC connection.
    pub fn describeVpcConnection(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_connection.DescribeVpcConnectionInput, options: describe_vpc_connection.Options) !describe_vpc_connection.DescribeVpcConnectionOutput {
        return describe_vpc_connection.execute(self, allocator, input, options);
    }

    /// A list of brokers that a client application can use to bootstrap. This list
    /// doesn't necessarily include all of the brokers in the cluster. The following
    /// Python 3.6 example shows how you can use the Amazon Resource Name (ARN) of a
    /// cluster to get its bootstrap brokers. If you don't know the ARN of your
    /// cluster, you can use the `ListClusters` operation to get the ARNs of all the
    /// clusters in this account and Region.
    pub fn getBootstrapBrokers(self: *Self, allocator: std.mem.Allocator, input: get_bootstrap_brokers.GetBootstrapBrokersInput, options: get_bootstrap_brokers.Options) !get_bootstrap_brokers.GetBootstrapBrokersOutput {
        return get_bootstrap_brokers.execute(self, allocator, input, options);
    }

    /// Get the MSK cluster policy specified by the Amazon Resource Name (ARN) in
    /// the request.
    pub fn getClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: get_cluster_policy.GetClusterPolicyInput, options: get_cluster_policy.Options) !get_cluster_policy.GetClusterPolicyOutput {
        return get_cluster_policy.execute(self, allocator, input, options);
    }

    /// Gets the Apache Kafka versions to which you can update the MSK cluster.
    pub fn getCompatibleKafkaVersions(self: *Self, allocator: std.mem.Allocator, input: get_compatible_kafka_versions.GetCompatibleKafkaVersionsInput, options: get_compatible_kafka_versions.Options) !get_compatible_kafka_versions.GetCompatibleKafkaVersionsOutput {
        return get_compatible_kafka_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of all the VPC connections in this Region.
    pub fn listClientVpcConnections(self: *Self, allocator: std.mem.Allocator, input: list_client_vpc_connections.ListClientVpcConnectionsInput, options: list_client_vpc_connections.Options) !list_client_vpc_connections.ListClientVpcConnectionsOutput {
        return list_client_vpc_connections.execute(self, allocator, input, options);
    }

    /// Returns a list of all the operations that have been performed on the
    /// specified MSK cluster.
    pub fn listClusterOperations(self: *Self, allocator: std.mem.Allocator, input: list_cluster_operations.ListClusterOperationsInput, options: list_cluster_operations.Options) !list_cluster_operations.ListClusterOperationsOutput {
        return list_cluster_operations.execute(self, allocator, input, options);
    }

    /// Returns a list of all the operations that have been performed on the
    /// specified MSK cluster.
    pub fn listClusterOperationsV2(self: *Self, allocator: std.mem.Allocator, input: list_cluster_operations_v2.ListClusterOperationsV2Input, options: list_cluster_operations_v2.Options) !list_cluster_operations_v2.ListClusterOperationsV2Output {
        return list_cluster_operations_v2.execute(self, allocator, input, options);
    }

    /// Returns a list of all the MSK clusters in the current Region.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of all the MSK clusters in the current Region.
    pub fn listClustersV2(self: *Self, allocator: std.mem.Allocator, input: list_clusters_v2.ListClustersV2Input, options: list_clusters_v2.Options) !list_clusters_v2.ListClustersV2Output {
        return list_clusters_v2.execute(self, allocator, input, options);
    }

    /// Returns a list of all the MSK configurations in this Region.
    pub fn listConfigurationRevisions(self: *Self, allocator: std.mem.Allocator, input: list_configuration_revisions.ListConfigurationRevisionsInput, options: list_configuration_revisions.Options) !list_configuration_revisions.ListConfigurationRevisionsOutput {
        return list_configuration_revisions.execute(self, allocator, input, options);
    }

    /// Returns a list of all the MSK configurations in this Region.
    pub fn listConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_configurations.ListConfigurationsInput, options: list_configurations.Options) !list_configurations.ListConfigurationsOutput {
        return list_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of Apache Kafka versions.
    pub fn listKafkaVersions(self: *Self, allocator: std.mem.Allocator, input: list_kafka_versions.ListKafkaVersionsInput, options: list_kafka_versions.Options) !list_kafka_versions.ListKafkaVersionsOutput {
        return list_kafka_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of the broker nodes in the cluster.
    pub fn listNodes(self: *Self, allocator: std.mem.Allocator, input: list_nodes.ListNodesInput, options: list_nodes.Options) !list_nodes.ListNodesOutput {
        return list_nodes.execute(self, allocator, input, options);
    }

    /// Lists the replicators.
    pub fn listReplicators(self: *Self, allocator: std.mem.Allocator, input: list_replicators.ListReplicatorsInput, options: list_replicators.Options) !list_replicators.ListReplicatorsOutput {
        return list_replicators.execute(self, allocator, input, options);
    }

    /// Returns a list of the Scram Secrets associated with an Amazon MSK cluster.
    pub fn listScramSecrets(self: *Self, allocator: std.mem.Allocator, input: list_scram_secrets.ListScramSecretsInput, options: list_scram_secrets.Options) !list_scram_secrets.ListScramSecretsOutput {
        return list_scram_secrets.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags associated with the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List topics in a MSK cluster.
    pub fn listTopics(self: *Self, allocator: std.mem.Allocator, input: list_topics.ListTopicsInput, options: list_topics.Options) !list_topics.ListTopicsOutput {
        return list_topics.execute(self, allocator, input, options);
    }

    /// Returns a list of all the VPC connections in this Region.
    pub fn listVpcConnections(self: *Self, allocator: std.mem.Allocator, input: list_vpc_connections.ListVpcConnectionsInput, options: list_vpc_connections.Options) !list_vpc_connections.ListVpcConnectionsOutput {
        return list_vpc_connections.execute(self, allocator, input, options);
    }

    /// Creates or updates the MSK cluster policy specified by the cluster Amazon
    /// Resource Name (ARN) in the request.
    pub fn putClusterPolicy(self: *Self, allocator: std.mem.Allocator, input: put_cluster_policy.PutClusterPolicyInput, options: put_cluster_policy.Options) !put_cluster_policy.PutClusterPolicyOutput {
        return put_cluster_policy.execute(self, allocator, input, options);
    }

    /// Reboots brokers.
    pub fn rebootBroker(self: *Self, allocator: std.mem.Allocator, input: reboot_broker.RebootBrokerInput, options: reboot_broker.Options) !reboot_broker.RebootBrokerOutput {
        return reboot_broker.execute(self, allocator, input, options);
    }

    /// Returns empty response.
    pub fn rejectClientVpcConnection(self: *Self, allocator: std.mem.Allocator, input: reject_client_vpc_connection.RejectClientVpcConnectionInput, options: reject_client_vpc_connection.Options) !reject_client_vpc_connection.RejectClientVpcConnectionOutput {
        return reject_client_vpc_connection.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified MSK resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the tags associated with the keys that are provided in the query.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the number of broker nodes in the cluster.
    pub fn updateBrokerCount(self: *Self, allocator: std.mem.Allocator, input: update_broker_count.UpdateBrokerCountInput, options: update_broker_count.Options) !update_broker_count.UpdateBrokerCountOutput {
        return update_broker_count.execute(self, allocator, input, options);
    }

    /// Updates the EBS storage associated with MSK brokers.
    pub fn updateBrokerStorage(self: *Self, allocator: std.mem.Allocator, input: update_broker_storage.UpdateBrokerStorageInput, options: update_broker_storage.Options) !update_broker_storage.UpdateBrokerStorageOutput {
        return update_broker_storage.execute(self, allocator, input, options);
    }

    /// Updates EC2 instance type.
    pub fn updateBrokerType(self: *Self, allocator: std.mem.Allocator, input: update_broker_type.UpdateBrokerTypeInput, options: update_broker_type.Options) !update_broker_type.UpdateBrokerTypeOutput {
        return update_broker_type.execute(self, allocator, input, options);
    }

    /// Updates the cluster with the configuration that is specified in the request
    /// body.
    pub fn updateClusterConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_cluster_configuration.UpdateClusterConfigurationInput, options: update_cluster_configuration.Options) !update_cluster_configuration.UpdateClusterConfigurationOutput {
        return update_cluster_configuration.execute(self, allocator, input, options);
    }

    /// Updates the Apache Kafka version for the cluster.
    pub fn updateClusterKafkaVersion(self: *Self, allocator: std.mem.Allocator, input: update_cluster_kafka_version.UpdateClusterKafkaVersionInput, options: update_cluster_kafka_version.Options) !update_cluster_kafka_version.UpdateClusterKafkaVersionOutput {
        return update_cluster_kafka_version.execute(self, allocator, input, options);
    }

    /// Updates an MSK configuration.
    pub fn updateConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_configuration.UpdateConfigurationInput, options: update_configuration.Options) !update_configuration.UpdateConfigurationOutput {
        return update_configuration.execute(self, allocator, input, options);
    }

    /// Updates the cluster's connectivity configuration.
    pub fn updateConnectivity(self: *Self, allocator: std.mem.Allocator, input: update_connectivity.UpdateConnectivityInput, options: update_connectivity.Options) !update_connectivity.UpdateConnectivityOutput {
        return update_connectivity.execute(self, allocator, input, options);
    }

    /// Updates the monitoring settings for the cluster. You can use this operation
    /// to specify which Apache Kafka metrics you want Amazon MSK to send to Amazon
    /// CloudWatch. You can also specify settings for open monitoring with
    /// Prometheus.
    pub fn updateMonitoring(self: *Self, allocator: std.mem.Allocator, input: update_monitoring.UpdateMonitoringInput, options: update_monitoring.Options) !update_monitoring.UpdateMonitoringOutput {
        return update_monitoring.execute(self, allocator, input, options);
    }

    /// Use this resource to update the intelligent rebalancing status of an Amazon
    /// MSK Provisioned cluster with Express brokers.
    pub fn updateRebalancing(self: *Self, allocator: std.mem.Allocator, input: update_rebalancing.UpdateRebalancingInput, options: update_rebalancing.Options) !update_rebalancing.UpdateRebalancingOutput {
        return update_rebalancing.execute(self, allocator, input, options);
    }

    /// Updates replication info of a replicator.
    pub fn updateReplicationInfo(self: *Self, allocator: std.mem.Allocator, input: update_replication_info.UpdateReplicationInfoInput, options: update_replication_info.Options) !update_replication_info.UpdateReplicationInfoOutput {
        return update_replication_info.execute(self, allocator, input, options);
    }

    /// Updates the security settings for the cluster. You can use this operation to
    /// specify encryption and authentication on existing clusters.
    pub fn updateSecurity(self: *Self, allocator: std.mem.Allocator, input: update_security.UpdateSecurityInput, options: update_security.Options) !update_security.UpdateSecurityOutput {
        return update_security.execute(self, allocator, input, options);
    }

    /// Updates cluster broker volume size (or) sets cluster storage mode to TIERED.
    pub fn updateStorage(self: *Self, allocator: std.mem.Allocator, input: update_storage.UpdateStorageInput, options: update_storage.Options) !update_storage.UpdateStorageOutput {
        return update_storage.execute(self, allocator, input, options);
    }

    pub fn describeTopicPartitionsPaginator(self: *Self, params: describe_topic_partitions.DescribeTopicPartitionsInput) paginator.DescribeTopicPartitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClientVpcConnectionsPaginator(self: *Self, params: list_client_vpc_connections.ListClientVpcConnectionsInput) paginator.ListClientVpcConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterOperationsPaginator(self: *Self, params: list_cluster_operations.ListClusterOperationsInput) paginator.ListClusterOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterOperationsV2Paginator(self: *Self, params: list_cluster_operations_v2.ListClusterOperationsV2Input) paginator.ListClusterOperationsV2Paginator {
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

    pub fn listClustersV2Paginator(self: *Self, params: list_clusters_v2.ListClustersV2Input) paginator.ListClustersV2Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationRevisionsPaginator(self: *Self, params: list_configuration_revisions.ListConfigurationRevisionsInput) paginator.ListConfigurationRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationsPaginator(self: *Self, params: list_configurations.ListConfigurationsInput) paginator.ListConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listKafkaVersionsPaginator(self: *Self, params: list_kafka_versions.ListKafkaVersionsInput) paginator.ListKafkaVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodesPaginator(self: *Self, params: list_nodes.ListNodesInput) paginator.ListNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReplicatorsPaginator(self: *Self, params: list_replicators.ListReplicatorsInput) paginator.ListReplicatorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScramSecretsPaginator(self: *Self, params: list_scram_secrets.ListScramSecretsInput) paginator.ListScramSecretsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTopicsPaginator(self: *Self, params: list_topics.ListTopicsInput) paginator.ListTopicsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVpcConnectionsPaginator(self: *Self, params: list_vpc_connections.ListVpcConnectionsInput) paginator.ListVpcConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
