const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        authorization_not_found_fault: AuthorizationNotFoundFault,
        certificate_not_found_fault: CertificateNotFoundFault,
        db_cluster_already_exists_fault: DBClusterAlreadyExistsFault,
        db_cluster_not_found_fault: DBClusterNotFoundFault,
        db_cluster_parameter_group_not_found_fault: DBClusterParameterGroupNotFoundFault,
        db_cluster_quota_exceeded_fault: DBClusterQuotaExceededFault,
        db_cluster_snapshot_already_exists_fault: DBClusterSnapshotAlreadyExistsFault,
        db_cluster_snapshot_not_found_fault: DBClusterSnapshotNotFoundFault,
        db_instance_already_exists_fault: DBInstanceAlreadyExistsFault,
        db_instance_not_found_fault: DBInstanceNotFoundFault,
        db_parameter_group_already_exists_fault: DBParameterGroupAlreadyExistsFault,
        db_parameter_group_not_found_fault: DBParameterGroupNotFoundFault,
        db_parameter_group_quota_exceeded_fault: DBParameterGroupQuotaExceededFault,
        db_security_group_not_found_fault: DBSecurityGroupNotFoundFault,
        db_snapshot_already_exists_fault: DBSnapshotAlreadyExistsFault,
        db_snapshot_not_found_fault: DBSnapshotNotFoundFault,
        db_subnet_group_already_exists_fault: DBSubnetGroupAlreadyExistsFault,
        db_subnet_group_does_not_cover_enough_a_zs: DBSubnetGroupDoesNotCoverEnoughAZs,
        db_subnet_group_not_found_fault: DBSubnetGroupNotFoundFault,
        db_subnet_group_quota_exceeded_fault: DBSubnetGroupQuotaExceededFault,
        db_subnet_quota_exceeded_fault: DBSubnetQuotaExceededFault,
        db_upgrade_dependency_failure_fault: DBUpgradeDependencyFailureFault,
        event_subscription_quota_exceeded_fault: EventSubscriptionQuotaExceededFault,
        global_cluster_already_exists_fault: GlobalClusterAlreadyExistsFault,
        global_cluster_not_found_fault: GlobalClusterNotFoundFault,
        global_cluster_quota_exceeded_fault: GlobalClusterQuotaExceededFault,
        instance_quota_exceeded_fault: InstanceQuotaExceededFault,
        insufficient_db_cluster_capacity_fault: InsufficientDBClusterCapacityFault,
        insufficient_db_instance_capacity_fault: InsufficientDBInstanceCapacityFault,
        insufficient_storage_cluster_capacity_fault: InsufficientStorageClusterCapacityFault,
        invalid_db_cluster_snapshot_state_fault: InvalidDBClusterSnapshotStateFault,
        invalid_db_cluster_state_fault: InvalidDBClusterStateFault,
        invalid_db_instance_state_fault: InvalidDBInstanceStateFault,
        invalid_db_parameter_group_state_fault: InvalidDBParameterGroupStateFault,
        invalid_db_security_group_state_fault: InvalidDBSecurityGroupStateFault,
        invalid_db_snapshot_state_fault: InvalidDBSnapshotStateFault,
        invalid_db_subnet_group_state_fault: InvalidDBSubnetGroupStateFault,
        invalid_db_subnet_state_fault: InvalidDBSubnetStateFault,
        invalid_event_subscription_state_fault: InvalidEventSubscriptionStateFault,
        invalid_global_cluster_state_fault: InvalidGlobalClusterStateFault,
        invalid_restore_fault: InvalidRestoreFault,
        invalid_subnet: InvalidSubnet,
        invalid_vpc_network_state_fault: InvalidVPCNetworkStateFault,
        kms_key_not_accessible_fault: KMSKeyNotAccessibleFault,
        network_type_not_supported: NetworkTypeNotSupported,
        resource_not_found_fault: ResourceNotFoundFault,
        shared_snapshot_quota_exceeded_fault: SharedSnapshotQuotaExceededFault,
        snapshot_quota_exceeded_fault: SnapshotQuotaExceededFault,
        sns_invalid_topic_fault: SNSInvalidTopicFault,
        sns_no_authorization_fault: SNSNoAuthorizationFault,
        sns_topic_arn_not_found_fault: SNSTopicArnNotFoundFault,
        source_not_found_fault: SourceNotFoundFault,
        storage_quota_exceeded_fault: StorageQuotaExceededFault,
        storage_type_not_supported_fault: StorageTypeNotSupportedFault,
        subnet_already_in_use: SubnetAlreadyInUse,
        subscription_already_exist_fault: SubscriptionAlreadyExistFault,
        subscription_category_not_found_fault: SubscriptionCategoryNotFoundFault,
        subscription_not_found_fault: SubscriptionNotFoundFault,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .authorization_not_found_fault => "AuthorizationNotFoundFault",
                .certificate_not_found_fault => "CertificateNotFoundFault",
                .db_cluster_already_exists_fault => "DBClusterAlreadyExistsFault",
                .db_cluster_not_found_fault => "DBClusterNotFoundFault",
                .db_cluster_parameter_group_not_found_fault => "DBClusterParameterGroupNotFoundFault",
                .db_cluster_quota_exceeded_fault => "DBClusterQuotaExceededFault",
                .db_cluster_snapshot_already_exists_fault => "DBClusterSnapshotAlreadyExistsFault",
                .db_cluster_snapshot_not_found_fault => "DBClusterSnapshotNotFoundFault",
                .db_instance_already_exists_fault => "DBInstanceAlreadyExistsFault",
                .db_instance_not_found_fault => "DBInstanceNotFoundFault",
                .db_parameter_group_already_exists_fault => "DBParameterGroupAlreadyExistsFault",
                .db_parameter_group_not_found_fault => "DBParameterGroupNotFoundFault",
                .db_parameter_group_quota_exceeded_fault => "DBParameterGroupQuotaExceededFault",
                .db_security_group_not_found_fault => "DBSecurityGroupNotFoundFault",
                .db_snapshot_already_exists_fault => "DBSnapshotAlreadyExistsFault",
                .db_snapshot_not_found_fault => "DBSnapshotNotFoundFault",
                .db_subnet_group_already_exists_fault => "DBSubnetGroupAlreadyExistsFault",
                .db_subnet_group_does_not_cover_enough_a_zs => "DBSubnetGroupDoesNotCoverEnoughAZs",
                .db_subnet_group_not_found_fault => "DBSubnetGroupNotFoundFault",
                .db_subnet_group_quota_exceeded_fault => "DBSubnetGroupQuotaExceededFault",
                .db_subnet_quota_exceeded_fault => "DBSubnetQuotaExceededFault",
                .db_upgrade_dependency_failure_fault => "DBUpgradeDependencyFailureFault",
                .event_subscription_quota_exceeded_fault => "EventSubscriptionQuotaExceededFault",
                .global_cluster_already_exists_fault => "GlobalClusterAlreadyExistsFault",
                .global_cluster_not_found_fault => "GlobalClusterNotFoundFault",
                .global_cluster_quota_exceeded_fault => "GlobalClusterQuotaExceededFault",
                .instance_quota_exceeded_fault => "InstanceQuotaExceededFault",
                .insufficient_db_cluster_capacity_fault => "InsufficientDBClusterCapacityFault",
                .insufficient_db_instance_capacity_fault => "InsufficientDBInstanceCapacityFault",
                .insufficient_storage_cluster_capacity_fault => "InsufficientStorageClusterCapacityFault",
                .invalid_db_cluster_snapshot_state_fault => "InvalidDBClusterSnapshotStateFault",
                .invalid_db_cluster_state_fault => "InvalidDBClusterStateFault",
                .invalid_db_instance_state_fault => "InvalidDBInstanceStateFault",
                .invalid_db_parameter_group_state_fault => "InvalidDBParameterGroupStateFault",
                .invalid_db_security_group_state_fault => "InvalidDBSecurityGroupStateFault",
                .invalid_db_snapshot_state_fault => "InvalidDBSnapshotStateFault",
                .invalid_db_subnet_group_state_fault => "InvalidDBSubnetGroupStateFault",
                .invalid_db_subnet_state_fault => "InvalidDBSubnetStateFault",
                .invalid_event_subscription_state_fault => "InvalidEventSubscriptionStateFault",
                .invalid_global_cluster_state_fault => "InvalidGlobalClusterStateFault",
                .invalid_restore_fault => "InvalidRestoreFault",
                .invalid_subnet => "InvalidSubnet",
                .invalid_vpc_network_state_fault => "InvalidVPCNetworkStateFault",
                .kms_key_not_accessible_fault => "KMSKeyNotAccessibleFault",
                .network_type_not_supported => "NetworkTypeNotSupported",
                .resource_not_found_fault => "ResourceNotFoundFault",
                .shared_snapshot_quota_exceeded_fault => "SharedSnapshotQuotaExceededFault",
                .snapshot_quota_exceeded_fault => "SnapshotQuotaExceededFault",
                .sns_invalid_topic_fault => "SNSInvalidTopicFault",
                .sns_no_authorization_fault => "SNSNoAuthorizationFault",
                .sns_topic_arn_not_found_fault => "SNSTopicArnNotFoundFault",
                .source_not_found_fault => "SourceNotFoundFault",
                .storage_quota_exceeded_fault => "StorageQuotaExceededFault",
                .storage_type_not_supported_fault => "StorageTypeNotSupportedFault",
                .subnet_already_in_use => "SubnetAlreadyInUse",
                .subscription_already_exist_fault => "SubscriptionAlreadyExistFault",
                .subscription_category_not_found_fault => "SubscriptionCategoryNotFoundFault",
                .subscription_not_found_fault => "SubscriptionNotFoundFault",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .authorization_not_found_fault => |e| e.message,
                .certificate_not_found_fault => |e| e.message,
                .db_cluster_already_exists_fault => |e| e.message,
                .db_cluster_not_found_fault => |e| e.message,
                .db_cluster_parameter_group_not_found_fault => |e| e.message,
                .db_cluster_quota_exceeded_fault => |e| e.message,
                .db_cluster_snapshot_already_exists_fault => |e| e.message,
                .db_cluster_snapshot_not_found_fault => |e| e.message,
                .db_instance_already_exists_fault => |e| e.message,
                .db_instance_not_found_fault => |e| e.message,
                .db_parameter_group_already_exists_fault => |e| e.message,
                .db_parameter_group_not_found_fault => |e| e.message,
                .db_parameter_group_quota_exceeded_fault => |e| e.message,
                .db_security_group_not_found_fault => |e| e.message,
                .db_snapshot_already_exists_fault => |e| e.message,
                .db_snapshot_not_found_fault => |e| e.message,
                .db_subnet_group_already_exists_fault => |e| e.message,
                .db_subnet_group_does_not_cover_enough_a_zs => |e| e.message,
                .db_subnet_group_not_found_fault => |e| e.message,
                .db_subnet_group_quota_exceeded_fault => |e| e.message,
                .db_subnet_quota_exceeded_fault => |e| e.message,
                .db_upgrade_dependency_failure_fault => |e| e.message,
                .event_subscription_quota_exceeded_fault => |e| e.message,
                .global_cluster_already_exists_fault => |e| e.message,
                .global_cluster_not_found_fault => |e| e.message,
                .global_cluster_quota_exceeded_fault => |e| e.message,
                .instance_quota_exceeded_fault => |e| e.message,
                .insufficient_db_cluster_capacity_fault => |e| e.message,
                .insufficient_db_instance_capacity_fault => |e| e.message,
                .insufficient_storage_cluster_capacity_fault => |e| e.message,
                .invalid_db_cluster_snapshot_state_fault => |e| e.message,
                .invalid_db_cluster_state_fault => |e| e.message,
                .invalid_db_instance_state_fault => |e| e.message,
                .invalid_db_parameter_group_state_fault => |e| e.message,
                .invalid_db_security_group_state_fault => |e| e.message,
                .invalid_db_snapshot_state_fault => |e| e.message,
                .invalid_db_subnet_group_state_fault => |e| e.message,
                .invalid_db_subnet_state_fault => |e| e.message,
                .invalid_event_subscription_state_fault => |e| e.message,
                .invalid_global_cluster_state_fault => |e| e.message,
                .invalid_restore_fault => |e| e.message,
                .invalid_subnet => |e| e.message,
                .invalid_vpc_network_state_fault => |e| e.message,
                .kms_key_not_accessible_fault => |e| e.message,
                .network_type_not_supported => |e| e.message,
                .resource_not_found_fault => |e| e.message,
                .shared_snapshot_quota_exceeded_fault => |e| e.message,
                .snapshot_quota_exceeded_fault => |e| e.message,
                .sns_invalid_topic_fault => |e| e.message,
                .sns_no_authorization_fault => |e| e.message,
                .sns_topic_arn_not_found_fault => |e| e.message,
                .source_not_found_fault => |e| e.message,
                .storage_quota_exceeded_fault => |e| e.message,
                .storage_type_not_supported_fault => |e| e.message,
                .subnet_already_in_use => |e| e.message,
                .subscription_already_exist_fault => |e| e.message,
                .subscription_category_not_found_fault => |e| e.message,
                .subscription_not_found_fault => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .authorization_not_found_fault => 404,
                .certificate_not_found_fault => 404,
                .db_cluster_already_exists_fault => 400,
                .db_cluster_not_found_fault => 404,
                .db_cluster_parameter_group_not_found_fault => 404,
                .db_cluster_quota_exceeded_fault => 403,
                .db_cluster_snapshot_already_exists_fault => 400,
                .db_cluster_snapshot_not_found_fault => 404,
                .db_instance_already_exists_fault => 400,
                .db_instance_not_found_fault => 404,
                .db_parameter_group_already_exists_fault => 400,
                .db_parameter_group_not_found_fault => 404,
                .db_parameter_group_quota_exceeded_fault => 400,
                .db_security_group_not_found_fault => 404,
                .db_snapshot_already_exists_fault => 400,
                .db_snapshot_not_found_fault => 404,
                .db_subnet_group_already_exists_fault => 400,
                .db_subnet_group_does_not_cover_enough_a_zs => 400,
                .db_subnet_group_not_found_fault => 404,
                .db_subnet_group_quota_exceeded_fault => 400,
                .db_subnet_quota_exceeded_fault => 400,
                .db_upgrade_dependency_failure_fault => 400,
                .event_subscription_quota_exceeded_fault => 400,
                .global_cluster_already_exists_fault => 400,
                .global_cluster_not_found_fault => 404,
                .global_cluster_quota_exceeded_fault => 400,
                .instance_quota_exceeded_fault => 400,
                .insufficient_db_cluster_capacity_fault => 403,
                .insufficient_db_instance_capacity_fault => 400,
                .insufficient_storage_cluster_capacity_fault => 400,
                .invalid_db_cluster_snapshot_state_fault => 400,
                .invalid_db_cluster_state_fault => 400,
                .invalid_db_instance_state_fault => 400,
                .invalid_db_parameter_group_state_fault => 400,
                .invalid_db_security_group_state_fault => 400,
                .invalid_db_snapshot_state_fault => 400,
                .invalid_db_subnet_group_state_fault => 400,
                .invalid_db_subnet_state_fault => 400,
                .invalid_event_subscription_state_fault => 400,
                .invalid_global_cluster_state_fault => 400,
                .invalid_restore_fault => 400,
                .invalid_subnet => 400,
                .invalid_vpc_network_state_fault => 400,
                .kms_key_not_accessible_fault => 400,
                .network_type_not_supported => 400,
                .resource_not_found_fault => 404,
                .shared_snapshot_quota_exceeded_fault => 400,
                .snapshot_quota_exceeded_fault => 400,
                .sns_invalid_topic_fault => 400,
                .sns_no_authorization_fault => 400,
                .sns_topic_arn_not_found_fault => 404,
                .source_not_found_fault => 404,
                .storage_quota_exceeded_fault => 400,
                .storage_type_not_supported_fault => 400,
                .subnet_already_in_use => 400,
                .subscription_already_exist_fault => 400,
                .subscription_category_not_found_fault => 404,
                .subscription_not_found_fault => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .authorization_not_found_fault => |e| e.request_id,
                .certificate_not_found_fault => |e| e.request_id,
                .db_cluster_already_exists_fault => |e| e.request_id,
                .db_cluster_not_found_fault => |e| e.request_id,
                .db_cluster_parameter_group_not_found_fault => |e| e.request_id,
                .db_cluster_quota_exceeded_fault => |e| e.request_id,
                .db_cluster_snapshot_already_exists_fault => |e| e.request_id,
                .db_cluster_snapshot_not_found_fault => |e| e.request_id,
                .db_instance_already_exists_fault => |e| e.request_id,
                .db_instance_not_found_fault => |e| e.request_id,
                .db_parameter_group_already_exists_fault => |e| e.request_id,
                .db_parameter_group_not_found_fault => |e| e.request_id,
                .db_parameter_group_quota_exceeded_fault => |e| e.request_id,
                .db_security_group_not_found_fault => |e| e.request_id,
                .db_snapshot_already_exists_fault => |e| e.request_id,
                .db_snapshot_not_found_fault => |e| e.request_id,
                .db_subnet_group_already_exists_fault => |e| e.request_id,
                .db_subnet_group_does_not_cover_enough_a_zs => |e| e.request_id,
                .db_subnet_group_not_found_fault => |e| e.request_id,
                .db_subnet_group_quota_exceeded_fault => |e| e.request_id,
                .db_subnet_quota_exceeded_fault => |e| e.request_id,
                .db_upgrade_dependency_failure_fault => |e| e.request_id,
                .event_subscription_quota_exceeded_fault => |e| e.request_id,
                .global_cluster_already_exists_fault => |e| e.request_id,
                .global_cluster_not_found_fault => |e| e.request_id,
                .global_cluster_quota_exceeded_fault => |e| e.request_id,
                .instance_quota_exceeded_fault => |e| e.request_id,
                .insufficient_db_cluster_capacity_fault => |e| e.request_id,
                .insufficient_db_instance_capacity_fault => |e| e.request_id,
                .insufficient_storage_cluster_capacity_fault => |e| e.request_id,
                .invalid_db_cluster_snapshot_state_fault => |e| e.request_id,
                .invalid_db_cluster_state_fault => |e| e.request_id,
                .invalid_db_instance_state_fault => |e| e.request_id,
                .invalid_db_parameter_group_state_fault => |e| e.request_id,
                .invalid_db_security_group_state_fault => |e| e.request_id,
                .invalid_db_snapshot_state_fault => |e| e.request_id,
                .invalid_db_subnet_group_state_fault => |e| e.request_id,
                .invalid_db_subnet_state_fault => |e| e.request_id,
                .invalid_event_subscription_state_fault => |e| e.request_id,
                .invalid_global_cluster_state_fault => |e| e.request_id,
                .invalid_restore_fault => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .invalid_vpc_network_state_fault => |e| e.request_id,
                .kms_key_not_accessible_fault => |e| e.request_id,
                .network_type_not_supported => |e| e.request_id,
                .resource_not_found_fault => |e| e.request_id,
                .shared_snapshot_quota_exceeded_fault => |e| e.request_id,
                .snapshot_quota_exceeded_fault => |e| e.request_id,
                .sns_invalid_topic_fault => |e| e.request_id,
                .sns_no_authorization_fault => |e| e.request_id,
                .sns_topic_arn_not_found_fault => |e| e.request_id,
                .source_not_found_fault => |e| e.request_id,
                .storage_quota_exceeded_fault => |e| e.request_id,
                .storage_type_not_supported_fault => |e| e.request_id,
                .subnet_already_in_use => |e| e.request_id,
                .subscription_already_exist_fault => |e| e.request_id,
                .subscription_category_not_found_fault => |e| e.request_id,
                .subscription_not_found_fault => |e| e.request_id,
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

pub const AuthorizationNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterSnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBClusterSnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBInstanceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBParameterGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBParameterGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBParameterGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSecurityGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSnapshotAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSnapshotNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupDoesNotCoverEnoughAZs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetGroupQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBSubnetQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DBUpgradeDependencyFailureFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventSubscriptionQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalClusterAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalClusterNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalClusterQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InstanceQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientDBClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientDBInstanceCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientStorageClusterCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBInstanceStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBParameterGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSecurityGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSnapshotStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSubnetGroupStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDBSubnetStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventSubscriptionStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGlobalClusterStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRestoreFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVPCNetworkStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSKeyNotAccessibleFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NetworkTypeNotSupported = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SharedSnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SNSInvalidTopicFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SNSNoAuthorizationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SNSTopicArnNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageTypeNotSupportedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetAlreadyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionAlreadyExistFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionCategoryNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
