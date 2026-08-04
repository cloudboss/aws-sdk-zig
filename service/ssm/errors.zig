const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
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

        pub fn code(self: Kind) []const u8 {
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

        pub fn message(self: Kind) []const u8 {
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

        pub fn httpStatus(self: Kind) u16 {
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

        pub fn requestId(self: Kind) []const u8 {
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

/// The requester doesn't have permissions to perform the requested operation.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Error returned if an attempt is made to register a patch group with a patch
/// baseline that is
/// already registered with a different patch baseline.
pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You must disassociate a document from all managed nodes before you can
/// delete it.
pub const AssociatedInstances = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The specified association already exists.
pub const AssociationAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The specified association doesn't exist.
pub const AssociationDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified execution ID doesn't exist. Verify the ID number and try
/// again.
pub const AssociationExecutionDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can have at most 2,000 active associations.
pub const AssociationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// You have reached the maximum number versions allowed for an association.
/// Each association
/// has a limit of 1,000 versions.
pub const AssociationVersionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Indicates that the Change Manager change template used in the change request
/// was rejected or is
/// still in a pending state.
pub const AutomationDefinitionNotApprovedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An Automation runbook with the specified name couldn't be found.
pub const AutomationDefinitionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An Automation runbook with the specified name and version couldn't be found.
pub const AutomationDefinitionVersionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of simultaneously running Automation executions exceeded the
/// allowable
/// limit.
pub const AutomationExecutionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There is no automation execution information for the requested automation
/// execution
/// ID.
pub const AutomationExecutionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified step name and execution ID don't exist. Verify the information
/// and try
/// again.
pub const AutomationStepNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You specified too many custom compliance types. You can specify a maximum of
/// 10 different
/// types.
pub const ComplianceTypeCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have exceeded the limit for custom schemas. Delete one or more custom
/// schemas and try
/// again.
pub const CustomSchemaCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified document already exists.
pub const DocumentAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can have at most 500 active SSM documents.
pub const DocumentLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The document can't be shared with more Amazon Web Services accounts. You can
/// specify a maximum of 20
/// accounts per API operation to share a private document.
///
/// By default, you can share a private document with a maximum of 1,000
/// accounts and publicly
/// share up to five documents.
///
/// If you need to increase the quota for privately or publicly shared Systems
/// Manager documents, contact
/// Amazon Web Services Support.
pub const DocumentPermissionLimit = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The document has too many versions. Delete one or more document versions and
/// try
/// again.
pub const DocumentVersionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Error returned when the ID specified for a resource, such as a maintenance
/// window or patch
/// baseline, doesn't exist.
///
/// For information about resource quotas in Amazon Web Services Systems
/// Manager, see [Systems Manager service
/// quotas](https://docs.aws.amazon.com/general/latest/gr/ssm.html#limits_ssm)
/// in the
/// *Amazon Web Services General Reference*.
pub const DoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The content of the association document matches another document. Change the
/// content of the
/// document and try again.
pub const DuplicateDocumentContent = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The version name has already been used in this document. Specify a different
/// version name,
/// and then try again.
pub const DuplicateDocumentVersionName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't specify a managed node ID in more than one association.
pub const DuplicateInstanceId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// You attempted to register a `LAMBDA` or `STEP_FUNCTIONS` task in a
/// region where the corresponding service isn't available.
pub const FeatureNotAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A hierarchy can have a maximum of 15 levels. For more information, see
/// [Requirements and
/// constraints for parameter
/// names](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-parameter-name-constraints.html) in the *Amazon Web Services Systems Manager User Guide*.
pub const HierarchyLevelLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Parameter Store doesn't support changing a parameter type in a hierarchy.
/// For example, you
/// can't change a parameter from a `String` type to a `SecureString` type. You
/// must create a new, unique parameter.
pub const HierarchyTypeMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Error returned when an idempotent operation is retried and the parameters
/// don't match the
/// original call to the API with the same idempotency token.
pub const IdempotentParameterMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There is a conflict in the policies specified for this parameter. You can't,
/// for example,
/// specify two Expiration policies for a parameter. Review your policies, and
/// try again.
pub const IncompatiblePolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An error occurred on the server side.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The activation isn't valid. The activation might have been deleted, or the
/// ActivationId and
/// the ActivationCode don't match.
pub const InvalidActivation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The activation ID isn't valid. Verify that you entered the correct
/// ActivationId or
/// ActivationCode and try again.
pub const InvalidActivationId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified aggregator isn't valid for the group type. Verify that the
/// aggregator you
/// provided is supported.
pub const InvalidAggregatorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request doesn't meet the regular expression requirement.
pub const InvalidAllowedPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The association isn't valid or doesn't exist.
pub const InvalidAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The version you specified isn't valid. Use ListAssociationVersions to view
/// all versions of
/// an association according to the association ID. Or, use the `$LATEST`
/// parameter to
/// view the latest version of the association.
pub const InvalidAssociationVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The supplied parameters for invoking the specified Automation runbook are
/// incorrect. For
/// example, they may not match the set of parameters permitted for the
/// specified Automation
/// document.
pub const InvalidAutomationExecutionParametersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The signal isn't valid for the current Automation execution.
pub const InvalidAutomationSignalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified update status operation isn't valid.
pub const InvalidAutomationStatusUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified command ID isn't valid. Verify the ID and try again.
pub const InvalidCommandId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// One or more of the parameters specified for the delete operation isn't
/// valid. Verify all
/// parameters and try again.
pub const InvalidDeleteInventoryParametersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The ID specified for the delete operation doesn't exist or isn't valid.
/// Verify the ID and
/// try again.
pub const InvalidDeletionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified SSM document doesn't exist.
pub const InvalidDocument = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The content for the document isn't valid.
pub const InvalidDocumentContent = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You attempted to delete a document while it is still shared. You must stop
/// sharing the
/// document before you can delete it.
pub const InvalidDocumentOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The version of the document schema isn't supported.
pub const InvalidDocumentSchemaVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The SSM document type isn't valid. Valid document types are described in the
/// `DocumentType` property.
pub const InvalidDocumentType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The document version isn't valid or doesn't exist.
pub const InvalidDocumentVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The filter name isn't valid. Verify that you entered the correct name and
/// try again.
pub const InvalidFilter = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified key isn't valid.
pub const InvalidFilterKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The specified filter option isn't valid. Valid options are Equals and
/// BeginsWith. For Path
/// filter, valid options are Recursive and OneLevel.
pub const InvalidFilterOption = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The filter value isn't valid. Verify the value and try again.
pub const InvalidFilterValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The following problems can cause this exception:
///
/// * You don't have permission to access the managed node.
///
/// * Amazon Web Services Systems Manager Agent (SSM Agent) isn't running.
///   Verify that SSM Agent is
/// running.
///
/// * SSM Agent isn't registered with the SSM endpoint. Try reinstalling SSM
///   Agent.
///
/// * The managed node isn't in a valid state. Valid states are: `Running`,
/// `Pending`, `Stopped`, and `Stopping`. Invalid states are:
/// `Shutting-down` and `Terminated`.
pub const InvalidInstanceId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified filter value isn't valid.
pub const InvalidInstanceInformationFilterValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified filter value isn't valid.
pub const InvalidInstancePropertyFilterValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified inventory group isn't valid.
pub const InvalidInventoryGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You specified invalid keys or values in the `Context` attribute for
/// `InventoryItem`. Verify the keys and values, and try again.
pub const InvalidInventoryItemContextException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request isn't valid.
pub const InvalidInventoryRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more content items isn't valid.
pub const InvalidItemContentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .type_name = "TypeName",
    };
};

/// The query key ID isn't valid.
pub const InvalidKeyId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified token isn't valid.
pub const InvalidNextToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more configuration items isn't valid. Verify that a valid Amazon
/// Resource Name (ARN)
/// was provided for an Amazon Simple Notification Service topic.
pub const InvalidNotificationConfig = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The delete inventory option specified isn't valid. Verify the option and try
/// again.
pub const InvalidOptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The S3 bucket doesn't exist.
pub const InvalidOutputFolder = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The output location isn't valid or doesn't exist.
pub const InvalidOutputLocation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// You must specify values for all required parameters in the Amazon Web
/// Services Systems Manager document (SSM
/// document). You can only supply values to parameters defined in the SSM
/// document.
pub const InvalidParameters = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The permission type isn't supported. *Share* is the only supported
/// permission type.
pub const InvalidPermissionType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The plugin name isn't valid.
pub const InvalidPluginName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// A policy attribute or its value is invalid.
pub const InvalidPolicyAttributeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The policy type isn't supported. Parameter Store supports the following
/// policy types:
/// Expiration, ExpirationNotification, and NoChangeNotification.
pub const InvalidPolicyTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The resource ID isn't valid. Verify that you entered the correct ID and try
/// again.
pub const InvalidResourceId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The resource type isn't valid. For example, if you are attempting to tag an
/// EC2 instance,
/// the instance must be a registered managed node.
pub const InvalidResourceType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The specified inventory item result attribute isn't valid.
pub const InvalidResultAttributeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The role name can't contain invalid characters. Also verify that you
/// specified an IAM role for notifications that includes the required trust
/// policy. For information about
/// configuring the IAM role for Run Command notifications, see [Monitoring
/// Systems Manager status changes using Amazon SNS
/// notifications](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitoring-sns-notifications.html) in
/// the *Amazon Web Services Systems Manager User Guide*.
pub const InvalidRole = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The schedule is invalid. Verify your cron or rate expression and try again.
pub const InvalidSchedule = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified tag key or value isn't valid.
pub const InvalidTag = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The target isn't valid or doesn't exist. It might not be configured for
/// Systems Manager or you might
/// not have permission to perform the operation.
pub const InvalidTarget = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// TargetMap parameter isn't valid.
pub const InvalidTargetMaps = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The parameter type name isn't valid.
pub const InvalidTypeNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The update isn't valid.
pub const InvalidUpdate = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The command ID and managed node ID you specified didn't match any
/// invocations. Verify the
/// command ID and the managed node ID and try again.
pub const InvocationDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The inventory item has invalid content.
pub const ItemContentMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .type_name = "TypeName",
    };
};

