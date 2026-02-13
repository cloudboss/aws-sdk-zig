const std = @import("std");

pub const ServiceError = union(enum) {
    access_denied_exception: AccessDeniedException,
    already_exists_exception: AlreadyExistsException,
    associated_instances: AssociatedInstances,
    association_already_exists: AssociationAlreadyExists,
    association_does_not_exist: AssociationDoesNotExist,
    association_execution_does_not_exist: AssociationExecutionDoesNotExist,
    association_limit_exceeded: AssociationLimitExceeded,
    association_version_limit_exceeded: AssociationVersionLimitExceeded,
    automation_definition_not_approved_exception: AutomationDefinitionNotApprovedException,
    automation_definition_not_found_exception: AutomationDefinitionNotFoundException,
    automation_definition_version_not_found_exception: AutomationDefinitionVersionNotFoundException,
    automation_execution_limit_exceeded_exception: AutomationExecutionLimitExceededException,
    automation_execution_not_found_exception: AutomationExecutionNotFoundException,
    automation_step_not_found_exception: AutomationStepNotFoundException,
    compliance_type_count_limit_exceeded_exception: ComplianceTypeCountLimitExceededException,
    custom_schema_count_limit_exceeded_exception: CustomSchemaCountLimitExceededException,
    document_already_exists: DocumentAlreadyExists,
    document_limit_exceeded: DocumentLimitExceeded,
    document_permission_limit: DocumentPermissionLimit,
    document_version_limit_exceeded: DocumentVersionLimitExceeded,
    does_not_exist_exception: DoesNotExistException,
    duplicate_document_content: DuplicateDocumentContent,
    duplicate_document_version_name: DuplicateDocumentVersionName,
    duplicate_instance_id: DuplicateInstanceId,
    feature_not_available_exception: FeatureNotAvailableException,
    hierarchy_level_limit_exceeded_exception: HierarchyLevelLimitExceededException,
    hierarchy_type_mismatch_exception: HierarchyTypeMismatchException,
    idempotent_parameter_mismatch: IdempotentParameterMismatch,
    incompatible_policy_exception: IncompatiblePolicyException,
    internal_server_error: InternalServerError,
    invalid_activation: InvalidActivation,
    invalid_activation_id: InvalidActivationId,
    invalid_aggregator_exception: InvalidAggregatorException,
    invalid_allowed_pattern_exception: InvalidAllowedPatternException,
    invalid_association: InvalidAssociation,
    invalid_association_version: InvalidAssociationVersion,
    invalid_automation_execution_parameters_exception: InvalidAutomationExecutionParametersException,
    invalid_automation_signal_exception: InvalidAutomationSignalException,
    invalid_automation_status_update_exception: InvalidAutomationStatusUpdateException,
    invalid_command_id: InvalidCommandId,
    invalid_delete_inventory_parameters_exception: InvalidDeleteInventoryParametersException,
    invalid_deletion_id_exception: InvalidDeletionIdException,
    invalid_document: InvalidDocument,
    invalid_document_content: InvalidDocumentContent,
    invalid_document_operation: InvalidDocumentOperation,
    invalid_document_schema_version: InvalidDocumentSchemaVersion,
    invalid_document_type: InvalidDocumentType,
    invalid_document_version: InvalidDocumentVersion,
    invalid_filter: InvalidFilter,
    invalid_filter_key: InvalidFilterKey,
    invalid_filter_option: InvalidFilterOption,
    invalid_filter_value: InvalidFilterValue,
    invalid_instance_id: InvalidInstanceId,
    invalid_instance_information_filter_value: InvalidInstanceInformationFilterValue,
    invalid_instance_property_filter_value: InvalidInstancePropertyFilterValue,
    invalid_inventory_group_exception: InvalidInventoryGroupException,
    invalid_inventory_item_context_exception: InvalidInventoryItemContextException,
    invalid_inventory_request_exception: InvalidInventoryRequestException,
    invalid_item_content_exception: InvalidItemContentException,
    invalid_key_id: InvalidKeyId,
    invalid_next_token: InvalidNextToken,
    invalid_notification_config: InvalidNotificationConfig,
    invalid_option_exception: InvalidOptionException,
    invalid_output_folder: InvalidOutputFolder,
    invalid_output_location: InvalidOutputLocation,
    invalid_parameters: InvalidParameters,
    invalid_permission_type: InvalidPermissionType,
    invalid_plugin_name: InvalidPluginName,
    invalid_policy_attribute_exception: InvalidPolicyAttributeException,
    invalid_policy_type_exception: InvalidPolicyTypeException,
    invalid_resource_id: InvalidResourceId,
    invalid_resource_type: InvalidResourceType,
    invalid_result_attribute_exception: InvalidResultAttributeException,
    invalid_role: InvalidRole,
    invalid_schedule: InvalidSchedule,
    invalid_tag: InvalidTag,
    invalid_target: InvalidTarget,
    invalid_target_maps: InvalidTargetMaps,
    invalid_type_name_exception: InvalidTypeNameException,
    invalid_update: InvalidUpdate,
    invocation_does_not_exist: InvocationDoesNotExist,
    item_content_mismatch_exception: ItemContentMismatchException,
    item_size_limit_exceeded_exception: ItemSizeLimitExceededException,
    malformed_resource_policy_document_exception: MalformedResourcePolicyDocumentException,
    max_document_size_exceeded: MaxDocumentSizeExceeded,
    no_longer_supported_exception: NoLongerSupportedException,
    ops_item_access_denied_exception: OpsItemAccessDeniedException,
    ops_item_already_exists_exception: OpsItemAlreadyExistsException,
    ops_item_conflict_exception: OpsItemConflictException,
    ops_item_invalid_parameter_exception: OpsItemInvalidParameterException,
    ops_item_limit_exceeded_exception: OpsItemLimitExceededException,
    ops_item_not_found_exception: OpsItemNotFoundException,
    ops_item_related_item_already_exists_exception: OpsItemRelatedItemAlreadyExistsException,
    ops_item_related_item_association_not_found_exception: OpsItemRelatedItemAssociationNotFoundException,
    ops_metadata_already_exists_exception: OpsMetadataAlreadyExistsException,
    ops_metadata_invalid_argument_exception: OpsMetadataInvalidArgumentException,
    ops_metadata_key_limit_exceeded_exception: OpsMetadataKeyLimitExceededException,
    ops_metadata_limit_exceeded_exception: OpsMetadataLimitExceededException,
    ops_metadata_not_found_exception: OpsMetadataNotFoundException,
    ops_metadata_too_many_updates_exception: OpsMetadataTooManyUpdatesException,
    parameter_already_exists: ParameterAlreadyExists,
    parameter_limit_exceeded: ParameterLimitExceeded,
    parameter_max_version_limit_exceeded: ParameterMaxVersionLimitExceeded,
    parameter_not_found: ParameterNotFound,
    parameter_pattern_mismatch_exception: ParameterPatternMismatchException,
    parameter_version_label_limit_exceeded: ParameterVersionLabelLimitExceeded,
    parameter_version_not_found: ParameterVersionNotFound,
    policies_limit_exceeded_exception: PoliciesLimitExceededException,
    resource_data_sync_already_exists_exception: ResourceDataSyncAlreadyExistsException,
    resource_data_sync_conflict_exception: ResourceDataSyncConflictException,
    resource_data_sync_count_exceeded_exception: ResourceDataSyncCountExceededException,
    resource_data_sync_invalid_configuration_exception: ResourceDataSyncInvalidConfigurationException,
    resource_data_sync_not_found_exception: ResourceDataSyncNotFoundException,
    resource_in_use_exception: ResourceInUseException,
    resource_limit_exceeded_exception: ResourceLimitExceededException,
    resource_not_found_exception: ResourceNotFoundException,
    resource_policy_conflict_exception: ResourcePolicyConflictException,
    resource_policy_invalid_parameter_exception: ResourcePolicyInvalidParameterException,
    resource_policy_limit_exceeded_exception: ResourcePolicyLimitExceededException,
    resource_policy_not_found_exception: ResourcePolicyNotFoundException,
    service_quota_exceeded_exception: ServiceQuotaExceededException,
    service_setting_not_found: ServiceSettingNotFound,
    status_unchanged: StatusUnchanged,
    sub_type_count_limit_exceeded_exception: SubTypeCountLimitExceededException,
    target_in_use_exception: TargetInUseException,
    target_not_connected: TargetNotConnected,
    throttling_exception: ThrottlingException,
    too_many_tags_error: TooManyTagsError,
    too_many_updates: TooManyUpdates,
    total_size_limit_exceeded_exception: TotalSizeLimitExceededException,
    unsupported_calendar_exception: UnsupportedCalendarException,
    unsupported_feature_required_exception: UnsupportedFeatureRequiredException,
    unsupported_inventory_item_context_exception: UnsupportedInventoryItemContextException,
    unsupported_inventory_schema_version_exception: UnsupportedInventorySchemaVersionException,
    unsupported_operating_system: UnsupportedOperatingSystem,
    unsupported_operation_exception: UnsupportedOperationException,
    unsupported_parameter_type: UnsupportedParameterType,
    unsupported_platform_type: UnsupportedPlatformType,
    validation_exception: ValidationException,
    unknown: UnknownServiceError,

    pub fn code(self: ServiceError) []const u8 {
        return switch (self) {
            .access_denied_exception => "AccessDeniedException",
            .already_exists_exception => "AlreadyExistsException",
            .associated_instances => "AssociatedInstances",
            .association_already_exists => "AssociationAlreadyExists",
            .association_does_not_exist => "AssociationDoesNotExist",
            .association_execution_does_not_exist => "AssociationExecutionDoesNotExist",
            .association_limit_exceeded => "AssociationLimitExceeded",
            .association_version_limit_exceeded => "AssociationVersionLimitExceeded",
            .automation_definition_not_approved_exception => "AutomationDefinitionNotApprovedException",
            .automation_definition_not_found_exception => "AutomationDefinitionNotFoundException",
            .automation_definition_version_not_found_exception => "AutomationDefinitionVersionNotFoundException",
            .automation_execution_limit_exceeded_exception => "AutomationExecutionLimitExceededException",
            .automation_execution_not_found_exception => "AutomationExecutionNotFoundException",
            .automation_step_not_found_exception => "AutomationStepNotFoundException",
            .compliance_type_count_limit_exceeded_exception => "ComplianceTypeCountLimitExceededException",
            .custom_schema_count_limit_exceeded_exception => "CustomSchemaCountLimitExceededException",
            .document_already_exists => "DocumentAlreadyExists",
            .document_limit_exceeded => "DocumentLimitExceeded",
            .document_permission_limit => "DocumentPermissionLimit",
            .document_version_limit_exceeded => "DocumentVersionLimitExceeded",
            .does_not_exist_exception => "DoesNotExistException",
            .duplicate_document_content => "DuplicateDocumentContent",
            .duplicate_document_version_name => "DuplicateDocumentVersionName",
            .duplicate_instance_id => "DuplicateInstanceId",
            .feature_not_available_exception => "FeatureNotAvailableException",
            .hierarchy_level_limit_exceeded_exception => "HierarchyLevelLimitExceededException",
            .hierarchy_type_mismatch_exception => "HierarchyTypeMismatchException",
            .idempotent_parameter_mismatch => "IdempotentParameterMismatch",
            .incompatible_policy_exception => "IncompatiblePolicyException",
            .internal_server_error => "InternalServerError",
            .invalid_activation => "InvalidActivation",
            .invalid_activation_id => "InvalidActivationId",
            .invalid_aggregator_exception => "InvalidAggregatorException",
            .invalid_allowed_pattern_exception => "InvalidAllowedPatternException",
            .invalid_association => "InvalidAssociation",
            .invalid_association_version => "InvalidAssociationVersion",
            .invalid_automation_execution_parameters_exception => "InvalidAutomationExecutionParametersException",
            .invalid_automation_signal_exception => "InvalidAutomationSignalException",
            .invalid_automation_status_update_exception => "InvalidAutomationStatusUpdateException",
            .invalid_command_id => "InvalidCommandId",
            .invalid_delete_inventory_parameters_exception => "InvalidDeleteInventoryParametersException",
            .invalid_deletion_id_exception => "InvalidDeletionIdException",
            .invalid_document => "InvalidDocument",
            .invalid_document_content => "InvalidDocumentContent",
            .invalid_document_operation => "InvalidDocumentOperation",
            .invalid_document_schema_version => "InvalidDocumentSchemaVersion",
            .invalid_document_type => "InvalidDocumentType",
            .invalid_document_version => "InvalidDocumentVersion",
            .invalid_filter => "InvalidFilter",
            .invalid_filter_key => "InvalidFilterKey",
            .invalid_filter_option => "InvalidFilterOption",
            .invalid_filter_value => "InvalidFilterValue",
            .invalid_instance_id => "InvalidInstanceId",
            .invalid_instance_information_filter_value => "InvalidInstanceInformationFilterValue",
            .invalid_instance_property_filter_value => "InvalidInstancePropertyFilterValue",
            .invalid_inventory_group_exception => "InvalidInventoryGroupException",
            .invalid_inventory_item_context_exception => "InvalidInventoryItemContextException",
            .invalid_inventory_request_exception => "InvalidInventoryRequestException",
            .invalid_item_content_exception => "InvalidItemContentException",
            .invalid_key_id => "InvalidKeyId",
            .invalid_next_token => "InvalidNextToken",
            .invalid_notification_config => "InvalidNotificationConfig",
            .invalid_option_exception => "InvalidOptionException",
            .invalid_output_folder => "InvalidOutputFolder",
            .invalid_output_location => "InvalidOutputLocation",
            .invalid_parameters => "InvalidParameters",
            .invalid_permission_type => "InvalidPermissionType",
            .invalid_plugin_name => "InvalidPluginName",
            .invalid_policy_attribute_exception => "InvalidPolicyAttributeException",
            .invalid_policy_type_exception => "InvalidPolicyTypeException",
            .invalid_resource_id => "InvalidResourceId",
            .invalid_resource_type => "InvalidResourceType",
            .invalid_result_attribute_exception => "InvalidResultAttributeException",
            .invalid_role => "InvalidRole",
            .invalid_schedule => "InvalidSchedule",
            .invalid_tag => "InvalidTag",
            .invalid_target => "InvalidTarget",
            .invalid_target_maps => "InvalidTargetMaps",
            .invalid_type_name_exception => "InvalidTypeNameException",
            .invalid_update => "InvalidUpdate",
            .invocation_does_not_exist => "InvocationDoesNotExist",
            .item_content_mismatch_exception => "ItemContentMismatchException",
            .item_size_limit_exceeded_exception => "ItemSizeLimitExceededException",
            .malformed_resource_policy_document_exception => "MalformedResourcePolicyDocumentException",
            .max_document_size_exceeded => "MaxDocumentSizeExceeded",
            .no_longer_supported_exception => "NoLongerSupportedException",
            .ops_item_access_denied_exception => "OpsItemAccessDeniedException",
            .ops_item_already_exists_exception => "OpsItemAlreadyExistsException",
            .ops_item_conflict_exception => "OpsItemConflictException",
            .ops_item_invalid_parameter_exception => "OpsItemInvalidParameterException",
            .ops_item_limit_exceeded_exception => "OpsItemLimitExceededException",
            .ops_item_not_found_exception => "OpsItemNotFoundException",
            .ops_item_related_item_already_exists_exception => "OpsItemRelatedItemAlreadyExistsException",
            .ops_item_related_item_association_not_found_exception => "OpsItemRelatedItemAssociationNotFoundException",
            .ops_metadata_already_exists_exception => "OpsMetadataAlreadyExistsException",
            .ops_metadata_invalid_argument_exception => "OpsMetadataInvalidArgumentException",
            .ops_metadata_key_limit_exceeded_exception => "OpsMetadataKeyLimitExceededException",
            .ops_metadata_limit_exceeded_exception => "OpsMetadataLimitExceededException",
            .ops_metadata_not_found_exception => "OpsMetadataNotFoundException",
            .ops_metadata_too_many_updates_exception => "OpsMetadataTooManyUpdatesException",
            .parameter_already_exists => "ParameterAlreadyExists",
            .parameter_limit_exceeded => "ParameterLimitExceeded",
            .parameter_max_version_limit_exceeded => "ParameterMaxVersionLimitExceeded",
            .parameter_not_found => "ParameterNotFound",
            .parameter_pattern_mismatch_exception => "ParameterPatternMismatchException",
            .parameter_version_label_limit_exceeded => "ParameterVersionLabelLimitExceeded",
            .parameter_version_not_found => "ParameterVersionNotFound",
            .policies_limit_exceeded_exception => "PoliciesLimitExceededException",
            .resource_data_sync_already_exists_exception => "ResourceDataSyncAlreadyExistsException",
            .resource_data_sync_conflict_exception => "ResourceDataSyncConflictException",
            .resource_data_sync_count_exceeded_exception => "ResourceDataSyncCountExceededException",
            .resource_data_sync_invalid_configuration_exception => "ResourceDataSyncInvalidConfigurationException",
            .resource_data_sync_not_found_exception => "ResourceDataSyncNotFoundException",
            .resource_in_use_exception => "ResourceInUseException",
            .resource_limit_exceeded_exception => "ResourceLimitExceededException",
            .resource_not_found_exception => "ResourceNotFoundException",
            .resource_policy_conflict_exception => "ResourcePolicyConflictException",
            .resource_policy_invalid_parameter_exception => "ResourcePolicyInvalidParameterException",
            .resource_policy_limit_exceeded_exception => "ResourcePolicyLimitExceededException",
            .resource_policy_not_found_exception => "ResourcePolicyNotFoundException",
            .service_quota_exceeded_exception => "ServiceQuotaExceededException",
            .service_setting_not_found => "ServiceSettingNotFound",
            .status_unchanged => "StatusUnchanged",
            .sub_type_count_limit_exceeded_exception => "SubTypeCountLimitExceededException",
            .target_in_use_exception => "TargetInUseException",
            .target_not_connected => "TargetNotConnected",
            .throttling_exception => "ThrottlingException",
            .too_many_tags_error => "TooManyTagsError",
            .too_many_updates => "TooManyUpdates",
            .total_size_limit_exceeded_exception => "TotalSizeLimitExceededException",
            .unsupported_calendar_exception => "UnsupportedCalendarException",
            .unsupported_feature_required_exception => "UnsupportedFeatureRequiredException",
            .unsupported_inventory_item_context_exception => "UnsupportedInventoryItemContextException",
            .unsupported_inventory_schema_version_exception => "UnsupportedInventorySchemaVersionException",
            .unsupported_operating_system => "UnsupportedOperatingSystem",
            .unsupported_operation_exception => "UnsupportedOperationException",
            .unsupported_parameter_type => "UnsupportedParameterType",
            .unsupported_platform_type => "UnsupportedPlatformType",
            .validation_exception => "ValidationException",
            .unknown => |e| e.code,
        };
    }

    pub fn message(self: ServiceError) []const u8 {
        return switch (self) {
            .access_denied_exception => |e| e.message,
            .already_exists_exception => |e| e.message,
            .associated_instances => |e| e.message,
            .association_already_exists => |e| e.message,
            .association_does_not_exist => |e| e.message,
            .association_execution_does_not_exist => |e| e.message,
            .association_limit_exceeded => |e| e.message,
            .association_version_limit_exceeded => |e| e.message,
            .automation_definition_not_approved_exception => |e| e.message,
            .automation_definition_not_found_exception => |e| e.message,
            .automation_definition_version_not_found_exception => |e| e.message,
            .automation_execution_limit_exceeded_exception => |e| e.message,
            .automation_execution_not_found_exception => |e| e.message,
            .automation_step_not_found_exception => |e| e.message,
            .compliance_type_count_limit_exceeded_exception => |e| e.message,
            .custom_schema_count_limit_exceeded_exception => |e| e.message,
            .document_already_exists => |e| e.message,
            .document_limit_exceeded => |e| e.message,
            .document_permission_limit => |e| e.message,
            .document_version_limit_exceeded => |e| e.message,
            .does_not_exist_exception => |e| e.message,
            .duplicate_document_content => |e| e.message,
            .duplicate_document_version_name => |e| e.message,
            .duplicate_instance_id => |e| e.message,
            .feature_not_available_exception => |e| e.message,
            .hierarchy_level_limit_exceeded_exception => |e| e.message,
            .hierarchy_type_mismatch_exception => |e| e.message,
            .idempotent_parameter_mismatch => |e| e.message,
            .incompatible_policy_exception => |e| e.message,
            .internal_server_error => |e| e.message,
            .invalid_activation => |e| e.message,
            .invalid_activation_id => |e| e.message,
            .invalid_aggregator_exception => |e| e.message,
            .invalid_allowed_pattern_exception => |e| e.message,
            .invalid_association => |e| e.message,
            .invalid_association_version => |e| e.message,
            .invalid_automation_execution_parameters_exception => |e| e.message,
            .invalid_automation_signal_exception => |e| e.message,
            .invalid_automation_status_update_exception => |e| e.message,
            .invalid_command_id => |e| e.message,
            .invalid_delete_inventory_parameters_exception => |e| e.message,
            .invalid_deletion_id_exception => |e| e.message,
            .invalid_document => |e| e.message,
            .invalid_document_content => |e| e.message,
            .invalid_document_operation => |e| e.message,
            .invalid_document_schema_version => |e| e.message,
            .invalid_document_type => |e| e.message,
            .invalid_document_version => |e| e.message,
            .invalid_filter => |e| e.message,
            .invalid_filter_key => |e| e.message,
            .invalid_filter_option => |e| e.message,
            .invalid_filter_value => |e| e.message,
            .invalid_instance_id => |e| e.message,
            .invalid_instance_information_filter_value => |e| e.message,
            .invalid_instance_property_filter_value => |e| e.message,
            .invalid_inventory_group_exception => |e| e.message,
            .invalid_inventory_item_context_exception => |e| e.message,
            .invalid_inventory_request_exception => |e| e.message,
            .invalid_item_content_exception => |e| e.message,
            .invalid_key_id => |e| e.message,
            .invalid_next_token => |e| e.message,
            .invalid_notification_config => |e| e.message,
            .invalid_option_exception => |e| e.message,
            .invalid_output_folder => |e| e.message,
            .invalid_output_location => |e| e.message,
            .invalid_parameters => |e| e.message,
            .invalid_permission_type => |e| e.message,
            .invalid_plugin_name => |e| e.message,
            .invalid_policy_attribute_exception => |e| e.message,
            .invalid_policy_type_exception => |e| e.message,
            .invalid_resource_id => |e| e.message,
            .invalid_resource_type => |e| e.message,
            .invalid_result_attribute_exception => |e| e.message,
            .invalid_role => |e| e.message,
            .invalid_schedule => |e| e.message,
            .invalid_tag => |e| e.message,
            .invalid_target => |e| e.message,
            .invalid_target_maps => |e| e.message,
            .invalid_type_name_exception => |e| e.message,
            .invalid_update => |e| e.message,
            .invocation_does_not_exist => |e| e.message,
            .item_content_mismatch_exception => |e| e.message,
            .item_size_limit_exceeded_exception => |e| e.message,
            .malformed_resource_policy_document_exception => |e| e.message,
            .max_document_size_exceeded => |e| e.message,
            .no_longer_supported_exception => |e| e.message,
            .ops_item_access_denied_exception => |e| e.message,
            .ops_item_already_exists_exception => |e| e.message,
            .ops_item_conflict_exception => |e| e.message,
            .ops_item_invalid_parameter_exception => |e| e.message,
            .ops_item_limit_exceeded_exception => |e| e.message,
            .ops_item_not_found_exception => |e| e.message,
            .ops_item_related_item_already_exists_exception => |e| e.message,
            .ops_item_related_item_association_not_found_exception => |e| e.message,
            .ops_metadata_already_exists_exception => |e| e.message,
            .ops_metadata_invalid_argument_exception => |e| e.message,
            .ops_metadata_key_limit_exceeded_exception => |e| e.message,
            .ops_metadata_limit_exceeded_exception => |e| e.message,
            .ops_metadata_not_found_exception => |e| e.message,
            .ops_metadata_too_many_updates_exception => |e| e.message,
            .parameter_already_exists => |e| e.message,
            .parameter_limit_exceeded => |e| e.message,
            .parameter_max_version_limit_exceeded => |e| e.message,
            .parameter_not_found => |e| e.message,
            .parameter_pattern_mismatch_exception => |e| e.message,
            .parameter_version_label_limit_exceeded => |e| e.message,
            .parameter_version_not_found => |e| e.message,
            .policies_limit_exceeded_exception => |e| e.message,
            .resource_data_sync_already_exists_exception => |e| e.message,
            .resource_data_sync_conflict_exception => |e| e.message,
            .resource_data_sync_count_exceeded_exception => |e| e.message,
            .resource_data_sync_invalid_configuration_exception => |e| e.message,
            .resource_data_sync_not_found_exception => |e| e.message,
            .resource_in_use_exception => |e| e.message,
            .resource_limit_exceeded_exception => |e| e.message,
            .resource_not_found_exception => |e| e.message,
            .resource_policy_conflict_exception => |e| e.message,
            .resource_policy_invalid_parameter_exception => |e| e.message,
            .resource_policy_limit_exceeded_exception => |e| e.message,
            .resource_policy_not_found_exception => |e| e.message,
            .service_quota_exceeded_exception => |e| e.message,
            .service_setting_not_found => |e| e.message,
            .status_unchanged => |e| e.message,
            .sub_type_count_limit_exceeded_exception => |e| e.message,
            .target_in_use_exception => |e| e.message,
            .target_not_connected => |e| e.message,
            .throttling_exception => |e| e.message,
            .too_many_tags_error => |e| e.message,
            .too_many_updates => |e| e.message,
            .total_size_limit_exceeded_exception => |e| e.message,
            .unsupported_calendar_exception => |e| e.message,
            .unsupported_feature_required_exception => |e| e.message,
            .unsupported_inventory_item_context_exception => |e| e.message,
            .unsupported_inventory_schema_version_exception => |e| e.message,
            .unsupported_operating_system => |e| e.message,
            .unsupported_operation_exception => |e| e.message,
            .unsupported_parameter_type => |e| e.message,
            .unsupported_platform_type => |e| e.message,
            .validation_exception => |e| e.message,
            .unknown => |e| e.message,
        };
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return switch (self) {
            .access_denied_exception => 400,
            .already_exists_exception => 400,
            .associated_instances => 400,
            .association_already_exists => 400,
            .association_does_not_exist => 400,
            .association_execution_does_not_exist => 400,
            .association_limit_exceeded => 400,
            .association_version_limit_exceeded => 400,
            .automation_definition_not_approved_exception => 400,
            .automation_definition_not_found_exception => 400,
            .automation_definition_version_not_found_exception => 400,
            .automation_execution_limit_exceeded_exception => 400,
            .automation_execution_not_found_exception => 400,
            .automation_step_not_found_exception => 400,
            .compliance_type_count_limit_exceeded_exception => 400,
            .custom_schema_count_limit_exceeded_exception => 400,
            .document_already_exists => 400,
            .document_limit_exceeded => 400,
            .document_permission_limit => 400,
            .document_version_limit_exceeded => 400,
            .does_not_exist_exception => 400,
            .duplicate_document_content => 400,
            .duplicate_document_version_name => 400,
            .duplicate_instance_id => 400,
            .feature_not_available_exception => 400,
            .hierarchy_level_limit_exceeded_exception => 400,
            .hierarchy_type_mismatch_exception => 400,
            .idempotent_parameter_mismatch => 400,
            .incompatible_policy_exception => 400,
            .internal_server_error => 500,
            .invalid_activation => 400,
            .invalid_activation_id => 400,
            .invalid_aggregator_exception => 400,
            .invalid_allowed_pattern_exception => 400,
            .invalid_association => 400,
            .invalid_association_version => 400,
            .invalid_automation_execution_parameters_exception => 400,
            .invalid_automation_signal_exception => 400,
            .invalid_automation_status_update_exception => 400,
            .invalid_command_id => 400,
            .invalid_delete_inventory_parameters_exception => 400,
            .invalid_deletion_id_exception => 400,
            .invalid_document => 400,
            .invalid_document_content => 400,
            .invalid_document_operation => 400,
            .invalid_document_schema_version => 400,
            .invalid_document_type => 400,
            .invalid_document_version => 400,
            .invalid_filter => 400,
            .invalid_filter_key => 400,
            .invalid_filter_option => 400,
            .invalid_filter_value => 400,
            .invalid_instance_id => 400,
            .invalid_instance_information_filter_value => 400,
            .invalid_instance_property_filter_value => 400,
            .invalid_inventory_group_exception => 400,
            .invalid_inventory_item_context_exception => 400,
            .invalid_inventory_request_exception => 400,
            .invalid_item_content_exception => 400,
            .invalid_key_id => 400,
            .invalid_next_token => 400,
            .invalid_notification_config => 400,
            .invalid_option_exception => 400,
            .invalid_output_folder => 400,
            .invalid_output_location => 400,
            .invalid_parameters => 400,
            .invalid_permission_type => 400,
            .invalid_plugin_name => 400,
            .invalid_policy_attribute_exception => 400,
            .invalid_policy_type_exception => 400,
            .invalid_resource_id => 400,
            .invalid_resource_type => 400,
            .invalid_result_attribute_exception => 400,
            .invalid_role => 400,
            .invalid_schedule => 400,
            .invalid_tag => 400,
            .invalid_target => 400,
            .invalid_target_maps => 400,
            .invalid_type_name_exception => 400,
            .invalid_update => 400,
            .invocation_does_not_exist => 400,
            .item_content_mismatch_exception => 400,
            .item_size_limit_exceeded_exception => 400,
            .malformed_resource_policy_document_exception => 400,
            .max_document_size_exceeded => 400,
            .no_longer_supported_exception => 400,
            .ops_item_access_denied_exception => 400,
            .ops_item_already_exists_exception => 400,
            .ops_item_conflict_exception => 400,
            .ops_item_invalid_parameter_exception => 400,
            .ops_item_limit_exceeded_exception => 400,
            .ops_item_not_found_exception => 400,
            .ops_item_related_item_already_exists_exception => 400,
            .ops_item_related_item_association_not_found_exception => 400,
            .ops_metadata_already_exists_exception => 400,
            .ops_metadata_invalid_argument_exception => 400,
            .ops_metadata_key_limit_exceeded_exception => 400,
            .ops_metadata_limit_exceeded_exception => 400,
            .ops_metadata_not_found_exception => 400,
            .ops_metadata_too_many_updates_exception => 400,
            .parameter_already_exists => 400,
            .parameter_limit_exceeded => 400,
            .parameter_max_version_limit_exceeded => 400,
            .parameter_not_found => 400,
            .parameter_pattern_mismatch_exception => 400,
            .parameter_version_label_limit_exceeded => 400,
            .parameter_version_not_found => 400,
            .policies_limit_exceeded_exception => 400,
            .resource_data_sync_already_exists_exception => 400,
            .resource_data_sync_conflict_exception => 400,
            .resource_data_sync_count_exceeded_exception => 400,
            .resource_data_sync_invalid_configuration_exception => 400,
            .resource_data_sync_not_found_exception => 400,
            .resource_in_use_exception => 400,
            .resource_limit_exceeded_exception => 400,
            .resource_not_found_exception => 400,
            .resource_policy_conflict_exception => 400,
            .resource_policy_invalid_parameter_exception => 400,
            .resource_policy_limit_exceeded_exception => 400,
            .resource_policy_not_found_exception => 400,
            .service_quota_exceeded_exception => 400,
            .service_setting_not_found => 400,
            .status_unchanged => 400,
            .sub_type_count_limit_exceeded_exception => 400,
            .target_in_use_exception => 400,
            .target_not_connected => 400,
            .throttling_exception => 400,
            .too_many_tags_error => 400,
            .too_many_updates => 400,
            .total_size_limit_exceeded_exception => 400,
            .unsupported_calendar_exception => 400,
            .unsupported_feature_required_exception => 400,
            .unsupported_inventory_item_context_exception => 400,
            .unsupported_inventory_schema_version_exception => 400,
            .unsupported_operating_system => 400,
            .unsupported_operation_exception => 400,
            .unsupported_parameter_type => 400,
            .unsupported_platform_type => 400,
            .validation_exception => 400,
            .unknown => |e| e.http_status,
        };
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return switch (self) {
            .access_denied_exception => |e| e.request_id,
            .already_exists_exception => |e| e.request_id,
            .associated_instances => |e| e.request_id,
            .association_already_exists => |e| e.request_id,
            .association_does_not_exist => |e| e.request_id,
            .association_execution_does_not_exist => |e| e.request_id,
            .association_limit_exceeded => |e| e.request_id,
            .association_version_limit_exceeded => |e| e.request_id,
            .automation_definition_not_approved_exception => |e| e.request_id,
            .automation_definition_not_found_exception => |e| e.request_id,
            .automation_definition_version_not_found_exception => |e| e.request_id,
            .automation_execution_limit_exceeded_exception => |e| e.request_id,
            .automation_execution_not_found_exception => |e| e.request_id,
            .automation_step_not_found_exception => |e| e.request_id,
            .compliance_type_count_limit_exceeded_exception => |e| e.request_id,
            .custom_schema_count_limit_exceeded_exception => |e| e.request_id,
            .document_already_exists => |e| e.request_id,
            .document_limit_exceeded => |e| e.request_id,
            .document_permission_limit => |e| e.request_id,
            .document_version_limit_exceeded => |e| e.request_id,
            .does_not_exist_exception => |e| e.request_id,
            .duplicate_document_content => |e| e.request_id,
            .duplicate_document_version_name => |e| e.request_id,
            .duplicate_instance_id => |e| e.request_id,
            .feature_not_available_exception => |e| e.request_id,
            .hierarchy_level_limit_exceeded_exception => |e| e.request_id,
            .hierarchy_type_mismatch_exception => |e| e.request_id,
            .idempotent_parameter_mismatch => |e| e.request_id,
            .incompatible_policy_exception => |e| e.request_id,
            .internal_server_error => |e| e.request_id,
            .invalid_activation => |e| e.request_id,
            .invalid_activation_id => |e| e.request_id,
            .invalid_aggregator_exception => |e| e.request_id,
            .invalid_allowed_pattern_exception => |e| e.request_id,
            .invalid_association => |e| e.request_id,
            .invalid_association_version => |e| e.request_id,
            .invalid_automation_execution_parameters_exception => |e| e.request_id,
            .invalid_automation_signal_exception => |e| e.request_id,
            .invalid_automation_status_update_exception => |e| e.request_id,
            .invalid_command_id => |e| e.request_id,
            .invalid_delete_inventory_parameters_exception => |e| e.request_id,
            .invalid_deletion_id_exception => |e| e.request_id,
            .invalid_document => |e| e.request_id,
            .invalid_document_content => |e| e.request_id,
            .invalid_document_operation => |e| e.request_id,
            .invalid_document_schema_version => |e| e.request_id,
            .invalid_document_type => |e| e.request_id,
            .invalid_document_version => |e| e.request_id,
            .invalid_filter => |e| e.request_id,
            .invalid_filter_key => |e| e.request_id,
            .invalid_filter_option => |e| e.request_id,
            .invalid_filter_value => |e| e.request_id,
            .invalid_instance_id => |e| e.request_id,
            .invalid_instance_information_filter_value => |e| e.request_id,
            .invalid_instance_property_filter_value => |e| e.request_id,
            .invalid_inventory_group_exception => |e| e.request_id,
            .invalid_inventory_item_context_exception => |e| e.request_id,
            .invalid_inventory_request_exception => |e| e.request_id,
            .invalid_item_content_exception => |e| e.request_id,
            .invalid_key_id => |e| e.request_id,
            .invalid_next_token => |e| e.request_id,
            .invalid_notification_config => |e| e.request_id,
            .invalid_option_exception => |e| e.request_id,
            .invalid_output_folder => |e| e.request_id,
            .invalid_output_location => |e| e.request_id,
            .invalid_parameters => |e| e.request_id,
            .invalid_permission_type => |e| e.request_id,
            .invalid_plugin_name => |e| e.request_id,
            .invalid_policy_attribute_exception => |e| e.request_id,
            .invalid_policy_type_exception => |e| e.request_id,
            .invalid_resource_id => |e| e.request_id,
            .invalid_resource_type => |e| e.request_id,
            .invalid_result_attribute_exception => |e| e.request_id,
            .invalid_role => |e| e.request_id,
            .invalid_schedule => |e| e.request_id,
            .invalid_tag => |e| e.request_id,
            .invalid_target => |e| e.request_id,
            .invalid_target_maps => |e| e.request_id,
            .invalid_type_name_exception => |e| e.request_id,
            .invalid_update => |e| e.request_id,
            .invocation_does_not_exist => |e| e.request_id,
            .item_content_mismatch_exception => |e| e.request_id,
            .item_size_limit_exceeded_exception => |e| e.request_id,
            .malformed_resource_policy_document_exception => |e| e.request_id,
            .max_document_size_exceeded => |e| e.request_id,
            .no_longer_supported_exception => |e| e.request_id,
            .ops_item_access_denied_exception => |e| e.request_id,
            .ops_item_already_exists_exception => |e| e.request_id,
            .ops_item_conflict_exception => |e| e.request_id,
            .ops_item_invalid_parameter_exception => |e| e.request_id,
            .ops_item_limit_exceeded_exception => |e| e.request_id,
            .ops_item_not_found_exception => |e| e.request_id,
            .ops_item_related_item_already_exists_exception => |e| e.request_id,
            .ops_item_related_item_association_not_found_exception => |e| e.request_id,
            .ops_metadata_already_exists_exception => |e| e.request_id,
            .ops_metadata_invalid_argument_exception => |e| e.request_id,
            .ops_metadata_key_limit_exceeded_exception => |e| e.request_id,
            .ops_metadata_limit_exceeded_exception => |e| e.request_id,
            .ops_metadata_not_found_exception => |e| e.request_id,
            .ops_metadata_too_many_updates_exception => |e| e.request_id,
            .parameter_already_exists => |e| e.request_id,
            .parameter_limit_exceeded => |e| e.request_id,
            .parameter_max_version_limit_exceeded => |e| e.request_id,
            .parameter_not_found => |e| e.request_id,
            .parameter_pattern_mismatch_exception => |e| e.request_id,
            .parameter_version_label_limit_exceeded => |e| e.request_id,
            .parameter_version_not_found => |e| e.request_id,
            .policies_limit_exceeded_exception => |e| e.request_id,
            .resource_data_sync_already_exists_exception => |e| e.request_id,
            .resource_data_sync_conflict_exception => |e| e.request_id,
            .resource_data_sync_count_exceeded_exception => |e| e.request_id,
            .resource_data_sync_invalid_configuration_exception => |e| e.request_id,
            .resource_data_sync_not_found_exception => |e| e.request_id,
            .resource_in_use_exception => |e| e.request_id,
            .resource_limit_exceeded_exception => |e| e.request_id,
            .resource_not_found_exception => |e| e.request_id,
            .resource_policy_conflict_exception => |e| e.request_id,
            .resource_policy_invalid_parameter_exception => |e| e.request_id,
            .resource_policy_limit_exceeded_exception => |e| e.request_id,
            .resource_policy_not_found_exception => |e| e.request_id,
            .service_quota_exceeded_exception => |e| e.request_id,
            .service_setting_not_found => |e| e.request_id,
            .status_unchanged => |e| e.request_id,
            .sub_type_count_limit_exceeded_exception => |e| e.request_id,
            .target_in_use_exception => |e| e.request_id,
            .target_not_connected => |e| e.request_id,
            .throttling_exception => |e| e.request_id,
            .too_many_tags_error => |e| e.request_id,
            .too_many_updates => |e| e.request_id,
            .total_size_limit_exceeded_exception => |e| e.request_id,
            .unsupported_calendar_exception => |e| e.request_id,
            .unsupported_feature_required_exception => |e| e.request_id,
            .unsupported_inventory_item_context_exception => |e| e.request_id,
            .unsupported_inventory_schema_version_exception => |e| e.request_id,
            .unsupported_operating_system => |e| e.request_id,
            .unsupported_operation_exception => |e| e.request_id,
            .unsupported_parameter_type => |e| e.request_id,
            .unsupported_platform_type => |e| e.request_id,
            .validation_exception => |e| e.request_id,
            .unknown => |e| e.request_id,
        };
    }
};

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociatedInstances = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociationAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociationDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociationExecutionDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociationVersionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AutomationDefinitionNotApprovedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AutomationDefinitionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AutomationDefinitionVersionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AutomationExecutionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AutomationExecutionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AutomationStepNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ComplianceTypeCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomSchemaCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DocumentAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DocumentLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DocumentPermissionLimit = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DocumentVersionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateDocumentContent = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateDocumentVersionName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateInstanceId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FeatureNotAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HierarchyLevelLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HierarchyTypeMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatiblePolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidActivation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidActivationId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAggregatorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAllowedPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAssociationVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAutomationExecutionParametersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAutomationSignalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAutomationStatusUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCommandId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeleteInventoryParametersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeletionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDocument = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDocumentContent = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDocumentOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDocumentSchemaVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDocumentType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDocumentVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFilter = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFilterKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFilterOption = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFilterValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInstanceId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInstanceInformationFilterValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInstancePropertyFilterValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInventoryGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInventoryItemContextException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInventoryRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidItemContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKeyId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNotificationConfig = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOutputFolder = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOutputLocation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameters = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPermissionType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPluginName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPolicyAttributeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPolicyTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResultAttributeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRole = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSchedule = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTag = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTarget = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTargetMaps = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTypeNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUpdate = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvocationDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ItemContentMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ItemSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedResourcePolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxDocumentSizeExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoLongerSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemRelatedItemAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsItemRelatedItemAssociationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsMetadataAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsMetadataInvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsMetadataKeyLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsMetadataLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsMetadataNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpsMetadataTooManyUpdatesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterMaxVersionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterPatternMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterVersionLabelLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParameterVersionNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PoliciesLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDataSyncAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDataSyncConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDataSyncCountExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDataSyncInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDataSyncNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceSettingNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StatusUnchanged = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubTypeCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetNotConnected = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyUpdates = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TotalSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedCalendarException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedFeatureRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedInventoryItemContextException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedInventorySchemaVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperatingSystem = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedParameterType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedPlatformType = struct {
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
