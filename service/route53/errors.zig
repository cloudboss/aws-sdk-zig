const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cidr_block_in_use_exception: CidrBlockInUseException,
        cidr_collection_already_exists_exception: CidrCollectionAlreadyExistsException,
        cidr_collection_in_use_exception: CidrCollectionInUseException,
        cidr_collection_version_mismatch_exception: CidrCollectionVersionMismatchException,
        concurrent_modification: ConcurrentModification,
        conflicting_domain_exists: ConflictingDomainExists,
        conflicting_types: ConflictingTypes,
        delegation_set_already_created: DelegationSetAlreadyCreated,
        delegation_set_already_reusable: DelegationSetAlreadyReusable,
        delegation_set_in_use: DelegationSetInUse,
        delegation_set_not_available: DelegationSetNotAvailable,
        delegation_set_not_reusable: DelegationSetNotReusable,
        dnssec_not_found: DNSSECNotFound,
        health_check_already_exists: HealthCheckAlreadyExists,
        health_check_in_use: HealthCheckInUse,
        health_check_version_mismatch: HealthCheckVersionMismatch,
        hosted_zone_already_exists: HostedZoneAlreadyExists,
        hosted_zone_not_empty: HostedZoneNotEmpty,
        hosted_zone_not_found: HostedZoneNotFound,
        hosted_zone_not_private: HostedZoneNotPrivate,
        hosted_zone_partially_delegated: HostedZonePartiallyDelegated,
        incompatible_version: IncompatibleVersion,
        insufficient_cloud_watch_logs_resource_policy: InsufficientCloudWatchLogsResourcePolicy,
        invalid_argument: InvalidArgument,
        invalid_change_batch: InvalidChangeBatch,
        invalid_domain_name: InvalidDomainName,
        invalid_input: InvalidInput,
        invalid_key_signing_key_name: InvalidKeySigningKeyName,
        invalid_key_signing_key_status: InvalidKeySigningKeyStatus,
        invalid_kms_arn: InvalidKMSArn,
        invalid_pagination_token: InvalidPaginationToken,
        invalid_signing_status: InvalidSigningStatus,
        invalid_traffic_policy_document: InvalidTrafficPolicyDocument,
        invalid_vpc_id: InvalidVPCId,
        key_signing_key_already_exists: KeySigningKeyAlreadyExists,
        key_signing_key_in_parent_ds_record: KeySigningKeyInParentDSRecord,
        key_signing_key_in_use: KeySigningKeyInUse,
        key_signing_key_with_active_status_not_found: KeySigningKeyWithActiveStatusNotFound,
        last_vpc_association: LastVPCAssociation,
        limits_exceeded: LimitsExceeded,
        no_such_change: NoSuchChange,
        no_such_cidr_collection_exception: NoSuchCidrCollectionException,
        no_such_cidr_location_exception: NoSuchCidrLocationException,
        no_such_cloud_watch_logs_log_group: NoSuchCloudWatchLogsLogGroup,
        no_such_delegation_set: NoSuchDelegationSet,
        no_such_geo_location: NoSuchGeoLocation,
        no_such_health_check: NoSuchHealthCheck,
        no_such_hosted_zone: NoSuchHostedZone,
        no_such_key_signing_key: NoSuchKeySigningKey,
        no_such_query_logging_config: NoSuchQueryLoggingConfig,
        no_such_traffic_policy: NoSuchTrafficPolicy,
        no_such_traffic_policy_instance: NoSuchTrafficPolicyInstance,
        not_authorized_exception: NotAuthorizedException,
        prior_request_not_complete: PriorRequestNotComplete,
        public_zone_vpc_association: PublicZoneVPCAssociation,
        query_logging_config_already_exists: QueryLoggingConfigAlreadyExists,
        throttling_exception: ThrottlingException,
        too_many_health_checks: TooManyHealthChecks,
        too_many_hosted_zones: TooManyHostedZones,
        too_many_key_signing_keys: TooManyKeySigningKeys,
        too_many_traffic_policies: TooManyTrafficPolicies,
        too_many_traffic_policy_instances: TooManyTrafficPolicyInstances,
        too_many_traffic_policy_versions_for_current_policy: TooManyTrafficPolicyVersionsForCurrentPolicy,
        too_many_vpc_association_authorizations: TooManyVPCAssociationAuthorizations,
        traffic_policy_already_exists: TrafficPolicyAlreadyExists,
        traffic_policy_in_use: TrafficPolicyInUse,
        traffic_policy_instance_already_exists: TrafficPolicyInstanceAlreadyExists,
        vpc_association_authorization_not_found: VPCAssociationAuthorizationNotFound,
        vpc_association_not_found: VPCAssociationNotFound,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cidr_block_in_use_exception => "CidrBlockInUseException",
                .cidr_collection_already_exists_exception => "CidrCollectionAlreadyExistsException",
                .cidr_collection_in_use_exception => "CidrCollectionInUseException",
                .cidr_collection_version_mismatch_exception => "CidrCollectionVersionMismatchException",
                .concurrent_modification => "ConcurrentModification",
                .conflicting_domain_exists => "ConflictingDomainExists",
                .conflicting_types => "ConflictingTypes",
                .delegation_set_already_created => "DelegationSetAlreadyCreated",
                .delegation_set_already_reusable => "DelegationSetAlreadyReusable",
                .delegation_set_in_use => "DelegationSetInUse",
                .delegation_set_not_available => "DelegationSetNotAvailable",
                .delegation_set_not_reusable => "DelegationSetNotReusable",
                .dnssec_not_found => "DNSSECNotFound",
                .health_check_already_exists => "HealthCheckAlreadyExists",
                .health_check_in_use => "HealthCheckInUse",
                .health_check_version_mismatch => "HealthCheckVersionMismatch",
                .hosted_zone_already_exists => "HostedZoneAlreadyExists",
                .hosted_zone_not_empty => "HostedZoneNotEmpty",
                .hosted_zone_not_found => "HostedZoneNotFound",
                .hosted_zone_not_private => "HostedZoneNotPrivate",
                .hosted_zone_partially_delegated => "HostedZonePartiallyDelegated",
                .incompatible_version => "IncompatibleVersion",
                .insufficient_cloud_watch_logs_resource_policy => "InsufficientCloudWatchLogsResourcePolicy",
                .invalid_argument => "InvalidArgument",
                .invalid_change_batch => "InvalidChangeBatch",
                .invalid_domain_name => "InvalidDomainName",
                .invalid_input => "InvalidInput",
                .invalid_key_signing_key_name => "InvalidKeySigningKeyName",
                .invalid_key_signing_key_status => "InvalidKeySigningKeyStatus",
                .invalid_kms_arn => "InvalidKMSArn",
                .invalid_pagination_token => "InvalidPaginationToken",
                .invalid_signing_status => "InvalidSigningStatus",
                .invalid_traffic_policy_document => "InvalidTrafficPolicyDocument",
                .invalid_vpc_id => "InvalidVPCId",
                .key_signing_key_already_exists => "KeySigningKeyAlreadyExists",
                .key_signing_key_in_parent_ds_record => "KeySigningKeyInParentDSRecord",
                .key_signing_key_in_use => "KeySigningKeyInUse",
                .key_signing_key_with_active_status_not_found => "KeySigningKeyWithActiveStatusNotFound",
                .last_vpc_association => "LastVPCAssociation",
                .limits_exceeded => "LimitsExceeded",
                .no_such_change => "NoSuchChange",
                .no_such_cidr_collection_exception => "NoSuchCidrCollectionException",
                .no_such_cidr_location_exception => "NoSuchCidrLocationException",
                .no_such_cloud_watch_logs_log_group => "NoSuchCloudWatchLogsLogGroup",
                .no_such_delegation_set => "NoSuchDelegationSet",
                .no_such_geo_location => "NoSuchGeoLocation",
                .no_such_health_check => "NoSuchHealthCheck",
                .no_such_hosted_zone => "NoSuchHostedZone",
                .no_such_key_signing_key => "NoSuchKeySigningKey",
                .no_such_query_logging_config => "NoSuchQueryLoggingConfig",
                .no_such_traffic_policy => "NoSuchTrafficPolicy",
                .no_such_traffic_policy_instance => "NoSuchTrafficPolicyInstance",
                .not_authorized_exception => "NotAuthorizedException",
                .prior_request_not_complete => "PriorRequestNotComplete",
                .public_zone_vpc_association => "PublicZoneVPCAssociation",
                .query_logging_config_already_exists => "QueryLoggingConfigAlreadyExists",
                .throttling_exception => "ThrottlingException",
                .too_many_health_checks => "TooManyHealthChecks",
                .too_many_hosted_zones => "TooManyHostedZones",
                .too_many_key_signing_keys => "TooManyKeySigningKeys",
                .too_many_traffic_policies => "TooManyTrafficPolicies",
                .too_many_traffic_policy_instances => "TooManyTrafficPolicyInstances",
                .too_many_traffic_policy_versions_for_current_policy => "TooManyTrafficPolicyVersionsForCurrentPolicy",
                .too_many_vpc_association_authorizations => "TooManyVPCAssociationAuthorizations",
                .traffic_policy_already_exists => "TrafficPolicyAlreadyExists",
                .traffic_policy_in_use => "TrafficPolicyInUse",
                .traffic_policy_instance_already_exists => "TrafficPolicyInstanceAlreadyExists",
                .vpc_association_authorization_not_found => "VPCAssociationAuthorizationNotFound",
                .vpc_association_not_found => "VPCAssociationNotFound",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cidr_block_in_use_exception => |e| e.message,
                .cidr_collection_already_exists_exception => |e| e.message,
                .cidr_collection_in_use_exception => |e| e.message,
                .cidr_collection_version_mismatch_exception => |e| e.message,
                .concurrent_modification => |e| e.message,
                .conflicting_domain_exists => |e| e.message,
                .conflicting_types => |e| e.message,
                .delegation_set_already_created => |e| e.message,
                .delegation_set_already_reusable => |e| e.message,
                .delegation_set_in_use => |e| e.message,
                .delegation_set_not_available => |e| e.message,
                .delegation_set_not_reusable => |e| e.message,
                .dnssec_not_found => |e| e.message,
                .health_check_already_exists => |e| e.message,
                .health_check_in_use => |e| e.message,
                .health_check_version_mismatch => |e| e.message,
                .hosted_zone_already_exists => |e| e.message,
                .hosted_zone_not_empty => |e| e.message,
                .hosted_zone_not_found => |e| e.message,
                .hosted_zone_not_private => |e| e.message,
                .hosted_zone_partially_delegated => |e| e.message,
                .incompatible_version => |e| e.message,
                .insufficient_cloud_watch_logs_resource_policy => |e| e.message,
                .invalid_argument => |e| e.message,
                .invalid_change_batch => |e| e.message,
                .invalid_domain_name => |e| e.message,
                .invalid_input => |e| e.message,
                .invalid_key_signing_key_name => |e| e.message,
                .invalid_key_signing_key_status => |e| e.message,
                .invalid_kms_arn => |e| e.message,
                .invalid_pagination_token => |e| e.message,
                .invalid_signing_status => |e| e.message,
                .invalid_traffic_policy_document => |e| e.message,
                .invalid_vpc_id => |e| e.message,
                .key_signing_key_already_exists => |e| e.message,
                .key_signing_key_in_parent_ds_record => |e| e.message,
                .key_signing_key_in_use => |e| e.message,
                .key_signing_key_with_active_status_not_found => |e| e.message,
                .last_vpc_association => |e| e.message,
                .limits_exceeded => |e| e.message,
                .no_such_change => |e| e.message,
                .no_such_cidr_collection_exception => |e| e.message,
                .no_such_cidr_location_exception => |e| e.message,
                .no_such_cloud_watch_logs_log_group => |e| e.message,
                .no_such_delegation_set => |e| e.message,
                .no_such_geo_location => |e| e.message,
                .no_such_health_check => |e| e.message,
                .no_such_hosted_zone => |e| e.message,
                .no_such_key_signing_key => |e| e.message,
                .no_such_query_logging_config => |e| e.message,
                .no_such_traffic_policy => |e| e.message,
                .no_such_traffic_policy_instance => |e| e.message,
                .not_authorized_exception => |e| e.message,
                .prior_request_not_complete => |e| e.message,
                .public_zone_vpc_association => |e| e.message,
                .query_logging_config_already_exists => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_health_checks => |e| e.message,
                .too_many_hosted_zones => |e| e.message,
                .too_many_key_signing_keys => |e| e.message,
                .too_many_traffic_policies => |e| e.message,
                .too_many_traffic_policy_instances => |e| e.message,
                .too_many_traffic_policy_versions_for_current_policy => |e| e.message,
                .too_many_vpc_association_authorizations => |e| e.message,
                .traffic_policy_already_exists => |e| e.message,
                .traffic_policy_in_use => |e| e.message,
                .traffic_policy_instance_already_exists => |e| e.message,
                .vpc_association_authorization_not_found => |e| e.message,
                .vpc_association_not_found => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cidr_block_in_use_exception => 400,
                .cidr_collection_already_exists_exception => 400,
                .cidr_collection_in_use_exception => 400,
                .cidr_collection_version_mismatch_exception => 409,
                .concurrent_modification => 400,
                .conflicting_domain_exists => 400,
                .conflicting_types => 400,
                .delegation_set_already_created => 400,
                .delegation_set_already_reusable => 400,
                .delegation_set_in_use => 400,
                .delegation_set_not_available => 400,
                .delegation_set_not_reusable => 400,
                .dnssec_not_found => 400,
                .health_check_already_exists => 409,
                .health_check_in_use => 400,
                .health_check_version_mismatch => 409,
                .hosted_zone_already_exists => 409,
                .hosted_zone_not_empty => 400,
                .hosted_zone_not_found => 400,
                .hosted_zone_not_private => 400,
                .hosted_zone_partially_delegated => 400,
                .incompatible_version => 400,
                .insufficient_cloud_watch_logs_resource_policy => 400,
                .invalid_argument => 400,
                .invalid_change_batch => 400,
                .invalid_domain_name => 400,
                .invalid_input => 400,
                .invalid_key_signing_key_name => 400,
                .invalid_key_signing_key_status => 400,
                .invalid_kms_arn => 400,
                .invalid_pagination_token => 400,
                .invalid_signing_status => 400,
                .invalid_traffic_policy_document => 400,
                .invalid_vpc_id => 400,
                .key_signing_key_already_exists => 409,
                .key_signing_key_in_parent_ds_record => 400,
                .key_signing_key_in_use => 400,
                .key_signing_key_with_active_status_not_found => 400,
                .last_vpc_association => 400,
                .limits_exceeded => 400,
                .no_such_change => 404,
                .no_such_cidr_collection_exception => 404,
                .no_such_cidr_location_exception => 404,
                .no_such_cloud_watch_logs_log_group => 404,
                .no_such_delegation_set => 400,
                .no_such_geo_location => 404,
                .no_such_health_check => 404,
                .no_such_hosted_zone => 404,
                .no_such_key_signing_key => 404,
                .no_such_query_logging_config => 404,
                .no_such_traffic_policy => 404,
                .no_such_traffic_policy_instance => 404,
                .not_authorized_exception => 401,
                .prior_request_not_complete => 400,
                .public_zone_vpc_association => 400,
                .query_logging_config_already_exists => 409,
                .throttling_exception => 400,
                .too_many_health_checks => 400,
                .too_many_hosted_zones => 400,
                .too_many_key_signing_keys => 400,
                .too_many_traffic_policies => 400,
                .too_many_traffic_policy_instances => 400,
                .too_many_traffic_policy_versions_for_current_policy => 400,
                .too_many_vpc_association_authorizations => 400,
                .traffic_policy_already_exists => 409,
                .traffic_policy_in_use => 400,
                .traffic_policy_instance_already_exists => 409,
                .vpc_association_authorization_not_found => 404,
                .vpc_association_not_found => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cidr_block_in_use_exception => |e| e.request_id,
                .cidr_collection_already_exists_exception => |e| e.request_id,
                .cidr_collection_in_use_exception => |e| e.request_id,
                .cidr_collection_version_mismatch_exception => |e| e.request_id,
                .concurrent_modification => |e| e.request_id,
                .conflicting_domain_exists => |e| e.request_id,
                .conflicting_types => |e| e.request_id,
                .delegation_set_already_created => |e| e.request_id,
                .delegation_set_already_reusable => |e| e.request_id,
                .delegation_set_in_use => |e| e.request_id,
                .delegation_set_not_available => |e| e.request_id,
                .delegation_set_not_reusable => |e| e.request_id,
                .dnssec_not_found => |e| e.request_id,
                .health_check_already_exists => |e| e.request_id,
                .health_check_in_use => |e| e.request_id,
                .health_check_version_mismatch => |e| e.request_id,
                .hosted_zone_already_exists => |e| e.request_id,
                .hosted_zone_not_empty => |e| e.request_id,
                .hosted_zone_not_found => |e| e.request_id,
                .hosted_zone_not_private => |e| e.request_id,
                .hosted_zone_partially_delegated => |e| e.request_id,
                .incompatible_version => |e| e.request_id,
                .insufficient_cloud_watch_logs_resource_policy => |e| e.request_id,
                .invalid_argument => |e| e.request_id,
                .invalid_change_batch => |e| e.request_id,
                .invalid_domain_name => |e| e.request_id,
                .invalid_input => |e| e.request_id,
                .invalid_key_signing_key_name => |e| e.request_id,
                .invalid_key_signing_key_status => |e| e.request_id,
                .invalid_kms_arn => |e| e.request_id,
                .invalid_pagination_token => |e| e.request_id,
                .invalid_signing_status => |e| e.request_id,
                .invalid_traffic_policy_document => |e| e.request_id,
                .invalid_vpc_id => |e| e.request_id,
                .key_signing_key_already_exists => |e| e.request_id,
                .key_signing_key_in_parent_ds_record => |e| e.request_id,
                .key_signing_key_in_use => |e| e.request_id,
                .key_signing_key_with_active_status_not_found => |e| e.request_id,
                .last_vpc_association => |e| e.request_id,
                .limits_exceeded => |e| e.request_id,
                .no_such_change => |e| e.request_id,
                .no_such_cidr_collection_exception => |e| e.request_id,
                .no_such_cidr_location_exception => |e| e.request_id,
                .no_such_cloud_watch_logs_log_group => |e| e.request_id,
                .no_such_delegation_set => |e| e.request_id,
                .no_such_geo_location => |e| e.request_id,
                .no_such_health_check => |e| e.request_id,
                .no_such_hosted_zone => |e| e.request_id,
                .no_such_key_signing_key => |e| e.request_id,
                .no_such_query_logging_config => |e| e.request_id,
                .no_such_traffic_policy => |e| e.request_id,
                .no_such_traffic_policy_instance => |e| e.request_id,
                .not_authorized_exception => |e| e.request_id,
                .prior_request_not_complete => |e| e.request_id,
                .public_zone_vpc_association => |e| e.request_id,
                .query_logging_config_already_exists => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_health_checks => |e| e.request_id,
                .too_many_hosted_zones => |e| e.request_id,
                .too_many_key_signing_keys => |e| e.request_id,
                .too_many_traffic_policies => |e| e.request_id,
                .too_many_traffic_policy_instances => |e| e.request_id,
                .too_many_traffic_policy_versions_for_current_policy => |e| e.request_id,
                .too_many_vpc_association_authorizations => |e| e.request_id,
                .traffic_policy_already_exists => |e| e.request_id,
                .traffic_policy_in_use => |e| e.request_id,
                .traffic_policy_instance_already_exists => |e| e.request_id,
                .vpc_association_authorization_not_found => |e| e.request_id,
                .vpc_association_not_found => |e| e.request_id,
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

