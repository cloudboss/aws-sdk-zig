const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        allocation_id_not_found_exception: AllocationIdNotFoundException,
        alpn_policy_not_supported_exception: ALPNPolicyNotSupportedException,
        availability_zone_not_supported_exception: AvailabilityZoneNotSupportedException,
        ca_certificates_bundle_not_found_exception: CaCertificatesBundleNotFoundException,
        capacity_decrease_requests_limit_exceeded_exception: CapacityDecreaseRequestsLimitExceededException,
        capacity_reservation_pending_exception: CapacityReservationPendingException,
        capacity_units_limit_exceeded_exception: CapacityUnitsLimitExceededException,
        certificate_not_found_exception: CertificateNotFoundException,
        delete_association_same_account_exception: DeleteAssociationSameAccountException,
        duplicate_listener_exception: DuplicateListenerException,
        duplicate_load_balancer_name_exception: DuplicateLoadBalancerNameException,
        duplicate_tag_keys_exception: DuplicateTagKeysException,
        duplicate_target_group_name_exception: DuplicateTargetGroupNameException,
        duplicate_trust_store_name_exception: DuplicateTrustStoreNameException,
        health_unavailable_exception: HealthUnavailableException,
        incompatible_protocols_exception: IncompatibleProtocolsException,
        insufficient_capacity_exception: InsufficientCapacityException,
        invalid_ca_certificates_bundle_exception: InvalidCaCertificatesBundleException,
        invalid_configuration_request_exception: InvalidConfigurationRequestException,
        invalid_load_balancer_action_exception: InvalidLoadBalancerActionException,
        invalid_revocation_content_exception: InvalidRevocationContentException,
        invalid_scheme_exception: InvalidSchemeException,
        invalid_security_group_exception: InvalidSecurityGroupException,
        invalid_subnet_exception: InvalidSubnetException,
        invalid_target_exception: InvalidTargetException,
        listener_not_found_exception: ListenerNotFoundException,
        load_balancer_not_found_exception: LoadBalancerNotFoundException,
        operation_not_permitted_exception: OperationNotPermittedException,
        prior_request_not_complete_exception: PriorRequestNotCompleteException,
        priority_in_use_exception: PriorityInUseException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        revocation_content_not_found_exception: RevocationContentNotFoundException,
        revocation_id_not_found_exception: RevocationIdNotFoundException,
        rule_not_found_exception: RuleNotFoundException,
        ssl_policy_not_found_exception: SSLPolicyNotFoundException,
        subnet_not_found_exception: SubnetNotFoundException,
        target_group_association_limit_exception: TargetGroupAssociationLimitException,
        target_group_not_found_exception: TargetGroupNotFoundException,
        too_many_actions_exception: TooManyActionsException,
        too_many_certificates_exception: TooManyCertificatesException,
        too_many_listeners_exception: TooManyListenersException,
        too_many_load_balancers_exception: TooManyLoadBalancersException,
        too_many_registrations_for_target_id_exception: TooManyRegistrationsForTargetIdException,
        too_many_rules_exception: TooManyRulesException,
        too_many_tags_exception: TooManyTagsException,
        too_many_target_groups_exception: TooManyTargetGroupsException,
        too_many_targets_exception: TooManyTargetsException,
        too_many_trust_store_revocation_entries_exception: TooManyTrustStoreRevocationEntriesException,
        too_many_trust_stores_exception: TooManyTrustStoresException,
        too_many_unique_target_groups_per_load_balancer_exception: TooManyUniqueTargetGroupsPerLoadBalancerException,
        trust_store_association_not_found_exception: TrustStoreAssociationNotFoundException,
        trust_store_in_use_exception: TrustStoreInUseException,
        trust_store_not_found_exception: TrustStoreNotFoundException,
        trust_store_not_ready_exception: TrustStoreNotReadyException,
        unsupported_protocol_exception: UnsupportedProtocolException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .allocation_id_not_found_exception => "AllocationIdNotFoundException",
                .alpn_policy_not_supported_exception => "ALPNPolicyNotSupportedException",
                .availability_zone_not_supported_exception => "AvailabilityZoneNotSupportedException",
                .ca_certificates_bundle_not_found_exception => "CaCertificatesBundleNotFoundException",
                .capacity_decrease_requests_limit_exceeded_exception => "CapacityDecreaseRequestsLimitExceededException",
                .capacity_reservation_pending_exception => "CapacityReservationPendingException",
                .capacity_units_limit_exceeded_exception => "CapacityUnitsLimitExceededException",
                .certificate_not_found_exception => "CertificateNotFoundException",
                .delete_association_same_account_exception => "DeleteAssociationSameAccountException",
                .duplicate_listener_exception => "DuplicateListenerException",
                .duplicate_load_balancer_name_exception => "DuplicateLoadBalancerNameException",
                .duplicate_tag_keys_exception => "DuplicateTagKeysException",
                .duplicate_target_group_name_exception => "DuplicateTargetGroupNameException",
                .duplicate_trust_store_name_exception => "DuplicateTrustStoreNameException",
                .health_unavailable_exception => "HealthUnavailableException",
                .incompatible_protocols_exception => "IncompatibleProtocolsException",
                .insufficient_capacity_exception => "InsufficientCapacityException",
                .invalid_ca_certificates_bundle_exception => "InvalidCaCertificatesBundleException",
                .invalid_configuration_request_exception => "InvalidConfigurationRequestException",
                .invalid_load_balancer_action_exception => "InvalidLoadBalancerActionException",
                .invalid_revocation_content_exception => "InvalidRevocationContentException",
                .invalid_scheme_exception => "InvalidSchemeException",
                .invalid_security_group_exception => "InvalidSecurityGroupException",
                .invalid_subnet_exception => "InvalidSubnetException",
                .invalid_target_exception => "InvalidTargetException",
                .listener_not_found_exception => "ListenerNotFoundException",
                .load_balancer_not_found_exception => "LoadBalancerNotFoundException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .prior_request_not_complete_exception => "PriorRequestNotCompleteException",
                .priority_in_use_exception => "PriorityInUseException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .revocation_content_not_found_exception => "RevocationContentNotFoundException",
                .revocation_id_not_found_exception => "RevocationIdNotFoundException",
                .rule_not_found_exception => "RuleNotFoundException",
                .ssl_policy_not_found_exception => "SSLPolicyNotFoundException",
                .subnet_not_found_exception => "SubnetNotFoundException",
                .target_group_association_limit_exception => "TargetGroupAssociationLimitException",
                .target_group_not_found_exception => "TargetGroupNotFoundException",
                .too_many_actions_exception => "TooManyActionsException",
                .too_many_certificates_exception => "TooManyCertificatesException",
                .too_many_listeners_exception => "TooManyListenersException",
                .too_many_load_balancers_exception => "TooManyLoadBalancersException",
                .too_many_registrations_for_target_id_exception => "TooManyRegistrationsForTargetIdException",
                .too_many_rules_exception => "TooManyRulesException",
                .too_many_tags_exception => "TooManyTagsException",
                .too_many_target_groups_exception => "TooManyTargetGroupsException",
                .too_many_targets_exception => "TooManyTargetsException",
                .too_many_trust_store_revocation_entries_exception => "TooManyTrustStoreRevocationEntriesException",
                .too_many_trust_stores_exception => "TooManyTrustStoresException",
                .too_many_unique_target_groups_per_load_balancer_exception => "TooManyUniqueTargetGroupsPerLoadBalancerException",
                .trust_store_association_not_found_exception => "TrustStoreAssociationNotFoundException",
                .trust_store_in_use_exception => "TrustStoreInUseException",
                .trust_store_not_found_exception => "TrustStoreNotFoundException",
                .trust_store_not_ready_exception => "TrustStoreNotReadyException",
                .unsupported_protocol_exception => "UnsupportedProtocolException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .allocation_id_not_found_exception => |e| e.message,
                .alpn_policy_not_supported_exception => |e| e.message,
                .availability_zone_not_supported_exception => |e| e.message,
                .ca_certificates_bundle_not_found_exception => |e| e.message,
                .capacity_decrease_requests_limit_exceeded_exception => |e| e.message,
                .capacity_reservation_pending_exception => |e| e.message,
                .capacity_units_limit_exceeded_exception => |e| e.message,
                .certificate_not_found_exception => |e| e.message,
                .delete_association_same_account_exception => |e| e.message,
                .duplicate_listener_exception => |e| e.message,
                .duplicate_load_balancer_name_exception => |e| e.message,
                .duplicate_tag_keys_exception => |e| e.message,
                .duplicate_target_group_name_exception => |e| e.message,
                .duplicate_trust_store_name_exception => |e| e.message,
                .health_unavailable_exception => |e| e.message,
                .incompatible_protocols_exception => |e| e.message,
                .insufficient_capacity_exception => |e| e.message,
                .invalid_ca_certificates_bundle_exception => |e| e.message,
                .invalid_configuration_request_exception => |e| e.message,
                .invalid_load_balancer_action_exception => |e| e.message,
                .invalid_revocation_content_exception => |e| e.message,
                .invalid_scheme_exception => |e| e.message,
                .invalid_security_group_exception => |e| e.message,
                .invalid_subnet_exception => |e| e.message,
                .invalid_target_exception => |e| e.message,
                .listener_not_found_exception => |e| e.message,
                .load_balancer_not_found_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .prior_request_not_complete_exception => |e| e.message,
                .priority_in_use_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .revocation_content_not_found_exception => |e| e.message,
                .revocation_id_not_found_exception => |e| e.message,
                .rule_not_found_exception => |e| e.message,
                .ssl_policy_not_found_exception => |e| e.message,
                .subnet_not_found_exception => |e| e.message,
                .target_group_association_limit_exception => |e| e.message,
                .target_group_not_found_exception => |e| e.message,
                .too_many_actions_exception => |e| e.message,
                .too_many_certificates_exception => |e| e.message,
                .too_many_listeners_exception => |e| e.message,
                .too_many_load_balancers_exception => |e| e.message,
                .too_many_registrations_for_target_id_exception => |e| e.message,
                .too_many_rules_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .too_many_target_groups_exception => |e| e.message,
                .too_many_targets_exception => |e| e.message,
                .too_many_trust_store_revocation_entries_exception => |e| e.message,
                .too_many_trust_stores_exception => |e| e.message,
                .too_many_unique_target_groups_per_load_balancer_exception => |e| e.message,
                .trust_store_association_not_found_exception => |e| e.message,
                .trust_store_in_use_exception => |e| e.message,
                .trust_store_not_found_exception => |e| e.message,
                .trust_store_not_ready_exception => |e| e.message,
                .unsupported_protocol_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .allocation_id_not_found_exception => 400,
                .alpn_policy_not_supported_exception => 400,
                .availability_zone_not_supported_exception => 400,
                .ca_certificates_bundle_not_found_exception => 400,
                .capacity_decrease_requests_limit_exceeded_exception => 400,
                .capacity_reservation_pending_exception => 400,
                .capacity_units_limit_exceeded_exception => 400,
                .certificate_not_found_exception => 400,
                .delete_association_same_account_exception => 400,
                .duplicate_listener_exception => 400,
                .duplicate_load_balancer_name_exception => 400,
                .duplicate_tag_keys_exception => 400,
                .duplicate_target_group_name_exception => 400,
                .duplicate_trust_store_name_exception => 400,
                .health_unavailable_exception => 500,
                .incompatible_protocols_exception => 400,
                .insufficient_capacity_exception => 500,
                .invalid_ca_certificates_bundle_exception => 400,
                .invalid_configuration_request_exception => 400,
                .invalid_load_balancer_action_exception => 400,
                .invalid_revocation_content_exception => 400,
                .invalid_scheme_exception => 400,
                .invalid_security_group_exception => 400,
                .invalid_subnet_exception => 400,
                .invalid_target_exception => 400,
                .listener_not_found_exception => 400,
                .load_balancer_not_found_exception => 400,
                .operation_not_permitted_exception => 400,
                .prior_request_not_complete_exception => 429,
                .priority_in_use_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .revocation_content_not_found_exception => 400,
                .revocation_id_not_found_exception => 400,
                .rule_not_found_exception => 400,
                .ssl_policy_not_found_exception => 400,
                .subnet_not_found_exception => 400,
                .target_group_association_limit_exception => 400,
                .target_group_not_found_exception => 400,
                .too_many_actions_exception => 400,
                .too_many_certificates_exception => 400,
                .too_many_listeners_exception => 400,
                .too_many_load_balancers_exception => 400,
                .too_many_registrations_for_target_id_exception => 400,
                .too_many_rules_exception => 400,
                .too_many_tags_exception => 400,
                .too_many_target_groups_exception => 400,
                .too_many_targets_exception => 400,
                .too_many_trust_store_revocation_entries_exception => 400,
                .too_many_trust_stores_exception => 400,
                .too_many_unique_target_groups_per_load_balancer_exception => 400,
                .trust_store_association_not_found_exception => 400,
                .trust_store_in_use_exception => 400,
                .trust_store_not_found_exception => 400,
                .trust_store_not_ready_exception => 400,
                .unsupported_protocol_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .allocation_id_not_found_exception => |e| e.request_id,
                .alpn_policy_not_supported_exception => |e| e.request_id,
                .availability_zone_not_supported_exception => |e| e.request_id,
                .ca_certificates_bundle_not_found_exception => |e| e.request_id,
                .capacity_decrease_requests_limit_exceeded_exception => |e| e.request_id,
                .capacity_reservation_pending_exception => |e| e.request_id,
                .capacity_units_limit_exceeded_exception => |e| e.request_id,
                .certificate_not_found_exception => |e| e.request_id,
                .delete_association_same_account_exception => |e| e.request_id,
                .duplicate_listener_exception => |e| e.request_id,
                .duplicate_load_balancer_name_exception => |e| e.request_id,
                .duplicate_tag_keys_exception => |e| e.request_id,
                .duplicate_target_group_name_exception => |e| e.request_id,
                .duplicate_trust_store_name_exception => |e| e.request_id,
                .health_unavailable_exception => |e| e.request_id,
                .incompatible_protocols_exception => |e| e.request_id,
                .insufficient_capacity_exception => |e| e.request_id,
                .invalid_ca_certificates_bundle_exception => |e| e.request_id,
                .invalid_configuration_request_exception => |e| e.request_id,
                .invalid_load_balancer_action_exception => |e| e.request_id,
                .invalid_revocation_content_exception => |e| e.request_id,
                .invalid_scheme_exception => |e| e.request_id,
                .invalid_security_group_exception => |e| e.request_id,
                .invalid_subnet_exception => |e| e.request_id,
                .invalid_target_exception => |e| e.request_id,
                .listener_not_found_exception => |e| e.request_id,
                .load_balancer_not_found_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .prior_request_not_complete_exception => |e| e.request_id,
                .priority_in_use_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .revocation_content_not_found_exception => |e| e.request_id,
                .revocation_id_not_found_exception => |e| e.request_id,
                .rule_not_found_exception => |e| e.request_id,
                .ssl_policy_not_found_exception => |e| e.request_id,
                .subnet_not_found_exception => |e| e.request_id,
                .target_group_association_limit_exception => |e| e.request_id,
                .target_group_not_found_exception => |e| e.request_id,
                .too_many_actions_exception => |e| e.request_id,
                .too_many_certificates_exception => |e| e.request_id,
                .too_many_listeners_exception => |e| e.request_id,
                .too_many_load_balancers_exception => |e| e.request_id,
                .too_many_registrations_for_target_id_exception => |e| e.request_id,
                .too_many_rules_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .too_many_target_groups_exception => |e| e.request_id,
                .too_many_targets_exception => |e| e.request_id,
                .too_many_trust_store_revocation_entries_exception => |e| e.request_id,
                .too_many_trust_stores_exception => |e| e.request_id,
                .too_many_unique_target_groups_per_load_balancer_exception => |e| e.request_id,
                .trust_store_association_not_found_exception => |e| e.request_id,
                .trust_store_in_use_exception => |e| e.request_id,
                .trust_store_not_found_exception => |e| e.request_id,
                .trust_store_not_ready_exception => |e| e.request_id,
                .unsupported_protocol_exception => |e| e.request_id,
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

