const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_fault: AccessDeniedFault,
        collector_not_found_fault: CollectorNotFoundFault,
        failed_dependency_fault: FailedDependencyFault,
        insufficient_resource_capacity_fault: InsufficientResourceCapacityFault,
        invalid_certificate_fault: InvalidCertificateFault,
        invalid_operation_fault: InvalidOperationFault,
        invalid_resource_state_fault: InvalidResourceStateFault,
        invalid_subnet: InvalidSubnet,
        kms_access_denied_fault: KMSAccessDeniedFault,
        kms_disabled_fault: KMSDisabledFault,
        kms_fault: KMSFault,
        kms_invalid_state_fault: KMSInvalidStateFault,
        kms_key_not_accessible_fault: KMSKeyNotAccessibleFault,
        kms_not_found_fault: KMSNotFoundFault,
        kms_throttling_fault: KMSThrottlingFault,
        replication_subnet_group_does_not_cover_enough_a_zs: ReplicationSubnetGroupDoesNotCoverEnoughAZs,
        resource_already_exists_fault: ResourceAlreadyExistsFault,
        resource_not_found_fault: ResourceNotFoundFault,
        resource_quota_exceeded_fault: ResourceQuotaExceededFault,
        s3_access_denied_fault: S3AccessDeniedFault,
        s3_resource_not_found_fault: S3ResourceNotFoundFault,
        sns_invalid_topic_fault: SNSInvalidTopicFault,
        sns_no_authorization_fault: SNSNoAuthorizationFault,
        storage_quota_exceeded_fault: StorageQuotaExceededFault,
        subnet_already_in_use: SubnetAlreadyInUse,
        upgrade_dependency_failure_fault: UpgradeDependencyFailureFault,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_fault => "AccessDeniedFault",
                .collector_not_found_fault => "CollectorNotFoundFault",
                .failed_dependency_fault => "FailedDependencyFault",
                .insufficient_resource_capacity_fault => "InsufficientResourceCapacityFault",
                .invalid_certificate_fault => "InvalidCertificateFault",
                .invalid_operation_fault => "InvalidOperationFault",
                .invalid_resource_state_fault => "InvalidResourceStateFault",
                .invalid_subnet => "InvalidSubnet",
                .kms_access_denied_fault => "KMSAccessDeniedFault",
                .kms_disabled_fault => "KMSDisabledFault",
                .kms_fault => "KMSFault",
                .kms_invalid_state_fault => "KMSInvalidStateFault",
                .kms_key_not_accessible_fault => "KMSKeyNotAccessibleFault",
                .kms_not_found_fault => "KMSNotFoundFault",
                .kms_throttling_fault => "KMSThrottlingFault",
                .replication_subnet_group_does_not_cover_enough_a_zs => "ReplicationSubnetGroupDoesNotCoverEnoughAZs",
                .resource_already_exists_fault => "ResourceAlreadyExistsFault",
                .resource_not_found_fault => "ResourceNotFoundFault",
                .resource_quota_exceeded_fault => "ResourceQuotaExceededFault",
                .s3_access_denied_fault => "S3AccessDeniedFault",
                .s3_resource_not_found_fault => "S3ResourceNotFoundFault",
                .sns_invalid_topic_fault => "SNSInvalidTopicFault",
                .sns_no_authorization_fault => "SNSNoAuthorizationFault",
                .storage_quota_exceeded_fault => "StorageQuotaExceededFault",
                .subnet_already_in_use => "SubnetAlreadyInUse",
                .upgrade_dependency_failure_fault => "UpgradeDependencyFailureFault",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_fault => |e| e.message,
                .collector_not_found_fault => |e| e.message,
                .failed_dependency_fault => |e| e.message,
                .insufficient_resource_capacity_fault => |e| e.message,
                .invalid_certificate_fault => |e| e.message,
                .invalid_operation_fault => |e| e.message,
                .invalid_resource_state_fault => |e| e.message,
                .invalid_subnet => |e| e.message,
                .kms_access_denied_fault => |e| e.message,
                .kms_disabled_fault => |e| e.message,
                .kms_fault => |e| e.message,
                .kms_invalid_state_fault => |e| e.message,
                .kms_key_not_accessible_fault => |e| e.message,
                .kms_not_found_fault => |e| e.message,
                .kms_throttling_fault => |e| e.message,
                .replication_subnet_group_does_not_cover_enough_a_zs => |e| e.message,
                .resource_already_exists_fault => |e| e.message,
                .resource_not_found_fault => |e| e.message,
                .resource_quota_exceeded_fault => |e| e.message,
                .s3_access_denied_fault => |e| e.message,
                .s3_resource_not_found_fault => |e| e.message,
                .sns_invalid_topic_fault => |e| e.message,
                .sns_no_authorization_fault => |e| e.message,
                .storage_quota_exceeded_fault => |e| e.message,
                .subnet_already_in_use => |e| e.message,
                .upgrade_dependency_failure_fault => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_fault => 400,
                .collector_not_found_fault => 404,
                .failed_dependency_fault => 400,
                .insufficient_resource_capacity_fault => 400,
                .invalid_certificate_fault => 400,
                .invalid_operation_fault => 400,
                .invalid_resource_state_fault => 400,
                .invalid_subnet => 400,
                .kms_access_denied_fault => 400,
                .kms_disabled_fault => 400,
                .kms_fault => 400,
                .kms_invalid_state_fault => 400,
                .kms_key_not_accessible_fault => 400,
                .kms_not_found_fault => 400,
                .kms_throttling_fault => 400,
                .replication_subnet_group_does_not_cover_enough_a_zs => 400,
                .resource_already_exists_fault => 400,
                .resource_not_found_fault => 400,
                .resource_quota_exceeded_fault => 400,
                .s3_access_denied_fault => 400,
                .s3_resource_not_found_fault => 400,
                .sns_invalid_topic_fault => 400,
                .sns_no_authorization_fault => 400,
                .storage_quota_exceeded_fault => 400,
                .subnet_already_in_use => 400,
                .upgrade_dependency_failure_fault => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_fault => |e| e.request_id,
                .collector_not_found_fault => |e| e.request_id,
                .failed_dependency_fault => |e| e.request_id,
                .insufficient_resource_capacity_fault => |e| e.request_id,
                .invalid_certificate_fault => |e| e.request_id,
                .invalid_operation_fault => |e| e.request_id,
                .invalid_resource_state_fault => |e| e.request_id,
                .invalid_subnet => |e| e.request_id,
                .kms_access_denied_fault => |e| e.request_id,
                .kms_disabled_fault => |e| e.request_id,
                .kms_fault => |e| e.request_id,
                .kms_invalid_state_fault => |e| e.request_id,
                .kms_key_not_accessible_fault => |e| e.request_id,
                .kms_not_found_fault => |e| e.request_id,
                .kms_throttling_fault => |e| e.request_id,
                .replication_subnet_group_does_not_cover_enough_a_zs => |e| e.request_id,
                .resource_already_exists_fault => |e| e.request_id,
                .resource_not_found_fault => |e| e.request_id,
                .resource_quota_exceeded_fault => |e| e.request_id,
                .s3_access_denied_fault => |e| e.request_id,
                .s3_resource_not_found_fault => |e| e.request_id,
                .sns_invalid_topic_fault => |e| e.request_id,
                .sns_no_authorization_fault => |e| e.request_id,
                .storage_quota_exceeded_fault => |e| e.request_id,
                .subnet_already_in_use => |e| e.request_id,
                .upgrade_dependency_failure_fault => |e| e.request_id,
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

pub const AccessDeniedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CollectorNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FailedDependencyFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientResourceCapacityFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCertificateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSAccessDeniedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSDisabledFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInvalidStateFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSKeyNotAccessibleFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSThrottlingFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationSubnetGroupDoesNotCoverEnoughAZs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3AccessDeniedFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3ResourceNotFoundFault = struct {
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

pub const StorageQuotaExceededFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetAlreadyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UpgradeDependencyFailureFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
