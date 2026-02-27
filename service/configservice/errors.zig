const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        conflict_exception: ConflictException,
        conformance_pack_template_validation_exception: ConformancePackTemplateValidationException,
        idempotent_parameter_mismatch: IdempotentParameterMismatch,
        insufficient_delivery_policy_exception: InsufficientDeliveryPolicyException,
        insufficient_permissions_exception: InsufficientPermissionsException,
        invalid_configuration_recorder_name_exception: InvalidConfigurationRecorderNameException,
        invalid_delivery_channel_name_exception: InvalidDeliveryChannelNameException,
        invalid_expression_exception: InvalidExpressionException,
        invalid_limit_exception: InvalidLimitException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_recording_group_exception: InvalidRecordingGroupException,
        invalid_result_token_exception: InvalidResultTokenException,
        invalid_role_exception: InvalidRoleException,
        invalid_s3_key_prefix_exception: InvalidS3KeyPrefixException,
        invalid_s3_kms_key_arn_exception: InvalidS3KmsKeyArnException,
        invalid_sns_topic_arn_exception: InvalidSNSTopicARNException,
        invalid_time_range_exception: InvalidTimeRangeException,
        last_delivery_channel_delete_failed_exception: LastDeliveryChannelDeleteFailedException,
        limit_exceeded_exception: LimitExceededException,
        max_active_resources_exceeded_exception: MaxActiveResourcesExceededException,
        max_number_of_config_rules_exceeded_exception: MaxNumberOfConfigRulesExceededException,
        max_number_of_configuration_recorders_exceeded_exception: MaxNumberOfConfigurationRecordersExceededException,
        max_number_of_conformance_packs_exceeded_exception: MaxNumberOfConformancePacksExceededException,
        max_number_of_delivery_channels_exceeded_exception: MaxNumberOfDeliveryChannelsExceededException,
        max_number_of_organization_config_rules_exceeded_exception: MaxNumberOfOrganizationConfigRulesExceededException,
        max_number_of_organization_conformance_packs_exceeded_exception: MaxNumberOfOrganizationConformancePacksExceededException,
        max_number_of_retention_configurations_exceeded_exception: MaxNumberOfRetentionConfigurationsExceededException,
        no_available_configuration_recorder_exception: NoAvailableConfigurationRecorderException,
        no_available_delivery_channel_exception: NoAvailableDeliveryChannelException,
        no_available_organization_exception: NoAvailableOrganizationException,
        no_running_configuration_recorder_exception: NoRunningConfigurationRecorderException,
        no_such_bucket_exception: NoSuchBucketException,
        no_such_config_rule_exception: NoSuchConfigRuleException,
        no_such_config_rule_in_conformance_pack_exception: NoSuchConfigRuleInConformancePackException,
        no_such_configuration_aggregator_exception: NoSuchConfigurationAggregatorException,
        no_such_configuration_recorder_exception: NoSuchConfigurationRecorderException,
        no_such_conformance_pack_exception: NoSuchConformancePackException,
        no_such_delivery_channel_exception: NoSuchDeliveryChannelException,
        no_such_organization_config_rule_exception: NoSuchOrganizationConfigRuleException,
        no_such_organization_conformance_pack_exception: NoSuchOrganizationConformancePackException,
        no_such_remediation_configuration_exception: NoSuchRemediationConfigurationException,
        no_such_remediation_exception_exception: NoSuchRemediationExceptionException,
        no_such_retention_configuration_exception: NoSuchRetentionConfigurationException,
        organization_access_denied_exception: OrganizationAccessDeniedException,
        organization_all_features_not_enabled_exception: OrganizationAllFeaturesNotEnabledException,
        organization_conformance_pack_template_validation_exception: OrganizationConformancePackTemplateValidationException,
        oversized_configuration_item_exception: OversizedConfigurationItemException,
        remediation_in_progress_exception: RemediationInProgressException,
        resource_concurrent_modification_exception: ResourceConcurrentModificationException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_discovered_exception: ResourceNotDiscoveredException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_tags_exception: TooManyTagsException,
        unmodifiable_entity_exception: UnmodifiableEntityException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => "ConflictException",
                .conformance_pack_template_validation_exception => "ConformancePackTemplateValidationException",
                .idempotent_parameter_mismatch => "IdempotentParameterMismatch",
                .insufficient_delivery_policy_exception => "InsufficientDeliveryPolicyException",
                .insufficient_permissions_exception => "InsufficientPermissionsException",
                .invalid_configuration_recorder_name_exception => "InvalidConfigurationRecorderNameException",
                .invalid_delivery_channel_name_exception => "InvalidDeliveryChannelNameException",
                .invalid_expression_exception => "InvalidExpressionException",
                .invalid_limit_exception => "InvalidLimitException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_recording_group_exception => "InvalidRecordingGroupException",
                .invalid_result_token_exception => "InvalidResultTokenException",
                .invalid_role_exception => "InvalidRoleException",
                .invalid_s3_key_prefix_exception => "InvalidS3KeyPrefixException",
                .invalid_s3_kms_key_arn_exception => "InvalidS3KmsKeyArnException",
                .invalid_sns_topic_arn_exception => "InvalidSNSTopicARNException",
                .invalid_time_range_exception => "InvalidTimeRangeException",
                .last_delivery_channel_delete_failed_exception => "LastDeliveryChannelDeleteFailedException",
                .limit_exceeded_exception => "LimitExceededException",
                .max_active_resources_exceeded_exception => "MaxActiveResourcesExceededException",
                .max_number_of_config_rules_exceeded_exception => "MaxNumberOfConfigRulesExceededException",
                .max_number_of_configuration_recorders_exceeded_exception => "MaxNumberOfConfigurationRecordersExceededException",
                .max_number_of_conformance_packs_exceeded_exception => "MaxNumberOfConformancePacksExceededException",
                .max_number_of_delivery_channels_exceeded_exception => "MaxNumberOfDeliveryChannelsExceededException",
                .max_number_of_organization_config_rules_exceeded_exception => "MaxNumberOfOrganizationConfigRulesExceededException",
                .max_number_of_organization_conformance_packs_exceeded_exception => "MaxNumberOfOrganizationConformancePacksExceededException",
                .max_number_of_retention_configurations_exceeded_exception => "MaxNumberOfRetentionConfigurationsExceededException",
                .no_available_configuration_recorder_exception => "NoAvailableConfigurationRecorderException",
                .no_available_delivery_channel_exception => "NoAvailableDeliveryChannelException",
                .no_available_organization_exception => "NoAvailableOrganizationException",
                .no_running_configuration_recorder_exception => "NoRunningConfigurationRecorderException",
                .no_such_bucket_exception => "NoSuchBucketException",
                .no_such_config_rule_exception => "NoSuchConfigRuleException",
                .no_such_config_rule_in_conformance_pack_exception => "NoSuchConfigRuleInConformancePackException",
                .no_such_configuration_aggregator_exception => "NoSuchConfigurationAggregatorException",
                .no_such_configuration_recorder_exception => "NoSuchConfigurationRecorderException",
                .no_such_conformance_pack_exception => "NoSuchConformancePackException",
                .no_such_delivery_channel_exception => "NoSuchDeliveryChannelException",
                .no_such_organization_config_rule_exception => "NoSuchOrganizationConfigRuleException",
                .no_such_organization_conformance_pack_exception => "NoSuchOrganizationConformancePackException",
                .no_such_remediation_configuration_exception => "NoSuchRemediationConfigurationException",
                .no_such_remediation_exception_exception => "NoSuchRemediationExceptionException",
                .no_such_retention_configuration_exception => "NoSuchRetentionConfigurationException",
                .organization_access_denied_exception => "OrganizationAccessDeniedException",
                .organization_all_features_not_enabled_exception => "OrganizationAllFeaturesNotEnabledException",
                .organization_conformance_pack_template_validation_exception => "OrganizationConformancePackTemplateValidationException",
                .oversized_configuration_item_exception => "OversizedConfigurationItemException",
                .remediation_in_progress_exception => "RemediationInProgressException",
                .resource_concurrent_modification_exception => "ResourceConcurrentModificationException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_discovered_exception => "ResourceNotDiscoveredException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_tags_exception => "TooManyTagsException",
                .unmodifiable_entity_exception => "UnmodifiableEntityException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.message,
                .conformance_pack_template_validation_exception => |e| e.message,
                .idempotent_parameter_mismatch => |e| e.message,
                .insufficient_delivery_policy_exception => |e| e.message,
                .insufficient_permissions_exception => |e| e.message,
                .invalid_configuration_recorder_name_exception => |e| e.message,
                .invalid_delivery_channel_name_exception => |e| e.message,
                .invalid_expression_exception => |e| e.message,
                .invalid_limit_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_recording_group_exception => |e| e.message,
                .invalid_result_token_exception => |e| e.message,
                .invalid_role_exception => |e| e.message,
                .invalid_s3_key_prefix_exception => |e| e.message,
                .invalid_s3_kms_key_arn_exception => |e| e.message,
                .invalid_sns_topic_arn_exception => |e| e.message,
                .invalid_time_range_exception => |e| e.message,
                .last_delivery_channel_delete_failed_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .max_active_resources_exceeded_exception => |e| e.message,
                .max_number_of_config_rules_exceeded_exception => |e| e.message,
                .max_number_of_configuration_recorders_exceeded_exception => |e| e.message,
                .max_number_of_conformance_packs_exceeded_exception => |e| e.message,
                .max_number_of_delivery_channels_exceeded_exception => |e| e.message,
                .max_number_of_organization_config_rules_exceeded_exception => |e| e.message,
                .max_number_of_organization_conformance_packs_exceeded_exception => |e| e.message,
                .max_number_of_retention_configurations_exceeded_exception => |e| e.message,
                .no_available_configuration_recorder_exception => |e| e.message,
                .no_available_delivery_channel_exception => |e| e.message,
                .no_available_organization_exception => |e| e.message,
                .no_running_configuration_recorder_exception => |e| e.message,
                .no_such_bucket_exception => |e| e.message,
                .no_such_config_rule_exception => |e| e.message,
                .no_such_config_rule_in_conformance_pack_exception => |e| e.message,
                .no_such_configuration_aggregator_exception => |e| e.message,
                .no_such_configuration_recorder_exception => |e| e.message,
                .no_such_conformance_pack_exception => |e| e.message,
                .no_such_delivery_channel_exception => |e| e.message,
                .no_such_organization_config_rule_exception => |e| e.message,
                .no_such_organization_conformance_pack_exception => |e| e.message,
                .no_such_remediation_configuration_exception => |e| e.message,
                .no_such_remediation_exception_exception => |e| e.message,
                .no_such_retention_configuration_exception => |e| e.message,
                .organization_access_denied_exception => |e| e.message,
                .organization_all_features_not_enabled_exception => |e| e.message,
                .organization_conformance_pack_template_validation_exception => |e| e.message,
                .oversized_configuration_item_exception => |e| e.message,
                .remediation_in_progress_exception => |e| e.message,
                .resource_concurrent_modification_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_discovered_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unmodifiable_entity_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .conflict_exception => 400,
                .conformance_pack_template_validation_exception => 400,
                .idempotent_parameter_mismatch => 400,
                .insufficient_delivery_policy_exception => 400,
                .insufficient_permissions_exception => 400,
                .invalid_configuration_recorder_name_exception => 400,
                .invalid_delivery_channel_name_exception => 400,
                .invalid_expression_exception => 400,
                .invalid_limit_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_recording_group_exception => 400,
                .invalid_result_token_exception => 400,
                .invalid_role_exception => 400,
                .invalid_s3_key_prefix_exception => 400,
                .invalid_s3_kms_key_arn_exception => 400,
                .invalid_sns_topic_arn_exception => 400,
                .invalid_time_range_exception => 400,
                .last_delivery_channel_delete_failed_exception => 400,
                .limit_exceeded_exception => 400,
                .max_active_resources_exceeded_exception => 400,
                .max_number_of_config_rules_exceeded_exception => 400,
                .max_number_of_configuration_recorders_exceeded_exception => 400,
                .max_number_of_conformance_packs_exceeded_exception => 400,
                .max_number_of_delivery_channels_exceeded_exception => 400,
                .max_number_of_organization_config_rules_exceeded_exception => 400,
                .max_number_of_organization_conformance_packs_exceeded_exception => 400,
                .max_number_of_retention_configurations_exceeded_exception => 400,
                .no_available_configuration_recorder_exception => 400,
                .no_available_delivery_channel_exception => 400,
                .no_available_organization_exception => 400,
                .no_running_configuration_recorder_exception => 400,
                .no_such_bucket_exception => 400,
                .no_such_config_rule_exception => 400,
                .no_such_config_rule_in_conformance_pack_exception => 400,
                .no_such_configuration_aggregator_exception => 400,
                .no_such_configuration_recorder_exception => 400,
                .no_such_conformance_pack_exception => 400,
                .no_such_delivery_channel_exception => 400,
                .no_such_organization_config_rule_exception => 400,
                .no_such_organization_conformance_pack_exception => 400,
                .no_such_remediation_configuration_exception => 400,
                .no_such_remediation_exception_exception => 400,
                .no_such_retention_configuration_exception => 400,
                .organization_access_denied_exception => 400,
                .organization_all_features_not_enabled_exception => 400,
                .organization_conformance_pack_template_validation_exception => 400,
                .oversized_configuration_item_exception => 400,
                .remediation_in_progress_exception => 400,
                .resource_concurrent_modification_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_discovered_exception => 400,
                .resource_not_found_exception => 400,
                .too_many_tags_exception => 400,
                .unmodifiable_entity_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.request_id,
                .conformance_pack_template_validation_exception => |e| e.request_id,
                .idempotent_parameter_mismatch => |e| e.request_id,
                .insufficient_delivery_policy_exception => |e| e.request_id,
                .insufficient_permissions_exception => |e| e.request_id,
                .invalid_configuration_recorder_name_exception => |e| e.request_id,
                .invalid_delivery_channel_name_exception => |e| e.request_id,
                .invalid_expression_exception => |e| e.request_id,
                .invalid_limit_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_recording_group_exception => |e| e.request_id,
                .invalid_result_token_exception => |e| e.request_id,
                .invalid_role_exception => |e| e.request_id,
                .invalid_s3_key_prefix_exception => |e| e.request_id,
                .invalid_s3_kms_key_arn_exception => |e| e.request_id,
                .invalid_sns_topic_arn_exception => |e| e.request_id,
                .invalid_time_range_exception => |e| e.request_id,
                .last_delivery_channel_delete_failed_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .max_active_resources_exceeded_exception => |e| e.request_id,
                .max_number_of_config_rules_exceeded_exception => |e| e.request_id,
                .max_number_of_configuration_recorders_exceeded_exception => |e| e.request_id,
                .max_number_of_conformance_packs_exceeded_exception => |e| e.request_id,
                .max_number_of_delivery_channels_exceeded_exception => |e| e.request_id,
                .max_number_of_organization_config_rules_exceeded_exception => |e| e.request_id,
                .max_number_of_organization_conformance_packs_exceeded_exception => |e| e.request_id,
                .max_number_of_retention_configurations_exceeded_exception => |e| e.request_id,
                .no_available_configuration_recorder_exception => |e| e.request_id,
                .no_available_delivery_channel_exception => |e| e.request_id,
                .no_available_organization_exception => |e| e.request_id,
                .no_running_configuration_recorder_exception => |e| e.request_id,
                .no_such_bucket_exception => |e| e.request_id,
                .no_such_config_rule_exception => |e| e.request_id,
                .no_such_config_rule_in_conformance_pack_exception => |e| e.request_id,
                .no_such_configuration_aggregator_exception => |e| e.request_id,
                .no_such_configuration_recorder_exception => |e| e.request_id,
                .no_such_conformance_pack_exception => |e| e.request_id,
                .no_such_delivery_channel_exception => |e| e.request_id,
                .no_such_organization_config_rule_exception => |e| e.request_id,
                .no_such_organization_conformance_pack_exception => |e| e.request_id,
                .no_such_remediation_configuration_exception => |e| e.request_id,
                .no_such_remediation_exception_exception => |e| e.request_id,
                .no_such_retention_configuration_exception => |e| e.request_id,
                .organization_access_denied_exception => |e| e.request_id,
                .organization_all_features_not_enabled_exception => |e| e.request_id,
                .organization_conformance_pack_template_validation_exception => |e| e.request_id,
                .oversized_configuration_item_exception => |e| e.request_id,
                .remediation_in_progress_exception => |e| e.request_id,
                .resource_concurrent_modification_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_discovered_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unmodifiable_entity_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConformancePackTemplateValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientDeliveryPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientPermissionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConfigurationRecorderNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeliveryChannelNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExpressionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLimitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRecordingGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResultTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3KeyPrefixException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3KmsKeyArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSNSTopicARNException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTimeRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LastDeliveryChannelDeleteFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxActiveResourcesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfConfigRulesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfConfigurationRecordersExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfConformancePacksExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfDeliveryChannelsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfOrganizationConfigRulesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfOrganizationConformancePacksExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxNumberOfRetentionConfigurationsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoAvailableConfigurationRecorderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoAvailableDeliveryChannelException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoAvailableOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoRunningConfigurationRecorderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchBucketException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchConfigRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchConfigRuleInConformancePackException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchConfigurationAggregatorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchConfigurationRecorderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchConformancePackException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchDeliveryChannelException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchOrganizationConfigRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchOrganizationConformancePackException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchRemediationConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchRemediationExceptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchRetentionConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationAllFeaturesNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationConformancePackTemplateValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OversizedConfigurationItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RemediationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotDiscoveredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnmodifiableEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
