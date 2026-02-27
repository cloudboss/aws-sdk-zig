const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied: AccessDenied,
        batch_too_large: BatchTooLarge,
        cache_policy_already_exists: CachePolicyAlreadyExists,
        cache_policy_in_use: CachePolicyInUse,
        cannot_change_immutable_public_key_fields: CannotChangeImmutablePublicKeyFields,
        cannot_delete_entity_while_in_use: CannotDeleteEntityWhileInUse,
        cannot_update_entity_while_in_use: CannotUpdateEntityWhileInUse,
        cloud_front_origin_access_identity_already_exists: CloudFrontOriginAccessIdentityAlreadyExists,
        cloud_front_origin_access_identity_in_use: CloudFrontOriginAccessIdentityInUse,
        cname_already_exists: CNAMEAlreadyExists,
        continuous_deployment_policy_already_exists: ContinuousDeploymentPolicyAlreadyExists,
        continuous_deployment_policy_in_use: ContinuousDeploymentPolicyInUse,
        distribution_already_exists: DistributionAlreadyExists,
        distribution_not_disabled: DistributionNotDisabled,
        entity_already_exists: EntityAlreadyExists,
        entity_limit_exceeded: EntityLimitExceeded,
        entity_not_found: EntityNotFound,
        entity_size_limit_exceeded: EntitySizeLimitExceeded,
        field_level_encryption_config_already_exists: FieldLevelEncryptionConfigAlreadyExists,
        field_level_encryption_config_in_use: FieldLevelEncryptionConfigInUse,
        field_level_encryption_profile_already_exists: FieldLevelEncryptionProfileAlreadyExists,
        field_level_encryption_profile_in_use: FieldLevelEncryptionProfileInUse,
        field_level_encryption_profile_size_exceeded: FieldLevelEncryptionProfileSizeExceeded,
        function_already_exists: FunctionAlreadyExists,
        function_in_use: FunctionInUse,
        function_size_limit_exceeded: FunctionSizeLimitExceeded,
        illegal_delete: IllegalDelete,
        illegal_field_level_encryption_config_association_with_cache_behavior: IllegalFieldLevelEncryptionConfigAssociationWithCacheBehavior,
        illegal_origin_access_configuration: IllegalOriginAccessConfiguration,
        illegal_update: IllegalUpdate,
        inconsistent_quantities: InconsistentQuantities,
        invalid_argument: InvalidArgument,
        invalid_association: InvalidAssociation,
        invalid_default_root_object: InvalidDefaultRootObject,
        invalid_domain_name_for_origin_access_control: InvalidDomainNameForOriginAccessControl,
        invalid_error_code: InvalidErrorCode,
        invalid_forward_cookies: InvalidForwardCookies,
        invalid_function_association: InvalidFunctionAssociation,
        invalid_geo_restriction_parameter: InvalidGeoRestrictionParameter,
        invalid_headers_for_s3_origin: InvalidHeadersForS3Origin,
        invalid_if_match_version: InvalidIfMatchVersion,
        invalid_lambda_function_association: InvalidLambdaFunctionAssociation,
        invalid_location_code: InvalidLocationCode,
        invalid_minimum_protocol_version: InvalidMinimumProtocolVersion,
        invalid_origin: InvalidOrigin,
        invalid_origin_access_control: InvalidOriginAccessControl,
        invalid_origin_access_identity: InvalidOriginAccessIdentity,
        invalid_origin_keepalive_timeout: InvalidOriginKeepaliveTimeout,
        invalid_origin_read_timeout: InvalidOriginReadTimeout,
        invalid_protocol_settings: InvalidProtocolSettings,
        invalid_query_string_parameters: InvalidQueryStringParameters,
        invalid_relative_path: InvalidRelativePath,
        invalid_required_protocol: InvalidRequiredProtocol,
        invalid_response_code: InvalidResponseCode,
        invalid_tagging: InvalidTagging,
        invalid_ttl_order: InvalidTTLOrder,
        invalid_viewer_certificate: InvalidViewerCertificate,
        invalid_web_acl_id: InvalidWebACLId,
        key_group_already_exists: KeyGroupAlreadyExists,
        missing_body: MissingBody,
        monitoring_subscription_already_exists: MonitoringSubscriptionAlreadyExists,
        no_such_cache_policy: NoSuchCachePolicy,
        no_such_cloud_front_origin_access_identity: NoSuchCloudFrontOriginAccessIdentity,
        no_such_continuous_deployment_policy: NoSuchContinuousDeploymentPolicy,
        no_such_distribution: NoSuchDistribution,
        no_such_field_level_encryption_config: NoSuchFieldLevelEncryptionConfig,
        no_such_field_level_encryption_profile: NoSuchFieldLevelEncryptionProfile,
        no_such_function_exists: NoSuchFunctionExists,
        no_such_invalidation: NoSuchInvalidation,
        no_such_monitoring_subscription: NoSuchMonitoringSubscription,
        no_such_origin: NoSuchOrigin,
        no_such_origin_access_control: NoSuchOriginAccessControl,
        no_such_origin_request_policy: NoSuchOriginRequestPolicy,
        no_such_public_key: NoSuchPublicKey,
        no_such_realtime_log_config: NoSuchRealtimeLogConfig,
        no_such_resource: NoSuchResource,
        no_such_response_headers_policy: NoSuchResponseHeadersPolicy,
        no_such_streaming_distribution: NoSuchStreamingDistribution,
        origin_access_control_already_exists: OriginAccessControlAlreadyExists,
        origin_access_control_in_use: OriginAccessControlInUse,
        origin_request_policy_already_exists: OriginRequestPolicyAlreadyExists,
        origin_request_policy_in_use: OriginRequestPolicyInUse,
        precondition_failed: PreconditionFailed,
        public_key_already_exists: PublicKeyAlreadyExists,
        public_key_in_use: PublicKeyInUse,
        query_arg_profile_empty: QueryArgProfileEmpty,
        realtime_log_config_already_exists: RealtimeLogConfigAlreadyExists,
        realtime_log_config_in_use: RealtimeLogConfigInUse,
        realtime_log_config_owner_mismatch: RealtimeLogConfigOwnerMismatch,
        resource_in_use: ResourceInUse,
        resource_not_disabled: ResourceNotDisabled,
        response_headers_policy_already_exists: ResponseHeadersPolicyAlreadyExists,
        response_headers_policy_in_use: ResponseHeadersPolicyInUse,
        staging_distribution_in_use: StagingDistributionInUse,
        streaming_distribution_already_exists: StreamingDistributionAlreadyExists,
        streaming_distribution_not_disabled: StreamingDistributionNotDisabled,
        test_function_failed: TestFunctionFailed,
        too_long_csp_in_response_headers_policy: TooLongCSPInResponseHeadersPolicy,
        too_many_cache_behaviors: TooManyCacheBehaviors,
        too_many_cache_policies: TooManyCachePolicies,
        too_many_certificates: TooManyCertificates,
        too_many_cloud_front_origin_access_identities: TooManyCloudFrontOriginAccessIdentities,
        too_many_continuous_deployment_policies: TooManyContinuousDeploymentPolicies,
        too_many_cookie_names_in_white_list: TooManyCookieNamesInWhiteList,
        too_many_cookies_in_cache_policy: TooManyCookiesInCachePolicy,
        too_many_cookies_in_origin_request_policy: TooManyCookiesInOriginRequestPolicy,
        too_many_custom_headers_in_response_headers_policy: TooManyCustomHeadersInResponseHeadersPolicy,
        too_many_distribution_cnam_es: TooManyDistributionCNAMEs,
        too_many_distributions: TooManyDistributions,
        too_many_distributions_associated_to_cache_policy: TooManyDistributionsAssociatedToCachePolicy,
        too_many_distributions_associated_to_field_level_encryption_config: TooManyDistributionsAssociatedToFieldLevelEncryptionConfig,
        too_many_distributions_associated_to_key_group: TooManyDistributionsAssociatedToKeyGroup,
        too_many_distributions_associated_to_origin_access_control: TooManyDistributionsAssociatedToOriginAccessControl,
        too_many_distributions_associated_to_origin_request_policy: TooManyDistributionsAssociatedToOriginRequestPolicy,
        too_many_distributions_associated_to_response_headers_policy: TooManyDistributionsAssociatedToResponseHeadersPolicy,
        too_many_distributions_with_function_associations: TooManyDistributionsWithFunctionAssociations,
        too_many_distributions_with_lambda_associations: TooManyDistributionsWithLambdaAssociations,
        too_many_distributions_with_single_function_arn: TooManyDistributionsWithSingleFunctionARN,
        too_many_field_level_encryption_configs: TooManyFieldLevelEncryptionConfigs,
        too_many_field_level_encryption_content_type_profiles: TooManyFieldLevelEncryptionContentTypeProfiles,
        too_many_field_level_encryption_encryption_entities: TooManyFieldLevelEncryptionEncryptionEntities,
        too_many_field_level_encryption_field_patterns: TooManyFieldLevelEncryptionFieldPatterns,
        too_many_field_level_encryption_profiles: TooManyFieldLevelEncryptionProfiles,
        too_many_field_level_encryption_query_arg_profiles: TooManyFieldLevelEncryptionQueryArgProfiles,
        too_many_function_associations: TooManyFunctionAssociations,
        too_many_functions: TooManyFunctions,
        too_many_headers_in_cache_policy: TooManyHeadersInCachePolicy,
        too_many_headers_in_forwarded_values: TooManyHeadersInForwardedValues,
        too_many_headers_in_origin_request_policy: TooManyHeadersInOriginRequestPolicy,
        too_many_invalidations_in_progress: TooManyInvalidationsInProgress,
        too_many_key_groups: TooManyKeyGroups,
        too_many_key_groups_associated_to_distribution: TooManyKeyGroupsAssociatedToDistribution,
        too_many_lambda_function_associations: TooManyLambdaFunctionAssociations,
        too_many_origin_access_controls: TooManyOriginAccessControls,
        too_many_origin_custom_headers: TooManyOriginCustomHeaders,
        too_many_origin_groups_per_distribution: TooManyOriginGroupsPerDistribution,
        too_many_origin_request_policies: TooManyOriginRequestPolicies,
        too_many_origins: TooManyOrigins,
        too_many_public_keys: TooManyPublicKeys,
        too_many_public_keys_in_key_group: TooManyPublicKeysInKeyGroup,
        too_many_query_string_parameters: TooManyQueryStringParameters,
        too_many_query_strings_in_cache_policy: TooManyQueryStringsInCachePolicy,
        too_many_query_strings_in_origin_request_policy: TooManyQueryStringsInOriginRequestPolicy,
        too_many_realtime_log_configs: TooManyRealtimeLogConfigs,
        too_many_remove_headers_in_response_headers_policy: TooManyRemoveHeadersInResponseHeadersPolicy,
        too_many_response_headers_policies: TooManyResponseHeadersPolicies,
        too_many_streaming_distribution_cnam_es: TooManyStreamingDistributionCNAMEs,
        too_many_streaming_distributions: TooManyStreamingDistributions,
        too_many_trusted_signers: TooManyTrustedSigners,
        trusted_key_group_does_not_exist: TrustedKeyGroupDoesNotExist,
        trusted_signer_does_not_exist: TrustedSignerDoesNotExist,
        unsupported_operation: UnsupportedOperation,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => "AccessDenied",
                .batch_too_large => "BatchTooLarge",
                .cache_policy_already_exists => "CachePolicyAlreadyExists",
                .cache_policy_in_use => "CachePolicyInUse",
                .cannot_change_immutable_public_key_fields => "CannotChangeImmutablePublicKeyFields",
                .cannot_delete_entity_while_in_use => "CannotDeleteEntityWhileInUse",
                .cannot_update_entity_while_in_use => "CannotUpdateEntityWhileInUse",
                .cloud_front_origin_access_identity_already_exists => "CloudFrontOriginAccessIdentityAlreadyExists",
                .cloud_front_origin_access_identity_in_use => "CloudFrontOriginAccessIdentityInUse",
                .cname_already_exists => "CNAMEAlreadyExists",
                .continuous_deployment_policy_already_exists => "ContinuousDeploymentPolicyAlreadyExists",
                .continuous_deployment_policy_in_use => "ContinuousDeploymentPolicyInUse",
                .distribution_already_exists => "DistributionAlreadyExists",
                .distribution_not_disabled => "DistributionNotDisabled",
                .entity_already_exists => "EntityAlreadyExists",
                .entity_limit_exceeded => "EntityLimitExceeded",
                .entity_not_found => "EntityNotFound",
                .entity_size_limit_exceeded => "EntitySizeLimitExceeded",
                .field_level_encryption_config_already_exists => "FieldLevelEncryptionConfigAlreadyExists",
                .field_level_encryption_config_in_use => "FieldLevelEncryptionConfigInUse",
                .field_level_encryption_profile_already_exists => "FieldLevelEncryptionProfileAlreadyExists",
                .field_level_encryption_profile_in_use => "FieldLevelEncryptionProfileInUse",
                .field_level_encryption_profile_size_exceeded => "FieldLevelEncryptionProfileSizeExceeded",
                .function_already_exists => "FunctionAlreadyExists",
                .function_in_use => "FunctionInUse",
                .function_size_limit_exceeded => "FunctionSizeLimitExceeded",
                .illegal_delete => "IllegalDelete",
                .illegal_field_level_encryption_config_association_with_cache_behavior => "IllegalFieldLevelEncryptionConfigAssociationWithCacheBehavior",
                .illegal_origin_access_configuration => "IllegalOriginAccessConfiguration",
                .illegal_update => "IllegalUpdate",
                .inconsistent_quantities => "InconsistentQuantities",
                .invalid_argument => "InvalidArgument",
                .invalid_association => "InvalidAssociation",
                .invalid_default_root_object => "InvalidDefaultRootObject",
                .invalid_domain_name_for_origin_access_control => "InvalidDomainNameForOriginAccessControl",
                .invalid_error_code => "InvalidErrorCode",
                .invalid_forward_cookies => "InvalidForwardCookies",
                .invalid_function_association => "InvalidFunctionAssociation",
                .invalid_geo_restriction_parameter => "InvalidGeoRestrictionParameter",
                .invalid_headers_for_s3_origin => "InvalidHeadersForS3Origin",
                .invalid_if_match_version => "InvalidIfMatchVersion",
                .invalid_lambda_function_association => "InvalidLambdaFunctionAssociation",
                .invalid_location_code => "InvalidLocationCode",
                .invalid_minimum_protocol_version => "InvalidMinimumProtocolVersion",
                .invalid_origin => "InvalidOrigin",
                .invalid_origin_access_control => "InvalidOriginAccessControl",
                .invalid_origin_access_identity => "InvalidOriginAccessIdentity",
                .invalid_origin_keepalive_timeout => "InvalidOriginKeepaliveTimeout",
                .invalid_origin_read_timeout => "InvalidOriginReadTimeout",
                .invalid_protocol_settings => "InvalidProtocolSettings",
                .invalid_query_string_parameters => "InvalidQueryStringParameters",
                .invalid_relative_path => "InvalidRelativePath",
                .invalid_required_protocol => "InvalidRequiredProtocol",
                .invalid_response_code => "InvalidResponseCode",
                .invalid_tagging => "InvalidTagging",
                .invalid_ttl_order => "InvalidTTLOrder",
                .invalid_viewer_certificate => "InvalidViewerCertificate",
                .invalid_web_acl_id => "InvalidWebACLId",
                .key_group_already_exists => "KeyGroupAlreadyExists",
                .missing_body => "MissingBody",
                .monitoring_subscription_already_exists => "MonitoringSubscriptionAlreadyExists",
                .no_such_cache_policy => "NoSuchCachePolicy",
                .no_such_cloud_front_origin_access_identity => "NoSuchCloudFrontOriginAccessIdentity",
                .no_such_continuous_deployment_policy => "NoSuchContinuousDeploymentPolicy",
                .no_such_distribution => "NoSuchDistribution",
                .no_such_field_level_encryption_config => "NoSuchFieldLevelEncryptionConfig",
                .no_such_field_level_encryption_profile => "NoSuchFieldLevelEncryptionProfile",
                .no_such_function_exists => "NoSuchFunctionExists",
                .no_such_invalidation => "NoSuchInvalidation",
                .no_such_monitoring_subscription => "NoSuchMonitoringSubscription",
                .no_such_origin => "NoSuchOrigin",
                .no_such_origin_access_control => "NoSuchOriginAccessControl",
                .no_such_origin_request_policy => "NoSuchOriginRequestPolicy",
                .no_such_public_key => "NoSuchPublicKey",
                .no_such_realtime_log_config => "NoSuchRealtimeLogConfig",
                .no_such_resource => "NoSuchResource",
                .no_such_response_headers_policy => "NoSuchResponseHeadersPolicy",
                .no_such_streaming_distribution => "NoSuchStreamingDistribution",
                .origin_access_control_already_exists => "OriginAccessControlAlreadyExists",
                .origin_access_control_in_use => "OriginAccessControlInUse",
                .origin_request_policy_already_exists => "OriginRequestPolicyAlreadyExists",
                .origin_request_policy_in_use => "OriginRequestPolicyInUse",
                .precondition_failed => "PreconditionFailed",
                .public_key_already_exists => "PublicKeyAlreadyExists",
                .public_key_in_use => "PublicKeyInUse",
                .query_arg_profile_empty => "QueryArgProfileEmpty",
                .realtime_log_config_already_exists => "RealtimeLogConfigAlreadyExists",
                .realtime_log_config_in_use => "RealtimeLogConfigInUse",
                .realtime_log_config_owner_mismatch => "RealtimeLogConfigOwnerMismatch",
                .resource_in_use => "ResourceInUse",
                .resource_not_disabled => "ResourceNotDisabled",
                .response_headers_policy_already_exists => "ResponseHeadersPolicyAlreadyExists",
                .response_headers_policy_in_use => "ResponseHeadersPolicyInUse",
                .staging_distribution_in_use => "StagingDistributionInUse",
                .streaming_distribution_already_exists => "StreamingDistributionAlreadyExists",
                .streaming_distribution_not_disabled => "StreamingDistributionNotDisabled",
                .test_function_failed => "TestFunctionFailed",
                .too_long_csp_in_response_headers_policy => "TooLongCSPInResponseHeadersPolicy",
                .too_many_cache_behaviors => "TooManyCacheBehaviors",
                .too_many_cache_policies => "TooManyCachePolicies",
                .too_many_certificates => "TooManyCertificates",
                .too_many_cloud_front_origin_access_identities => "TooManyCloudFrontOriginAccessIdentities",
                .too_many_continuous_deployment_policies => "TooManyContinuousDeploymentPolicies",
                .too_many_cookie_names_in_white_list => "TooManyCookieNamesInWhiteList",
                .too_many_cookies_in_cache_policy => "TooManyCookiesInCachePolicy",
                .too_many_cookies_in_origin_request_policy => "TooManyCookiesInOriginRequestPolicy",
                .too_many_custom_headers_in_response_headers_policy => "TooManyCustomHeadersInResponseHeadersPolicy",
                .too_many_distribution_cnam_es => "TooManyDistributionCNAMEs",
                .too_many_distributions => "TooManyDistributions",
                .too_many_distributions_associated_to_cache_policy => "TooManyDistributionsAssociatedToCachePolicy",
                .too_many_distributions_associated_to_field_level_encryption_config => "TooManyDistributionsAssociatedToFieldLevelEncryptionConfig",
                .too_many_distributions_associated_to_key_group => "TooManyDistributionsAssociatedToKeyGroup",
                .too_many_distributions_associated_to_origin_access_control => "TooManyDistributionsAssociatedToOriginAccessControl",
                .too_many_distributions_associated_to_origin_request_policy => "TooManyDistributionsAssociatedToOriginRequestPolicy",
                .too_many_distributions_associated_to_response_headers_policy => "TooManyDistributionsAssociatedToResponseHeadersPolicy",
                .too_many_distributions_with_function_associations => "TooManyDistributionsWithFunctionAssociations",
                .too_many_distributions_with_lambda_associations => "TooManyDistributionsWithLambdaAssociations",
                .too_many_distributions_with_single_function_arn => "TooManyDistributionsWithSingleFunctionARN",
                .too_many_field_level_encryption_configs => "TooManyFieldLevelEncryptionConfigs",
                .too_many_field_level_encryption_content_type_profiles => "TooManyFieldLevelEncryptionContentTypeProfiles",
                .too_many_field_level_encryption_encryption_entities => "TooManyFieldLevelEncryptionEncryptionEntities",
                .too_many_field_level_encryption_field_patterns => "TooManyFieldLevelEncryptionFieldPatterns",
                .too_many_field_level_encryption_profiles => "TooManyFieldLevelEncryptionProfiles",
                .too_many_field_level_encryption_query_arg_profiles => "TooManyFieldLevelEncryptionQueryArgProfiles",
                .too_many_function_associations => "TooManyFunctionAssociations",
                .too_many_functions => "TooManyFunctions",
                .too_many_headers_in_cache_policy => "TooManyHeadersInCachePolicy",
                .too_many_headers_in_forwarded_values => "TooManyHeadersInForwardedValues",
                .too_many_headers_in_origin_request_policy => "TooManyHeadersInOriginRequestPolicy",
                .too_many_invalidations_in_progress => "TooManyInvalidationsInProgress",
                .too_many_key_groups => "TooManyKeyGroups",
                .too_many_key_groups_associated_to_distribution => "TooManyKeyGroupsAssociatedToDistribution",
                .too_many_lambda_function_associations => "TooManyLambdaFunctionAssociations",
                .too_many_origin_access_controls => "TooManyOriginAccessControls",
                .too_many_origin_custom_headers => "TooManyOriginCustomHeaders",
                .too_many_origin_groups_per_distribution => "TooManyOriginGroupsPerDistribution",
                .too_many_origin_request_policies => "TooManyOriginRequestPolicies",
                .too_many_origins => "TooManyOrigins",
                .too_many_public_keys => "TooManyPublicKeys",
                .too_many_public_keys_in_key_group => "TooManyPublicKeysInKeyGroup",
                .too_many_query_string_parameters => "TooManyQueryStringParameters",
                .too_many_query_strings_in_cache_policy => "TooManyQueryStringsInCachePolicy",
                .too_many_query_strings_in_origin_request_policy => "TooManyQueryStringsInOriginRequestPolicy",
                .too_many_realtime_log_configs => "TooManyRealtimeLogConfigs",
                .too_many_remove_headers_in_response_headers_policy => "TooManyRemoveHeadersInResponseHeadersPolicy",
                .too_many_response_headers_policies => "TooManyResponseHeadersPolicies",
                .too_many_streaming_distribution_cnam_es => "TooManyStreamingDistributionCNAMEs",
                .too_many_streaming_distributions => "TooManyStreamingDistributions",
                .too_many_trusted_signers => "TooManyTrustedSigners",
                .trusted_key_group_does_not_exist => "TrustedKeyGroupDoesNotExist",
                .trusted_signer_does_not_exist => "TrustedSignerDoesNotExist",
                .unsupported_operation => "UnsupportedOperation",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => |e| e.message,
                .batch_too_large => |e| e.message,
                .cache_policy_already_exists => |e| e.message,
                .cache_policy_in_use => |e| e.message,
                .cannot_change_immutable_public_key_fields => |e| e.message,
                .cannot_delete_entity_while_in_use => |e| e.message,
                .cannot_update_entity_while_in_use => |e| e.message,
                .cloud_front_origin_access_identity_already_exists => |e| e.message,
                .cloud_front_origin_access_identity_in_use => |e| e.message,
                .cname_already_exists => |e| e.message,
                .continuous_deployment_policy_already_exists => |e| e.message,
                .continuous_deployment_policy_in_use => |e| e.message,
                .distribution_already_exists => |e| e.message,
                .distribution_not_disabled => |e| e.message,
                .entity_already_exists => |e| e.message,
                .entity_limit_exceeded => |e| e.message,
                .entity_not_found => |e| e.message,
                .entity_size_limit_exceeded => |e| e.message,
                .field_level_encryption_config_already_exists => |e| e.message,
                .field_level_encryption_config_in_use => |e| e.message,
                .field_level_encryption_profile_already_exists => |e| e.message,
                .field_level_encryption_profile_in_use => |e| e.message,
                .field_level_encryption_profile_size_exceeded => |e| e.message,
                .function_already_exists => |e| e.message,
                .function_in_use => |e| e.message,
                .function_size_limit_exceeded => |e| e.message,
                .illegal_delete => |e| e.message,
                .illegal_field_level_encryption_config_association_with_cache_behavior => |e| e.message,
                .illegal_origin_access_configuration => |e| e.message,
                .illegal_update => |e| e.message,
                .inconsistent_quantities => |e| e.message,
                .invalid_argument => |e| e.message,
                .invalid_association => |e| e.message,
                .invalid_default_root_object => |e| e.message,
                .invalid_domain_name_for_origin_access_control => |e| e.message,
                .invalid_error_code => |e| e.message,
                .invalid_forward_cookies => |e| e.message,
                .invalid_function_association => |e| e.message,
                .invalid_geo_restriction_parameter => |e| e.message,
                .invalid_headers_for_s3_origin => |e| e.message,
                .invalid_if_match_version => |e| e.message,
                .invalid_lambda_function_association => |e| e.message,
                .invalid_location_code => |e| e.message,
                .invalid_minimum_protocol_version => |e| e.message,
                .invalid_origin => |e| e.message,
                .invalid_origin_access_control => |e| e.message,
                .invalid_origin_access_identity => |e| e.message,
                .invalid_origin_keepalive_timeout => |e| e.message,
                .invalid_origin_read_timeout => |e| e.message,
                .invalid_protocol_settings => |e| e.message,
                .invalid_query_string_parameters => |e| e.message,
                .invalid_relative_path => |e| e.message,
                .invalid_required_protocol => |e| e.message,
                .invalid_response_code => |e| e.message,
                .invalid_tagging => |e| e.message,
                .invalid_ttl_order => |e| e.message,
                .invalid_viewer_certificate => |e| e.message,
                .invalid_web_acl_id => |e| e.message,
                .key_group_already_exists => |e| e.message,
                .missing_body => |e| e.message,
                .monitoring_subscription_already_exists => |e| e.message,
                .no_such_cache_policy => |e| e.message,
                .no_such_cloud_front_origin_access_identity => |e| e.message,
                .no_such_continuous_deployment_policy => |e| e.message,
                .no_such_distribution => |e| e.message,
                .no_such_field_level_encryption_config => |e| e.message,
                .no_such_field_level_encryption_profile => |e| e.message,
                .no_such_function_exists => |e| e.message,
                .no_such_invalidation => |e| e.message,
                .no_such_monitoring_subscription => |e| e.message,
                .no_such_origin => |e| e.message,
                .no_such_origin_access_control => |e| e.message,
                .no_such_origin_request_policy => |e| e.message,
                .no_such_public_key => |e| e.message,
                .no_such_realtime_log_config => |e| e.message,
                .no_such_resource => |e| e.message,
                .no_such_response_headers_policy => |e| e.message,
                .no_such_streaming_distribution => |e| e.message,
                .origin_access_control_already_exists => |e| e.message,
                .origin_access_control_in_use => |e| e.message,
                .origin_request_policy_already_exists => |e| e.message,
                .origin_request_policy_in_use => |e| e.message,
                .precondition_failed => |e| e.message,
                .public_key_already_exists => |e| e.message,
                .public_key_in_use => |e| e.message,
                .query_arg_profile_empty => |e| e.message,
                .realtime_log_config_already_exists => |e| e.message,
                .realtime_log_config_in_use => |e| e.message,
                .realtime_log_config_owner_mismatch => |e| e.message,
                .resource_in_use => |e| e.message,
                .resource_not_disabled => |e| e.message,
                .response_headers_policy_already_exists => |e| e.message,
                .response_headers_policy_in_use => |e| e.message,
                .staging_distribution_in_use => |e| e.message,
                .streaming_distribution_already_exists => |e| e.message,
                .streaming_distribution_not_disabled => |e| e.message,
                .test_function_failed => |e| e.message,
                .too_long_csp_in_response_headers_policy => |e| e.message,
                .too_many_cache_behaviors => |e| e.message,
                .too_many_cache_policies => |e| e.message,
                .too_many_certificates => |e| e.message,
                .too_many_cloud_front_origin_access_identities => |e| e.message,
                .too_many_continuous_deployment_policies => |e| e.message,
                .too_many_cookie_names_in_white_list => |e| e.message,
                .too_many_cookies_in_cache_policy => |e| e.message,
                .too_many_cookies_in_origin_request_policy => |e| e.message,
                .too_many_custom_headers_in_response_headers_policy => |e| e.message,
                .too_many_distribution_cnam_es => |e| e.message,
                .too_many_distributions => |e| e.message,
                .too_many_distributions_associated_to_cache_policy => |e| e.message,
                .too_many_distributions_associated_to_field_level_encryption_config => |e| e.message,
                .too_many_distributions_associated_to_key_group => |e| e.message,
                .too_many_distributions_associated_to_origin_access_control => |e| e.message,
                .too_many_distributions_associated_to_origin_request_policy => |e| e.message,
                .too_many_distributions_associated_to_response_headers_policy => |e| e.message,
                .too_many_distributions_with_function_associations => |e| e.message,
                .too_many_distributions_with_lambda_associations => |e| e.message,
                .too_many_distributions_with_single_function_arn => |e| e.message,
                .too_many_field_level_encryption_configs => |e| e.message,
                .too_many_field_level_encryption_content_type_profiles => |e| e.message,
                .too_many_field_level_encryption_encryption_entities => |e| e.message,
                .too_many_field_level_encryption_field_patterns => |e| e.message,
                .too_many_field_level_encryption_profiles => |e| e.message,
                .too_many_field_level_encryption_query_arg_profiles => |e| e.message,
                .too_many_function_associations => |e| e.message,
                .too_many_functions => |e| e.message,
                .too_many_headers_in_cache_policy => |e| e.message,
                .too_many_headers_in_forwarded_values => |e| e.message,
                .too_many_headers_in_origin_request_policy => |e| e.message,
                .too_many_invalidations_in_progress => |e| e.message,
                .too_many_key_groups => |e| e.message,
                .too_many_key_groups_associated_to_distribution => |e| e.message,
                .too_many_lambda_function_associations => |e| e.message,
                .too_many_origin_access_controls => |e| e.message,
                .too_many_origin_custom_headers => |e| e.message,
                .too_many_origin_groups_per_distribution => |e| e.message,
                .too_many_origin_request_policies => |e| e.message,
                .too_many_origins => |e| e.message,
                .too_many_public_keys => |e| e.message,
                .too_many_public_keys_in_key_group => |e| e.message,
                .too_many_query_string_parameters => |e| e.message,
                .too_many_query_strings_in_cache_policy => |e| e.message,
                .too_many_query_strings_in_origin_request_policy => |e| e.message,
                .too_many_realtime_log_configs => |e| e.message,
                .too_many_remove_headers_in_response_headers_policy => |e| e.message,
                .too_many_response_headers_policies => |e| e.message,
                .too_many_streaming_distribution_cnam_es => |e| e.message,
                .too_many_streaming_distributions => |e| e.message,
                .too_many_trusted_signers => |e| e.message,
                .trusted_key_group_does_not_exist => |e| e.message,
                .trusted_signer_does_not_exist => |e| e.message,
                .unsupported_operation => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied => 403,
                .batch_too_large => 413,
                .cache_policy_already_exists => 409,
                .cache_policy_in_use => 409,
                .cannot_change_immutable_public_key_fields => 400,
                .cannot_delete_entity_while_in_use => 409,
                .cannot_update_entity_while_in_use => 409,
                .cloud_front_origin_access_identity_already_exists => 409,
                .cloud_front_origin_access_identity_in_use => 409,
                .cname_already_exists => 409,
                .continuous_deployment_policy_already_exists => 409,
                .continuous_deployment_policy_in_use => 409,
                .distribution_already_exists => 409,
                .distribution_not_disabled => 409,
                .entity_already_exists => 409,
                .entity_limit_exceeded => 400,
                .entity_not_found => 404,
                .entity_size_limit_exceeded => 413,
                .field_level_encryption_config_already_exists => 409,
                .field_level_encryption_config_in_use => 409,
                .field_level_encryption_profile_already_exists => 409,
                .field_level_encryption_profile_in_use => 409,
                .field_level_encryption_profile_size_exceeded => 400,
                .function_already_exists => 409,
                .function_in_use => 409,
                .function_size_limit_exceeded => 413,
                .illegal_delete => 400,
                .illegal_field_level_encryption_config_association_with_cache_behavior => 400,
                .illegal_origin_access_configuration => 400,
                .illegal_update => 400,
                .inconsistent_quantities => 400,
                .invalid_argument => 400,
                .invalid_association => 409,
                .invalid_default_root_object => 400,
                .invalid_domain_name_for_origin_access_control => 400,
                .invalid_error_code => 400,
                .invalid_forward_cookies => 400,
                .invalid_function_association => 400,
                .invalid_geo_restriction_parameter => 400,
                .invalid_headers_for_s3_origin => 400,
                .invalid_if_match_version => 400,
                .invalid_lambda_function_association => 400,
                .invalid_location_code => 400,
                .invalid_minimum_protocol_version => 400,
                .invalid_origin => 400,
                .invalid_origin_access_control => 400,
                .invalid_origin_access_identity => 400,
                .invalid_origin_keepalive_timeout => 400,
                .invalid_origin_read_timeout => 400,
                .invalid_protocol_settings => 400,
                .invalid_query_string_parameters => 400,
                .invalid_relative_path => 400,
                .invalid_required_protocol => 400,
                .invalid_response_code => 400,
                .invalid_tagging => 400,
                .invalid_ttl_order => 400,
                .invalid_viewer_certificate => 400,
                .invalid_web_acl_id => 400,
                .key_group_already_exists => 409,
                .missing_body => 400,
                .monitoring_subscription_already_exists => 409,
                .no_such_cache_policy => 404,
                .no_such_cloud_front_origin_access_identity => 404,
                .no_such_continuous_deployment_policy => 404,
                .no_such_distribution => 404,
                .no_such_field_level_encryption_config => 404,
                .no_such_field_level_encryption_profile => 404,
                .no_such_function_exists => 404,
                .no_such_invalidation => 404,
                .no_such_monitoring_subscription => 404,
                .no_such_origin => 404,
                .no_such_origin_access_control => 404,
                .no_such_origin_request_policy => 404,
                .no_such_public_key => 404,
                .no_such_realtime_log_config => 404,
                .no_such_resource => 404,
                .no_such_response_headers_policy => 404,
                .no_such_streaming_distribution => 404,
                .origin_access_control_already_exists => 409,
                .origin_access_control_in_use => 409,
                .origin_request_policy_already_exists => 409,
                .origin_request_policy_in_use => 409,
                .precondition_failed => 412,
                .public_key_already_exists => 409,
                .public_key_in_use => 409,
                .query_arg_profile_empty => 400,
                .realtime_log_config_already_exists => 409,
                .realtime_log_config_in_use => 400,
                .realtime_log_config_owner_mismatch => 401,
                .resource_in_use => 409,
                .resource_not_disabled => 409,
                .response_headers_policy_already_exists => 409,
                .response_headers_policy_in_use => 409,
                .staging_distribution_in_use => 409,
                .streaming_distribution_already_exists => 409,
                .streaming_distribution_not_disabled => 409,
                .test_function_failed => 500,
                .too_long_csp_in_response_headers_policy => 400,
                .too_many_cache_behaviors => 400,
                .too_many_cache_policies => 400,
                .too_many_certificates => 400,
                .too_many_cloud_front_origin_access_identities => 400,
                .too_many_continuous_deployment_policies => 400,
                .too_many_cookie_names_in_white_list => 400,
                .too_many_cookies_in_cache_policy => 400,
                .too_many_cookies_in_origin_request_policy => 400,
                .too_many_custom_headers_in_response_headers_policy => 400,
                .too_many_distribution_cnam_es => 400,
                .too_many_distributions => 400,
                .too_many_distributions_associated_to_cache_policy => 400,
                .too_many_distributions_associated_to_field_level_encryption_config => 400,
                .too_many_distributions_associated_to_key_group => 400,
                .too_many_distributions_associated_to_origin_access_control => 400,
                .too_many_distributions_associated_to_origin_request_policy => 400,
                .too_many_distributions_associated_to_response_headers_policy => 400,
                .too_many_distributions_with_function_associations => 400,
                .too_many_distributions_with_lambda_associations => 400,
                .too_many_distributions_with_single_function_arn => 400,
                .too_many_field_level_encryption_configs => 400,
                .too_many_field_level_encryption_content_type_profiles => 400,
                .too_many_field_level_encryption_encryption_entities => 400,
                .too_many_field_level_encryption_field_patterns => 400,
                .too_many_field_level_encryption_profiles => 400,
                .too_many_field_level_encryption_query_arg_profiles => 400,
                .too_many_function_associations => 400,
                .too_many_functions => 400,
                .too_many_headers_in_cache_policy => 400,
                .too_many_headers_in_forwarded_values => 400,
                .too_many_headers_in_origin_request_policy => 400,
                .too_many_invalidations_in_progress => 400,
                .too_many_key_groups => 400,
                .too_many_key_groups_associated_to_distribution => 400,
                .too_many_lambda_function_associations => 400,
                .too_many_origin_access_controls => 400,
                .too_many_origin_custom_headers => 400,
                .too_many_origin_groups_per_distribution => 400,
                .too_many_origin_request_policies => 400,
                .too_many_origins => 400,
                .too_many_public_keys => 400,
                .too_many_public_keys_in_key_group => 400,
                .too_many_query_string_parameters => 400,
                .too_many_query_strings_in_cache_policy => 400,
                .too_many_query_strings_in_origin_request_policy => 400,
                .too_many_realtime_log_configs => 400,
                .too_many_remove_headers_in_response_headers_policy => 400,
                .too_many_response_headers_policies => 400,
                .too_many_streaming_distribution_cnam_es => 400,
                .too_many_streaming_distributions => 400,
                .too_many_trusted_signers => 400,
                .trusted_key_group_does_not_exist => 400,
                .trusted_signer_does_not_exist => 400,
                .unsupported_operation => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => |e| e.request_id,
                .batch_too_large => |e| e.request_id,
                .cache_policy_already_exists => |e| e.request_id,
                .cache_policy_in_use => |e| e.request_id,
                .cannot_change_immutable_public_key_fields => |e| e.request_id,
                .cannot_delete_entity_while_in_use => |e| e.request_id,
                .cannot_update_entity_while_in_use => |e| e.request_id,
                .cloud_front_origin_access_identity_already_exists => |e| e.request_id,
                .cloud_front_origin_access_identity_in_use => |e| e.request_id,
                .cname_already_exists => |e| e.request_id,
                .continuous_deployment_policy_already_exists => |e| e.request_id,
                .continuous_deployment_policy_in_use => |e| e.request_id,
                .distribution_already_exists => |e| e.request_id,
                .distribution_not_disabled => |e| e.request_id,
                .entity_already_exists => |e| e.request_id,
                .entity_limit_exceeded => |e| e.request_id,
                .entity_not_found => |e| e.request_id,
                .entity_size_limit_exceeded => |e| e.request_id,
                .field_level_encryption_config_already_exists => |e| e.request_id,
                .field_level_encryption_config_in_use => |e| e.request_id,
                .field_level_encryption_profile_already_exists => |e| e.request_id,
                .field_level_encryption_profile_in_use => |e| e.request_id,
                .field_level_encryption_profile_size_exceeded => |e| e.request_id,
                .function_already_exists => |e| e.request_id,
                .function_in_use => |e| e.request_id,
                .function_size_limit_exceeded => |e| e.request_id,
                .illegal_delete => |e| e.request_id,
                .illegal_field_level_encryption_config_association_with_cache_behavior => |e| e.request_id,
                .illegal_origin_access_configuration => |e| e.request_id,
                .illegal_update => |e| e.request_id,
                .inconsistent_quantities => |e| e.request_id,
                .invalid_argument => |e| e.request_id,
                .invalid_association => |e| e.request_id,
                .invalid_default_root_object => |e| e.request_id,
                .invalid_domain_name_for_origin_access_control => |e| e.request_id,
                .invalid_error_code => |e| e.request_id,
                .invalid_forward_cookies => |e| e.request_id,
                .invalid_function_association => |e| e.request_id,
                .invalid_geo_restriction_parameter => |e| e.request_id,
                .invalid_headers_for_s3_origin => |e| e.request_id,
                .invalid_if_match_version => |e| e.request_id,
                .invalid_lambda_function_association => |e| e.request_id,
                .invalid_location_code => |e| e.request_id,
                .invalid_minimum_protocol_version => |e| e.request_id,
                .invalid_origin => |e| e.request_id,
                .invalid_origin_access_control => |e| e.request_id,
                .invalid_origin_access_identity => |e| e.request_id,
                .invalid_origin_keepalive_timeout => |e| e.request_id,
                .invalid_origin_read_timeout => |e| e.request_id,
                .invalid_protocol_settings => |e| e.request_id,
                .invalid_query_string_parameters => |e| e.request_id,
                .invalid_relative_path => |e| e.request_id,
                .invalid_required_protocol => |e| e.request_id,
                .invalid_response_code => |e| e.request_id,
                .invalid_tagging => |e| e.request_id,
                .invalid_ttl_order => |e| e.request_id,
                .invalid_viewer_certificate => |e| e.request_id,
                .invalid_web_acl_id => |e| e.request_id,
                .key_group_already_exists => |e| e.request_id,
                .missing_body => |e| e.request_id,
                .monitoring_subscription_already_exists => |e| e.request_id,
                .no_such_cache_policy => |e| e.request_id,
                .no_such_cloud_front_origin_access_identity => |e| e.request_id,
                .no_such_continuous_deployment_policy => |e| e.request_id,
                .no_such_distribution => |e| e.request_id,
                .no_such_field_level_encryption_config => |e| e.request_id,
                .no_such_field_level_encryption_profile => |e| e.request_id,
                .no_such_function_exists => |e| e.request_id,
                .no_such_invalidation => |e| e.request_id,
                .no_such_monitoring_subscription => |e| e.request_id,
                .no_such_origin => |e| e.request_id,
                .no_such_origin_access_control => |e| e.request_id,
                .no_such_origin_request_policy => |e| e.request_id,
                .no_such_public_key => |e| e.request_id,
                .no_such_realtime_log_config => |e| e.request_id,
                .no_such_resource => |e| e.request_id,
                .no_such_response_headers_policy => |e| e.request_id,
                .no_such_streaming_distribution => |e| e.request_id,
                .origin_access_control_already_exists => |e| e.request_id,
                .origin_access_control_in_use => |e| e.request_id,
                .origin_request_policy_already_exists => |e| e.request_id,
                .origin_request_policy_in_use => |e| e.request_id,
                .precondition_failed => |e| e.request_id,
                .public_key_already_exists => |e| e.request_id,
                .public_key_in_use => |e| e.request_id,
                .query_arg_profile_empty => |e| e.request_id,
                .realtime_log_config_already_exists => |e| e.request_id,
                .realtime_log_config_in_use => |e| e.request_id,
                .realtime_log_config_owner_mismatch => |e| e.request_id,
                .resource_in_use => |e| e.request_id,
                .resource_not_disabled => |e| e.request_id,
                .response_headers_policy_already_exists => |e| e.request_id,
                .response_headers_policy_in_use => |e| e.request_id,
                .staging_distribution_in_use => |e| e.request_id,
                .streaming_distribution_already_exists => |e| e.request_id,
                .streaming_distribution_not_disabled => |e| e.request_id,
                .test_function_failed => |e| e.request_id,
                .too_long_csp_in_response_headers_policy => |e| e.request_id,
                .too_many_cache_behaviors => |e| e.request_id,
                .too_many_cache_policies => |e| e.request_id,
                .too_many_certificates => |e| e.request_id,
                .too_many_cloud_front_origin_access_identities => |e| e.request_id,
                .too_many_continuous_deployment_policies => |e| e.request_id,
                .too_many_cookie_names_in_white_list => |e| e.request_id,
                .too_many_cookies_in_cache_policy => |e| e.request_id,
                .too_many_cookies_in_origin_request_policy => |e| e.request_id,
                .too_many_custom_headers_in_response_headers_policy => |e| e.request_id,
                .too_many_distribution_cnam_es => |e| e.request_id,
                .too_many_distributions => |e| e.request_id,
                .too_many_distributions_associated_to_cache_policy => |e| e.request_id,
                .too_many_distributions_associated_to_field_level_encryption_config => |e| e.request_id,
                .too_many_distributions_associated_to_key_group => |e| e.request_id,
                .too_many_distributions_associated_to_origin_access_control => |e| e.request_id,
                .too_many_distributions_associated_to_origin_request_policy => |e| e.request_id,
                .too_many_distributions_associated_to_response_headers_policy => |e| e.request_id,
                .too_many_distributions_with_function_associations => |e| e.request_id,
                .too_many_distributions_with_lambda_associations => |e| e.request_id,
                .too_many_distributions_with_single_function_arn => |e| e.request_id,
                .too_many_field_level_encryption_configs => |e| e.request_id,
                .too_many_field_level_encryption_content_type_profiles => |e| e.request_id,
                .too_many_field_level_encryption_encryption_entities => |e| e.request_id,
                .too_many_field_level_encryption_field_patterns => |e| e.request_id,
                .too_many_field_level_encryption_profiles => |e| e.request_id,
                .too_many_field_level_encryption_query_arg_profiles => |e| e.request_id,
                .too_many_function_associations => |e| e.request_id,
                .too_many_functions => |e| e.request_id,
                .too_many_headers_in_cache_policy => |e| e.request_id,
                .too_many_headers_in_forwarded_values => |e| e.request_id,
                .too_many_headers_in_origin_request_policy => |e| e.request_id,
                .too_many_invalidations_in_progress => |e| e.request_id,
                .too_many_key_groups => |e| e.request_id,
                .too_many_key_groups_associated_to_distribution => |e| e.request_id,
                .too_many_lambda_function_associations => |e| e.request_id,
                .too_many_origin_access_controls => |e| e.request_id,
                .too_many_origin_custom_headers => |e| e.request_id,
                .too_many_origin_groups_per_distribution => |e| e.request_id,
                .too_many_origin_request_policies => |e| e.request_id,
                .too_many_origins => |e| e.request_id,
                .too_many_public_keys => |e| e.request_id,
                .too_many_public_keys_in_key_group => |e| e.request_id,
                .too_many_query_string_parameters => |e| e.request_id,
                .too_many_query_strings_in_cache_policy => |e| e.request_id,
                .too_many_query_strings_in_origin_request_policy => |e| e.request_id,
                .too_many_realtime_log_configs => |e| e.request_id,
                .too_many_remove_headers_in_response_headers_policy => |e| e.request_id,
                .too_many_response_headers_policies => |e| e.request_id,
                .too_many_streaming_distribution_cnam_es => |e| e.request_id,
                .too_many_streaming_distributions => |e| e.request_id,
                .too_many_trusted_signers => |e| e.request_id,
                .trusted_key_group_does_not_exist => |e| e.request_id,
                .trusted_signer_does_not_exist => |e| e.request_id,
                .unsupported_operation => |e| e.request_id,
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