pub const AllocationIdNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ALPNPolicyNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AvailabilityZoneNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CaCertificatesBundleNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CapacityDecreaseRequestsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CapacityReservationPendingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CapacityUnitsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteAssociationSameAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateListenerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateLoadBalancerNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateTagKeysException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateTargetGroupNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateTrustStoreNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HealthUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleProtocolsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientCapacityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCaCertificatesBundleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConfigurationRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLoadBalancerActionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRevocationContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSchemeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSecurityGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ListenerNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LoadBalancerNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PriorRequestNotCompleteException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PriorityInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RevocationContentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RevocationIdNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RuleNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SSLPolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetGroupAssociationLimitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetGroupNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyActionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCertificatesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyListenersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyLoadBalancersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRegistrationsForTargetIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRulesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTargetGroupsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTargetsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTrustStoreRevocationEntriesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTrustStoresException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyUniqueTargetGroupsPerLoadBalancerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrustStoreAssociationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrustStoreInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrustStoreNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrustStoreNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedProtocolException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AllocationIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .allocation_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ALPNPolicyNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .alpn_policy_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AvailabilityZoneNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .availability_zone_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CaCertificatesBundleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ca_certificates_bundle_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityDecreaseRequestsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_decrease_requests_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityReservationPendingException")) {
        return .{ .arena = arena, .kind = .{ .capacity_reservation_pending_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityUnitsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_units_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .certificate_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteAssociationSameAccountException")) {
        return .{ .arena = arena, .kind = .{ .delete_association_same_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateListenerException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_listener_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateLoadBalancerNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_load_balancer_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTargetGroupNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_target_group_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTrustStoreNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_trust_store_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .health_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleProtocolsException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_protocols_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCaCertificatesBundleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ca_certificates_bundle_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLoadBalancerActionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_load_balancer_action_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRevocationContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_revocation_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchemeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_scheme_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListenerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .listener_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LoadBalancerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .load_balancer_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorRequestNotCompleteException")) {
        return .{ .arena = arena, .kind = .{ .prior_request_not_complete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorityInUseException")) {
        return .{ .arena = arena, .kind = .{ .priority_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevocationContentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .revocation_content_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevocationIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .revocation_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .rule_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SSLPolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ssl_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetGroupAssociationLimitException")) {
        return .{ .arena = arena, .kind = .{ .target_group_association_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetGroupNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .target_group_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyActionsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_actions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCertificatesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_certificates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyListenersException")) {
        return .{ .arena = arena, .kind = .{ .too_many_listeners_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyLoadBalancersException")) {
        return .{ .arena = arena, .kind = .{ .too_many_load_balancers_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRegistrationsForTargetIdException")) {
        return .{ .arena = arena, .kind = .{ .too_many_registrations_for_target_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRulesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_rules_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTargetGroupsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_target_groups_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTargetsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_targets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustStoreRevocationEntriesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_trust_store_revocation_entries_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustStoresException")) {
        return .{ .arena = arena, .kind = .{ .too_many_trust_stores_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyUniqueTargetGroupsPerLoadBalancerException")) {
        return .{ .arena = arena, .kind = .{ .too_many_unique_target_groups_per_load_balancer_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreAssociationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_association_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreInUseException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedProtocolException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_protocol_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