pub const CidrBlockInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CidrCollectionAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CidrCollectionInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CidrCollectionVersionMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModification = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictingDomainExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictingTypes = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DelegationSetAlreadyCreated = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DelegationSetAlreadyReusable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DelegationSetInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DelegationSetNotAvailable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DelegationSetNotReusable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DNSSECNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HealthCheckAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HealthCheckInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HealthCheckVersionMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HostedZoneAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HostedZoneNotEmpty = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HostedZoneNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HostedZoneNotPrivate = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HostedZonePartiallyDelegated = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientCloudWatchLogsResourcePolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgument = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidChangeBatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDomainName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKeySigningKeyName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKeySigningKeyStatus = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKMSArn = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPaginationToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSigningStatus = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTrafficPolicyDocument = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidVPCId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeySigningKeyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeySigningKeyInParentDSRecord = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeySigningKeyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeySigningKeyWithActiveStatusNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LastVPCAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitsExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchChange = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchCidrCollectionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchCidrLocationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchCloudWatchLogsLogGroup = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchDelegationSet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchGeoLocation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchHealthCheck = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchHostedZone = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchKeySigningKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchQueryLoggingConfig = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchTrafficPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchTrafficPolicyInstance = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PriorRequestNotComplete = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PublicZoneVPCAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryLoggingConfigAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyHealthChecks = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyHostedZones = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyKeySigningKeys = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTrafficPolicies = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTrafficPolicyInstances = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTrafficPolicyVersionsForCurrentPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyVPCAssociationAuthorizations = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrafficPolicyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrafficPolicyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrafficPolicyInstanceAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VPCAssociationAuthorizationNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VPCAssociationNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