/// The inventory item size has exceeded the size limit.
pub const ItemSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .type_name = "TypeName",
    };
};

/// The specified policy document is malformed or invalid, or excessive
/// `PutResourcePolicy` or `DeleteResourcePolicy` calls have been made.
pub const MalformedResourcePolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The size limit of a document is 64 KB.
pub const MaxDocumentSizeExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation is no longer supported by Systems Manager.
pub const NoLongerSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You don't have permission to view OpsItems in the specified account. Verify
/// that your account
/// is configured either as a Systems Manager delegated administrator or that
/// you are logged into the Organizations
/// management account.
pub const OpsItemAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The OpsItem already exists.
pub const OpsItemAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    ops_item_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .ops_item_id = "OpsItemId",
    };
};

/// The specified OpsItem is in the process of being deleted.
pub const OpsItemConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A specified parameter argument isn't valid. Verify the available arguments
/// and try
/// again.
pub const OpsItemInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    parameter_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .parameter_names = "ParameterNames",
    };
};

/// The request caused OpsItems to exceed one or more quotas.
pub const OpsItemLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    limit: ?i32 = null,

    limit_type: ?[]const u8 = null,

    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .limit_type = "LimitType",
        .message = "Message",
        .resource_types = "ResourceTypes",
    };
};

