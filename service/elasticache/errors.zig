const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        api_call_rate_for_customer_exceeded_fault: APICallRateForCustomerExceededFault,
        authorization_already_exists_fault: AuthorizationAlreadyExistsFault,
        authorization_not_found_fault: AuthorizationNotFoundFault,
        cache_cluster_already_exists_fault: CacheClusterAlreadyExistsFault,
        cache_cluster_not_found_fault: CacheClusterNotFoundFault,
        cache_parameter_group_already_exists_fault: CacheParameterGroupAlreadyExistsFault,
        cache_parameter_group_not_found_fault: CacheParameterGroupNotFoundFault,
        cache_parameter_group_quota_exceeded_fault: CacheParameterGroupQuotaExceededFault,
        cache_security_group_already_exists_fault: CacheSecurityGroupAlreadyExistsFault,
        cache_security_group_not_found_fault: CacheSecurityGroupNotFoundFault,
        cache_security_group_quota_exceeded_fault: CacheSecurityGroupQuotaExceededFault,
        cache_subnet_group_already_exists_fault: CacheSubnetGroupAlreadyExistsFault,
        cache_subnet_group_in_use: CacheSubnetGroupInUse,
        cache_subnet_group_not_found_fault: CacheSubnetGroupNotFoundFault,
        cache_subnet_group_quota_exceeded_fault: CacheSubnetGroupQuotaExceededFault,
        cache_subnet_quota_exceeded_fault: CacheSubnetQuotaExceededFault,
        cluster_quota_for_customer_exceeded_fault: ClusterQuotaForCustomerExceededFault,
        default_user_associated_to_user_group_fault: DefaultUserAssociatedToUserGroupFault,
        default_user_required: DefaultUserRequired,
        duplicate_user_name_fault: DuplicateUserNameFault,
        global_replication_group_already_exists_fault: GlobalReplicationGroupAlreadyExistsFault,
        global_replication_group_not_found_fault: GlobalReplicationGroupNotFoundFault,
        insufficient_cache_cluster_capacity_fault: InsufficientCacheClusterCapacityFault,
        invalid_arn_fault: InvalidARNFault,
        invalid_cache_cluster_state_fault: InvalidCacheClusterStateFault,
        invalid_cache_parameter_group_state_fault: InvalidCacheParameterGroupStateFault,
        invalid_cache_security_group_state_fault: InvalidCacheSecurityGroupStateFault,
        invalid_credentials_exception: InvalidCredentialsException,
        invalid_global_replication_group_state_fault: InvalidGlobalReplicationGroupStateFault,
        invalid_kms_key_fault: InvalidKMSKeyFault,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_replication_group_state_fault: InvalidReplicationGroupStateFault,
        invalid_serverless_cache_snapshot_state_fault: InvalidServerlessCacheSnapshotStateFault,
        invalid_serverless_cache_state_fault: InvalidServerlessCacheStateFault,
        invalid_snapshot_state_fault: InvalidSnapshotStateFault,
        invalid_subnet: InvalidSubnet,
        invalid_user_group_state_fault: InvalidUserGroupStateFault,
        invalid_user_state_fault: InvalidUserStateFault,
        invalid_vpc_network_state_fault: InvalidVPCNetworkStateFault,
        no_operation_fault: NoOperationFault,
        node_group_not_found_fault: NodeGroupNotFoundFault,
        node_groups_per_replication_group_quota_exceeded_fault: NodeGroupsPerReplicationGroupQuotaExceededFault,
        node_quota_for_cluster_exceeded_fault: NodeQuotaForClusterExceededFault,
        node_quota_for_customer_exceeded_fault: NodeQuotaForCustomerExceededFault,
        replication_group_already_exists_fault: ReplicationGroupAlreadyExistsFault,
        replication_group_already_under_migration_fault: ReplicationGroupAlreadyUnderMigrationFault,
        replication_group_not_found_fault: ReplicationGroupNotFoundFault,
        replication_group_not_under_migration_fault: ReplicationGroupNotUnderMigrationFault,
        reserved_cache_node_already_exists_fault: ReservedCacheNodeAlreadyExistsFault,
        reserved_cache_node_not_found_fault: ReservedCacheNodeNotFoundFault,
        reserved_cache_node_quota_exceeded_fault: ReservedCacheNodeQuotaExceededFault,
        reserved_cache_nodes_offering_not_found_fault: ReservedCacheNodesOfferingNotFoundFault,
        serverless_cache_already_exists_fault: ServerlessCacheAlreadyExistsFault,
        serverless_cache_not_found_fault: ServerlessCacheNotFoundFault,
        serverless_cache_quota_for_customer_exceeded_fault: ServerlessCacheQuotaForCustomerExceededFault,
        serverless_cache_snapshot_already_exists_fault: ServerlessCacheSnapshotAlreadyExistsFault,
        serverless_cache_snapshot_not_found_fault: ServerlessCacheSnapshotNotFoundFault,
        serverless_cache_snapshot_quota_exceeded_fault: ServerlessCacheSnapshotQuotaExceededFault,
        service_linked_role_not_found_fault: ServiceLinkedRoleNotFoundFault,
        service_update_not_found_fault: ServiceUpdateNotFoundFault,
        snapshot_already_exists_fault: SnapshotAlreadyExistsFault,
        snapshot_feature_not_supported_fault: SnapshotFeatureNotSupportedFault,
        snapshot_not_found_fault: SnapshotNotFoundFault,
        snapshot_quota_exceeded_fault: SnapshotQuotaExceededFault,
        subnet_in_use: SubnetInUse,
        subnet_not_allowed_fault: SubnetNotAllowedFault,
        tag_not_found_fault: TagNotFoundFault,
        tag_quota_per_resource_exceeded: TagQuotaPerResourceExceeded,
        test_failover_not_available_fault: TestFailoverNotAvailableFault,
        user_already_exists_fault: UserAlreadyExistsFault,
        user_group_already_exists_fault: UserGroupAlreadyExistsFault,
        user_group_not_found_fault: UserGroupNotFoundFault,
        user_group_quota_exceeded_fault: UserGroupQuotaExceededFault,
        user_not_found_fault: UserNotFoundFault,
        user_quota_exceeded_fault: UserQuotaExceededFault,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .api_call_rate_for_customer_exceeded_fault => "APICallRateForCustomerExceededFault",
                .authorization_already_exists_fault => "AuthorizationAlreadyExistsFault",
                .authorization_not_found_fault => "AuthorizationNotFoundFault",
                .cache_cluster_already_exists_fault => "CacheClusterAlreadyExistsFault",
                .cache_cluster_not_found_fault => "CacheClusterNotFoundFault",
                .cache_parameter_group_already_exists_fault => "CacheParameterGroupAlreadyExistsFault",
                .cache_parameter_group_not_found_fault => "CacheParameterGroupNotFoundFault",
                .cache_parameter_group_quota_exceeded_fault => "CacheParameterGroupQuotaExceededFault",
                .cache_security_group_already_exists_fault => "CacheSecurityGroupAlreadyExistsFault",
                .cache_security_group_not_found_fault => "CacheSecurityGroupNotFoundFault",
                .cache_security_group_quota_exceeded_fault => "CacheSecurityGroupQuotaExceededFault",
                .cache_subnet_group_already_exists_fault => "CacheSubnetGroupAlreadyExistsFault",
                .cache_subnet_group_in_use => "CacheSubnetGroupInUse",
                .cache_subnet_group_not_found_fault => "CacheSubnetGroupNotFoundFault",
                .cache_subnet_group_quota_exceeded_fault => "CacheSubnetGroupQuotaExceededFault",
                .cache_subnet_quota_exceeded_fault => "CacheSubnetQuotaExceededFault",
                .cluster_quota_for_customer_exceeded_fault => "ClusterQuotaForCustomerExceededFault",
                .default_user_associated_to_user_group_fault => "DefaultUserAssociatedToUserGroupFault",
                .default_user_required => "DefaultUserRequired",
                .duplicate_user_name_fault => "DuplicateUserNameFault",
                .global_replication_group_already_exists_fault => "GlobalReplicationGroupAlreadyExistsFault",
                .global_replication_group_not_found_fault => "GlobalReplicationGroupNotFoundFault",
                .insufficient_cache_cluster_capacity_fault => "InsufficientCacheClusterCapacityFault",
                .invalid_arn_fault => "InvalidARNFault",
                .invalid_cache_cluster_state_fault => "InvalidCacheClusterStateFault",
                .invalid_cache_parameter_group_state_fault => "InvalidCacheParameterGroupStateFault",
                .invalid_cache_security_group_state_fault => "InvalidCacheSecurityGroupStateFault",
                .invalid_credentials_exception => "InvalidCredentialsException",
                .invalid_global_replication_group_state_fault => "InvalidGlobalReplicationGroupStateFault",
                .invalid_kms_key_fault => "InvalidKMSKeyFault",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_replication_group_state_fault => "InvalidReplicationGroupStateFault",
                .invalid_serverless_cache_snapshot_state_fault => "InvalidServerlessCacheSnapshotStateFault",
                .invalid_serverless_cache_state_fault => "InvalidServerlessCacheStateFault",
                .invalid_snapshot_state_fault => "InvalidSnapshotStateFault",
                .invalid_subnet => "InvalidSubnet",
                .invalid_user_group_state_fault => "InvalidUserGroupStateFault",
                .invalid_user_state_fault => "InvalidUserStateFault",
                .invalid_vpc_network_state_fault => "InvalidVPCNetworkStateFault",
                .no_operation_fault => "NoOperationFault",
                .node_group_not_found_fault => "NodeGroupNotFoundFault",
                .node_groups_per_replication_group_quota_exceeded_fault => "NodeGroupsPerReplicationGroupQuotaExceededFault",
                .node_quota_for_cluster_exceeded_fault => "NodeQuotaForClusterExceededFault",
                .node_quota_for_customer_exceeded_fault => "NodeQuotaForCustomerExceededFault",
                .replication_group_already_exists_fault => "ReplicationGroupAlreadyExistsFault",
                .replication_group_already_under_migration_fault => "ReplicationGroupAlreadyUnderMigrationFault",
                .replication_group_not_found_fault => "ReplicationGroupNotFoundFault",
                .replication_group_not_under_migration_fault => "ReplicationGroupNotUnderMigrationFault",
                .reserved_cache_node_already_exists_fault => "ReservedCacheNodeAlreadyExistsFault",
                .reserved_cache_node_not_found_fault => "ReservedCacheNodeNotFoundFault",
                .reserved_cache_node_quota_exceeded_fault => "ReservedCacheNodeQuotaExceededFault",
                .reserved_cache_nodes_offering_not_found_fault => "ReservedCacheNodesOfferingNotFoundFault",
                .serverless_cache_already_exists_fault => "ServerlessCacheAlreadyExistsFault",
                .serverless_cache_not_found_fault => "ServerlessCacheNotFoundFault",
                .serverless_cache_quota_for_customer_exceeded_fault => "ServerlessCacheQuotaForCustomerExceededFault",
                .serverless_cache_snapshot_already_exists_fault => "ServerlessCacheSnapshotAlreadyExistsFault",
                .serverless_cache_snapshot_not_found_fault => "ServerlessCacheSnapshotNotFoundFault",
                .serverless_cache_snapshot_quota_exceeded_fault => "ServerlessCacheSnapshotQuotaExceededFault",
                .service_linked_role_not_found_fault => "ServiceLinkedRoleNotFoundFault",
                .service_update_not_found_fault => "ServiceUpdateNotFoundFault",
                .snapshot_already_exists_fault => "SnapshotAlreadyExistsFault",
                .snapshot_feature_not_supported_fault => "SnapshotFeatureNotSupportedFault",
                .snapshot_not_found_fault => "SnapshotNotFoundFault",
                .snapshot_quota_exceeded_fault => "SnapshotQuotaExceededFault",
                .subnet_in_use => "SubnetInUse",
                .subnet_not_allowed_fault => "SubnetNotAllowedFault",
                .tag_not_found_fault => "TagNotFoundFault",
                .tag_quota_per_resource_exceeded => "TagQuotaPerResourceExceeded",
                .test_failover_not_available_fault => "TestFailoverNotAvailableFault",
                .user_already_exists_fault => "UserAlreadyExistsFault",
                .user_group_already_exists_fault => "UserGroupAlreadyExistsFault",
                .user_group_not_found_fault => "UserGroupNotFoundFault",
                .user_group_quota_exceeded_fault => "UserGroupQuotaExceededFault",
                .user_not_found_fault => "UserNotFoundFault",
                .user_quota_exceeded_fault => "UserQuotaExceededFault",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .api_call_rate_for_customer_exceeded_fault => |e| e.message,
                .authorization_already_exists_fault => |e| e.message,
                .authorization_not_found_fault => |e| e.message,
                .cache_cluster_already_exists_fault => |e| e.message,
                .cache_cluster_not_found_fault => |e| e.message,
                .cache_parameter_group_already_exists_fault => |e| e.message,
                .cache_parameter_group_not_found_fault => |e| e.message,
                .cache_parameter_group_quota_exceeded_fault => |e| e.message,
                .cache_security_group_already_exists_fault => |e| e.message,
                .cache_security_group_not_found_fault => |e| e.message,
                .cache_security_group_quota_exceeded_fault => |e| e.message,
                .cache_subnet_group_already_exists_fault => |e| e.message,
                .cache_subnet_group_in_use => |e| e.message,
                .cache_subnet_group_not_found_fault => |e| e.message,
                .cache_subnet_group_quota_exceeded_fault => |e| e.message,
                .cache_subnet_quota_exceeded_fault => |e| e.message,
                .cluster_quota_for_customer_exceeded_fault => |e| e.message,
                .default_user_associated_to_user_group_fault => |e| e.message,
                .default_user_required => |e| e.message,
                .duplicate_user_name_fault => |e| e.message,
                .global_replication_group_already_exists_fault => |e| e.message,
                .global_replication_group_not_found_fault => |e| e.message,
                .insufficient_cache_cluster_capacity_fault => |e| e.message,
                .invalid_arn_fault => |e| e.message,
                .invalid_cache_cluster_state_fault => |e| e.message,
                .invalid_cache_parameter_group_state_fault => |e| e.message,
                .invalid_cache_security_group_state_fault => |e| e.message,
                .invalid_credentials_exception => |e| e.message,
                .invalid_global_replication_group_state_fault => |e| e.message,
                .invalid_kms_key_fault => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_replication_group_state_fault => |e| e.message,
                .invalid_serverless_cache_snapshot_state_fault => |e| e.message,
                .invalid_serverless_cache_state_fault => |e| e.message,
                .invalid_snapshot_state_fault => |e| e.message,
                .invalid_subnet => |e| e.message,
                .invalid_user_group_state_fault => |e| e.message,
                .invalid_user_state_fault => |e| e.message,
                .invalid_vpc_network_state_fault => |e| e.message,
                .no_operation_fault => |e| e.message,
                .node_group_not_found_fault => |e| e.message,
                .node_groups_per_replication_group_quota_exceeded_fault => |e| e.message,
                .node_quota_for_cluster_exceeded_fault => |e| e.message,
                .node_quota_for_customer_exceeded_fault => |e| e.message,
                .replication_group_already_exists_fault => |e| e.message,
                .replication_group_already_under_migration_fault => |e| e.message,
                .replication_group_not_found_fault => |e| e.message,
                .replication_group_not_under_migration_fault => |e| e.message,
                .reserved_cache_node_already_exists_fault => |e| e.message,
                .reserved_cache_node_not_found_fault => |e| e.message,
                .reserved_cache_node_quota_exceeded_fault => |e| e.message,
                .reserved_cache_nodes_offering_not_found_fault => |e| e.message,
                .serverless_cache_already_exists_fault => |e| e.message,
                .serverless_cache_not_found_fault => |e| e.message,
                .serverless_cache_quota_for_customer_exceeded_fault => |e| e.message,
                .serverless_cache_snapshot_already_exists_fault => |e| e.message,
                .serverless_cache_snapshot_not_found_fault => |e| e.message,
                .serverless_cache_snapshot_quota_exceeded_fault => |e| e.message,
                .service_linked_role_not_found_fault => |e| e.message,
                .service_update_not_found_fault => |e| e.message,
                .snapshot_already_exists_fault => |e| e.message,
                .snapshot_feature_not_supported_fault => |e| e.message,
                .snapshot_not_found_fault => |e| e.message,
                .snapshot_quota_exceeded_fault => |e| e.message,
                .subnet_in_use => |e| e.message,
                .subnet_not_allowed_fault => |e| e.message,
                .tag_not_found_fault => |e| e.message,
                .tag_quota_per_resource_exceeded => |e| e.message,
                .test_failover_not_available_fault => |e| e.message,
                .user_already_exists_fault => |e| e.message,
                .user_group_already_exists_fault => |e| e.message,
                .user_group_not_found_fault => |e| e.message,
                .user_group_quota_exceeded_fault => |e| e.message,
                .user_not_found_fault => |e| e.message,
                .user_quota_exceeded_fault => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .api_call_rate_for_customer_exceeded_fault => 400,
                .authorization_already_exists_fault => 400,
                .authorization_not_found_fault => 404,
                .cache_cluster_already_exists_fault => 400,
                .cache_cluster_not_found_fault => 404,
                .cache_parameter_group_already_exists_fault => 400,
                .cache_parameter_group_not_found_fault => 404,
                .cache_parameter_group_quota_exceeded_fault => 400,
                .cache_security_group_already_exists_fault => 400,
                .cache_security_group_not_found_fault => 404,
                .cache_security_group_quota_exceeded_fault => 400,
                .cache_subnet_group_already_exists_fault => 400,
                .cache_subnet_group_in_use => 400,
                .cache_subnet_group_not_found_fault => 400,
                .cache_subnet_group_quota_exceeded_fault => 400,
                .cache_subnet_quota_exceeded_fault => 400,
                .cluster_quota_for_customer_exceeded_fault => 400,
                .default_user_associated_to_user_group_fault => 400,
                .default_user_required => 400,
                .duplicate_user_name_fault => 400,
                .global_replication_group_already_exists_fault => 400,
                .global_replication_group_not_found_fault => 404,
                .insufficient_cache_cluster_capacity_fault => 400,
                .invalid_arn_fault => 400,
                .invalid_cache_cluster_state_fault => 400,
                .invalid_cache_parameter_group_state_fault => 400,
                .invalid_cache_security_group_state_fault => 400,
                .invalid_credentials_exception => 408,
                .invalid_global_replication_group_state_fault => 400,
                .invalid_kms_key_fault => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_replication_group_state_fault => 400,
                .invalid_serverless_cache_snapshot_state_fault => 400,
                .invalid_serverless_cache_state_fault => 400,
                .invalid_snapshot_state_fault => 400,
                .invalid_subnet => 400,
                .invalid_user_group_state_fault => 400,
                .invalid_user_state_fault => 400,
                .invalid_vpc_network_state_fault => 400,
                .no_operation_fault => 400,
                .node_group_not_found_fault => 404,
                .node_groups_per_replication_group_quota_exceeded_fault => 400,
                .node_quota_for_cluster_exceeded_fault => 400,
                .node_quota_for_customer_exceeded_fault => 400,
                .replication_group_already_exists_fault => 400,
                .replication_group_already_under_migration_fault => 400,
                .replication_group_not_found_fault => 404,
                .replication_group_not_under_migration_fault => 400,
                .reserved_cache_node_already_exists_fault => 404,
                .reserved_cache_node_not_found_fault => 404,
                .reserved_cache_node_quota_exceeded_fault => 400,
                .reserved_cache_nodes_offering_not_found_fault => 404,
                .serverless_cache_already_exists_fault => 400,
                .serverless_cache_not_found_fault => 404,
                .serverless_cache_quota_for_customer_exceeded_fault => 400,
                .serverless_cache_snapshot_already_exists_fault => 400,
                .serverless_cache_snapshot_not_found_fault => 404,
                .serverless_cache_snapshot_quota_exceeded_fault => 400,
                .service_linked_role_not_found_fault => 400,
                .service_update_not_found_fault => 404,
                .snapshot_already_exists_fault => 400,
                .snapshot_feature_not_supported_fault => 400,
                .snapshot_not_found_fault => 404,
                .snapshot_quota_exceeded_fault => 400,
                .subnet_in_use => 400,
                .subnet_not_allowed_fault => 400,
                .tag_not_found_fault => 404,
                .tag_quota_per_resource_exceeded => 400,
                .test_failover_not_available_fault => 400,
                .user_already_exists_fault => 400,
                .user_group_already_exists_fault => 400,
                .user_group_not_found_fault => 404,
                .user_group_quota_exceeded_fault => 400,
                .user_not_found_fault => 404,
                .user_quota_exceeded_fault => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .api_call_rate_for_customer_exceeded_fault => |e| e.request_id,
                .authorization_already_exists_fault => |e| e.request_id,
                .authorization_not_found_fault => |e| e.request_id,
                .cache_cluster_already_exists_fault => |e| e.request_id,
                .cache_cluster_not_found_fault => |e| e.request_id,
                .cache_parameter_group_already_exists_fault => |e| e.request_id,
                .cache_parameter_group_not_found_fault => |e| e.request_id,
                .cache_parameter_group_quota_exceeded_fault => |e| e.request_id,
                .cache_security_group_already_exists_fault => |e| e.request_id,
                .cache_security_group_not_found_fault => |e| e.request_id,
                .cache_security_group_quota_exceeded_fault => |e| e.request_id,
                .cache_subnet_group_already_exists_fault => |e| e.request_id,
                .cache_subnet_group_in_use => |e| e.request_id,
                .cache_subnet_group_not_found_fault => |e| e.request_id,
                .cache_subnet_group_quota_exceeded_fault => |e| e.request_id,
                .cache_subnet_quota_exceeded_fault => |e| e.request_id,
                .cluster_quota_for_customer_exceeded_fault => |e| e.request_id,
                .default_user_associated_to_user_group_fault => |e| e.request_id,
                .default_user_required => |e| e.request_id,
                .duplicate_user_name_fault => |e| e.request_id,
                .global_replication_group_already_exists_fault => |e| e.request_id,
                .global_replication_group_not_found_fault => |e| e.request_id,
                .insufficient_cache_cluster_capacity_fault => |e| e.request_id,
                .invalid_arn_fault => |e| e.request_id,
                .invalid_cache_cluster_state_fault => |e| e.request_id,
                .invalid_cache_parameter_group_state_fault => |e| e.request_id,
                .invalid_cache_security_group_state_fault => |e| e.request_id,
                .invalid_credentials_exception => |e| e.request_id,
                .invalid_global_replication_group_state_fault => |e| e.request_id,
                .invalid_kms_key_fault => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_replication_group_state_fault => |e| e.request_id,
                .invalid_serverless_cache_snapshot_state_fault => |e| e.request_id,
                .invalid_serverless_cache_state_fault => |e| e.request_id,
                .invalid_snapshot_state_fault => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .invalid_user_group_state_fault => |e| e.request_id,
                .invalid_user_state_fault => |e| e.request_id,
                .invalid_vpc_network_state_fault => |e| e.request_id,
                .no_operation_fault => |e| e.request_id,
                .node_group_not_found_fault => |e| e.request_id,
                .node_groups_per_replication_group_quota_exceeded_fault => |e| e.request_id,
                .node_quota_for_cluster_exceeded_fault => |e| e.request_id,
                .node_quota_for_customer_exceeded_fault => |e| e.request_id,
                .replication_group_already_exists_fault => |e| e.request_id,
                .replication_group_already_under_migration_fault => |e| e.request_id,
                .replication_group_not_found_fault => |e| e.request_id,
                .replication_group_not_under_migration_fault => |e| e.request_id,
                .reserved_cache_node_already_exists_fault => |e| e.request_id,
                .reserved_cache_node_not_found_fault => |e| e.request_id,
                .reserved_cache_node_quota_exceeded_fault => |e| e.request_id,
                .reserved_cache_nodes_offering_not_found_fault => |e| e.request_id,
                .serverless_cache_already_exists_fault => |e| e.request_id,
                .serverless_cache_not_found_fault => |e| e.request_id,
                .serverless_cache_quota_for_customer_exceeded_fault => |e| e.request_id,
                .serverless_cache_snapshot_already_exists_fault => |e| e.request_id,
                .serverless_cache_snapshot_not_found_fault => |e| e.request_id,
                .serverless_cache_snapshot_quota_exceeded_fault => |e| e.request_id,
                .service_linked_role_not_found_fault => |e| e.request_id,
                .service_update_not_found_fault => |e| e.request_id,
                .snapshot_already_exists_fault => |e| e.request_id,
                .snapshot_feature_not_supported_fault => |e| e.request_id,
                .snapshot_not_found_fault => |e| e.request_id,
                .snapshot_quota_exceeded_fault => |e| e.request_id,
                .subnet_in_use => |e| e.request_id,
                .subnet_not_allowed_fault => |e| e.request_id,
                .tag_not_found_fault => |e| e.request_id,
                .tag_quota_per_resource_exceeded => |e| e.request_id,
                .test_failover_not_available_fault => |e| e.request_id,
                .user_already_exists_fault => |e| e.request_id,
                .user_group_already_exists_fault => |e| e.request_id,
                .user_group_not_found_fault => |e| e.request_id,
                .user_group_quota_exceeded_fault => |e| e.request_id,
                .user_not_found_fault => |e| e.request_id,
                .user_quota_exceeded_fault => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

pub const APICallRateForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthorizationAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthorizationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheParameterGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSecurityGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSecurityGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSecurityGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSubnetGroupInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSubnetGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CacheSubnetQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DefaultUserAssociatedToUserGroupFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DefaultUserRequired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateUserNameFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalReplicationGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalReplicationGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientCacheClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidARNFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCacheClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCacheParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCacheSecurityGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCredentialsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGlobalReplicationGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKMSKeyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidReplicationGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidServerlessCacheSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidServerlessCacheStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUserGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUserStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoOperationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NodeGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NodeGroupsPerReplicationGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NodeQuotaForClusterExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NodeQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationGroupAlreadyUnderMigrationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationGroupNotUnderMigrationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedCacheNodeAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedCacheNodeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedCacheNodeQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedCacheNodesOfferingNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerlessCacheAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerlessCacheNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerlessCacheQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerlessCacheSnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerlessCacheSnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerlessCacheSnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceLinkedRoleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUpdateNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotFeatureNotSupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetNotAllowedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagQuotaPerResourceExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TestFailoverNotAvailableFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
