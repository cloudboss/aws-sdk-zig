const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        account_has_ongoing_import_exception: AccountHasOngoingImportException,
        account_not_found_exception: AccountNotFoundException,
        account_not_registered_exception: AccountNotRegisteredException,
        account_registered_exception: AccountRegisteredException,
        cannot_delegate_management_account_exception: CannotDelegateManagementAccountException,
        channel_already_exists_exception: ChannelAlreadyExistsException,
        channel_arn_invalid_exception: ChannelARNInvalidException,
        channel_exists_for_eds_exception: ChannelExistsForEDSException,
        channel_max_limit_exceeded_exception: ChannelMaxLimitExceededException,
        channel_not_found_exception: ChannelNotFoundException,
        cloud_trail_access_not_enabled_exception: CloudTrailAccessNotEnabledException,
        cloud_trail_arn_invalid_exception: CloudTrailARNInvalidException,
        cloud_trail_invalid_client_token_id_exception: CloudTrailInvalidClientTokenIdException,
        cloud_watch_logs_delivery_unavailable_exception: CloudWatchLogsDeliveryUnavailableException,
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        delegated_admin_account_limit_exceeded_exception: DelegatedAdminAccountLimitExceededException,
        event_data_store_already_exists_exception: EventDataStoreAlreadyExistsException,
        event_data_store_arn_invalid_exception: EventDataStoreARNInvalidException,
        event_data_store_federation_enabled_exception: EventDataStoreFederationEnabledException,
        event_data_store_has_ongoing_import_exception: EventDataStoreHasOngoingImportException,
        event_data_store_max_limit_exceeded_exception: EventDataStoreMaxLimitExceededException,
        event_data_store_not_found_exception: EventDataStoreNotFoundException,
        event_data_store_termination_protected_exception: EventDataStoreTerminationProtectedException,
        generate_response_exception: GenerateResponseException,
        import_not_found_exception: ImportNotFoundException,
        inactive_event_data_store_exception: InactiveEventDataStoreException,
        inactive_query_exception: InactiveQueryException,
        insight_not_enabled_exception: InsightNotEnabledException,
        insufficient_dependency_service_access_permission_exception: InsufficientDependencyServiceAccessPermissionException,
        insufficient_encryption_policy_exception: InsufficientEncryptionPolicyException,
        insufficient_iam_access_permission_exception: InsufficientIAMAccessPermissionException,
        insufficient_s3_bucket_policy_exception: InsufficientS3BucketPolicyException,
        insufficient_sns_topic_policy_exception: InsufficientSnsTopicPolicyException,
        invalid_cloud_watch_logs_log_group_arn_exception: InvalidCloudWatchLogsLogGroupArnException,
        invalid_cloud_watch_logs_role_arn_exception: InvalidCloudWatchLogsRoleArnException,
        invalid_date_range_exception: InvalidDateRangeException,
        invalid_event_category_exception: InvalidEventCategoryException,
        invalid_event_data_store_category_exception: InvalidEventDataStoreCategoryException,
        invalid_event_data_store_status_exception: InvalidEventDataStoreStatusException,
        invalid_event_selectors_exception: InvalidEventSelectorsException,
        invalid_home_region_exception: InvalidHomeRegionException,
        invalid_import_source_exception: InvalidImportSourceException,
        invalid_insight_selectors_exception: InvalidInsightSelectorsException,
        invalid_kms_key_id_exception: InvalidKmsKeyIdException,
        invalid_lookup_attributes_exception: InvalidLookupAttributesException,
        invalid_max_results_exception: InvalidMaxResultsException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_query_statement_exception: InvalidQueryStatementException,
        invalid_query_status_exception: InvalidQueryStatusException,
        invalid_s3_bucket_name_exception: InvalidS3BucketNameException,
        invalid_s3_prefix_exception: InvalidS3PrefixException,
        invalid_sns_topic_name_exception: InvalidSnsTopicNameException,
        invalid_source_exception: InvalidSourceException,
        invalid_tag_parameter_exception: InvalidTagParameterException,
        invalid_time_range_exception: InvalidTimeRangeException,
        invalid_token_exception: InvalidTokenException,
        invalid_trail_name_exception: InvalidTrailNameException,
        kms_exception: KmsException,
        kms_key_disabled_exception: KmsKeyDisabledException,
        kms_key_not_found_exception: KmsKeyNotFoundException,
        max_concurrent_queries_exception: MaxConcurrentQueriesException,
        maximum_number_of_trails_exceeded_exception: MaximumNumberOfTrailsExceededException,
        no_management_account_slr_exists_exception: NoManagementAccountSLRExistsException,
        not_organization_management_account_exception: NotOrganizationManagementAccountException,
        not_organization_master_account_exception: NotOrganizationMasterAccountException,
        operation_not_permitted_exception: OperationNotPermittedException,
        organization_not_in_all_features_mode_exception: OrganizationNotInAllFeaturesModeException,
        organizations_not_in_use_exception: OrganizationsNotInUseException,
        query_id_not_found_exception: QueryIdNotFoundException,
        resource_arn_not_valid_exception: ResourceARNNotValidException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_policy_not_found_exception: ResourcePolicyNotFoundException,
        resource_policy_not_valid_exception: ResourcePolicyNotValidException,
        resource_type_not_supported_exception: ResourceTypeNotSupportedException,
        s3_bucket_does_not_exist_exception: S3BucketDoesNotExistException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        tags_limit_exceeded_exception: TagsLimitExceededException,
        throttling_exception: ThrottlingException,
        trail_already_exists_exception: TrailAlreadyExistsException,
        trail_not_found_exception: TrailNotFoundException,
        trail_not_provided_exception: TrailNotProvidedException,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .account_has_ongoing_import_exception => "AccountHasOngoingImportException",
                .account_not_found_exception => "AccountNotFoundException",
                .account_not_registered_exception => "AccountNotRegisteredException",
                .account_registered_exception => "AccountRegisteredException",
                .cannot_delegate_management_account_exception => "CannotDelegateManagementAccountException",
                .channel_already_exists_exception => "ChannelAlreadyExistsException",
                .channel_arn_invalid_exception => "ChannelARNInvalidException",
                .channel_exists_for_eds_exception => "ChannelExistsForEDSException",
                .channel_max_limit_exceeded_exception => "ChannelMaxLimitExceededException",
                .channel_not_found_exception => "ChannelNotFoundException",
                .cloud_trail_access_not_enabled_exception => "CloudTrailAccessNotEnabledException",
                .cloud_trail_arn_invalid_exception => "CloudTrailARNInvalidException",
                .cloud_trail_invalid_client_token_id_exception => "CloudTrailInvalidClientTokenIdException",
                .cloud_watch_logs_delivery_unavailable_exception => "CloudWatchLogsDeliveryUnavailableException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .delegated_admin_account_limit_exceeded_exception => "DelegatedAdminAccountLimitExceededException",
                .event_data_store_already_exists_exception => "EventDataStoreAlreadyExistsException",
                .event_data_store_arn_invalid_exception => "EventDataStoreARNInvalidException",
                .event_data_store_federation_enabled_exception => "EventDataStoreFederationEnabledException",
                .event_data_store_has_ongoing_import_exception => "EventDataStoreHasOngoingImportException",
                .event_data_store_max_limit_exceeded_exception => "EventDataStoreMaxLimitExceededException",
                .event_data_store_not_found_exception => "EventDataStoreNotFoundException",
                .event_data_store_termination_protected_exception => "EventDataStoreTerminationProtectedException",
                .generate_response_exception => "GenerateResponseException",
                .import_not_found_exception => "ImportNotFoundException",
                .inactive_event_data_store_exception => "InactiveEventDataStoreException",
                .inactive_query_exception => "InactiveQueryException",
                .insight_not_enabled_exception => "InsightNotEnabledException",
                .insufficient_dependency_service_access_permission_exception => "InsufficientDependencyServiceAccessPermissionException",
                .insufficient_encryption_policy_exception => "InsufficientEncryptionPolicyException",
                .insufficient_iam_access_permission_exception => "InsufficientIAMAccessPermissionException",
                .insufficient_s3_bucket_policy_exception => "InsufficientS3BucketPolicyException",
                .insufficient_sns_topic_policy_exception => "InsufficientSnsTopicPolicyException",
                .invalid_cloud_watch_logs_log_group_arn_exception => "InvalidCloudWatchLogsLogGroupArnException",
                .invalid_cloud_watch_logs_role_arn_exception => "InvalidCloudWatchLogsRoleArnException",
                .invalid_date_range_exception => "InvalidDateRangeException",
                .invalid_event_category_exception => "InvalidEventCategoryException",
                .invalid_event_data_store_category_exception => "InvalidEventDataStoreCategoryException",
                .invalid_event_data_store_status_exception => "InvalidEventDataStoreStatusException",
                .invalid_event_selectors_exception => "InvalidEventSelectorsException",
                .invalid_home_region_exception => "InvalidHomeRegionException",
                .invalid_import_source_exception => "InvalidImportSourceException",
                .invalid_insight_selectors_exception => "InvalidInsightSelectorsException",
                .invalid_kms_key_id_exception => "InvalidKmsKeyIdException",
                .invalid_lookup_attributes_exception => "InvalidLookupAttributesException",
                .invalid_max_results_exception => "InvalidMaxResultsException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_query_statement_exception => "InvalidQueryStatementException",
                .invalid_query_status_exception => "InvalidQueryStatusException",
                .invalid_s3_bucket_name_exception => "InvalidS3BucketNameException",
                .invalid_s3_prefix_exception => "InvalidS3PrefixException",
                .invalid_sns_topic_name_exception => "InvalidSnsTopicNameException",
                .invalid_source_exception => "InvalidSourceException",
                .invalid_tag_parameter_exception => "InvalidTagParameterException",
                .invalid_time_range_exception => "InvalidTimeRangeException",
                .invalid_token_exception => "InvalidTokenException",
                .invalid_trail_name_exception => "InvalidTrailNameException",
                .kms_exception => "KmsException",
                .kms_key_disabled_exception => "KmsKeyDisabledException",
                .kms_key_not_found_exception => "KmsKeyNotFoundException",
                .max_concurrent_queries_exception => "MaxConcurrentQueriesException",
                .maximum_number_of_trails_exceeded_exception => "MaximumNumberOfTrailsExceededException",
                .no_management_account_slr_exists_exception => "NoManagementAccountSLRExistsException",
                .not_organization_management_account_exception => "NotOrganizationManagementAccountException",
                .not_organization_master_account_exception => "NotOrganizationMasterAccountException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .organization_not_in_all_features_mode_exception => "OrganizationNotInAllFeaturesModeException",
                .organizations_not_in_use_exception => "OrganizationsNotInUseException",
                .query_id_not_found_exception => "QueryIdNotFoundException",
                .resource_arn_not_valid_exception => "ResourceARNNotValidException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_policy_not_found_exception => "ResourcePolicyNotFoundException",
                .resource_policy_not_valid_exception => "ResourcePolicyNotValidException",
                .resource_type_not_supported_exception => "ResourceTypeNotSupportedException",
                .s3_bucket_does_not_exist_exception => "S3BucketDoesNotExistException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .tags_limit_exceeded_exception => "TagsLimitExceededException",
                .throttling_exception => "ThrottlingException",
                .trail_already_exists_exception => "TrailAlreadyExistsException",
                .trail_not_found_exception => "TrailNotFoundException",
                .trail_not_provided_exception => "TrailNotProvidedException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .account_has_ongoing_import_exception => |e| e.message,
                .account_not_found_exception => |e| e.message,
                .account_not_registered_exception => |e| e.message,
                .account_registered_exception => |e| e.message,
                .cannot_delegate_management_account_exception => |e| e.message,
                .channel_already_exists_exception => |e| e.message,
                .channel_arn_invalid_exception => |e| e.message,
                .channel_exists_for_eds_exception => |e| e.message,
                .channel_max_limit_exceeded_exception => |e| e.message,
                .channel_not_found_exception => |e| e.message,
                .cloud_trail_access_not_enabled_exception => |e| e.message,
                .cloud_trail_arn_invalid_exception => |e| e.message,
                .cloud_trail_invalid_client_token_id_exception => |e| e.message,
                .cloud_watch_logs_delivery_unavailable_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .delegated_admin_account_limit_exceeded_exception => |e| e.message,
                .event_data_store_already_exists_exception => |e| e.message,
                .event_data_store_arn_invalid_exception => |e| e.message,
                .event_data_store_federation_enabled_exception => |e| e.message,
                .event_data_store_has_ongoing_import_exception => |e| e.message,
                .event_data_store_max_limit_exceeded_exception => |e| e.message,
                .event_data_store_not_found_exception => |e| e.message,
                .event_data_store_termination_protected_exception => |e| e.message,
                .generate_response_exception => |e| e.message,
                .import_not_found_exception => |e| e.message,
                .inactive_event_data_store_exception => |e| e.message,
                .inactive_query_exception => |e| e.message,
                .insight_not_enabled_exception => |e| e.message,
                .insufficient_dependency_service_access_permission_exception => |e| e.message,
                .insufficient_encryption_policy_exception => |e| e.message,
                .insufficient_iam_access_permission_exception => |e| e.message,
                .insufficient_s3_bucket_policy_exception => |e| e.message,
                .insufficient_sns_topic_policy_exception => |e| e.message,
                .invalid_cloud_watch_logs_log_group_arn_exception => |e| e.message,
                .invalid_cloud_watch_logs_role_arn_exception => |e| e.message,
                .invalid_date_range_exception => |e| e.message,
                .invalid_event_category_exception => |e| e.message,
                .invalid_event_data_store_category_exception => |e| e.message,
                .invalid_event_data_store_status_exception => |e| e.message,
                .invalid_event_selectors_exception => |e| e.message,
                .invalid_home_region_exception => |e| e.message,
                .invalid_import_source_exception => |e| e.message,
                .invalid_insight_selectors_exception => |e| e.message,
                .invalid_kms_key_id_exception => |e| e.message,
                .invalid_lookup_attributes_exception => |e| e.message,
                .invalid_max_results_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_query_statement_exception => |e| e.message,
                .invalid_query_status_exception => |e| e.message,
                .invalid_s3_bucket_name_exception => |e| e.message,
                .invalid_s3_prefix_exception => |e| e.message,
                .invalid_sns_topic_name_exception => |e| e.message,
                .invalid_source_exception => |e| e.message,
                .invalid_tag_parameter_exception => |e| e.message,
                .invalid_time_range_exception => |e| e.message,
                .invalid_token_exception => |e| e.message,
                .invalid_trail_name_exception => |e| e.message,
                .kms_exception => |e| e.message,
                .kms_key_disabled_exception => |e| e.message,
                .kms_key_not_found_exception => |e| e.message,
                .max_concurrent_queries_exception => |e| e.message,
                .maximum_number_of_trails_exceeded_exception => |e| e.message,
                .no_management_account_slr_exists_exception => |e| e.message,
                .not_organization_management_account_exception => |e| e.message,
                .not_organization_master_account_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .organization_not_in_all_features_mode_exception => |e| e.message,
                .organizations_not_in_use_exception => |e| e.message,
                .query_id_not_found_exception => |e| e.message,
                .resource_arn_not_valid_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_policy_not_found_exception => |e| e.message,
                .resource_policy_not_valid_exception => |e| e.message,
                .resource_type_not_supported_exception => |e| e.message,
                .s3_bucket_does_not_exist_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .tags_limit_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .trail_already_exists_exception => |e| e.message,
                .trail_not_found_exception => |e| e.message,
                .trail_not_provided_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .account_has_ongoing_import_exception => 400,
                .account_not_found_exception => 404,
                .account_not_registered_exception => 400,
                .account_registered_exception => 400,
                .cannot_delegate_management_account_exception => 400,
                .channel_already_exists_exception => 400,
                .channel_arn_invalid_exception => 400,
                .channel_exists_for_eds_exception => 400,
                .channel_max_limit_exceeded_exception => 400,
                .channel_not_found_exception => 404,
                .cloud_trail_access_not_enabled_exception => 400,
                .cloud_trail_arn_invalid_exception => 400,
                .cloud_trail_invalid_client_token_id_exception => 400,
                .cloud_watch_logs_delivery_unavailable_exception => 400,
                .concurrent_modification_exception => 400,
                .conflict_exception => 409,
                .delegated_admin_account_limit_exceeded_exception => 400,
                .event_data_store_already_exists_exception => 400,
                .event_data_store_arn_invalid_exception => 400,
                .event_data_store_federation_enabled_exception => 400,
                .event_data_store_has_ongoing_import_exception => 400,
                .event_data_store_max_limit_exceeded_exception => 400,
                .event_data_store_not_found_exception => 404,
                .event_data_store_termination_protected_exception => 400,
                .generate_response_exception => 400,
                .import_not_found_exception => 404,
                .inactive_event_data_store_exception => 400,
                .inactive_query_exception => 400,
                .insight_not_enabled_exception => 400,
                .insufficient_dependency_service_access_permission_exception => 400,
                .insufficient_encryption_policy_exception => 400,
                .insufficient_iam_access_permission_exception => 400,
                .insufficient_s3_bucket_policy_exception => 403,
                .insufficient_sns_topic_policy_exception => 403,
                .invalid_cloud_watch_logs_log_group_arn_exception => 400,
                .invalid_cloud_watch_logs_role_arn_exception => 400,
                .invalid_date_range_exception => 400,
                .invalid_event_category_exception => 400,
                .invalid_event_data_store_category_exception => 400,
                .invalid_event_data_store_status_exception => 400,
                .invalid_event_selectors_exception => 400,
                .invalid_home_region_exception => 400,
                .invalid_import_source_exception => 400,
                .invalid_insight_selectors_exception => 400,
                .invalid_kms_key_id_exception => 400,
                .invalid_lookup_attributes_exception => 400,
                .invalid_max_results_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_query_statement_exception => 400,
                .invalid_query_status_exception => 400,
                .invalid_s3_bucket_name_exception => 400,
                .invalid_s3_prefix_exception => 400,
                .invalid_sns_topic_name_exception => 400,
                .invalid_source_exception => 400,
                .invalid_tag_parameter_exception => 400,
                .invalid_time_range_exception => 400,
                .invalid_token_exception => 400,
                .invalid_trail_name_exception => 400,
                .kms_exception => 400,
                .kms_key_disabled_exception => 400,
                .kms_key_not_found_exception => 400,
                .max_concurrent_queries_exception => 429,
                .maximum_number_of_trails_exceeded_exception => 403,
                .no_management_account_slr_exists_exception => 403,
                .not_organization_management_account_exception => 403,
                .not_organization_master_account_exception => 400,
                .operation_not_permitted_exception => 400,
                .organization_not_in_all_features_mode_exception => 400,
                .organizations_not_in_use_exception => 404,
                .query_id_not_found_exception => 404,
                .resource_arn_not_valid_exception => 400,
                .resource_not_found_exception => 400,
                .resource_policy_not_found_exception => 404,
                .resource_policy_not_valid_exception => 400,
                .resource_type_not_supported_exception => 400,
                .s3_bucket_does_not_exist_exception => 404,
                .service_quota_exceeded_exception => 400,
                .tags_limit_exceeded_exception => 400,
                .throttling_exception => 429,
                .trail_already_exists_exception => 400,
                .trail_not_found_exception => 404,
                .trail_not_provided_exception => 404,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .account_has_ongoing_import_exception => |e| e.request_id,
                .account_not_found_exception => |e| e.request_id,
                .account_not_registered_exception => |e| e.request_id,
                .account_registered_exception => |e| e.request_id,
                .cannot_delegate_management_account_exception => |e| e.request_id,
                .channel_already_exists_exception => |e| e.request_id,
                .channel_arn_invalid_exception => |e| e.request_id,
                .channel_exists_for_eds_exception => |e| e.request_id,
                .channel_max_limit_exceeded_exception => |e| e.request_id,
                .channel_not_found_exception => |e| e.request_id,
                .cloud_trail_access_not_enabled_exception => |e| e.request_id,
                .cloud_trail_arn_invalid_exception => |e| e.request_id,
                .cloud_trail_invalid_client_token_id_exception => |e| e.request_id,
                .cloud_watch_logs_delivery_unavailable_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .delegated_admin_account_limit_exceeded_exception => |e| e.request_id,
                .event_data_store_already_exists_exception => |e| e.request_id,
                .event_data_store_arn_invalid_exception => |e| e.request_id,
                .event_data_store_federation_enabled_exception => |e| e.request_id,
                .event_data_store_has_ongoing_import_exception => |e| e.request_id,
                .event_data_store_max_limit_exceeded_exception => |e| e.request_id,
                .event_data_store_not_found_exception => |e| e.request_id,
                .event_data_store_termination_protected_exception => |e| e.request_id,
                .generate_response_exception => |e| e.request_id,
                .import_not_found_exception => |e| e.request_id,
                .inactive_event_data_store_exception => |e| e.request_id,
                .inactive_query_exception => |e| e.request_id,
                .insight_not_enabled_exception => |e| e.request_id,
                .insufficient_dependency_service_access_permission_exception => |e| e.request_id,
                .insufficient_encryption_policy_exception => |e| e.request_id,
                .insufficient_iam_access_permission_exception => |e| e.request_id,
                .insufficient_s3_bucket_policy_exception => |e| e.request_id,
                .insufficient_sns_topic_policy_exception => |e| e.request_id,
                .invalid_cloud_watch_logs_log_group_arn_exception => |e| e.request_id,
                .invalid_cloud_watch_logs_role_arn_exception => |e| e.request_id,
                .invalid_date_range_exception => |e| e.request_id,
                .invalid_event_category_exception => |e| e.request_id,
                .invalid_event_data_store_category_exception => |e| e.request_id,
                .invalid_event_data_store_status_exception => |e| e.request_id,
                .invalid_event_selectors_exception => |e| e.request_id,
                .invalid_home_region_exception => |e| e.request_id,
                .invalid_import_source_exception => |e| e.request_id,
                .invalid_insight_selectors_exception => |e| e.request_id,
                .invalid_kms_key_id_exception => |e| e.request_id,
                .invalid_lookup_attributes_exception => |e| e.request_id,
                .invalid_max_results_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_query_statement_exception => |e| e.request_id,
                .invalid_query_status_exception => |e| e.request_id,
                .invalid_s3_bucket_name_exception => |e| e.request_id,
                .invalid_s3_prefix_exception => |e| e.request_id,
                .invalid_sns_topic_name_exception => |e| e.request_id,
                .invalid_source_exception => |e| e.request_id,
                .invalid_tag_parameter_exception => |e| e.request_id,
                .invalid_time_range_exception => |e| e.request_id,
                .invalid_token_exception => |e| e.request_id,
                .invalid_trail_name_exception => |e| e.request_id,
                .kms_exception => |e| e.request_id,
                .kms_key_disabled_exception => |e| e.request_id,
                .kms_key_not_found_exception => |e| e.request_id,
                .max_concurrent_queries_exception => |e| e.request_id,
                .maximum_number_of_trails_exceeded_exception => |e| e.request_id,
                .no_management_account_slr_exists_exception => |e| e.request_id,
                .not_organization_management_account_exception => |e| e.request_id,
                .not_organization_master_account_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .organization_not_in_all_features_mode_exception => |e| e.request_id,
                .organizations_not_in_use_exception => |e| e.request_id,
                .query_id_not_found_exception => |e| e.request_id,
                .resource_arn_not_valid_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_policy_not_found_exception => |e| e.request_id,
                .resource_policy_not_valid_exception => |e| e.request_id,
                .resource_type_not_supported_exception => |e| e.request_id,
                .s3_bucket_does_not_exist_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .tags_limit_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .trail_already_exists_exception => |e| e.request_id,
                .trail_not_found_exception => |e| e.request_id,
                .trail_not_provided_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountHasOngoingImportException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountNotRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotDelegateManagementAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelARNInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelExistsForEDSException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelMaxLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudTrailAccessNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudTrailARNInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudTrailInvalidClientTokenIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudWatchLogsDeliveryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DelegatedAdminAccountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreARNInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreFederationEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreHasOngoingImportException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreMaxLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EventDataStoreTerminationProtectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GenerateResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImportNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InactiveEventDataStoreException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InactiveQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsightNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientDependencyServiceAccessPermissionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientEncryptionPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientIAMAccessPermissionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientS3BucketPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientSnsTopicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCloudWatchLogsLogGroupArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCloudWatchLogsRoleArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDateRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventCategoryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventDataStoreCategoryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventDataStoreStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEventSelectorsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidHomeRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidImportSourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInsightSelectorsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKmsKeyIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLookupAttributesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMaxResultsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidQueryStatementException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidQueryStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3BucketNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3PrefixException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSnsTopicNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTimeRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTrailNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsKeyDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsKeyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxConcurrentQueriesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumNumberOfTrailsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoManagementAccountSLRExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotOrganizationManagementAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotOrganizationMasterAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationNotInAllFeaturesModeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationsNotInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryIdNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceARNNotValidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyNotValidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceTypeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3BucketDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrailAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrailNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrailNotProvidedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