/// The specified OpsItem ID doesn't exist. Verify the ID and try again.
pub const OpsItemNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Resource Name (ARN) is already associated with the OpsItem.
pub const OpsItemRelatedItemAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    ops_item_id: ?[]const u8 = null,

    resource_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .ops_item_id = "OpsItemId",
        .resource_uri = "ResourceUri",
    };
};

/// The association wasn't found using the parameters you specified in the call.
/// Verify the
/// information and try again.
pub const OpsItemRelatedItemAssociationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An OpsMetadata object already exists for the selected resource.
pub const OpsMetadataAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One of the arguments passed is invalid.
pub const OpsMetadataInvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The OpsMetadata object exceeds the maximum number of OpsMetadata keys that
/// you can assign to
/// an application in Application Manager.
pub const OpsMetadataKeyLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your account reached the maximum number of OpsMetadata objects allowed by
/// Application Manager. The
/// maximum is 200 OpsMetadata objects. Delete one or more OpsMetadata object
/// and try again.
pub const OpsMetadataLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The OpsMetadata object doesn't exist.
pub const OpsMetadataNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The system is processing too many concurrent updates. Wait a few moments and
/// try
/// again.
pub const OpsMetadataTooManyUpdatesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The parameter already exists. You can't create duplicate parameters.
pub const ParameterAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have exceeded the number of parameters for this Amazon Web Services
/// account. Delete one or more
/// parameters and try again.
pub const ParameterLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Parameter Store retains the 100 most recently created versions of a
/// parameter. After this
/// number of versions has been created, Parameter Store deletes the oldest
/// version when a new one is
/// created. However, if the oldest version has a *label* attached to it,
/// Parameter Store won't delete the version and instead presents this error
/// message:
///
/// `An error occurred (ParameterMaxVersionLimitExceeded) when calling the
/// PutParameter
/// operation: You attempted to create a new version of *parameter-name* by
/// calling the PutParameter API with the overwrite flag. Version
/// *version-number*, the oldest version, can't be deleted because it has a
/// label associated with it. Move the label to another version of the
/// parameter, and try
/// again.`
///
/// This safeguard is to prevent parameter versions with mission critical labels
/// assigned to
/// them from being deleted. To continue creating new parameters, first move the
/// label from the
/// oldest version of the parameter to a newer one for use in your operations.
/// For information about
/// moving parameter labels, see [Move a parameter label
/// (console)](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-labels.html#sysman-paramstore-labels-console-move) or [Move a parameter label (CLI)](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-labels.html#sysman-paramstore-labels-cli-move) in the *Amazon Web Services Systems Manager User Guide*.
pub const ParameterMaxVersionLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The parameter couldn't be found. Verify the name and try again.
///
/// For the `DeleteParameter` and `GetParameter` actions, if the
/// specified parameter doesn't exist, the `ParameterNotFound` exception is
/// *not* recorded in CloudTrail event logs.
pub const ParameterNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The parameter name isn't valid.
pub const ParameterPatternMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A parameter version can have a maximum of ten labels.
pub const ParameterVersionLabelLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified parameter version wasn't found. Verify the parameter name and
/// version, and try
/// again.
pub const ParameterVersionNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You specified more than the maximum number of allowed policies for the
/// parameter. The
/// maximum is 10.
pub const PoliciesLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A sync configuration with the same name already exists.
pub const ResourceDataSyncAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    sync_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .sync_name = "SyncName",
    };
};

