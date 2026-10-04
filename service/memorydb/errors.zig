const aws = @import("aws");
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

/// An ACL with the specified name already exists.
pub const ACLAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified ACL does not exist.
pub const ACLNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of ACLs allowed.
pub const ACLQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The customer has exceeded the maximum number of API requests allowed per
/// time period.
pub const APICallRateForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A cluster with the specified name already exists.
pub const ClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified cluster does not exist.
pub const ClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of clusters allowed for this customer.
pub const ClusterQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A default user is required and must be specified.
pub const DefaultUserRequired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A user with the specified name already exists.
pub const DuplicateUserNameFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The cluster does not have sufficient capacity to perform the requested
/// operation.
pub const InsufficientClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The ACL is not in a valid state for the requested operation.
pub const InvalidACLStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon Resource Name (ARN) is not valid.
pub const InvalidARNFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The cluster is not in a valid state for the requested operation.
pub const InvalidClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided credentials are not valid.
pub const InvalidCredentialsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified KMS key is not valid or accessible.
pub const InvalidKMSKeyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested operation cannot be performed on the multi-Region cluster in
/// its current state.
pub const InvalidMultiRegionClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The node is not in a valid state for the requested operation.
pub const InvalidNodeStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified parameter combination is not valid.
pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The parameter group is not in a valid state for the requested operation.
pub const InvalidParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified parameter value is not valid.
pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The snapshot is not in a valid state for the requested operation.
pub const InvalidSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified subnet is not valid.
pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The user is not in a valid state for the requested operation.
pub const InvalidUserStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The VPC network is not in a valid state for the requested operation.
pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A multi-Region cluster with the specified name already exists.
pub const MultiRegionClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified multi-Region cluster does not exist.
pub const MultiRegionClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified multi-Region parameter group does not exist.
pub const MultiRegionParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested operation would result in no changes.
pub const NoOperationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of nodes allowed for this cluster.
pub const NodeQuotaForClusterExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of nodes allowed for this customer.
pub const NodeQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A parameter group with the specified name already exists.
pub const ParameterGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified parameter group does not exist.
pub const ParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of parameter groups allowed.
pub const ParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You already have a reservation with the given identifier.
pub const ReservedNodeAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested node does not exist.
pub const ReservedNodeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the user's node
/// quota.
pub const ReservedNodeQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested node offering does not exist.
pub const ReservedNodesOfferingNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The required service-linked role was not found.
pub const ServiceLinkedRoleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified service update does not exist.
pub const ServiceUpdateNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified shard does not exist.
pub const ShardNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of shards allowed per cluster.
pub const ShardsPerClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A snapshot with the specified name already exists.
pub const SnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified snapshot does not exist.
pub const SnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of snapshots allowed.
pub const SnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A subnet group with the specified name already exists.
pub const SubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The subnet group is currently in use and cannot be deleted.
pub const SubnetGroupInUseFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified subnet group does not exist.
pub const SubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of subnet groups allowed.
pub const SubnetGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The subnet is currently in use and cannot be deleted.
pub const SubnetInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified subnet is not allowed for this operation.
pub const SubnetNotAllowedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of subnets allowed.
pub const SubnetQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified tag does not exist.
pub const TagNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of tags allowed per resource.
pub const TagQuotaPerResourceExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Test failover is not available for this cluster configuration.
pub const TestFailoverNotAvailableFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A user with the specified name already exists.
pub const UserAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified user does not exist.
pub const UserNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the maximum number
/// of users allowed.
pub const UserQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ACLAlreadyExistsFault")) {
        const parsed_error: ?ACLAlreadyExistsFault = aws.json.parseJsonObject(ACLAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .acl_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ACLNotFoundFault")) {
        const parsed_error: ?ACLNotFoundFault = aws.json.parseJsonObject(ACLNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .acl_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ACLQuotaExceededFault")) {
        const parsed_error: ?ACLQuotaExceededFault = aws.json.parseJsonObject(ACLQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .acl_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "APICallRateForCustomerExceededFault")) {
        const parsed_error: ?APICallRateForCustomerExceededFault = aws.json.parseJsonObject(APICallRateForCustomerExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .api_call_rate_for_customer_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterAlreadyExistsFault")) {
        const parsed_error: ?ClusterAlreadyExistsFault = aws.json.parseJsonObject(ClusterAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundFault")) {
        const parsed_error: ?ClusterNotFoundFault = aws.json.parseJsonObject(ClusterNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterQuotaForCustomerExceededFault")) {
        const parsed_error: ?ClusterQuotaForCustomerExceededFault = aws.json.parseJsonObject(ClusterQuotaForCustomerExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_quota_for_customer_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DefaultUserRequired")) {
        const parsed_error: ?DefaultUserRequired = aws.json.parseJsonObject(DefaultUserRequired, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .default_user_required = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateUserNameFault")) {
        const parsed_error: ?DuplicateUserNameFault = aws.json.parseJsonObject(DuplicateUserNameFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_user_name_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientClusterCapacityFault")) {
        const parsed_error: ?InsufficientClusterCapacityFault = aws.json.parseJsonObject(InsufficientClusterCapacityFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_cluster_capacity_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidACLStateFault")) {
        const parsed_error: ?InvalidACLStateFault = aws.json.parseJsonObject(InvalidACLStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_acl_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidARNFault")) {
        const parsed_error: ?InvalidARNFault = aws.json.parseJsonObject(InvalidARNFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterStateFault")) {
        const parsed_error: ?InvalidClusterStateFault = aws.json.parseJsonObject(InvalidClusterStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_cluster_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCredentialsException")) {
        const parsed_error: ?InvalidCredentialsException = aws.json.parseJsonObject(InvalidCredentialsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_credentials_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSKeyFault")) {
        const parsed_error: ?InvalidKMSKeyFault = aws.json.parseJsonObject(InvalidKMSKeyFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_kms_key_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMultiRegionClusterStateFault")) {
        const parsed_error: ?InvalidMultiRegionClusterStateFault = aws.json.parseJsonObject(InvalidMultiRegionClusterStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_multi_region_cluster_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNodeStateFault")) {
        const parsed_error: ?InvalidNodeStateFault = aws.json.parseJsonObject(InvalidNodeStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_node_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        const parsed_error: ?InvalidParameterCombinationException = aws.json.parseJsonObject(InvalidParameterCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterGroupStateFault")) {
        const parsed_error: ?InvalidParameterGroupStateFault = aws.json.parseJsonObject(InvalidParameterGroupStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_group_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        const parsed_error: ?InvalidParameterValueException = aws.json.parseJsonObject(InvalidParameterValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSnapshotStateFault")) {
        const parsed_error: ?InvalidSnapshotStateFault = aws.json.parseJsonObject(InvalidSnapshotStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_snapshot_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        const parsed_error: ?InvalidSubnet = aws.json.parseJsonObject(InvalidSubnet, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_subnet = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUserStateFault")) {
        const parsed_error: ?InvalidUserStateFault = aws.json.parseJsonObject(InvalidUserStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_user_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        const parsed_error: ?InvalidVPCNetworkStateFault = aws.json.parseJsonObject(InvalidVPCNetworkStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultiRegionClusterAlreadyExistsFault")) {
        const parsed_error: ?MultiRegionClusterAlreadyExistsFault = aws.json.parseJsonObject(MultiRegionClusterAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multi_region_cluster_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultiRegionClusterNotFoundFault")) {
        const parsed_error: ?MultiRegionClusterNotFoundFault = aws.json.parseJsonObject(MultiRegionClusterNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multi_region_cluster_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultiRegionParameterGroupNotFoundFault")) {
        const parsed_error: ?MultiRegionParameterGroupNotFoundFault = aws.json.parseJsonObject(MultiRegionParameterGroupNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multi_region_parameter_group_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoOperationFault")) {
        const parsed_error: ?NoOperationFault = aws.json.parseJsonObject(NoOperationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_operation_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForClusterExceededFault")) {
        const parsed_error: ?NodeQuotaForClusterExceededFault = aws.json.parseJsonObject(NodeQuotaForClusterExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .node_quota_for_cluster_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForCustomerExceededFault")) {
        const parsed_error: ?NodeQuotaForCustomerExceededFault = aws.json.parseJsonObject(NodeQuotaForCustomerExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .node_quota_for_customer_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupAlreadyExistsFault")) {
        const parsed_error: ?ParameterGroupAlreadyExistsFault = aws.json.parseJsonObject(ParameterGroupAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_group_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupNotFoundFault")) {
        const parsed_error: ?ParameterGroupNotFoundFault = aws.json.parseJsonObject(ParameterGroupNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_group_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupQuotaExceededFault")) {
        const parsed_error: ?ParameterGroupQuotaExceededFault = aws.json.parseJsonObject(ParameterGroupQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_group_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeAlreadyExistsFault")) {
        const parsed_error: ?ReservedNodeAlreadyExistsFault = aws.json.parseJsonObject(ReservedNodeAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_node_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeNotFoundFault")) {
        const parsed_error: ?ReservedNodeNotFoundFault = aws.json.parseJsonObject(ReservedNodeNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_node_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeQuotaExceededFault")) {
        const parsed_error: ?ReservedNodeQuotaExceededFault = aws.json.parseJsonObject(ReservedNodeQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_node_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodesOfferingNotFoundFault")) {
        const parsed_error: ?ReservedNodesOfferingNotFoundFault = aws.json.parseJsonObject(ReservedNodesOfferingNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_nodes_offering_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleNotFoundFault")) {
        const parsed_error: ?ServiceLinkedRoleNotFoundFault = aws.json.parseJsonObject(ServiceLinkedRoleNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_linked_role_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceUpdateNotFoundFault")) {
        const parsed_error: ?ServiceUpdateNotFoundFault = aws.json.parseJsonObject(ServiceUpdateNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_update_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ShardNotFoundFault")) {
        const parsed_error: ?ShardNotFoundFault = aws.json.parseJsonObject(ShardNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .shard_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ShardsPerClusterQuotaExceededFault")) {
        const parsed_error: ?ShardsPerClusterQuotaExceededFault = aws.json.parseJsonObject(ShardsPerClusterQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .shards_per_cluster_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotAlreadyExistsFault")) {
        const parsed_error: ?SnapshotAlreadyExistsFault = aws.json.parseJsonObject(SnapshotAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFoundFault")) {
        const parsed_error: ?SnapshotNotFoundFault = aws.json.parseJsonObject(SnapshotNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotQuotaExceededFault")) {
        const parsed_error: ?SnapshotQuotaExceededFault = aws.json.parseJsonObject(SnapshotQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupAlreadyExistsFault")) {
        const parsed_error: ?SubnetGroupAlreadyExistsFault = aws.json.parseJsonObject(SubnetGroupAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupInUseFault")) {
        const parsed_error: ?SubnetGroupInUseFault = aws.json.parseJsonObject(SubnetGroupInUseFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_in_use_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupNotFoundFault")) {
        const parsed_error: ?SubnetGroupNotFoundFault = aws.json.parseJsonObject(SubnetGroupNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupQuotaExceededFault")) {
        const parsed_error: ?SubnetGroupQuotaExceededFault = aws.json.parseJsonObject(SubnetGroupQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetInUse")) {
        const parsed_error: ?SubnetInUse = aws.json.parseJsonObject(SubnetInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetNotAllowedFault")) {
        const parsed_error: ?SubnetNotAllowedFault = aws.json.parseJsonObject(SubnetNotAllowedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_not_allowed_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetQuotaExceededFault")) {
        const parsed_error: ?SubnetQuotaExceededFault = aws.json.parseJsonObject(SubnetQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagNotFoundFault")) {
        const parsed_error: ?TagNotFoundFault = aws.json.parseJsonObject(TagNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagQuotaPerResourceExceeded")) {
        const parsed_error: ?TagQuotaPerResourceExceeded = aws.json.parseJsonObject(TagQuotaPerResourceExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_quota_per_resource_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TestFailoverNotAvailableFault")) {
        const parsed_error: ?TestFailoverNotAvailableFault = aws.json.parseJsonObject(TestFailoverNotAvailableFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .test_failover_not_available_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserAlreadyExistsFault")) {
        const parsed_error: ?UserAlreadyExistsFault = aws.json.parseJsonObject(UserAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundFault")) {
        const parsed_error: ?UserNotFoundFault = aws.json.parseJsonObject(UserNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserQuotaExceededFault")) {
        const parsed_error: ?UserQuotaExceededFault = aws.json.parseJsonObject(UserQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_quota_exceeded_fault = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
