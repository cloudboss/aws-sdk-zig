const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cluster_already_exists_fault: ClusterAlreadyExistsFault,
        cluster_not_found_fault: ClusterNotFoundFault,
        cluster_quota_for_customer_exceeded_fault: ClusterQuotaForCustomerExceededFault,
        insufficient_cluster_capacity_fault: InsufficientClusterCapacityFault,
        invalid_arn_fault: InvalidARNFault,
        invalid_cluster_state_fault: InvalidClusterStateFault,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_group_state_fault: InvalidParameterGroupStateFault,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_subnet: InvalidSubnet,
        invalid_vpc_network_state_fault: InvalidVPCNetworkStateFault,
        node_not_found_fault: NodeNotFoundFault,
        node_quota_for_cluster_exceeded_fault: NodeQuotaForClusterExceededFault,
        node_quota_for_customer_exceeded_fault: NodeQuotaForCustomerExceededFault,
        parameter_group_already_exists_fault: ParameterGroupAlreadyExistsFault,
        parameter_group_not_found_fault: ParameterGroupNotFoundFault,
        parameter_group_quota_exceeded_fault: ParameterGroupQuotaExceededFault,
        service_linked_role_not_found_fault: ServiceLinkedRoleNotFoundFault,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        subnet_group_already_exists_fault: SubnetGroupAlreadyExistsFault,
        subnet_group_in_use_fault: SubnetGroupInUseFault,
        subnet_group_not_found_fault: SubnetGroupNotFoundFault,
        subnet_group_quota_exceeded_fault: SubnetGroupQuotaExceededFault,
        subnet_in_use: SubnetInUse,
        subnet_not_allowed_fault: SubnetNotAllowedFault,
        subnet_quota_exceeded_fault: SubnetQuotaExceededFault,
        tag_not_found_fault: TagNotFoundFault,
        tag_quota_per_resource_exceeded: TagQuotaPerResourceExceeded,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cluster_already_exists_fault => "ClusterAlreadyExistsFault",
                .cluster_not_found_fault => "ClusterNotFoundFault",
                .cluster_quota_for_customer_exceeded_fault => "ClusterQuotaForCustomerExceededFault",
                .insufficient_cluster_capacity_fault => "InsufficientClusterCapacityFault",
                .invalid_arn_fault => "InvalidARNFault",
                .invalid_cluster_state_fault => "InvalidClusterStateFault",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_group_state_fault => "InvalidParameterGroupStateFault",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_subnet => "InvalidSubnet",
                .invalid_vpc_network_state_fault => "InvalidVPCNetworkStateFault",
                .node_not_found_fault => "NodeNotFoundFault",
                .node_quota_for_cluster_exceeded_fault => "NodeQuotaForClusterExceededFault",
                .node_quota_for_customer_exceeded_fault => "NodeQuotaForCustomerExceededFault",
                .parameter_group_already_exists_fault => "ParameterGroupAlreadyExistsFault",
                .parameter_group_not_found_fault => "ParameterGroupNotFoundFault",
                .parameter_group_quota_exceeded_fault => "ParameterGroupQuotaExceededFault",
                .service_linked_role_not_found_fault => "ServiceLinkedRoleNotFoundFault",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .subnet_group_already_exists_fault => "SubnetGroupAlreadyExistsFault",
                .subnet_group_in_use_fault => "SubnetGroupInUseFault",
                .subnet_group_not_found_fault => "SubnetGroupNotFoundFault",
                .subnet_group_quota_exceeded_fault => "SubnetGroupQuotaExceededFault",
                .subnet_in_use => "SubnetInUse",
                .subnet_not_allowed_fault => "SubnetNotAllowedFault",
                .subnet_quota_exceeded_fault => "SubnetQuotaExceededFault",
                .tag_not_found_fault => "TagNotFoundFault",
                .tag_quota_per_resource_exceeded => "TagQuotaPerResourceExceeded",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cluster_already_exists_fault => |e| e.message,
                .cluster_not_found_fault => |e| e.message,
                .cluster_quota_for_customer_exceeded_fault => |e| e.message,
                .insufficient_cluster_capacity_fault => |e| e.message,
                .invalid_arn_fault => |e| e.message,
                .invalid_cluster_state_fault => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_group_state_fault => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_subnet => |e| e.message,
                .invalid_vpc_network_state_fault => |e| e.message,
                .node_not_found_fault => |e| e.message,
                .node_quota_for_cluster_exceeded_fault => |e| e.message,
                .node_quota_for_customer_exceeded_fault => |e| e.message,
                .parameter_group_already_exists_fault => |e| e.message,
                .parameter_group_not_found_fault => |e| e.message,
                .parameter_group_quota_exceeded_fault => |e| e.message,
                .service_linked_role_not_found_fault => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .subnet_group_already_exists_fault => |e| e.message,
                .subnet_group_in_use_fault => |e| e.message,
                .subnet_group_not_found_fault => |e| e.message,
                .subnet_group_quota_exceeded_fault => |e| e.message,
                .subnet_in_use => |e| e.message,
                .subnet_not_allowed_fault => |e| e.message,
                .subnet_quota_exceeded_fault => |e| e.message,
                .tag_not_found_fault => |e| e.message,
                .tag_quota_per_resource_exceeded => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cluster_already_exists_fault => 400,
                .cluster_not_found_fault => 404,
                .cluster_quota_for_customer_exceeded_fault => 400,
                .insufficient_cluster_capacity_fault => 400,
                .invalid_arn_fault => 400,
                .invalid_cluster_state_fault => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_group_state_fault => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_subnet => 400,
                .invalid_vpc_network_state_fault => 400,
                .node_not_found_fault => 404,
                .node_quota_for_cluster_exceeded_fault => 400,
                .node_quota_for_customer_exceeded_fault => 400,
                .parameter_group_already_exists_fault => 400,
                .parameter_group_not_found_fault => 404,
                .parameter_group_quota_exceeded_fault => 400,
                .service_linked_role_not_found_fault => 400,
                .service_quota_exceeded_exception => 402,
                .subnet_group_already_exists_fault => 400,
                .subnet_group_in_use_fault => 400,
                .subnet_group_not_found_fault => 404,
                .subnet_group_quota_exceeded_fault => 400,
                .subnet_in_use => 400,
                .subnet_not_allowed_fault => 400,
                .subnet_quota_exceeded_fault => 400,
                .tag_not_found_fault => 404,
                .tag_quota_per_resource_exceeded => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cluster_already_exists_fault => |e| e.request_id,
                .cluster_not_found_fault => |e| e.request_id,
                .cluster_quota_for_customer_exceeded_fault => |e| e.request_id,
                .insufficient_cluster_capacity_fault => |e| e.request_id,
                .invalid_arn_fault => |e| e.request_id,
                .invalid_cluster_state_fault => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_group_state_fault => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .invalid_vpc_network_state_fault => |e| e.request_id,
                .node_not_found_fault => |e| e.request_id,
                .node_quota_for_cluster_exceeded_fault => |e| e.request_id,
                .node_quota_for_customer_exceeded_fault => |e| e.request_id,
                .parameter_group_already_exists_fault => |e| e.request_id,
                .parameter_group_not_found_fault => |e| e.request_id,
                .parameter_group_quota_exceeded_fault => |e| e.request_id,
                .service_linked_role_not_found_fault => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .subnet_group_already_exists_fault => |e| e.request_id,
                .subnet_group_in_use_fault => |e| e.request_id,
                .subnet_group_not_found_fault => |e| e.request_id,
                .subnet_group_quota_exceeded_fault => |e| e.request_id,
                .subnet_in_use => |e| e.request_id,
                .subnet_not_allowed_fault => |e| e.request_id,
                .subnet_quota_exceeded_fault => |e| e.request_id,
                .tag_not_found_fault => |e| e.request_id,
                .tag_quota_per_resource_exceeded => |e| e.request_id,
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

