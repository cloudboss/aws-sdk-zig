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

/// You do not have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when you start a new import and a previous import
/// is still in
/// progress.
pub const AccountHasOngoingImportException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified account is not found or not part
/// of an
/// organization.
pub const AccountNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified account is not registered as the
/// CloudTrail delegated administrator.
pub const AccountNotRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the account is already registered as the
/// CloudTrail
/// delegated administrator.
pub const AccountRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the management account of an organization is
/// registered as
/// the CloudTrail delegated administrator.
pub const CannotDelegateManagementAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided channel already exists.
pub const ChannelAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified value of `ChannelARN` is not
/// valid.
pub const ChannelARNInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified event data store cannot yet be
/// deleted because it
/// is in use by a channel.
pub const ChannelExistsForEDSException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the maximum number of channels limit is
/// exceeded.
pub const ChannelMaxLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when CloudTrail cannot find the specified channel.
pub const ChannelNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when trusted access has not been enabled between
/// CloudTrail and Organizations. For more information, see [How to enable or
/// disable trusted
/// access](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html#orgs_how-to-enable-disable-trusted-access) in the *Organizations User Guide* and [Prepare For Creating a Trail For Your Organization](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/creating-an-organizational-trail-prepare.html) in the *CloudTrail User Guide*.
pub const CloudTrailAccessNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when an operation is called with an ARN that is not
/// valid.
///
/// The following is the format of a trail ARN:
/// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
///
/// The following is the format of an event data store ARN:
/// `arn:aws:cloudtrail:us-east-2:123456789012:eventdatastore/EXAMPLE-f852-4e8f-8bd1-bcf6cEXAMPLE`
///
/// The following is the format of a dashboard ARN:
/// `arn:aws:cloudtrail:us-east-1:123456789012:dashboard/exampleDash`
///
/// The following is the format of a channel ARN:
/// `arn:aws:cloudtrail:us-east-2:123456789012:channel/01234567890`
pub const CloudTrailARNInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when a call results in the `InvalidClientTokenId`
/// error code. This can occur when you are creating or updating a trail to send
/// notifications
/// to an Amazon SNS topic that is in a suspended Amazon Web Services account.
pub const CloudTrailInvalidClientTokenIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Cannot set a CloudWatch Logs delivery for this Region.
pub const CloudWatchLogsDeliveryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You are trying to update a resource when another request is in progress.
/// Allow sufficient wait time for the previous request to complete, then retry
/// your request.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified resource is not ready for an
/// operation. This
/// can occur when you try to run an operation on a resource before CloudTrail
/// has time
/// to fully load the resource, or because another operation is modifying the
/// resource. If this exception occurs, wait a few minutes, and then try the
/// operation again.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the maximum number of CloudTrail delegated
/// administrators is reached.
pub const DelegatedAdminAccountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An event data store with that name already exists.
pub const EventDataStoreAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified event data store ARN is not valid or does not map to an event
/// data store
/// in your account.
pub const EventDataStoreARNInvalidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You cannot delete the event data store because Lake query federation is
/// enabled. To delete the event data store, run the `DisableFederation`
/// operation to
/// disable Lake query federation on the event data store.
pub const EventDataStoreFederationEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when you try to update or delete an event data
/// store that
/// currently has an import in progress.
pub const EventDataStoreHasOngoingImportException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Your account has used the maximum number of event data stores.
pub const EventDataStoreMaxLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified event data store was not found.
pub const EventDataStoreNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The event data store cannot be deleted because termination protection is
/// enabled for
/// it.
pub const EventDataStoreTerminationProtectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when a valid query could not be generated for the
/// provided prompt.
pub const GenerateResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified import was not found.
pub const ImportNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The event data store is inactive.
pub const InactiveEventDataStoreException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified query cannot be canceled because it is in the `FINISHED`,
/// `FAILED`, `TIMED_OUT`, or `CANCELLED` state.
pub const InactiveQueryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// If you run `GetInsightSelectors` on a trail or event data store that does
/// not have Insights
/// events enabled, the operation throws the exception
/// `InsightNotEnabledException`.
pub const InsightNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the IAM identity that is used to create
/// the organization resource lacks one or more required permissions for
/// creating an
/// organization resource in a required service.
pub const InsufficientDependencyServiceAccessPermissionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// For the `CreateTrail`
/// `PutInsightSelectors`, `UpdateTrail`, `StartQuery`, and `StartImport`
/// operations, this exception is thrown
/// when the policy on the S3 bucket or KMS key does
/// not have sufficient permissions for the operation.
///
/// For all other operations, this exception is thrown when the policy for the
/// KMS key does
/// not have sufficient permissions for the operation.
pub const InsufficientEncryptionPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The task can't be completed because you are signed in with an account that
/// lacks permissions to view or create a service-linked role. Sign in with an
/// account that has the required permissions and then try again.
pub const InsufficientIAMAccessPermissionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the policy on the S3 bucket is not sufficient.
pub const InsufficientS3BucketPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the policy on the Amazon SNS topic is not
/// sufficient.
pub const InsufficientSnsTopicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided CloudWatch Logs log group is not
/// valid.
pub const InvalidCloudWatchLogsLogGroupArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided role is not valid.
pub const InvalidCloudWatchLogsRoleArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A date range for the query was specified that is not valid. Be sure that the
/// start time
/// is chronologically before the end time. For more information about writing a
/// query, see
/// [Create or edit a
/// query](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-create-edit-query.html) in the *CloudTrail User Guide*.
pub const InvalidDateRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Occurs if an event category that is not valid is specified as a value of
/// `EventCategory`.
pub const InvalidEventCategoryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when event categories of specified event data
/// stores are not
/// valid.
pub const InvalidEventDataStoreCategoryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The event data store is not in a status that supports the operation.
pub const InvalidEventDataStoreStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the `PutEventSelectors` operation is called
/// with a number of event selectors, advanced event selectors, or data
/// resources that is not
/// valid. The combination of event selectors or advanced event selectors and
/// data resources is
/// not valid. A trail can have up to 5 event selectors. If a trail uses
/// advanced event
/// selectors, a maximum of 500 total values for all conditions in all advanced
/// event selectors
/// is allowed. A trail is limited to 250 data resources. These data resources
/// can be
/// distributed across event selectors, but the overall total cannot exceed 250.
///
/// You can:
///
/// * Specify a valid number of event selectors (1 to 5) for a trail.
///
/// * Specify a valid number of data resources (1 to 250) for an event selector.
///   The
/// limit of number of resources on an individual event selector is configurable
/// up to
/// 250. However, this upper limit is allowed only if the total number of data
/// resources
/// does not exceed 250 across all event selectors for a trail.
///
/// * Specify up to 500 values for all conditions in all advanced event
///   selectors for a
/// trail.
///
/// * Specify a valid value for a parameter. For example, specifying the
/// `ReadWriteType` parameter with a value of `read-only` is not
/// valid.
pub const InvalidEventSelectorsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when an operation is called on a trail from a
/// Region other than
/// the Region in which the trail was created.
pub const InvalidHomeRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided source S3 bucket is not valid for
/// import.
pub const InvalidImportSourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// For `PutInsightSelectors`, this exception is thrown when the formatting or
/// syntax of the `InsightSelectors` JSON statement is not
/// valid, or the specified `InsightType` in the `InsightSelectors` statement is
/// not
/// valid. Valid values for `InsightType` are `ApiCallRateInsight` and
/// `ApiErrorRateInsight`. To enable Insights on an event data store, the
/// destination event data store specified by the
/// `InsightsDestination` parameter must log Insights events and the source
/// event data
/// store specified by the `EventDataStore` parameter must log management
/// events.
///
/// For `UpdateEventDataStore`, this exception is thrown if Insights are enabled
/// on the event data store and the updated
/// advanced event selectors are not compatible with the configured
/// `InsightSelectors`.
/// If the `InsightSelectors` includes an `InsightType` of `ApiCallRateInsight`,
/// the source event data store must log `write` management events.
/// If the `InsightSelectors` includes an `InsightType` of
/// `ApiErrorRateInsight`, the source event data store must log management
/// events.
pub const InvalidInsightSelectorsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the KMS key ARN is not valid.
pub const InvalidKmsKeyIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Occurs when a lookup attribute is specified that is not valid.
pub const InvalidLookupAttributesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown if the limit specified is not valid.
pub const InvalidMaxResultsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A token that is not valid, or a token that was previously used in a request
/// with
/// different parameters. This exception is thrown if the token is not valid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the combination of parameters provided is not
/// valid.
pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request includes a parameter that is not valid.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The query that was submitted has validation errors, or uses incorrect syntax
/// or
/// unsupported keywords. For more information about writing a query, see
/// [Create or edit a
/// query](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-create-edit-query.html) in the *CloudTrail User
/// Guide*.
pub const InvalidQueryStatementException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The query status is not valid for the operation.
pub const InvalidQueryStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided S3 bucket name is not valid.
pub const InvalidS3BucketNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided S3 prefix is not valid.
pub const InvalidS3PrefixException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided SNS topic name is not valid.
pub const InvalidSnsTopicNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified value of `Source` is not valid.
pub const InvalidSourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified tag key or values are not valid.
/// It can also
/// occur if there are duplicate tags or too many tags on the resource.
pub const InvalidTagParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Occurs if the timestamp values are not valid. Either the start time occurs
/// after the end
/// time, or the time range is outside the range of possible values.
pub const InvalidTimeRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Reserved for future use.
pub const InvalidTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided trail name is not valid. Trail
/// names must
/// meet the following requirements:
///
/// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.),
///   underscores
/// (_), or dashes (-)
///
/// * Start with a letter or number, and end with a letter or number
///
/// * Be between 3 and 128 characters
///
/// * Have no adjacent periods, underscores or dashes. Names like
/// `my-_namespace` and `my--namespace` are not valid.
///
/// * Not be in IP address format (for example, 192.168.5.4)
pub const InvalidTrailNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when there is an issue with the specified KMS
/// key and the trail or event data store can't be updated.
pub const KmsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is no longer in use.
pub const KmsKeyDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the KMS key does not exist, when the S3
/// bucket and the KMS key are not in the same Region, or when the KMS key
/// associated with the Amazon SNS topic either does not exist or is
/// not in the same Region.
pub const KmsKeyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You are already running the maximum number of concurrent queries. The
/// maximum number of concurrent queries is 10. Wait a minute for some
/// queries to finish, and then run the query again.
pub const MaxConcurrentQueriesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the maximum number of trails is reached.
pub const MaximumNumberOfTrailsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the management account does not have a
/// service-linked
/// role.
pub const NoManagementAccountSLRExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the account making the request is not the
/// organization's
/// management account.
pub const NotOrganizationManagementAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the Amazon Web Services account making the
/// request to
/// create or update an organization trail or event data store is not the
/// management account
/// for an organization in Organizations. For more information, see [Prepare For
/// Creating a Trail For Your
/// Organization](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/creating-an-organizational-trail-prepare.html) or [Organization event data stores](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-lake-organizations.html).
pub const NotOrganizationMasterAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the requested operation is not permitted.
pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when Organizations is not configured to support all
/// features. All features must be enabled in Organizations to support creating
/// an
/// organization trail or event data store.
pub const OrganizationNotInAllFeaturesModeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the request is made from an Amazon Web
/// Services account
/// that is not a member of an organization. To make this request, sign in using
/// the
/// credentials of an account that belongs to an organization.
pub const OrganizationsNotInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The query ID does not exist or does not map to a query.
pub const QueryIdNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the provided resource does not exist, or the
/// ARN format of the resource is not valid.
///
/// The following is the format of an event data store ARN:
/// `arn:aws:cloudtrail:us-east-2:123456789012:eventdatastore/EXAMPLE-f852-4e8f-8bd1-bcf6cEXAMPLE`
///
/// The following is the format of a dashboard ARN:
/// `arn:aws:cloudtrail:us-east-1:123456789012:dashboard/exampleDash`
///
/// The following is the format of a channel ARN:
/// `arn:aws:cloudtrail:us-east-2:123456789012:channel/01234567890`
pub const ResourceARNNotValidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified resource is not found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified resource policy is not found.
pub const ResourcePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the resouce-based policy has syntax errors, or
/// contains a principal that is not valid.
pub const ResourcePolicyNotValidException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified resource type is not supported
/// by CloudTrail.
pub const ResourceTypeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified S3 bucket does not exist.
pub const S3BucketDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the quota is exceeded. For information about
/// CloudTrail quotas, see [Service
/// quotas](https://docs.aws.amazon.com/general/latest/gr/ct.html#limits_cloudtrail)
/// in the *Amazon Web Services General Reference*.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of tags per trail, event data store, dashboard, or channel has
/// exceeded the permitted amount. Currently, the limit is
/// 50.
pub const TagsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the request rate exceeds the limit.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the specified trail already exists.
pub const TrailAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the trail with the given name is not found.
pub const TrailNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is no longer in use.
pub const TrailNotProvidedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This exception is thrown when the requested operation is not supported.
pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