pub const AccessDenied = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchTooLarge = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CachePolicyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CachePolicyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotChangeImmutablePublicKeyFields = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotDeleteEntityWhileInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotUpdateEntityWhileInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudFrontOriginAccessIdentityAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudFrontOriginAccessIdentityInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CNAMEAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ContinuousDeploymentPolicyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ContinuousDeploymentPolicyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DistributionAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DistributionNotDisabled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntitySizeLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FieldLevelEncryptionConfigAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FieldLevelEncryptionConfigInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FieldLevelEncryptionProfileAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FieldLevelEncryptionProfileInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FieldLevelEncryptionProfileSizeExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FunctionAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FunctionInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FunctionSizeLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalDelete = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalFieldLevelEncryptionConfigAssociationWithCacheBehavior = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalOriginAccessConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalUpdate = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InconsistentQuantities = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgument = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDefaultRootObject = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDomainNameForOriginAccessControl = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidErrorCode = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidForwardCookies = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFunctionAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGeoRestrictionParameter = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidHeadersForS3Origin = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIfMatchVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLambdaFunctionAssociation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLocationCode = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMinimumProtocolVersion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOrigin = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOriginAccessControl = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOriginAccessIdentity = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOriginKeepaliveTimeout = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOriginReadTimeout = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidProtocolSettings = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidQueryStringParameters = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRelativePath = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequiredProtocol = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResponseCode = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagging = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTTLOrder = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidViewerCertificate = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidWebACLId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeyGroupAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingBody = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MonitoringSubscriptionAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchCachePolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchCloudFrontOriginAccessIdentity = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchContinuousDeploymentPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchDistribution = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchFieldLevelEncryptionConfig = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchFieldLevelEncryptionProfile = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchFunctionExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchInvalidation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchMonitoringSubscription = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchOrigin = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchOriginAccessControl = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchOriginRequestPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchPublicKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchRealtimeLogConfig = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchResource = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchResponseHeadersPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchStreamingDistribution = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OriginAccessControlAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OriginAccessControlInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OriginRequestPolicyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OriginRequestPolicyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreconditionFailed = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PublicKeyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PublicKeyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryArgProfileEmpty = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RealtimeLogConfigAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RealtimeLogConfigInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RealtimeLogConfigOwnerMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotDisabled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResponseHeadersPolicyAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResponseHeadersPolicyInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StagingDistributionInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StreamingDistributionAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StreamingDistributionNotDisabled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TestFunctionFailed = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooLongCSPInResponseHeadersPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCacheBehaviors = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCachePolicies = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCertificates = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCloudFrontOriginAccessIdentities = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyContinuousDeploymentPolicies = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCookieNamesInWhiteList = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCookiesInCachePolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCookiesInOriginRequestPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyCustomHeadersInResponseHeadersPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionCNAMEs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributions = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsAssociatedToCachePolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsAssociatedToFieldLevelEncryptionConfig = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsAssociatedToKeyGroup = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsAssociatedToOriginAccessControl = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsAssociatedToOriginRequestPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsAssociatedToResponseHeadersPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsWithFunctionAssociations = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsWithLambdaAssociations = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyDistributionsWithSingleFunctionARN = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFieldLevelEncryptionConfigs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFieldLevelEncryptionContentTypeProfiles = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFieldLevelEncryptionEncryptionEntities = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFieldLevelEncryptionFieldPatterns = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFieldLevelEncryptionProfiles = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFieldLevelEncryptionQueryArgProfiles = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFunctionAssociations = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFunctions = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyHeadersInCachePolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyHeadersInForwardedValues = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyHeadersInOriginRequestPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyInvalidationsInProgress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyKeyGroups = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyKeyGroupsAssociatedToDistribution = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyLambdaFunctionAssociations = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyOriginAccessControls = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyOriginCustomHeaders = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyOriginGroupsPerDistribution = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyOriginRequestPolicies = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyOrigins = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyPublicKeys = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyPublicKeysInKeyGroup = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyQueryStringParameters = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyQueryStringsInCachePolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyQueryStringsInOriginRequestPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRealtimeLogConfigs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRemoveHeadersInResponseHeadersPolicy = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyResponseHeadersPolicies = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyStreamingDistributionCNAMEs = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyStreamingDistributions = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTrustedSigners = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrustedKeyGroupDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TrustedSignerDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