/// You already have a DAX cluster with the given identifier.
pub const ClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested cluster ID does not refer to an existing DAX
/// cluster.
pub const ClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have attempted to exceed the maximum number of DAX clusters for
/// your Amazon Web Services account.
pub const ClusterQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There are not enough system resources to create the cluster you requested
/// (or to
/// resize an already-existing cluster).
pub const InsufficientClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Resource Name (ARN) supplied in the request is not valid.
pub const InvalidARNFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested DAX cluster is not in the
/// *available* state.
pub const InvalidClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Two or more incompatible parameters were specified.
pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more parameters in a parameter group are in an invalid state.
pub const InvalidParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The value for a parameter is invalid.
pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid subnet identifier was specified.
pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The VPC network is in an invalid state.
pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// None of the nodes in the cluster have the given node ID.
pub const NodeNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have attempted to exceed the maximum number of nodes for a DAX
/// cluster.
pub const NodeQuotaForClusterExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have attempted to exceed the maximum number of nodes for your Amazon Web
/// Services account.
pub const NodeQuotaForCustomerExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified parameter group already exists.
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

/// You have attempted to exceed the maximum number of parameter groups.
pub const ParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified service linked role (SLR) was not found.
pub const ServiceLinkedRoleNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the maximum number of x509 certificates that can be created
/// for
/// encrypted clusters in a 30 day period. Contact Amazon Web Services customer
/// support to
/// discuss options for continuing to create encrypted clusters.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The specified subnet group already exists.
pub const SubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified subnet group is currently in use.
pub const SubnetGroupInUseFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested subnet group name does not refer to an existing subnet
/// group.
pub const SubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the allowed number
/// of
/// subnets in a subnet group.
pub const SubnetGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested subnet is being used by another subnet group.
pub const SubnetInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified subnet can't be used for the requested network type. This
/// error
/// occurs when either there aren't enough subnets of the required network type
/// to create
/// the cluster, or when you try to use a subnet that doesn't support the
/// requested network
/// type (for example, trying to create a dual-stack cluster with a subnet that
/// doesn't have
/// IPv6 CIDR).
pub const SubnetNotAllowedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request cannot be processed because it would exceed the allowed number
/// of
/// subnets in a subnet group.
pub const SubnetQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag does not exist.
pub const TagNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have exceeded the maximum number of tags for this DAX cluster.
pub const TagQuotaPerResourceExceeded = struct {
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