/// Another `UpdateResourceDataSync` request is being processed. Wait a few
/// minutes
/// and try again.
pub const ResourceDataSyncConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have exceeded the allowed maximum sync configurations.
pub const ResourceDataSyncCountExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified sync configuration is invalid.
pub const ResourceDataSyncInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified sync name wasn't found.
pub const ResourceDataSyncNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    sync_name: ?[]const u8 = null,

    sync_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .sync_name = "SyncName",
        .sync_type = "SyncType",
    };
};

/// Error returned if an attempt is made to delete a patch baseline that is
/// registered for a
/// patch group.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Error returned when the caller has exceeded the default resource quotas. For
/// example, too
/// many maintenance windows or patch baselines have been created.
///
/// For information about resource quotas in Systems Manager, see [Systems
/// Manager service
/// quotas](https://docs.aws.amazon.com/general/latest/gr/ssm.html#limits_ssm)
/// in the
/// *Amazon Web Services General Reference*.
pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified parameter to be shared could not be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The hash provided in the call doesn't match the stored hash. This exception
/// is thrown when
/// trying to update an obsolete policy version or when multiple requests to
/// update a policy are
/// sent.
pub const ResourcePolicyConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more parameters specified for the call aren't valid. Verify the
/// parameters and their
/// values and try again.
pub const ResourcePolicyInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    parameter_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .parameter_names = "ParameterNames",
    };
};

