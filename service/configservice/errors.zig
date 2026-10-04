const aws = @import("aws");
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

/// For
/// [PutServiceLinkedConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_PutServiceLinkedConfigurationRecorder.html), you cannot create a service-linked recorder because a service-linked recorder already exists for the specified service.
///
/// For
/// [DeleteServiceLinkedConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_DeleteServiceLinkedConfigurationRecorder.html), you cannot delete the service-linked recorder because it is currently in use by the linked Amazon Web Services service.
///
/// For
/// [DeleteDeliveryChannel](https://docs.aws.amazon.com/config/latest/APIReference/API_DeleteDeliveryChannel.html), you cannot delete the specified delivery channel because the customer managed configuration recorder is running. Use the [StopConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_StopConfigurationRecorder.html) operation to stop the customer managed configuration
/// recorder.
///
/// For
/// [AssociateResourceTypes](https://docs.aws.amazon.com/config/latest/APIReference/API_AssociateResourceTypes.html) and [DisassociateResourceTypes](https://docs.aws.amazon.com/config/latest/APIReference/API_DisassociateResourceTypes.html), one of the following errors:
///
/// * For service-linked configuration recorders, the configuration recorder is
///   not in use by the service. No association or dissociation of resource
///   types is permitted.
///
/// * For service-linked configuration recorders, your requested change to the
///   configuration recorder has been denied by its linked Amazon Web Services
///   service.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a template that is not valid or supported.
pub const ConformancePackTemplateValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Using the same client token with one or more different parameters. Specify a
/// new client token with the parameter changes and try again.
pub const IdempotentParameterMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your Amazon S3 bucket policy does not allow Config to
/// write to it.
pub const InsufficientDeliveryPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Indicates one of the following errors:
///
/// * For
///   [PutConfigRule](https://docs.aws.amazon.com/config/latest/APIReference/API_PutConfigRule.html), the rule cannot be created because the IAM role assigned to Config lacks permissions to perform the config:Put* action.
///
/// * For
///   [PutConfigRule](https://docs.aws.amazon.com/config/latest/APIReference/API_PutConfigRule.html), the Lambda function cannot be invoked. Check the function ARN, and check the function's permissions.
///
/// * For
///   [PutOrganizationConfigRule](https://docs.aws.amazon.com/config/latest/APIReference/API_PutOrganizationConfigRule.html), organization Config rule cannot be created because you do not have permissions to call IAM `GetRole` action or create a service-linked role.
///
/// * For
///   [PutConformancePack](https://docs.aws.amazon.com/config/latest/APIReference/API_PutConformancePack.html) and [PutOrganizationConformancePack](https://docs.aws.amazon.com/config/latest/APIReference/API_PutOrganizationConformancePack.html), a conformance pack cannot be created because you do not have the following permissions:
///
/// * You do not have permission to call IAM `GetRole` action or create a
///   service-linked role.
///
/// * You do not have permission to read Amazon S3 bucket or call
///   SSM:GetDocument.
///
/// * For
///   [PutServiceLinkedConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_PutServiceLinkedConfigurationRecorder.html), a service-linked configuration recorder cannot be created because you do not have the following permissions: IAM `CreateServiceLinkedRole`.
pub const InsufficientPermissionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The configuration recorder name is not valid. The prefix
/// "`AWSConfigurationRecorderFor`" is reserved for service-linked configuration
/// recorders.
pub const InvalidConfigurationRecorderNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified delivery channel name is not valid.
pub const InvalidDeliveryChannelNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The syntax of the query is incorrect.
pub const InvalidExpressionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified limit is outside the allowable range.
pub const InvalidLimitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified next token is not valid. Specify the
/// `nextToken` string that was returned in the previous
/// response to get the next page of results.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more of the specified parameters are not valid. Verify
/// that your parameters are valid and try again.
pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One of the following errors:
///
/// * You have provided a combination of parameter values that is not valid. For
///   example:
///
/// * Setting the `allSupported` field of
///   [RecordingGroup](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html) to `true`,
/// but providing a non-empty list for the `resourceTypes`field of
/// [RecordingGroup](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html).
///
/// * Setting the `allSupported` field of
///   [RecordingGroup](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html) to `true`, but also setting the `useOnly` field of [RecordingStrategy](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html) to `EXCLUSION_BY_RESOURCE_TYPES`.
///
/// * Every parameter is either null, false, or empty.
///
/// * You have reached the limit of the number of resource types you can provide
///   for the recording group.
///
/// * You have provided resource types or a recording strategy that are not
///   valid.
pub const InvalidRecordingGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified `ResultToken` is not valid.
pub const InvalidResultTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have provided a null or empty Amazon Resource Name (ARN) for the IAM
/// role assumed by Config and used by the customer managed configuration
/// recorder.
pub const InvalidRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon S3 key prefix is not valid.
pub const InvalidS3KeyPrefixException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon KMS Key ARN is not valid.
pub const InvalidS3KmsKeyArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon SNS topic does not exist.
pub const InvalidSNSTopicARNException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified time range is not valid. The earlier time is not
/// chronologically before the later time.
pub const InvalidTimeRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You cannot delete the delivery channel you specified because the customer
/// managed configuration recorder is running.
pub const LastDeliveryChannelDeleteFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// For `PutServiceLinkedConfigurationRecorder` API, this exception
/// is thrown if the number of service-linked roles in the account exceeds the
/// limit.
///
/// For `StartConfigRulesEvaluation` API, this exception
/// is thrown if an evaluation is in progress or if you call the
/// StartConfigRulesEvaluation API more than once per
/// minute.
///
/// For `PutConfigurationAggregator` API, this exception
/// is thrown if the number of accounts and aggregators exceeds the
/// limit.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of active custom resource types in your account.
/// There is a limit of 100,000.
/// Delete unused resources using
/// [DeleteResourceConfig](https://docs.aws.amazon.com/config/latest/APIReference/API_DeleteResourceConfig.html)
/// ``.
pub const MaxActiveResourcesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Failed to add the Config rule because the account already
/// contains the maximum number of 1000 rules. Consider deleting any
/// deactivated rules before you add new rules.
pub const MaxNumberOfConfigRulesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of the number of configuration recorders you can
/// create.
pub const MaxNumberOfConfigurationRecordersExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of the number of conformance packs you can create
/// in an account. For more information, see [
/// **Service Limits**
/// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
pub const MaxNumberOfConformancePacksExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of the number of delivery channels
/// you can create.
pub const MaxNumberOfDeliveryChannelsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of the number of organization Config rules you
/// can create. For more information, see see [
/// **Service Limits**
/// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
pub const MaxNumberOfOrganizationConfigRulesExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of the number of organization conformance packs
/// you can create in an account. For more information, see [
/// **Service Limits**
/// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
pub const MaxNumberOfOrganizationConformancePacksExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Failed to add the retention configuration because a retention configuration
/// with that name already exists.
pub const MaxNumberOfRetentionConfigurationsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There are no customer managed configuration recorders available to record
/// your resources. Use the
/// [PutConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_PutConfigurationRecorder.html) operation to create the customer managed configuration
/// recorder.
pub const NoAvailableConfigurationRecorderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There is no delivery channel available to record
/// configurations.
pub const NoAvailableDeliveryChannelException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Organization is no longer available.
pub const NoAvailableOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There is no configuration recorder running.
pub const NoRunningConfigurationRecorderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon S3 bucket does not exist.
pub const NoSuchBucketException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Config rule in the request is not valid. Verify that the rule is an
/// Config Process Check rule, that the rule name is correct, and that valid
/// Amazon Resouce Names (ARNs) are used before trying again.
pub const NoSuchConfigRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Config rule that you passed in the filter does not exist.
pub const NoSuchConfigRuleInConformancePackException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a configuration aggregator that does not exist.
pub const NoSuchConfigurationAggregatorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a configuration recorder that does not
/// exist.
pub const NoSuchConfigurationRecorderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You specified one or more conformance packs that do not exist.
pub const NoSuchConformancePackException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a delivery channel that does not
/// exist.
pub const NoSuchDeliveryChannelException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Config rule in the request is not valid. Verify that the rule is an
/// organization Config Process Check rule, that the rule name is correct, and
/// that valid Amazon Resouce Names (ARNs) are used before trying again.
pub const NoSuchOrganizationConfigRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Config organization conformance pack that you passed in the filter does not
/// exist.
///
/// For DeleteOrganizationConformancePack, you tried to delete an organization
/// conformance pack that does not exist.
pub const NoSuchOrganizationConformancePackException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You specified an Config rule without a remediation configuration.
pub const NoSuchRemediationConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You tried to delete a remediation exception that does not exist.
pub const NoSuchRemediationExceptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a retention configuration that does not exist.
pub const NoSuchRetentionConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// For `PutConfigurationAggregator` API, you can see this exception for the
/// following reasons:
///
/// * No permission to call `EnableAWSServiceAccess` API
///
/// * The configuration aggregator cannot be updated because your Amazon Web
///   Services Organization management account or the delegated administrator
///   role changed.
/// Delete this aggregator and create a new one with the current Amazon Web
/// Services Organization.
///
/// * The configuration aggregator is associated with a previous Amazon Web
///   Services Organization and Config cannot aggregate data with current Amazon
///   Web Services Organization.
/// Delete this aggregator and create a new one with the current Amazon Web
/// Services Organization.
///
/// * You are not a registered delegated administrator for Config with
///   permissions to call `ListDelegatedAdministrators` API.
/// Ensure that the management account registers delagated administrator for
/// Config service principal name before the delegated administrator creates an
/// aggregator.
///
/// For all `OrganizationConfigRule` and `OrganizationConformancePack` APIs,
/// Config throws an exception if APIs are called from member accounts. All APIs
/// must be called from organization management account.
pub const OrganizationAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Config resource cannot be created because your organization does not have
/// all features enabled.
pub const OrganizationAllFeaturesNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a template that is not valid or supported.
pub const OrganizationConformancePackTemplateValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The configuration item size is outside the allowable range.
pub const OversizedConfigurationItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Remediation action is in progress. You can either cancel execution in Amazon
/// Web Services Systems Manager or wait and try again later.
pub const RemediationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Two users are trying to modify the same query at the same time. Wait for a
/// moment and try again.
pub const ResourceConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You see this exception in the following cases:
///
/// * For DeleteConfigRule, Config is deleting this rule. Try your request again
///   later.
///
/// * For DeleteConfigRule, the rule is deleting your evaluation results. Try
///   your request again later.
///
/// * For DeleteConfigRule, a remediation action is associated with the rule and
///   Config cannot delete this rule. Delete the remediation action associated
///   with the rule before deleting the rule and try your request again later.
///
/// * For PutConfigOrganizationRule, organization Config rule deletion is in
///   progress. Try your request again later.
///
/// * For DeleteOrganizationConfigRule, organization Config rule creation is in
///   progress. Try your request again later.
///
/// * For PutConformancePack and PutOrganizationConformancePack, a conformance
///   pack creation, update, and deletion is in progress. Try your request again
///   later.
///
/// * For DeleteConformancePack, a conformance pack creation, update, and
///   deletion is in progress. Try your request again later.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a resource that is either unknown or has not
/// been discovered.
pub const ResourceNotDiscoveredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have specified a resource that does not exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit of the number of tags you can use.
/// For more information, see [
/// **Service Limits**
/// ](https://docs.aws.amazon.com/config/latest/developerguide/configlimits.html) in the *Config Developer Guide*.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested operation is not valid.
///
/// For
/// [PutConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_PutConfigurationRecorder.html),
/// you will see this exception because you cannot use this operation to create
/// a service-linked configuration recorder. Use the
/// [PutServiceLinkedConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_PutServiceLinkedConfigurationRecorder.html) operation to create a service-linked configuration
/// recorder.
///
/// For
/// [DeleteConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_DeleteConfigurationRecorder.html), you will see this exception because you cannot use this operation to delete a service-linked configuration recorder. Use the [DeleteServiceLinkedConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_DeleteServiceLinkedConfigurationRecorder.html) operation to delete a service-linked configuration
/// recorder.
///
/// For
/// [StartConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_StartConfigurationRecorder.html) and [StopConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_StopConfigurationRecorder.html), you will see this exception because these operations do not affect service-linked configuration recorders.
/// Service-linked configuration recorders are always recording. To stop
/// recording, you must delete the service-linked configuration recorder. Use
/// the
/// [DeleteServiceLinkedConfigurationRecorder](https://docs.aws.amazon.com/config/latest/APIReference/API_DeleteServiceLinkedConfigurationRecorder.html) operation to delete a service-linked configuration
/// recorder.
pub const UnmodifiableEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested operation is not valid. You will see this exception if there
/// are missing required fields or if the input value fails the validation.
///
/// For
/// [PutStoredQuery](https://docs.aws.amazon.com/config/latest/APIReference/API_PutStoredQuery.html), one of the following errors:
///
/// * There are missing required fields.
///
/// * The input value fails the validation.
///
/// * You are trying to create more than 300 queries.
///
/// For
/// [DescribeConfigurationRecorders](https://docs.aws.amazon.com/config/latest/APIReference/API_DescribeConfigurationRecorders.html) and [DescribeConfigurationRecorderStatus](https://docs.aws.amazon.com/config/latest/APIReference/API_DescribeConfigurationRecorderStatus.html), one of the following errors:
///
/// * You have specified more than one configuration recorder.
///
/// * You have provided a service principal for service-linked configuration
///   recorder that is not valid.
///
/// For
/// [AssociateResourceTypes](https://docs.aws.amazon.com/config/latest/APIReference/API_AssociateResourceTypes.html) and [DisassociateResourceTypes](https://docs.aws.amazon.com/config/latest/APIReference/API_DisassociateResourceTypes.html), one of the following errors:
///
/// * Your configuraiton recorder has a recording strategy that does not allow
///   the association or disassociation of resource types.
///
/// * One or more of the specified resource types are already associated or
///   disassociated with the configuration recorder.
///
/// * For service-linked configuration recorders, the configuration recorder
///   does not record one or more of the specified resource types.
pub const ValidationException = struct {
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?ConflictException = aws.json.parseJsonObject(ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConformancePackTemplateValidationException")) {
        const parsed_error: ?ConformancePackTemplateValidationException = aws.json.parseJsonObject(ConformancePackTemplateValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conformance_pack_template_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        const parsed_error: ?IdempotentParameterMismatch = aws.json.parseJsonObject(IdempotentParameterMismatch, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientDeliveryPolicyException")) {
        const parsed_error: ?InsufficientDeliveryPolicyException = aws.json.parseJsonObject(InsufficientDeliveryPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_delivery_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientPermissionsException")) {
        const parsed_error: ?InsufficientPermissionsException = aws.json.parseJsonObject(InsufficientPermissionsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_permissions_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRecorderNameException")) {
        const parsed_error: ?InvalidConfigurationRecorderNameException = aws.json.parseJsonObject(InvalidConfigurationRecorderNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_configuration_recorder_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeliveryChannelNameException")) {
        const parsed_error: ?InvalidDeliveryChannelNameException = aws.json.parseJsonObject(InvalidDeliveryChannelNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_delivery_channel_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExpressionException")) {
        const parsed_error: ?InvalidExpressionException = aws.json.parseJsonObject(InvalidExpressionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_expression_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLimitException")) {
        const parsed_error: ?InvalidLimitException = aws.json.parseJsonObject(InvalidLimitException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_limit_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?InvalidNextTokenException = aws.json.parseJsonObject(InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidRecordingGroupException")) {
        const parsed_error: ?InvalidRecordingGroupException = aws.json.parseJsonObject(InvalidRecordingGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_recording_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResultTokenException")) {
        const parsed_error: ?InvalidResultTokenException = aws.json.parseJsonObject(InvalidResultTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_result_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        const parsed_error: ?InvalidRoleException = aws.json.parseJsonObject(InvalidRoleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyPrefixException")) {
        const parsed_error: ?InvalidS3KeyPrefixException = aws.json.parseJsonObject(InvalidS3KeyPrefixException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_s3_key_prefix_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KmsKeyArnException")) {
        const parsed_error: ?InvalidS3KmsKeyArnException = aws.json.parseJsonObject(InvalidS3KmsKeyArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_s3_kms_key_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSNSTopicARNException")) {
        const parsed_error: ?InvalidSNSTopicARNException = aws.json.parseJsonObject(InvalidSNSTopicARNException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sns_topic_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTimeRangeException")) {
        const parsed_error: ?InvalidTimeRangeException = aws.json.parseJsonObject(InvalidTimeRangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_time_range_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LastDeliveryChannelDeleteFailedException")) {
        const parsed_error: ?LastDeliveryChannelDeleteFailedException = aws.json.parseJsonObject(LastDeliveryChannelDeleteFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .last_delivery_channel_delete_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?LimitExceededException = aws.json.parseJsonObject(LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxActiveResourcesExceededException")) {
        const parsed_error: ?MaxActiveResourcesExceededException = aws.json.parseJsonObject(MaxActiveResourcesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_active_resources_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConfigRulesExceededException")) {
        const parsed_error: ?MaxNumberOfConfigRulesExceededException = aws.json.parseJsonObject(MaxNumberOfConfigRulesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_config_rules_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConfigurationRecordersExceededException")) {
        const parsed_error: ?MaxNumberOfConfigurationRecordersExceededException = aws.json.parseJsonObject(MaxNumberOfConfigurationRecordersExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_configuration_recorders_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConformancePacksExceededException")) {
        const parsed_error: ?MaxNumberOfConformancePacksExceededException = aws.json.parseJsonObject(MaxNumberOfConformancePacksExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_conformance_packs_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfDeliveryChannelsExceededException")) {
        const parsed_error: ?MaxNumberOfDeliveryChannelsExceededException = aws.json.parseJsonObject(MaxNumberOfDeliveryChannelsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_delivery_channels_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfOrganizationConfigRulesExceededException")) {
        const parsed_error: ?MaxNumberOfOrganizationConfigRulesExceededException = aws.json.parseJsonObject(MaxNumberOfOrganizationConfigRulesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_organization_config_rules_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfOrganizationConformancePacksExceededException")) {
        const parsed_error: ?MaxNumberOfOrganizationConformancePacksExceededException = aws.json.parseJsonObject(MaxNumberOfOrganizationConformancePacksExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_organization_conformance_packs_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfRetentionConfigurationsExceededException")) {
        const parsed_error: ?MaxNumberOfRetentionConfigurationsExceededException = aws.json.parseJsonObject(MaxNumberOfRetentionConfigurationsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_retention_configurations_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableConfigurationRecorderException")) {
        const parsed_error: ?NoAvailableConfigurationRecorderException = aws.json.parseJsonObject(NoAvailableConfigurationRecorderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_configuration_recorder_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableDeliveryChannelException")) {
        const parsed_error: ?NoAvailableDeliveryChannelException = aws.json.parseJsonObject(NoAvailableDeliveryChannelException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_delivery_channel_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableOrganizationException")) {
        const parsed_error: ?NoAvailableOrganizationException = aws.json.parseJsonObject(NoAvailableOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoRunningConfigurationRecorderException")) {
        const parsed_error: ?NoRunningConfigurationRecorderException = aws.json.parseJsonObject(NoRunningConfigurationRecorderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_running_configuration_recorder_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucketException")) {
        const parsed_error: ?NoSuchBucketException = aws.json.parseJsonObject(NoSuchBucketException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_bucket_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigRuleException")) {
        const parsed_error: ?NoSuchConfigRuleException = aws.json.parseJsonObject(NoSuchConfigRuleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_config_rule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigRuleInConformancePackException")) {
        const parsed_error: ?NoSuchConfigRuleInConformancePackException = aws.json.parseJsonObject(NoSuchConfigRuleInConformancePackException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_config_rule_in_conformance_pack_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigurationAggregatorException")) {
        const parsed_error: ?NoSuchConfigurationAggregatorException = aws.json.parseJsonObject(NoSuchConfigurationAggregatorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_configuration_aggregator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigurationRecorderException")) {
        const parsed_error: ?NoSuchConfigurationRecorderException = aws.json.parseJsonObject(NoSuchConfigurationRecorderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_configuration_recorder_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConformancePackException")) {
        const parsed_error: ?NoSuchConformancePackException = aws.json.parseJsonObject(NoSuchConformancePackException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_conformance_pack_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchDeliveryChannelException")) {
        const parsed_error: ?NoSuchDeliveryChannelException = aws.json.parseJsonObject(NoSuchDeliveryChannelException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_delivery_channel_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrganizationConfigRuleException")) {
        const parsed_error: ?NoSuchOrganizationConfigRuleException = aws.json.parseJsonObject(NoSuchOrganizationConfigRuleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_organization_config_rule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrganizationConformancePackException")) {
        const parsed_error: ?NoSuchOrganizationConformancePackException = aws.json.parseJsonObject(NoSuchOrganizationConformancePackException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_organization_conformance_pack_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchRemediationConfigurationException")) {
        const parsed_error: ?NoSuchRemediationConfigurationException = aws.json.parseJsonObject(NoSuchRemediationConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_remediation_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchRemediationExceptionException")) {
        const parsed_error: ?NoSuchRemediationExceptionException = aws.json.parseJsonObject(NoSuchRemediationExceptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_remediation_exception_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchRetentionConfigurationException")) {
        const parsed_error: ?NoSuchRetentionConfigurationException = aws.json.parseJsonObject(NoSuchRetentionConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_retention_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationAccessDeniedException")) {
        const parsed_error: ?OrganizationAccessDeniedException = aws.json.parseJsonObject(OrganizationAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationAllFeaturesNotEnabledException")) {
        const parsed_error: ?OrganizationAllFeaturesNotEnabledException = aws.json.parseJsonObject(OrganizationAllFeaturesNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_all_features_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationConformancePackTemplateValidationException")) {
        const parsed_error: ?OrganizationConformancePackTemplateValidationException = aws.json.parseJsonObject(OrganizationConformancePackTemplateValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_conformance_pack_template_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OversizedConfigurationItemException")) {
        const parsed_error: ?OversizedConfigurationItemException = aws.json.parseJsonObject(OversizedConfigurationItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .oversized_configuration_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RemediationInProgressException")) {
        const parsed_error: ?RemediationInProgressException = aws.json.parseJsonObject(RemediationInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .remediation_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceConcurrentModificationException")) {
        const parsed_error: ?ResourceConcurrentModificationException = aws.json.parseJsonObject(ResourceConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?ResourceInUseException = aws.json.parseJsonObject(ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotDiscoveredException")) {
        const parsed_error: ?ResourceNotDiscoveredException = aws.json.parseJsonObject(ResourceNotDiscoveredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_discovered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?ResourceNotFoundException = aws.json.parseJsonObject(ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?TooManyTagsException = aws.json.parseJsonObject(TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnmodifiableEntityException")) {
        const parsed_error: ?UnmodifiableEntityException = aws.json.parseJsonObject(UnmodifiableEntityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unmodifiable_entity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?ValidationException = aws.json.parseJsonObject(ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
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
