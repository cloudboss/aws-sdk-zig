const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        acl_already_exists_fault: ACLAlreadyExistsFault,
        acl_not_found_fault: ACLNotFoundFault,
        acl_quota_exceeded_fault: ACLQuotaExceededFault,
        api_call_rate_for_customer_exceeded_fault: APICallRateForCustomerExceededFault,
        cluster_already_exists_fault: ClusterAlreadyExistsFault,
        cluster_not_found_fault: ClusterNotFoundFault,
        cluster_quota_for_customer_exceeded_fault: ClusterQuotaForCustomerExceededFault,
        default_user_required: DefaultUserRequired,
        duplicate_user_name_fault: DuplicateUserNameFault,
        insufficient_cluster_capacity_fault: InsufficientClusterCapacityFault,
        invalid_acl_state_fault: InvalidACLStateFault,
        invalid_arn_fault: InvalidARNFault,
        invalid_cluster_state_fault: InvalidClusterStateFault,
        invalid_credentials_exception: InvalidCredentialsException,
        invalid_kms_key_fault: InvalidKMSKeyFault,
        invalid_multi_region_cluster_state_fault: InvalidMultiRegionClusterStateFault,
        invalid_node_state_fault: InvalidNodeStateFault,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_group_state_fault: InvalidParameterGroupStateFault,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_snapshot_state_fault: InvalidSnapshotStateFault,
        invalid_subnet: InvalidSubnet,
        invalid_user_state_fault: InvalidUserStateFault,
        invalid_vpc_network_state_fault: InvalidVPCNetworkStateFault,
        multi_region_cluster_already_exists_fault: MultiRegionClusterAlreadyExistsFault,
        multi_region_cluster_not_found_fault: MultiRegionClusterNotFoundFault,
        multi_region_parameter_group_not_found_fault: MultiRegionParameterGroupNotFoundFault,
        no_operation_fault: NoOperationFault,
        node_quota_for_cluster_exceeded_fault: NodeQuotaForClusterExceededFault,
        node_quota_for_customer_exceeded_fault: NodeQuotaForCustomerExceededFault,
        parameter_group_already_exists_fault: ParameterGroupAlreadyExistsFault,
        parameter_group_not_found_fault: ParameterGroupNotFoundFault,
        parameter_group_quota_exceeded_fault: ParameterGroupQuotaExceededFault,
        reserved_node_already_exists_fault: ReservedNodeAlreadyExistsFault,
        reserved_node_not_found_fault: ReservedNodeNotFoundFault,
        reserved_node_quota_exceeded_fault: ReservedNodeQuotaExceededFault,
        reserved_nodes_offering_not_found_fault: ReservedNodesOfferingNotFoundFault,
        service_linked_role_not_found_fault: ServiceLinkedRoleNotFoundFault,
        service_update_not_found_fault: ServiceUpdateNotFoundFault,
        shard_not_found_fault: ShardNotFoundFault,
        shards_per_cluster_quota_exceeded_fault: ShardsPerClusterQuotaExceededFault,
        snapshot_already_exists_fault: SnapshotAlreadyExistsFault,
        snapshot_not_found_fault: SnapshotNotFoundFault,
        snapshot_quota_exceeded_fault: SnapshotQuotaExceededFault,
        subnet_group_already_exists_fault: SubnetGroupAlreadyExistsFault,
        subnet_group_in_use_fault: SubnetGroupInUseFault,
        subnet_group_not_found_fault: SubnetGroupNotFoundFault,
        subnet_group_quota_exceeded_fault: SubnetGroupQuotaExceededFault,
        subnet_in_use: SubnetInUse,
        subnet_not_allowed_fault: SubnetNotAllowedFault,
        subnet_quota_exceeded_fault: SubnetQuotaExceededFault,
        tag_not_found_fault: TagNotFoundFault,
        tag_quota_per_resource_exceeded: TagQuotaPerResourceExceeded,
        test_failover_not_available_fault: TestFailoverNotAvailableFault,
        user_already_exists_fault: UserAlreadyExistsFault,
        user_not_found_fault: UserNotFoundFault,
        user_quota_exceeded_fault: UserQuotaExceededFault,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .acl_already_exists_fault => "ACLAlreadyExistsFault",
                .acl_not_found_fault => "ACLNotFoundFault",
                .acl_quota_exceeded_fault => "ACLQuotaExceededFault",
                .api_call_rate_for_customer_exceeded_fault => "APICallRateForCustomerExceededFault",
                .cluster_already_exists_fault => "ClusterAlreadyExistsFault",
                .cluster_not_found_fault => "ClusterNotFoundFault",
                .cluster_quota_for_customer_exceeded_fault => "ClusterQuotaForCustomerExceededFault",
                .default_user_required => "DefaultUserRequired",
                .duplicate_user_name_fault => "DuplicateUserNameFault",
                .insufficient_cluster_capacity_fault => "InsufficientClusterCapacityFault",
                .invalid_acl_state_fault => "InvalidACLStateFault",
                .invalid_arn_fault => "InvalidARNFault",
                .invalid_cluster_state_fault => "InvalidClusterStateFault",
                .invalid_credentials_exception => "InvalidCredentialsException",
                .invalid_kms_key_fault => "InvalidKMSKeyFault",
                .invalid_multi_region_cluster_state_fault => "InvalidMultiRegionClusterStateFault",
                .invalid_node_state_fault => "InvalidNodeStateFault",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_group_state_fault => "InvalidParameterGroupStateFault",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_snapshot_state_fault => "InvalidSnapshotStateFault",
                .invalid_subnet => "InvalidSubnet",
                .invalid_user_state_fault => "InvalidUserStateFault",
                .invalid_vpc_network_state_fault => "InvalidVPCNetworkStateFault",
                .multi_region_cluster_already_exists_fault => "MultiRegionClusterAlreadyExistsFault",
                .multi_region_cluster_not_found_fault => "MultiRegionClusterNotFoundFault",
                .multi_region_parameter_group_not_found_fault => "MultiRegionParameterGroupNotFoundFault",
                .no_operation_fault => "NoOperationFault",
                .node_quota_for_cluster_exceeded_fault => "NodeQuotaForClusterExceededFault",
                .node_quota_for_customer_exceeded_fault => "NodeQuotaForCustomerExceededFault",
                .parameter_group_already_exists_fault => "ParameterGroupAlreadyExistsFault",
                .parameter_group_not_found_fault => "ParameterGroupNotFoundFault",
                .parameter_group_quota_exceeded_fault => "ParameterGroupQuotaExceededFault",
                .reserved_node_already_exists_fault => "ReservedNodeAlreadyExistsFault",
                .reserved_node_not_found_fault => "ReservedNodeNotFoundFault",
                .reserved_node_quota_exceeded_fault => "ReservedNodeQuotaExceededFault",
                .reserved_nodes_offering_not_found_fault => "ReservedNodesOfferingNotFoundFault",
                .service_linked_role_not_found_fault => "ServiceLinkedRoleNotFoundFault",
                .service_update_not_found_fault => "ServiceUpdateNotFoundFault",
                .shard_not_found_fault => "ShardNotFoundFault",
                .shards_per_cluster_quota_exceeded_fault => "ShardsPerClusterQuotaExceededFault",
                .snapshot_already_exists_fault => "SnapshotAlreadyExistsFault",
                .snapshot_not_found_fault => "SnapshotNotFoundFault",
                .snapshot_quota_exceeded_fault => "SnapshotQuotaExceededFault",
                .subnet_group_already_exists_fault => "SubnetGroupAlreadyExistsFault",
                .subnet_group_in_use_fault => "SubnetGroupInUseFault",
                .subnet_group_not_found_fault => "SubnetGroupNotFoundFault",
                .subnet_group_quota_exceeded_fault => "SubnetGroupQuotaExceededFault",
                .subnet_in_use => "SubnetInUse",
                .subnet_not_allowed_fault => "SubnetNotAllowedFault",
                .subnet_quota_exceeded_fault => "SubnetQuotaExceededFault",
                .tag_not_found_fault => "TagNotFoundFault",
                .tag_quota_per_resource_exceeded => "TagQuotaPerResourceExceeded",
                .test_failover_not_available_fault => "TestFailoverNotAvailableFault",
                .user_already_exists_fault => "UserAlreadyExistsFault",
                .user_not_found_fault => "UserNotFoundFault",
                .user_quota_exceeded_fault => "UserQuotaExceededFault",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .acl_already_exists_fault => |e| e.message,
                .acl_not_found_fault => |e| e.message,
                .acl_quota_exceeded_fault => |e| e.message,
                .api_call_rate_for_customer_exceeded_fault => |e| e.message,
                .cluster_already_exists_fault => |e| e.message,
                .cluster_not_found_fault => |e| e.message,
                .cluster_quota_for_customer_exceeded_fault => |e| e.message,
                .default_user_required => |e| e.message,
                .duplicate_user_name_fault => |e| e.message,
                .insufficient_cluster_capacity_fault => |e| e.message,
                .invalid_acl_state_fault => |e| e.message,
                .invalid_arn_fault => |e| e.message,
                .invalid_cluster_state_fault => |e| e.message,
                .invalid_credentials_exception => |e| e.message,
                .invalid_kms_key_fault => |e| e.message,
                .invalid_multi_region_cluster_state_fault => |e| e.message,
                .invalid_node_state_fault => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_group_state_fault => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_snapshot_state_fault => |e| e.message,
                .invalid_subnet => |e| e.message,
                .invalid_user_state_fault => |e| e.message,
                .invalid_vpc_network_state_fault => |e| e.message,
                .multi_region_cluster_already_exists_fault => |e| e.message,
                .multi_region_cluster_not_found_fault => |e| e.message,
                .multi_region_parameter_group_not_found_fault => |e| e.message,
                .no_operation_fault => |e| e.message,
                .node_quota_for_cluster_exceeded_fault => |e| e.message,
                .node_quota_for_customer_exceeded_fault => |e| e.message,
                .parameter_group_already_exists_fault => |e| e.message,
                .parameter_group_not_found_fault => |e| e.message,
                .parameter_group_quota_exceeded_fault => |e| e.message,
                .reserved_node_already_exists_fault => |e| e.message,
                .reserved_node_not_found_fault => |e| e.message,
                .reserved_node_quota_exceeded_fault => |e| e.message,
                .reserved_nodes_offering_not_found_fault => |e| e.message,
                .service_linked_role_not_found_fault => |e| e.message,
                .service_update_not_found_fault => |e| e.message,
                .shard_not_found_fault => |e| e.message,
                .shards_per_cluster_quota_exceeded_fault => |e| e.message,
                .snapshot_already_exists_fault => |e| e.message,
                .snapshot_not_found_fault => |e| e.message,
                .snapshot_quota_exceeded_fault => |e| e.message,
                .subnet_group_already_exists_fault => |e| e.message,
                .subnet_group_in_use_fault => |e| e.message,
                .subnet_group_not_found_fault => |e| e.message,
                .subnet_group_quota_exceeded_fault => |e| e.message,
                .subnet_in_use => |e| e.message,
                .subnet_not_allowed_fault => |e| e.message,
                .subnet_quota_exceeded_fault => |e| e.message,
                .tag_not_found_fault => |e| e.message,
                .tag_quota_per_resource_exceeded => |e| e.message,
                .test_failover_not_available_fault => |e| e.message,
                .user_already_exists_fault => |e| e.message,
                .user_not_found_fault => |e| e.message,
                .user_quota_exceeded_fault => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .acl_already_exists_fault => 400,
                .acl_not_found_fault => 404,
                .acl_quota_exceeded_fault => 400,
                .api_call_rate_for_customer_exceeded_fault => 400,
                .cluster_already_exists_fault => 400,
                .cluster_not_found_fault => 404,
                .cluster_quota_for_customer_exceeded_fault => 400,
                .default_user_required => 400,
                .duplicate_user_name_fault => 400,
                .insufficient_cluster_capacity_fault => 400,
                .invalid_acl_state_fault => 400,
                .invalid_arn_fault => 400,
                .invalid_cluster_state_fault => 400,
                .invalid_credentials_exception => 408,
                .invalid_kms_key_fault => 400,
                .invalid_multi_region_cluster_state_fault => 400,
                .invalid_node_state_fault => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_group_state_fault => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_snapshot_state_fault => 400,
                .invalid_subnet => 400,
                .invalid_user_state_fault => 400,
                .invalid_vpc_network_state_fault => 400,
                .multi_region_cluster_already_exists_fault => 400,
                .multi_region_cluster_not_found_fault => 404,
                .multi_region_parameter_group_not_found_fault => 404,
                .no_operation_fault => 400,
                .node_quota_for_cluster_exceeded_fault => 400,
                .node_quota_for_customer_exceeded_fault => 400,
                .parameter_group_already_exists_fault => 400,
                .parameter_group_not_found_fault => 404,
                .parameter_group_quota_exceeded_fault => 400,
                .reserved_node_already_exists_fault => 404,
                .reserved_node_not_found_fault => 404,
                .reserved_node_quota_exceeded_fault => 400,
                .reserved_nodes_offering_not_found_fault => 404,
                .service_linked_role_not_found_fault => 400,
                .service_update_not_found_fault => 404,
                .shard_not_found_fault => 404,
                .shards_per_cluster_quota_exceeded_fault => 400,
                .snapshot_already_exists_fault => 400,
                .snapshot_not_found_fault => 404,
                .snapshot_quota_exceeded_fault => 400,
                .subnet_group_already_exists_fault => 400,
                .subnet_group_in_use_fault => 400,
                .subnet_group_not_found_fault => 404,
                .subnet_group_quota_exceeded_fault => 400,
                .subnet_in_use => 400,
                .subnet_not_allowed_fault => 400,
                .subnet_quota_exceeded_fault => 400,
                .tag_not_found_fault => 404,
                .tag_quota_per_resource_exceeded => 400,
                .test_failover_not_available_fault => 400,
                .user_already_exists_fault => 400,
                .user_not_found_fault => 404,
                .user_quota_exceeded_fault => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .acl_already_exists_fault => |e| e.request_id,
                .acl_not_found_fault => |e| e.request_id,
                .acl_quota_exceeded_fault => |e| e.request_id,
                .api_call_rate_for_customer_exceeded_fault => |e| e.request_id,
                .cluster_already_exists_fault => |e| e.request_id,
                .cluster_not_found_fault => |e| e.request_id,
                .cluster_quota_for_customer_exceeded_fault => |e| e.request_id,
                .default_user_required => |e| e.request_id,
                .duplicate_user_name_fault => |e| e.request_id,
                .insufficient_cluster_capacity_fault => |e| e.request_id,
                .invalid_acl_state_fault => |e| e.request_id,
                .invalid_arn_fault => |e| e.request_id,
                .invalid_cluster_state_fault => |e| e.request_id,
                .invalid_credentials_exception => |e| e.request_id,
                .invalid_kms_key_fault => |e| e.request_id,
                .invalid_multi_region_cluster_state_fault => |e| e.request_id,
                .invalid_node_state_fault => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_group_state_fault => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_snapshot_state_fault => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .invalid_user_state_fault => |e| e.request_id,
                .invalid_vpc_network_state_fault => |e| e.request_id,
                .multi_region_cluster_already_exists_fault => |e| e.request_id,
                .multi_region_cluster_not_found_fault => |e| e.request_id,
                .multi_region_parameter_group_not_found_fault => |e| e.request_id,
                .no_operation_fault => |e| e.request_id,
                .node_quota_for_cluster_exceeded_fault => |e| e.request_id,
                .node_quota_for_customer_exceeded_fault => |e| e.request_id,
                .parameter_group_already_exists_fault => |e| e.request_id,
                .parameter_group_not_found_fault => |e| e.request_id,
                .parameter_group_quota_exceeded_fault => |e| e.request_id,
                .reserved_node_already_exists_fault => |e| e.request_id,
                .reserved_node_not_found_fault => |e| e.request_id,
                .reserved_node_quota_exceeded_fault => |e| e.request_id,
                .reserved_nodes_offering_not_found_fault => |e| e.request_id,
                .service_linked_role_not_found_fault => |e| e.request_id,
                .service_update_not_found_fault => |e| e.request_id,
                .shard_not_found_fault => |e| e.request_id,
                .shards_per_cluster_quota_exceeded_fault => |e| e.request_id,
                .snapshot_already_exists_fault => |e| e.request_id,
                .snapshot_not_found_fault => |e| e.request_id,
                .snapshot_quota_exceeded_fault => |e| e.request_id,
                .subnet_group_already_exists_fault => |e| e.request_id,
                .subnet_group_in_use_fault => |e| e.request_id,
                .subnet_group_not_found_fault => |e| e.request_id,
                .subnet_group_quota_exceeded_fault => |e| e.request_id,
                .subnet_in_use => |e| e.request_id,
                .subnet_not_allowed_fault => |e| e.request_id,
                .subnet_quota_exceeded_fault => |e| e.request_id,
                .tag_not_found_fault => |e| e.request_id,
                .tag_quota_per_resource_exceeded => |e| e.request_id,
                .test_failover_not_available_fault => |e| e.request_id,
                .user_already_exists_fault => |e| e.request_id,
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

pub const ACLAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ACLNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ACLQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const APICallRateForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterQuotaForCustomerExceededFault = struct {
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

pub const InsufficientClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidACLStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidARNFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCredentialsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKMSKeyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMultiRegionClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNodeStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
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

pub const InvalidUserStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MultiRegionClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MultiRegionClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MultiRegionParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoOperationFault = struct {
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

pub const ParameterGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodeQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNodesOfferingNotFoundFault = struct {
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

pub const ShardNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ShardsPerClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotAlreadyExistsFault = struct {
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

pub const SubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetGroupInUseFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetGroupQuotaExceededFault = struct {
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

pub const SubnetQuotaExceededFault = struct {
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