/// The PutResourcePolicy API action enforces two limits. A policy can't be
/// greater than 1024 bytes in size. And only one policy can be attached to
/// `OpsItemGroup`. Verify these limits and try again.
pub const ResourcePolicyLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    limit: ?i32 = null,

    limit_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .limit_type = "LimitType",
        .message = "Message",
    };
};

/// No policies with the specified policy ID and hash could be found.
pub const ResourcePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request exceeds the service quota. Service quotas, also referred to as
/// limits, are the
/// maximum number of service resources or operations for your Amazon Web
/// Services account.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota code recognized by the Amazon Web Services Service Quotas service.
    quota_code: []const u8,

    /// The unique ID of the resource referenced in the failed request.
    resource_id: ?[]const u8 = null,

    /// The resource type of the resource referenced in the failed request.
    resource_type: ?[]const u8 = null,

    /// The code for the Amazon Web Services service that owns the quota.
    service_code: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .service_code = "ServiceCode",
    };
};

/// The specified service setting wasn't found. Either the service name or the
/// setting hasn't
/// been provisioned by the Amazon Web Services service team.
pub const ServiceSettingNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The updated status is the same as the current status.
pub const StatusUnchanged = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The sub-type count exceeded the limit for the inventory type.
pub const SubTypeCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You specified the `Safe` option for the
/// DeregisterTargetFromMaintenanceWindow
/// operation, but the target is still referenced in a task.
pub const TargetInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified target managed node for the session isn't fully configured for
/// use with Session Manager.
/// For more information, see [Setting up
/// Session
/// Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started.html) in the *Amazon Web Services Systems Manager User Guide*. This error is also returned if you
/// attempt to start a session on a managed node that is located in a different
/// account or
/// Region
pub const TargetNotConnected = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request or operation couldn't be performed because the service is
/// throttling
/// requests.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota code recognized by the Amazon Web Services Service Quotas service.
    quota_code: ?[]const u8 = null,

    /// The code for the Amazon Web Services service that owns the quota.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .quota_code = "QuotaCode",
        .service_code = "ServiceCode",
    };
};

/// The `Targets` parameter includes too many tags. Remove one or more tags and
/// try
/// the command again.
pub const TooManyTagsError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// There are concurrent updates for a resource that supports one update at a
/// time.
pub const TooManyUpdates = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The size of inventory data has exceeded the total size limit for the
/// resource.
pub const TotalSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The calendar entry contained in the specified SSM document isn't supported.
pub const UnsupportedCalendarException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Patching for applications released by Microsoft is only available on EC2
/// instances and
/// advanced instances. To patch applications released by Microsoft on
/// on-premises servers and VMs,
/// you must enable advanced instances. For more information, see [Turning on
/// the advanced-instances
/// tier](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-managedinstances-advanced.html) in the *Amazon Web Services Systems Manager User Guide*.
pub const UnsupportedFeatureRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The `Context` attribute that you specified for the `InventoryItem`
/// isn't allowed for this inventory type. You can only use the `Context`
/// attribute with
/// inventory types like `AWS:ComplianceItem`.
pub const UnsupportedInventoryItemContextException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .type_name = "TypeName",
    };
};

/// Inventory item type schema version has to match supported versions in the
/// service. Check
/// output of GetInventorySchema to see the available schema version for each
/// type.
pub const UnsupportedInventorySchemaVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operating systems you specified isn't supported, or the operation isn't
/// supported for
/// the operating system.
pub const UnsupportedOperatingSystem = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This operation is not supported for the current account. You must first
/// enable the Systems Manager integrated experience in your account.
pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The parameter type isn't supported.
pub const UnsupportedParameterType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The document doesn't support the platform type of the given managed node
/// IDs. For example,
/// you sent an document for a Windows managed node to a Linux node.
pub const UnsupportedPlatformType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request isn't valid. Verify that you entered valid contents for the
/// command and try
/// again.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason code for the invalid request.
    reason_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason_code = "ReasonCode",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
