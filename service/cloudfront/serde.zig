const aws = @import("aws");
const std = @import("std");

const ActiveTrustedKeyGroups = @import("active_trusted_key_groups.zig").ActiveTrustedKeyGroups;
const ActiveTrustedSigners = @import("active_trusted_signers.zig").ActiveTrustedSigners;
const AliasICPRecordal = @import("alias_icp_recordal.zig").AliasICPRecordal;
const Aliases = @import("aliases.zig").Aliases;
const AllowedMethods = @import("allowed_methods.zig").AllowedMethods;
const AnycastIpList = @import("anycast_ip_list.zig").AnycastIpList;
const AnycastIpListCollection = @import("anycast_ip_list_collection.zig").AnycastIpListCollection;
const AnycastIpListSummary = @import("anycast_ip_list_summary.zig").AnycastIpListSummary;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const CacheBehaviors = @import("cache_behaviors.zig").CacheBehaviors;
const CachePolicy = @import("cache_policy.zig").CachePolicy;
const CachePolicyConfig = @import("cache_policy_config.zig").CachePolicyConfig;
const CachePolicyCookieBehavior = @import("cache_policy_cookie_behavior.zig").CachePolicyCookieBehavior;
const CachePolicyCookiesConfig = @import("cache_policy_cookies_config.zig").CachePolicyCookiesConfig;
const CachePolicyHeaderBehavior = @import("cache_policy_header_behavior.zig").CachePolicyHeaderBehavior;
const CachePolicyHeadersConfig = @import("cache_policy_headers_config.zig").CachePolicyHeadersConfig;
const CachePolicyList = @import("cache_policy_list.zig").CachePolicyList;
const CachePolicyQueryStringBehavior = @import("cache_policy_query_string_behavior.zig").CachePolicyQueryStringBehavior;
const CachePolicyQueryStringsConfig = @import("cache_policy_query_strings_config.zig").CachePolicyQueryStringsConfig;
const CachePolicySummary = @import("cache_policy_summary.zig").CachePolicySummary;
const CachePolicyType = @import("cache_policy_type.zig").CachePolicyType;
const CachedMethods = @import("cached_methods.zig").CachedMethods;
const Certificate = @import("certificate.zig").Certificate;
const CertificateSource = @import("certificate_source.zig").CertificateSource;
const CertificateTransparencyLoggingPreference = @import("certificate_transparency_logging_preference.zig").CertificateTransparencyLoggingPreference;
const CloudFrontOriginAccessIdentity = @import("cloud_front_origin_access_identity.zig").CloudFrontOriginAccessIdentity;
const CloudFrontOriginAccessIdentityConfig = @import("cloud_front_origin_access_identity_config.zig").CloudFrontOriginAccessIdentityConfig;
const CloudFrontOriginAccessIdentityList = @import("cloud_front_origin_access_identity_list.zig").CloudFrontOriginAccessIdentityList;
const CloudFrontOriginAccessIdentitySummary = @import("cloud_front_origin_access_identity_summary.zig").CloudFrontOriginAccessIdentitySummary;
const ConflictingAlias = @import("conflicting_alias.zig").ConflictingAlias;
const ConflictingAliasesList = @import("conflicting_aliases_list.zig").ConflictingAliasesList;
const ConnectionFunctionAssociation = @import("connection_function_association.zig").ConnectionFunctionAssociation;
const ConnectionFunctionSummary = @import("connection_function_summary.zig").ConnectionFunctionSummary;
const ConnectionFunctionTestResult = @import("connection_function_test_result.zig").ConnectionFunctionTestResult;
const ConnectionGroup = @import("connection_group.zig").ConnectionGroup;
const ConnectionGroupAssociationFilter = @import("connection_group_association_filter.zig").ConnectionGroupAssociationFilter;
const ConnectionGroupSummary = @import("connection_group_summary.zig").ConnectionGroupSummary;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const ContentTypeProfile = @import("content_type_profile.zig").ContentTypeProfile;
const ContentTypeProfileConfig = @import("content_type_profile_config.zig").ContentTypeProfileConfig;
const ContentTypeProfiles = @import("content_type_profiles.zig").ContentTypeProfiles;
const ContinuousDeploymentPolicy = @import("continuous_deployment_policy.zig").ContinuousDeploymentPolicy;
const ContinuousDeploymentPolicyConfig = @import("continuous_deployment_policy_config.zig").ContinuousDeploymentPolicyConfig;
const ContinuousDeploymentPolicyList = @import("continuous_deployment_policy_list.zig").ContinuousDeploymentPolicyList;
const ContinuousDeploymentPolicySummary = @import("continuous_deployment_policy_summary.zig").ContinuousDeploymentPolicySummary;
const ContinuousDeploymentPolicyType = @import("continuous_deployment_policy_type.zig").ContinuousDeploymentPolicyType;
const ContinuousDeploymentSingleHeaderConfig = @import("continuous_deployment_single_header_config.zig").ContinuousDeploymentSingleHeaderConfig;
const ContinuousDeploymentSingleWeightConfig = @import("continuous_deployment_single_weight_config.zig").ContinuousDeploymentSingleWeightConfig;
const CookieNames = @import("cookie_names.zig").CookieNames;
const CookiePreference = @import("cookie_preference.zig").CookiePreference;
const CustomErrorResponse = @import("custom_error_response.zig").CustomErrorResponse;
const CustomErrorResponses = @import("custom_error_responses.zig").CustomErrorResponses;
const CustomHeaders = @import("custom_headers.zig").CustomHeaders;
const CustomOriginConfig = @import("custom_origin_config.zig").CustomOriginConfig;
const CustomizationActionType = @import("customization_action_type.zig").CustomizationActionType;
const Customizations = @import("customizations.zig").Customizations;
const DefaultCacheBehavior = @import("default_cache_behavior.zig").DefaultCacheBehavior;
const Distribution = @import("distribution.zig").Distribution;
const DistributionConfig = @import("distribution_config.zig").DistributionConfig;
const DistributionConfigWithTags = @import("distribution_config_with_tags.zig").DistributionConfigWithTags;
const DistributionIdList = @import("distribution_id_list.zig").DistributionIdList;
const DistributionIdOwner = @import("distribution_id_owner.zig").DistributionIdOwner;
const DistributionIdOwnerList = @import("distribution_id_owner_list.zig").DistributionIdOwnerList;
const DistributionList = @import("distribution_list.zig").DistributionList;
const DistributionResourceId = @import("distribution_resource_id.zig").DistributionResourceId;
const DistributionResourceType = @import("distribution_resource_type.zig").DistributionResourceType;
const DistributionSummary = @import("distribution_summary.zig").DistributionSummary;
const DistributionTenant = @import("distribution_tenant.zig").DistributionTenant;
const DistributionTenantAssociationFilter = @import("distribution_tenant_association_filter.zig").DistributionTenantAssociationFilter;
const DistributionTenantSummary = @import("distribution_tenant_summary.zig").DistributionTenantSummary;
const DnsConfiguration = @import("dns_configuration.zig").DnsConfiguration;
const DnsConfigurationStatus = @import("dns_configuration_status.zig").DnsConfigurationStatus;
const DomainConflict = @import("domain_conflict.zig").DomainConflict;
const DomainItem = @import("domain_item.zig").DomainItem;
const DomainResult = @import("domain_result.zig").DomainResult;
const DomainStatus = @import("domain_status.zig").DomainStatus;
const EncryptionEntities = @import("encryption_entities.zig").EncryptionEntities;
const EncryptionEntity = @import("encryption_entity.zig").EncryptionEntity;
const EndPoint = @import("end_point.zig").EndPoint;
const EventType = @import("event_type.zig").EventType;
const FieldLevelEncryption = @import("field_level_encryption.zig").FieldLevelEncryption;
const FieldLevelEncryptionConfig = @import("field_level_encryption_config.zig").FieldLevelEncryptionConfig;
const FieldLevelEncryptionList = @import("field_level_encryption_list.zig").FieldLevelEncryptionList;
const FieldLevelEncryptionProfile = @import("field_level_encryption_profile.zig").FieldLevelEncryptionProfile;
const FieldLevelEncryptionProfileConfig = @import("field_level_encryption_profile_config.zig").FieldLevelEncryptionProfileConfig;
const FieldLevelEncryptionProfileList = @import("field_level_encryption_profile_list.zig").FieldLevelEncryptionProfileList;
const FieldLevelEncryptionProfileSummary = @import("field_level_encryption_profile_summary.zig").FieldLevelEncryptionProfileSummary;
const FieldLevelEncryptionSummary = @import("field_level_encryption_summary.zig").FieldLevelEncryptionSummary;
const FieldPatterns = @import("field_patterns.zig").FieldPatterns;
const Format = @import("format.zig").Format;
const ForwardedValues = @import("forwarded_values.zig").ForwardedValues;
const FrameOptionsList = @import("frame_options_list.zig").FrameOptionsList;
const FunctionAssociation = @import("function_association.zig").FunctionAssociation;
const FunctionAssociations = @import("function_associations.zig").FunctionAssociations;
const FunctionConfig = @import("function_config.zig").FunctionConfig;
const FunctionList = @import("function_list.zig").FunctionList;
const FunctionMetadata = @import("function_metadata.zig").FunctionMetadata;
const FunctionRuntime = @import("function_runtime.zig").FunctionRuntime;
const FunctionStage = @import("function_stage.zig").FunctionStage;
const FunctionSummary = @import("function_summary.zig").FunctionSummary;
const GeoRestriction = @import("geo_restriction.zig").GeoRestriction;
const GeoRestrictionCustomization = @import("geo_restriction_customization.zig").GeoRestrictionCustomization;
const GeoRestrictionType = @import("geo_restriction_type.zig").GeoRestrictionType;
const GrpcConfig = @import("grpc_config.zig").GrpcConfig;
const Headers = @import("headers.zig").Headers;
const HttpVersion = @import("http_version.zig").HttpVersion;
const ICPRecordalStatus = @import("icp_recordal_status.zig").ICPRecordalStatus;
const ImportSource = @import("import_source.zig").ImportSource;
const ImportSourceType = @import("import_source_type.zig").ImportSourceType;
const Invalidation = @import("invalidation.zig").Invalidation;
const InvalidationBatch = @import("invalidation_batch.zig").InvalidationBatch;
const InvalidationList = @import("invalidation_list.zig").InvalidationList;
const InvalidationSummary = @import("invalidation_summary.zig").InvalidationSummary;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamCidrConfig = @import("ipam_cidr_config.zig").IpamCidrConfig;
const IpamCidrStatus = @import("ipam_cidr_status.zig").IpamCidrStatus;
const IpamConfig = @import("ipam_config.zig").IpamConfig;
const ItemSelection = @import("item_selection.zig").ItemSelection;
const KGKeyPairIds = @import("kg_key_pair_ids.zig").KGKeyPairIds;
const KeyGroup = @import("key_group.zig").KeyGroup;
const KeyGroupConfig = @import("key_group_config.zig").KeyGroupConfig;
const KeyGroupList = @import("key_group_list.zig").KeyGroupList;
const KeyGroupSummary = @import("key_group_summary.zig").KeyGroupSummary;
const KeyPairIds = @import("key_pair_ids.zig").KeyPairIds;
const KeyValueStore = @import("key_value_store.zig").KeyValueStore;
const KeyValueStoreAssociation = @import("key_value_store_association.zig").KeyValueStoreAssociation;
const KeyValueStoreAssociations = @import("key_value_store_associations.zig").KeyValueStoreAssociations;
const KeyValueStoreList = @import("key_value_store_list.zig").KeyValueStoreList;
const KinesisStreamConfig = @import("kinesis_stream_config.zig").KinesisStreamConfig;
const LambdaFunctionAssociation = @import("lambda_function_association.zig").LambdaFunctionAssociation;
const LambdaFunctionAssociations = @import("lambda_function_associations.zig").LambdaFunctionAssociations;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const ManagedCertificateDetails = @import("managed_certificate_details.zig").ManagedCertificateDetails;
const ManagedCertificateRequest = @import("managed_certificate_request.zig").ManagedCertificateRequest;
const ManagedCertificateStatus = @import("managed_certificate_status.zig").ManagedCertificateStatus;
const Method = @import("method.zig").Method;
const MinimumProtocolVersion = @import("minimum_protocol_version.zig").MinimumProtocolVersion;
const MonitoringSubscription = @import("monitoring_subscription.zig").MonitoringSubscription;
const Origin = @import("origin.zig").Origin;
const OriginAccessControl = @import("origin_access_control.zig").OriginAccessControl;
const OriginAccessControlConfig = @import("origin_access_control_config.zig").OriginAccessControlConfig;
const OriginAccessControlList = @import("origin_access_control_list.zig").OriginAccessControlList;
const OriginAccessControlOriginTypes = @import("origin_access_control_origin_types.zig").OriginAccessControlOriginTypes;
const OriginAccessControlSigningBehaviors = @import("origin_access_control_signing_behaviors.zig").OriginAccessControlSigningBehaviors;
const OriginAccessControlSigningProtocols = @import("origin_access_control_signing_protocols.zig").OriginAccessControlSigningProtocols;
const OriginAccessControlSummary = @import("origin_access_control_summary.zig").OriginAccessControlSummary;
const OriginCustomHeader = @import("origin_custom_header.zig").OriginCustomHeader;
const OriginGroup = @import("origin_group.zig").OriginGroup;
const OriginGroupFailoverCriteria = @import("origin_group_failover_criteria.zig").OriginGroupFailoverCriteria;
const OriginGroupMember = @import("origin_group_member.zig").OriginGroupMember;
const OriginGroupMembers = @import("origin_group_members.zig").OriginGroupMembers;
const OriginGroupSelectionCriteria = @import("origin_group_selection_criteria.zig").OriginGroupSelectionCriteria;
const OriginGroups = @import("origin_groups.zig").OriginGroups;
const OriginMtlsConfig = @import("origin_mtls_config.zig").OriginMtlsConfig;
const OriginProtocolPolicy = @import("origin_protocol_policy.zig").OriginProtocolPolicy;
const OriginRequestPolicy = @import("origin_request_policy.zig").OriginRequestPolicy;
const OriginRequestPolicyConfig = @import("origin_request_policy_config.zig").OriginRequestPolicyConfig;
const OriginRequestPolicyCookieBehavior = @import("origin_request_policy_cookie_behavior.zig").OriginRequestPolicyCookieBehavior;
const OriginRequestPolicyCookiesConfig = @import("origin_request_policy_cookies_config.zig").OriginRequestPolicyCookiesConfig;
const OriginRequestPolicyHeaderBehavior = @import("origin_request_policy_header_behavior.zig").OriginRequestPolicyHeaderBehavior;
const OriginRequestPolicyHeadersConfig = @import("origin_request_policy_headers_config.zig").OriginRequestPolicyHeadersConfig;
const OriginRequestPolicyList = @import("origin_request_policy_list.zig").OriginRequestPolicyList;
const OriginRequestPolicyQueryStringBehavior = @import("origin_request_policy_query_string_behavior.zig").OriginRequestPolicyQueryStringBehavior;
const OriginRequestPolicyQueryStringsConfig = @import("origin_request_policy_query_strings_config.zig").OriginRequestPolicyQueryStringsConfig;
const OriginRequestPolicySummary = @import("origin_request_policy_summary.zig").OriginRequestPolicySummary;
const OriginRequestPolicyType = @import("origin_request_policy_type.zig").OriginRequestPolicyType;
const OriginShield = @import("origin_shield.zig").OriginShield;
const OriginSslProtocols = @import("origin_ssl_protocols.zig").OriginSslProtocols;
const Origins = @import("origins.zig").Origins;
const Parameter = @import("parameter.zig").Parameter;
const ParameterDefinition = @import("parameter_definition.zig").ParameterDefinition;
const ParameterDefinitionSchema = @import("parameter_definition_schema.zig").ParameterDefinitionSchema;
const ParametersInCacheKeyAndForwardedToOrigin = @import("parameters_in_cache_key_and_forwarded_to_origin.zig").ParametersInCacheKeyAndForwardedToOrigin;
const Paths = @import("paths.zig").Paths;
const PriceClass = @import("price_class.zig").PriceClass;
const PublicKey = @import("public_key.zig").PublicKey;
const PublicKeyConfig = @import("public_key_config.zig").PublicKeyConfig;
const PublicKeyList = @import("public_key_list.zig").PublicKeyList;
const PublicKeySummary = @import("public_key_summary.zig").PublicKeySummary;
const QueryArgProfile = @import("query_arg_profile.zig").QueryArgProfile;
const QueryArgProfileConfig = @import("query_arg_profile_config.zig").QueryArgProfileConfig;
const QueryArgProfiles = @import("query_arg_profiles.zig").QueryArgProfiles;
const QueryStringCacheKeys = @import("query_string_cache_keys.zig").QueryStringCacheKeys;
const QueryStringNames = @import("query_string_names.zig").QueryStringNames;
const RealtimeLogConfig = @import("realtime_log_config.zig").RealtimeLogConfig;
const RealtimeLogConfigs = @import("realtime_log_configs.zig").RealtimeLogConfigs;
const RealtimeMetricsSubscriptionConfig = @import("realtime_metrics_subscription_config.zig").RealtimeMetricsSubscriptionConfig;
const RealtimeMetricsSubscriptionStatus = @import("realtime_metrics_subscription_status.zig").RealtimeMetricsSubscriptionStatus;
const ReferrerPolicyList = @import("referrer_policy_list.zig").ReferrerPolicyList;
const ResponseHeadersPolicy = @import("response_headers_policy.zig").ResponseHeadersPolicy;
const ResponseHeadersPolicyAccessControlAllowHeaders = @import("response_headers_policy_access_control_allow_headers.zig").ResponseHeadersPolicyAccessControlAllowHeaders;
const ResponseHeadersPolicyAccessControlAllowMethods = @import("response_headers_policy_access_control_allow_methods.zig").ResponseHeadersPolicyAccessControlAllowMethods;
const ResponseHeadersPolicyAccessControlAllowMethodsValues = @import("response_headers_policy_access_control_allow_methods_values.zig").ResponseHeadersPolicyAccessControlAllowMethodsValues;
const ResponseHeadersPolicyAccessControlAllowOrigins = @import("response_headers_policy_access_control_allow_origins.zig").ResponseHeadersPolicyAccessControlAllowOrigins;
const ResponseHeadersPolicyAccessControlExposeHeaders = @import("response_headers_policy_access_control_expose_headers.zig").ResponseHeadersPolicyAccessControlExposeHeaders;
const ResponseHeadersPolicyConfig = @import("response_headers_policy_config.zig").ResponseHeadersPolicyConfig;
const ResponseHeadersPolicyContentSecurityPolicy = @import("response_headers_policy_content_security_policy.zig").ResponseHeadersPolicyContentSecurityPolicy;
const ResponseHeadersPolicyContentTypeOptions = @import("response_headers_policy_content_type_options.zig").ResponseHeadersPolicyContentTypeOptions;
const ResponseHeadersPolicyCorsConfig = @import("response_headers_policy_cors_config.zig").ResponseHeadersPolicyCorsConfig;
const ResponseHeadersPolicyCustomHeader = @import("response_headers_policy_custom_header.zig").ResponseHeadersPolicyCustomHeader;
const ResponseHeadersPolicyCustomHeadersConfig = @import("response_headers_policy_custom_headers_config.zig").ResponseHeadersPolicyCustomHeadersConfig;
const ResponseHeadersPolicyFrameOptions = @import("response_headers_policy_frame_options.zig").ResponseHeadersPolicyFrameOptions;
const ResponseHeadersPolicyList = @import("response_headers_policy_list.zig").ResponseHeadersPolicyList;
const ResponseHeadersPolicyReferrerPolicy = @import("response_headers_policy_referrer_policy.zig").ResponseHeadersPolicyReferrerPolicy;
const ResponseHeadersPolicyRemoveHeader = @import("response_headers_policy_remove_header.zig").ResponseHeadersPolicyRemoveHeader;
const ResponseHeadersPolicyRemoveHeadersConfig = @import("response_headers_policy_remove_headers_config.zig").ResponseHeadersPolicyRemoveHeadersConfig;
const ResponseHeadersPolicySecurityHeadersConfig = @import("response_headers_policy_security_headers_config.zig").ResponseHeadersPolicySecurityHeadersConfig;
const ResponseHeadersPolicyServerTimingHeadersConfig = @import("response_headers_policy_server_timing_headers_config.zig").ResponseHeadersPolicyServerTimingHeadersConfig;
const ResponseHeadersPolicyStrictTransportSecurity = @import("response_headers_policy_strict_transport_security.zig").ResponseHeadersPolicyStrictTransportSecurity;
const ResponseHeadersPolicySummary = @import("response_headers_policy_summary.zig").ResponseHeadersPolicySummary;
const ResponseHeadersPolicyType = @import("response_headers_policy_type.zig").ResponseHeadersPolicyType;
const ResponseHeadersPolicyXSSProtection = @import("response_headers_policy_xss_protection.zig").ResponseHeadersPolicyXSSProtection;
const Restrictions = @import("restrictions.zig").Restrictions;
const S3Origin = @import("s3_origin.zig").S3Origin;
const S3OriginConfig = @import("s3_origin_config.zig").S3OriginConfig;
const SSLSupportMethod = @import("ssl_support_method.zig").SSLSupportMethod;
const SessionStickinessConfig = @import("session_stickiness_config.zig").SessionStickinessConfig;
const Signer = @import("signer.zig").Signer;
const SslProtocol = @import("ssl_protocol.zig").SslProtocol;
const StagingDistributionDnsNames = @import("staging_distribution_dns_names.zig").StagingDistributionDnsNames;
const StatusCodes = @import("status_codes.zig").StatusCodes;
const StreamingDistribution = @import("streaming_distribution.zig").StreamingDistribution;
const StreamingDistributionConfig = @import("streaming_distribution_config.zig").StreamingDistributionConfig;
const StreamingDistributionConfigWithTags = @import("streaming_distribution_config_with_tags.zig").StreamingDistributionConfigWithTags;
const StreamingDistributionList = @import("streaming_distribution_list.zig").StreamingDistributionList;
const StreamingDistributionSummary = @import("streaming_distribution_summary.zig").StreamingDistributionSummary;
const StreamingLoggingConfig = @import("streaming_logging_config.zig").StreamingLoggingConfig;
const StringSchemaConfig = @import("string_schema_config.zig").StringSchemaConfig;
const Tag = @import("tag.zig").Tag;
const TagKeys = @import("tag_keys.zig").TagKeys;
const Tags = @import("tags.zig").Tags;
const TenantConfig = @import("tenant_config.zig").TenantConfig;
const TestResult = @import("test_result.zig").TestResult;
const TrafficConfig = @import("traffic_config.zig").TrafficConfig;
const TrustStore = @import("trust_store.zig").TrustStore;
const TrustStoreConfig = @import("trust_store_config.zig").TrustStoreConfig;
const TrustStoreStatus = @import("trust_store_status.zig").TrustStoreStatus;
const TrustStoreSummary = @import("trust_store_summary.zig").TrustStoreSummary;
const TrustedKeyGroups = @import("trusted_key_groups.zig").TrustedKeyGroups;
const TrustedSigners = @import("trusted_signers.zig").TrustedSigners;
const ValidationTokenDetail = @import("validation_token_detail.zig").ValidationTokenDetail;
const ValidationTokenHost = @import("validation_token_host.zig").ValidationTokenHost;
const ViewerCertificate = @import("viewer_certificate.zig").ViewerCertificate;
const ViewerMtlsConfig = @import("viewer_mtls_config.zig").ViewerMtlsConfig;
const ViewerMtlsMode = @import("viewer_mtls_mode.zig").ViewerMtlsMode;
const ViewerProtocolPolicy = @import("viewer_protocol_policy.zig").ViewerProtocolPolicy;
const VpcOrigin = @import("vpc_origin.zig").VpcOrigin;
const VpcOriginConfig = @import("vpc_origin_config.zig").VpcOriginConfig;
const VpcOriginEndpointConfig = @import("vpc_origin_endpoint_config.zig").VpcOriginEndpointConfig;
const VpcOriginList = @import("vpc_origin_list.zig").VpcOriginList;
const VpcOriginSummary = @import("vpc_origin_summary.zig").VpcOriginSummary;
const WebAclCustomization = @import("web_acl_customization.zig").WebAclCustomization;

pub fn deserializeAccessControlAllowHeadersList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccessControlAllowMethodsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResponseHeadersPolicyAccessControlAllowMethodsValues {
    var list: std.ArrayList(ResponseHeadersPolicyAccessControlAllowMethodsValues) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ResponseHeadersPolicyAccessControlAllowMethodsValues, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccessControlAllowOriginsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccessControlExposeHeadersList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAliasICPRecordals(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AliasICPRecordal {
    var list: std.ArrayList(AliasICPRecordal) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAliasICPRecordal(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAliasList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAnycastIpListSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AnycastIpListSummary {
    var list: std.ArrayList(AnycastIpListSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAnycastIpListSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAnycastIps(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAwsAccountNumberList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCacheBehaviorList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CacheBehavior {
    var list: std.ArrayList(CacheBehavior) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCacheBehavior(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCachePolicySummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CachePolicySummary {
    var list: std.ArrayList(CachePolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCachePolicySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCloudFrontOriginAccessIdentitySummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CloudFrontOriginAccessIdentitySummary {
    var list: std.ArrayList(CloudFrontOriginAccessIdentitySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCloudFrontOriginAccessIdentitySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeConflictingAliases(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConflictingAlias {
    var list: std.ArrayList(ConflictingAlias) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConflictingAlias(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeConnectionFunctionSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConnectionFunctionSummary {
    var list: std.ArrayList(ConnectionFunctionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConnectionFunctionSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeConnectionGroupSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ConnectionGroupSummary {
    var list: std.ArrayList(ConnectionGroupSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeConnectionGroupSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeContentTypeProfileList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ContentTypeProfile {
    var list: std.ArrayList(ContentTypeProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeContentTypeProfile(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeContinuousDeploymentPolicySummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ContinuousDeploymentPolicySummary {
    var list: std.ArrayList(ContinuousDeploymentPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeContinuousDeploymentPolicySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCookieNameList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCustomErrorResponseList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CustomErrorResponse {
    var list: std.ArrayList(CustomErrorResponse) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCustomErrorResponse(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDistributionIdListSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDistributionIdOwnerItemList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DistributionIdOwner {
    var list: std.ArrayList(DistributionIdOwner) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDistributionIdOwner(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDistributionSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DistributionSummary {
    var list: std.ArrayList(DistributionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDistributionSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDistributionTenantList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DistributionTenantSummary {
    var list: std.ArrayList(DistributionTenantSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDistributionTenantSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDnsConfigurationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DnsConfiguration {
    var list: std.ArrayList(DnsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDnsConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDomainConflictsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DomainConflict {
    var list: std.ArrayList(DomainConflict) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDomainConflict(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDomainResultList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DomainResult {
    var list: std.ArrayList(DomainResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDomainResult(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEncryptionEntityList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EncryptionEntity {
    var list: std.ArrayList(EncryptionEntity) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEncryptionEntity(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEndPointList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EndPoint {
    var list: std.ArrayList(EndPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEndPoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFieldLevelEncryptionProfileSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FieldLevelEncryptionProfileSummary {
    var list: std.ArrayList(FieldLevelEncryptionProfileSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeFieldLevelEncryptionProfileSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFieldLevelEncryptionSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FieldLevelEncryptionSummary {
    var list: std.ArrayList(FieldLevelEncryptionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeFieldLevelEncryptionSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFieldList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFieldPatternList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFunctionAssociationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FunctionAssociation {
    var list: std.ArrayList(FunctionAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeFunctionAssociation(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFunctionExecutionLogList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFunctionSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FunctionSummary {
    var list: std.ArrayList(FunctionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeFunctionSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeHeaderList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInvalidationSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InvalidationSummary {
    var list: std.ArrayList(InvalidationSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInvalidationSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIpamCidrConfigList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const IpamCidrConfig {
    var list: std.ArrayList(IpamCidrConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeIpamCidrConfig(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeKGKeyPairIdsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const KGKeyPairIds {
    var list: std.ArrayList(KGKeyPairIds) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeKGKeyPairIds(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeKeyGroupSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const KeyGroupSummary {
    var list: std.ArrayList(KeyGroupSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeKeyGroupSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeKeyPairIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeKeyValueStoreAssociationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const KeyValueStoreAssociation {
    var list: std.ArrayList(KeyValueStoreAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeKeyValueStoreAssociation(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeKeyValueStoreSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const KeyValueStore {
    var list: std.ArrayList(KeyValueStore) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeKeyValueStore(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeLambdaFunctionAssociationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const LambdaFunctionAssociation {
    var list: std.ArrayList(LambdaFunctionAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeLambdaFunctionAssociation(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeLocationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMethodsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Method {
    var list: std.ArrayList(Method) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(Method, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOriginAccessControlSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OriginAccessControlSummary {
    var list: std.ArrayList(OriginAccessControlSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOriginAccessControlSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOriginCustomHeadersList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OriginCustomHeader {
    var list: std.ArrayList(OriginCustomHeader) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOriginCustomHeader(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOriginGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OriginGroup {
    var list: std.ArrayList(OriginGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOriginGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOriginGroupMemberList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OriginGroupMember {
    var list: std.ArrayList(OriginGroupMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOriginGroupMember(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOriginList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Origin {
    var list: std.ArrayList(Origin) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOrigin(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOriginRequestPolicySummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OriginRequestPolicySummary {
    var list: std.ArrayList(OriginRequestPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOriginRequestPolicySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeParameterDefinitions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ParameterDefinition {
    var list: std.ArrayList(ParameterDefinition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeParameterDefinition(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeParameters(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Parameter {
    var list: std.ArrayList(Parameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeParameter(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePathList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePublicKeyIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePublicKeySummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PublicKeySummary {
    var list: std.ArrayList(PublicKeySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePublicKeySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeQueryArgProfileList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const QueryArgProfile {
    var list: std.ArrayList(QueryArgProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeQueryArgProfile(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeQueryStringCacheKeysList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeQueryStringNamesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRealtimeLogConfigList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RealtimeLogConfig {
    var list: std.ArrayList(RealtimeLogConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRealtimeLogConfig(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResponseHeadersPolicyCustomHeaderList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResponseHeadersPolicyCustomHeader {
    var list: std.ArrayList(ResponseHeadersPolicyCustomHeader) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResponseHeadersPolicyCustomHeader(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResponseHeadersPolicyRemoveHeaderList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResponseHeadersPolicyRemoveHeader {
    var list: std.ArrayList(ResponseHeadersPolicyRemoveHeader) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResponseHeadersPolicyRemoveHeader(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResponseHeadersPolicySummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResponseHeadersPolicySummary {
    var list: std.ArrayList(ResponseHeadersPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResponseHeadersPolicySummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSignerList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Signer {
    var list: std.ArrayList(Signer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSigner(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSslProtocolsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SslProtocol {
    var list: std.ArrayList(SslProtocol) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(SslProtocol, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeStagingDistributionDnsNameList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeStatusCodeList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const i32 {
    var list: std.ArrayList(i32) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeStreamingDistributionSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StreamingDistributionSummary {
    var list: std.ArrayList(StreamingDistributionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStreamingDistributionSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTagList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTag(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTrustStoreList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrustStoreSummary {
    var list: std.ArrayList(TrustStoreSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrustStoreSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTrustedKeyGroupIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeValidationTokenDetailList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ValidationTokenDetail {
    var list: std.ArrayList(ValidationTokenDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeValidationTokenDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeVpcOriginSummaryList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const VpcOriginSummary {
    var list: std.ArrayList(VpcOriginSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeVpcOriginSummary(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeActiveTrustedKeyGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ActiveTrustedKeyGroups {
    var result: ActiveTrustedKeyGroups = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKGKeyPairIdsList(reader, alloc, "KeyGroup");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeActiveTrustedSigners(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ActiveTrustedSigners {
    var result: ActiveTrustedSigners = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeSignerList(reader, alloc, "Signer");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAliasICPRecordal(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AliasICPRecordal {
    var result: AliasICPRecordal = undefined;
    result.cname = null;
    result.icp_recordal_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CNAME")) {
                    result.cname = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ICPRecordalStatus")) {
                    result.icp_recordal_status = std.meta.stringToEnum(ICPRecordalStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAliases(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Aliases {
    var result: Aliases = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAliasList(reader, alloc, "CNAME");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAllowedMethods(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AllowedMethods {
    var result: AllowedMethods = undefined;
    result.cached_methods = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CachedMethods")) {
                    result.cached_methods = try deserializeCachedMethods(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeMethodsList(reader, alloc, "Method");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnycastIpList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnycastIpList {
    var result: AnycastIpList = undefined;
    result.ip_address_type = null;
    result.ipam_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIps")) {
                    result.anycast_ips = try deserializeAnycastIps(reader, alloc, "AnycastIp");
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = std.meta.stringToEnum(IpAddressType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamConfig")) {
                    result.ipam_config = try deserializeIpamConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IpCount")) {
                    result.ip_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnycastIpListCollection(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnycastIpListCollection {
    var result: AnycastIpListCollection = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAnycastIpListSummaries(reader, alloc, "AnycastIpListSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnycastIpListSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnycastIpListSummary {
    var result: AnycastIpListSummary = undefined;
    result.e_tag = null;
    result.ip_address_type = null;
    result.ipam_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = std.meta.stringToEnum(IpAddressType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamConfig")) {
                    result.ipam_config = try deserializeIpamConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IpCount")) {
                    result.ip_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheBehavior(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheBehavior {
    var result: CacheBehavior = undefined;
    result.allowed_methods = null;
    result.cache_policy_id = null;
    result.compress = null;
    result.default_ttl = null;
    result.field_level_encryption_id = null;
    result.forwarded_values = null;
    result.function_associations = null;
    result.grpc_config = null;
    result.lambda_function_associations = null;
    result.max_ttl = null;
    result.min_ttl = null;
    result.origin_request_policy_id = null;
    result.realtime_log_config_arn = null;
    result.response_headers_policy_id = null;
    result.smooth_streaming = null;
    result.trusted_key_groups = null;
    result.trusted_signers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedMethods")) {
                    result.allowed_methods = try deserializeAllowedMethods(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CachePolicyId")) {
                    result.cache_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Compress")) {
                    result.compress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultTTL")) {
                    result.default_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FieldLevelEncryptionId")) {
                    result.field_level_encryption_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForwardedValues")) {
                    result.forwarded_values = try deserializeForwardedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "FunctionAssociations")) {
                    result.function_associations = try deserializeFunctionAssociations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GrpcConfig")) {
                    result.grpc_config = try deserializeGrpcConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LambdaFunctionAssociations")) {
                    result.lambda_function_associations = try deserializeLambdaFunctionAssociations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MaxTTL")) {
                    result.max_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinTTL")) {
                    result.min_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginRequestPolicyId")) {
                    result.origin_request_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PathPattern")) {
                    result.path_pattern = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RealtimeLogConfigArn")) {
                    result.realtime_log_config_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseHeadersPolicyId")) {
                    result.response_headers_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SmoothStreaming")) {
                    result.smooth_streaming = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TargetOriginId")) {
                    result.target_origin_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustedKeyGroups")) {
                    result.trusted_key_groups = try deserializeTrustedKeyGroups(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ViewerProtocolPolicy")) {
                    result.viewer_protocol_policy = std.meta.stringToEnum(ViewerProtocolPolicy, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCacheBehaviors(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CacheBehaviors {
    var result: CacheBehaviors = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCacheBehaviorList(reader, alloc, "CacheBehavior");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicy {
    var result: CachePolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CachePolicyConfig")) {
                    result.cache_policy_config = try deserializeCachePolicyConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicyConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicyConfig {
    var result: CachePolicyConfig = undefined;
    result.comment = null;
    result.default_ttl = null;
    result.max_ttl = null;
    result.parameters_in_cache_key_and_forwarded_to_origin = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultTTL")) {
                    result.default_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxTTL")) {
                    result.max_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinTTL")) {
                    result.min_ttl = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParametersInCacheKeyAndForwardedToOrigin")) {
                    result.parameters_in_cache_key_and_forwarded_to_origin = try deserializeParametersInCacheKeyAndForwardedToOrigin(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicyCookiesConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicyCookiesConfig {
    var result: CachePolicyCookiesConfig = undefined;
    result.cookies = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieBehavior")) {
                    result.cookie_behavior = std.meta.stringToEnum(CachePolicyCookieBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cookies")) {
                    result.cookies = try deserializeCookieNames(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicyHeadersConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicyHeadersConfig {
    var result: CachePolicyHeadersConfig = undefined;
    result.headers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderBehavior")) {
                    result.header_behavior = std.meta.stringToEnum(CachePolicyHeaderBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Headers")) {
                    result.headers = try deserializeHeaders(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicyList {
    var result: CachePolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCachePolicySummaryList(reader, alloc, "CachePolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicyQueryStringsConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicyQueryStringsConfig {
    var result: CachePolicyQueryStringsConfig = undefined;
    result.query_strings = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "QueryStringBehavior")) {
                    result.query_string_behavior = std.meta.stringToEnum(CachePolicyQueryStringBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryStrings")) {
                    result.query_strings = try deserializeQueryStringNames(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachePolicySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachePolicySummary {
    var result: CachePolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CachePolicy")) {
                    result.cache_policy = try deserializeCachePolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(CachePolicyType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCachedMethods(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CachedMethods {
    var result: CachedMethods = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeMethodsList(reader, alloc, "Method");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCertificate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Certificate {
    var result: Certificate = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudFrontOriginAccessIdentity(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudFrontOriginAccessIdentity {
    var result: CloudFrontOriginAccessIdentity = undefined;
    result.cloud_front_origin_access_identity_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudFrontOriginAccessIdentityConfig")) {
                    result.cloud_front_origin_access_identity_config = try deserializeCloudFrontOriginAccessIdentityConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3CanonicalUserId")) {
                    result.s3_canonical_user_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudFrontOriginAccessIdentityConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudFrontOriginAccessIdentityConfig {
    var result: CloudFrontOriginAccessIdentityConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudFrontOriginAccessIdentityList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudFrontOriginAccessIdentityList {
    var result: CloudFrontOriginAccessIdentityList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCloudFrontOriginAccessIdentitySummaryList(reader, alloc, "CloudFrontOriginAccessIdentitySummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCloudFrontOriginAccessIdentitySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CloudFrontOriginAccessIdentitySummary {
    var result: CloudFrontOriginAccessIdentitySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3CanonicalUserId")) {
                    result.s3_canonical_user_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConflictingAlias(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConflictingAlias {
    var result: ConflictingAlias = undefined;
    result.account_id = null;
    result.alias = null;
    result.distribution_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConflictingAliasesList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConflictingAliasesList {
    var result: ConflictingAliasesList = undefined;
    result.items = null;
    result.max_items = null;
    result.next_marker = null;
    result.quantity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeConflictingAliases(reader, alloc, "ConflictingAlias");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectionFunctionAssociation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionFunctionAssociation {
    var result: ConnectionFunctionAssociation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectionFunctionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionFunctionSummary {
    var result: ConnectionFunctionSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConnectionFunctionArn")) {
                    result.connection_function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionConfig")) {
                    result.connection_function_config = try deserializeFunctionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stage")) {
                    result.stage = std.meta.stringToEnum(FunctionStage, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectionFunctionTestResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionFunctionTestResult {
    var result: ConnectionFunctionTestResult = undefined;
    result.compute_utilization = null;
    result.connection_function_error_message = null;
    result.connection_function_execution_logs = null;
    result.connection_function_output = null;
    result.connection_function_summary = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ComputeUtilization")) {
                    result.compute_utilization = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionErrorMessage")) {
                    result.connection_function_error_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionExecutionLogs")) {
                    result.connection_function_execution_logs = try deserializeFunctionExecutionLogList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionOutput")) {
                    result.connection_function_output = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionSummary")) {
                    result.connection_function_summary = try deserializeConnectionFunctionSummary(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectionGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionGroup {
    var result: ConnectionGroup = undefined;
    result.anycast_ip_list_id = null;
    result.arn = null;
    result.created_time = null;
    result.enabled = null;
    result.id = null;
    result.ipv_6_enabled = null;
    result.is_default = null;
    result.last_modified_time = null;
    result.name = null;
    result.routing_endpoint = null;
    result.status = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Ipv6Enabled")) {
                    result.ipv_6_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoutingEndpoint")) {
                    result.routing_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeConnectionGroupSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ConnectionGroupSummary {
    var result: ConnectionGroupSummary = undefined;
    result.anycast_ip_list_id = null;
    result.enabled = null;
    result.is_default = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoutingEndpoint")) {
                    result.routing_endpoint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContentTypeProfile(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContentTypeProfile {
    var result: ContentTypeProfile = undefined;
    result.profile_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentType")) {
                    result.content_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = std.meta.stringToEnum(Format, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProfileId")) {
                    result.profile_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContentTypeProfileConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContentTypeProfileConfig {
    var result: ContentTypeProfileConfig = undefined;
    result.content_type_profiles = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentTypeProfiles")) {
                    result.content_type_profiles = try deserializeContentTypeProfiles(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ForwardWhenContentTypeIsUnknown")) {
                    result.forward_when_content_type_is_unknown = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContentTypeProfiles(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContentTypeProfiles {
    var result: ContentTypeProfiles = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeContentTypeProfileList(reader, alloc, "ContentTypeProfile");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContinuousDeploymentPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContinuousDeploymentPolicy {
    var result: ContinuousDeploymentPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinuousDeploymentPolicyConfig")) {
                    result.continuous_deployment_policy_config = try deserializeContinuousDeploymentPolicyConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContinuousDeploymentPolicyConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContinuousDeploymentPolicyConfig {
    var result: ContinuousDeploymentPolicyConfig = undefined;
    result.traffic_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StagingDistributionDnsNames")) {
                    result.staging_distribution_dns_names = try deserializeStagingDistributionDnsNames(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TrafficConfig")) {
                    result.traffic_config = try deserializeTrafficConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContinuousDeploymentPolicyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContinuousDeploymentPolicyList {
    var result: ContinuousDeploymentPolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeContinuousDeploymentPolicySummaryList(reader, alloc, "ContinuousDeploymentPolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContinuousDeploymentPolicySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContinuousDeploymentPolicySummary {
    var result: ContinuousDeploymentPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinuousDeploymentPolicy")) {
                    result.continuous_deployment_policy = try deserializeContinuousDeploymentPolicy(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContinuousDeploymentSingleHeaderConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContinuousDeploymentSingleHeaderConfig {
    var result: ContinuousDeploymentSingleHeaderConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Header")) {
                    result.header = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeContinuousDeploymentSingleWeightConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ContinuousDeploymentSingleWeightConfig {
    var result: ContinuousDeploymentSingleWeightConfig = undefined;
    result.session_stickiness_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SessionStickinessConfig")) {
                    result.session_stickiness_config = try deserializeSessionStickinessConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Weight")) {
                    result.weight = try std.fmt.parseFloat(f32, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCookieNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CookieNames {
    var result: CookieNames = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCookieNameList(reader, alloc, "Name");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCookiePreference(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CookiePreference {
    var result: CookiePreference = undefined;
    result.whitelisted_names = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Forward")) {
                    result.forward = std.meta.stringToEnum(ItemSelection, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "WhitelistedNames")) {
                    result.whitelisted_names = try deserializeCookieNames(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomErrorResponse(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomErrorResponse {
    var result: CustomErrorResponse = undefined;
    result.error_caching_min_ttl = null;
    result.response_code = null;
    result.response_page_path = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCachingMinTTL")) {
                    result.error_caching_min_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "ResponseCode")) {
                    result.response_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponsePagePath")) {
                    result.response_page_path = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomErrorResponses(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomErrorResponses {
    var result: CustomErrorResponses = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCustomErrorResponseList(reader, alloc, "CustomErrorResponse");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomHeaders(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomHeaders {
    var result: CustomHeaders = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginCustomHeadersList(reader, alloc, "OriginCustomHeader");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomOriginConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CustomOriginConfig {
    var result: CustomOriginConfig = undefined;
    result.ip_address_type = null;
    result.origin_keepalive_timeout = null;
    result.origin_mtls_config = null;
    result.origin_read_timeout = null;
    result.origin_ssl_protocols = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HTTPPort")) {
                    result.http_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "HTTPSPort")) {
                    result.https_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = std.meta.stringToEnum(IpAddressType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginKeepaliveTimeout")) {
                    result.origin_keepalive_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginMtlsConfig")) {
                    result.origin_mtls_config = try deserializeOriginMtlsConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "OriginProtocolPolicy")) {
                    result.origin_protocol_policy = std.meta.stringToEnum(OriginProtocolPolicy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginReadTimeout")) {
                    result.origin_read_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginSslProtocols")) {
                    result.origin_ssl_protocols = try deserializeOriginSslProtocols(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCustomizations(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Customizations {
    var result: Customizations = undefined;
    result.certificate = null;
    result.geo_restrictions = null;
    result.web_acl = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Certificate")) {
                    result.certificate = try deserializeCertificate(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GeoRestrictions")) {
                    result.geo_restrictions = try deserializeGeoRestrictionCustomization(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "WebAcl")) {
                    result.web_acl = try deserializeWebAclCustomization(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDefaultCacheBehavior(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DefaultCacheBehavior {
    var result: DefaultCacheBehavior = undefined;
    result.allowed_methods = null;
    result.cache_policy_id = null;
    result.compress = null;
    result.default_ttl = null;
    result.field_level_encryption_id = null;
    result.forwarded_values = null;
    result.function_associations = null;
    result.grpc_config = null;
    result.lambda_function_associations = null;
    result.max_ttl = null;
    result.min_ttl = null;
    result.origin_request_policy_id = null;
    result.realtime_log_config_arn = null;
    result.response_headers_policy_id = null;
    result.smooth_streaming = null;
    result.trusted_key_groups = null;
    result.trusted_signers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedMethods")) {
                    result.allowed_methods = try deserializeAllowedMethods(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CachePolicyId")) {
                    result.cache_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Compress")) {
                    result.compress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultTTL")) {
                    result.default_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FieldLevelEncryptionId")) {
                    result.field_level_encryption_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForwardedValues")) {
                    result.forwarded_values = try deserializeForwardedValues(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "FunctionAssociations")) {
                    result.function_associations = try deserializeFunctionAssociations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GrpcConfig")) {
                    result.grpc_config = try deserializeGrpcConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LambdaFunctionAssociations")) {
                    result.lambda_function_associations = try deserializeLambdaFunctionAssociations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MaxTTL")) {
                    result.max_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinTTL")) {
                    result.min_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginRequestPolicyId")) {
                    result.origin_request_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RealtimeLogConfigArn")) {
                    result.realtime_log_config_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseHeadersPolicyId")) {
                    result.response_headers_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SmoothStreaming")) {
                    result.smooth_streaming = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TargetOriginId")) {
                    result.target_origin_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustedKeyGroups")) {
                    result.trusted_key_groups = try deserializeTrustedKeyGroups(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ViewerProtocolPolicy")) {
                    result.viewer_protocol_policy = std.meta.stringToEnum(ViewerProtocolPolicy, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistribution(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Distribution {
    var result: Distribution = undefined;
    result.active_trusted_key_groups = null;
    result.active_trusted_signers = null;
    result.alias_icp_recordals = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActiveTrustedKeyGroups")) {
                    result.active_trusted_key_groups = try deserializeActiveTrustedKeyGroups(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ActiveTrustedSigners")) {
                    result.active_trusted_signers = try deserializeActiveTrustedSigners(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AliasICPRecordals")) {
                    result.alias_icp_recordals = try deserializeAliasICPRecordals(reader, alloc, "AliasICPRecordal");
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DistributionConfig")) {
                    result.distribution_config = try deserializeDistributionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InProgressInvalidationBatches")) {
                    result.in_progress_invalidation_batches = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionConfig {
    var result: DistributionConfig = undefined;
    result.aliases = null;
    result.anycast_ip_list_id = null;
    result.cache_behaviors = null;
    result.connection_function_association = null;
    result.connection_mode = null;
    result.continuous_deployment_policy_id = null;
    result.custom_error_responses = null;
    result.default_root_object = null;
    result.http_version = null;
    result.is_ipv6_enabled = null;
    result.logging = null;
    result.origin_groups = null;
    result.price_class = null;
    result.restrictions = null;
    result.staging = null;
    result.tenant_config = null;
    result.viewer_certificate = null;
    result.viewer_mtls_config = null;
    result.web_acl_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Aliases")) {
                    result.aliases = try deserializeAliases(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheBehaviors")) {
                    result.cache_behaviors = try deserializeCacheBehaviors(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionAssociation")) {
                    result.connection_function_association = try deserializeConnectionFunctionAssociation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ConnectionMode")) {
                    result.connection_mode = std.meta.stringToEnum(ConnectionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContinuousDeploymentPolicyId")) {
                    result.continuous_deployment_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomErrorResponses")) {
                    result.custom_error_responses = try deserializeCustomErrorResponses(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DefaultCacheBehavior")) {
                    result.default_cache_behavior = try deserializeDefaultCacheBehavior(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DefaultRootObject")) {
                    result.default_root_object = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HttpVersion")) {
                    result.http_version = std.meta.stringToEnum(HttpVersion, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsIPV6Enabled")) {
                    result.is_ipv6_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Logging")) {
                    result.logging = try deserializeLoggingConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "OriginGroups")) {
                    result.origin_groups = try deserializeOriginGroups(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Origins")) {
                    result.origins = try deserializeOrigins(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = std.meta.stringToEnum(PriceClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Restrictions")) {
                    result.restrictions = try deserializeRestrictions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Staging")) {
                    result.staging = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TenantConfig")) {
                    result.tenant_config = try deserializeTenantConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ViewerCertificate")) {
                    result.viewer_certificate = try deserializeViewerCertificate(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ViewerMtlsConfig")) {
                    result.viewer_mtls_config = try deserializeViewerMtlsConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "WebACLId")) {
                    result.web_acl_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionIdList {
    var result: DistributionIdList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeDistributionIdListSummary(reader, alloc, "DistributionId");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionIdOwner(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionIdOwner {
    var result: DistributionIdOwner = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwnerAccountId")) {
                    result.owner_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionIdOwnerList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionIdOwnerList {
    var result: DistributionIdOwnerList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeDistributionIdOwnerItemList(reader, alloc, "DistributionIdOwner");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionList {
    var result: DistributionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeDistributionSummaryList(reader, alloc, "DistributionSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionSummary {
    var result: DistributionSummary = undefined;
    result.alias_icp_recordals = null;
    result.anycast_ip_list_id = null;
    result.connection_function_association = null;
    result.connection_mode = null;
    result.e_tag = null;
    result.origin_groups = null;
    result.viewer_mtls_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Aliases")) {
                    result.aliases = try deserializeAliases(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AliasICPRecordals")) {
                    result.alias_icp_recordals = try deserializeAliasICPRecordals(reader, alloc, "AliasICPRecordal");
                } else if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheBehaviors")) {
                    result.cache_behaviors = try deserializeCacheBehaviors(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionAssociation")) {
                    result.connection_function_association = try deserializeConnectionFunctionAssociation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ConnectionMode")) {
                    result.connection_mode = std.meta.stringToEnum(ConnectionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomErrorResponses")) {
                    result.custom_error_responses = try deserializeCustomErrorResponses(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DefaultCacheBehavior")) {
                    result.default_cache_behavior = try deserializeDefaultCacheBehavior(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpVersion")) {
                    result.http_version = std.meta.stringToEnum(HttpVersion, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsIPV6Enabled")) {
                    result.is_ipv6_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginGroups")) {
                    result.origin_groups = try deserializeOriginGroups(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Origins")) {
                    result.origins = try deserializeOrigins(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = std.meta.stringToEnum(PriceClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Restrictions")) {
                    result.restrictions = try deserializeRestrictions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Staging")) {
                    result.staging = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ViewerCertificate")) {
                    result.viewer_certificate = try deserializeViewerCertificate(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ViewerMtlsConfig")) {
                    result.viewer_mtls_config = try deserializeViewerMtlsConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "WebACLId")) {
                    result.web_acl_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionTenant(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionTenant {
    var result: DistributionTenant = undefined;
    result.arn = null;
    result.connection_group_id = null;
    result.created_time = null;
    result.customizations = null;
    result.distribution_id = null;
    result.domains = null;
    result.enabled = null;
    result.id = null;
    result.last_modified_time = null;
    result.name = null;
    result.parameters = null;
    result.status = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionGroupId")) {
                    result.connection_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Customizations")) {
                    result.customizations = try deserializeCustomizations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Domains")) {
                    result.domains = try deserializeDomainResultList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParameters(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDistributionTenantSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DistributionTenantSummary {
    var result: DistributionTenantSummary = undefined;
    result.connection_group_id = null;
    result.customizations = null;
    result.enabled = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionGroupId")) {
                    result.connection_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Customizations")) {
                    result.customizations = try deserializeCustomizations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Domains")) {
                    result.domains = try deserializeDomainResultList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDnsConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DnsConfiguration {
    var result: DnsConfiguration = undefined;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(DnsConfigurationStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDomainConflict(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainConflict {
    var result: DomainConflict = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = std.meta.stringToEnum(DistributionResourceType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDomainResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainResult {
    var result: DomainResult = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(DomainStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEncryptionEntities(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EncryptionEntities {
    var result: EncryptionEntities = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeEncryptionEntityList(reader, alloc, "EncryptionEntity");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEncryptionEntity(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EncryptionEntity {
    var result: EncryptionEntity = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FieldPatterns")) {
                    result.field_patterns = try deserializeFieldPatterns(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ProviderId")) {
                    result.provider_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicKeyId")) {
                    result.public_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEndPoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EndPoint {
    var result: EndPoint = undefined;
    result.kinesis_stream_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KinesisStreamConfig")) {
                    result.kinesis_stream_config = try deserializeKinesisStreamConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StreamType")) {
                    result.stream_type = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryption(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryption {
    var result: FieldLevelEncryption = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FieldLevelEncryptionConfig")) {
                    result.field_level_encryption_config = try deserializeFieldLevelEncryptionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionConfig {
    var result: FieldLevelEncryptionConfig = undefined;
    result.comment = null;
    result.content_type_profile_config = null;
    result.query_arg_profile_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentTypeProfileConfig")) {
                    result.content_type_profile_config = try deserializeContentTypeProfileConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "QueryArgProfileConfig")) {
                    result.query_arg_profile_config = try deserializeQueryArgProfileConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionList {
    var result: FieldLevelEncryptionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFieldLevelEncryptionSummaryList(reader, alloc, "FieldLevelEncryptionSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionProfile(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionProfile {
    var result: FieldLevelEncryptionProfile = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FieldLevelEncryptionProfileConfig")) {
                    result.field_level_encryption_profile_config = try deserializeFieldLevelEncryptionProfileConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionProfileConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionProfileConfig {
    var result: FieldLevelEncryptionProfileConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionEntities")) {
                    result.encryption_entities = try deserializeEncryptionEntities(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionProfileList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionProfileList {
    var result: FieldLevelEncryptionProfileList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFieldLevelEncryptionProfileSummaryList(reader, alloc, "FieldLevelEncryptionProfileSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionProfileSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionProfileSummary {
    var result: FieldLevelEncryptionProfileSummary = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionEntities")) {
                    result.encryption_entities = try deserializeEncryptionEntities(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldLevelEncryptionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldLevelEncryptionSummary {
    var result: FieldLevelEncryptionSummary = undefined;
    result.comment = null;
    result.content_type_profile_config = null;
    result.query_arg_profile_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentTypeProfileConfig")) {
                    result.content_type_profile_config = try deserializeContentTypeProfileConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryArgProfileConfig")) {
                    result.query_arg_profile_config = try deserializeQueryArgProfileConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFieldPatterns(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FieldPatterns {
    var result: FieldPatterns = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFieldPatternList(reader, alloc, "FieldPattern");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeForwardedValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ForwardedValues {
    var result: ForwardedValues = undefined;
    result.headers = null;
    result.query_string_cache_keys = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cookies")) {
                    result.cookies = try deserializeCookiePreference(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Headers")) {
                    result.headers = try deserializeHeaders(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "QueryString")) {
                    result.query_string = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "QueryStringCacheKeys")) {
                    result.query_string_cache_keys = try deserializeQueryStringCacheKeys(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFunctionAssociation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FunctionAssociation {
    var result: FunctionAssociation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventType")) {
                    result.event_type = std.meta.stringToEnum(EventType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionARN")) {
                    result.function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFunctionAssociations(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FunctionAssociations {
    var result: FunctionAssociations = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFunctionAssociationList(reader, alloc, "FunctionAssociation");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFunctionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FunctionConfig {
    var result: FunctionConfig = undefined;
    result.key_value_store_associations = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyValueStoreAssociations")) {
                    result.key_value_store_associations = try deserializeKeyValueStoreAssociations(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Runtime")) {
                    result.runtime = std.meta.stringToEnum(FunctionRuntime, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFunctionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FunctionList {
    var result: FunctionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFunctionSummaryList(reader, alloc, "FunctionSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFunctionMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FunctionMetadata {
    var result: FunctionMetadata = undefined;
    result.created_time = null;
    result.stage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FunctionARN")) {
                    result.function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stage")) {
                    result.stage = std.meta.stringToEnum(FunctionStage, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeFunctionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !FunctionSummary {
    var result: FunctionSummary = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FunctionConfig")) {
                    result.function_config = try deserializeFunctionConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "FunctionMetadata")) {
                    result.function_metadata = try deserializeFunctionMetadata(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGeoRestriction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GeoRestriction {
    var result: GeoRestriction = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeLocationList(reader, alloc, "Location");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "RestrictionType")) {
                    result.restriction_type = std.meta.stringToEnum(GeoRestrictionType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGeoRestrictionCustomization(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GeoRestrictionCustomization {
    var result: GeoRestrictionCustomization = undefined;
    result.locations = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Locations")) {
                    result.locations = try deserializeLocationList(reader, alloc, "Location");
                } else if (std.mem.eql(u8, e.local, "RestrictionType")) {
                    result.restriction_type = std.meta.stringToEnum(GeoRestrictionType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGrpcConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GrpcConfig {
    _ = alloc;
    var result: GrpcConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeHeaders(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Headers {
    var result: Headers = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeHeaderList(reader, alloc, "Name");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInvalidation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Invalidation {
    var result: Invalidation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvalidationBatch")) {
                    result.invalidation_batch = try deserializeInvalidationBatch(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInvalidationBatch(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InvalidationBatch {
    var result: InvalidationBatch = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Paths")) {
                    result.paths = try deserializePaths(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInvalidationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InvalidationList {
    var result: InvalidationList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeInvalidationSummaryList(reader, alloc, "InvalidationSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInvalidationSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InvalidationSummary {
    var result: InvalidationSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIpamCidrConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IpamCidrConfig {
    var result: IpamCidrConfig = undefined;
    result.anycast_ip = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIp")) {
                    result.anycast_ip = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cidr")) {
                    result.cidr = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamPoolArn")) {
                    result.ipam_pool_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(IpamCidrStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeIpamConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IpamConfig {
    var result: IpamConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IpamCidrConfigs")) {
                    result.ipam_cidr_configs = try deserializeIpamCidrConfigList(reader, alloc, "IpamCidrConfig");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKGKeyPairIds(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KGKeyPairIds {
    var result: KGKeyPairIds = undefined;
    result.key_group_id = null;
    result.key_pair_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyGroupId")) {
                    result.key_group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyPairIds")) {
                    result.key_pair_ids = try deserializeKeyPairIds(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyGroup {
    var result: KeyGroup = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyGroupConfig")) {
                    result.key_group_config = try deserializeKeyGroupConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyGroupConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyGroupConfig {
    var result: KeyGroupConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializePublicKeyIdList(reader, alloc, "PublicKey");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyGroupList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyGroupList {
    var result: KeyGroupList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyGroupSummaryList(reader, alloc, "KeyGroupSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyGroupSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyGroupSummary {
    var result: KeyGroupSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyGroup")) {
                    result.key_group = try deserializeKeyGroup(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyPairIds(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyPairIds {
    var result: KeyPairIds = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyPairIdList(reader, alloc, "KeyPairId");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyValueStore(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyValueStore {
    var result: KeyValueStore = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyValueStoreAssociation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyValueStoreAssociation {
    var result: KeyValueStoreAssociation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyValueStoreARN")) {
                    result.key_value_store_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyValueStoreAssociations(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyValueStoreAssociations {
    var result: KeyValueStoreAssociations = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyValueStoreAssociationList(reader, alloc, "KeyValueStoreAssociation");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKeyValueStoreList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KeyValueStoreList {
    var result: KeyValueStoreList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyValueStoreSummaryList(reader, alloc, "KeyValueStore");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeKinesisStreamConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !KinesisStreamConfig {
    var result: KinesisStreamConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RoleARN")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StreamARN")) {
                    result.stream_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLambdaFunctionAssociation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LambdaFunctionAssociation {
    var result: LambdaFunctionAssociation = undefined;
    result.include_body = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventType")) {
                    result.event_type = std.meta.stringToEnum(EventType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IncludeBody")) {
                    result.include_body = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LambdaFunctionARN")) {
                    result.lambda_function_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLambdaFunctionAssociations(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LambdaFunctionAssociations {
    var result: LambdaFunctionAssociations = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeLambdaFunctionAssociationList(reader, alloc, "LambdaFunctionAssociation");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoggingConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoggingConfig {
    var result: LoggingConfig = undefined;
    result.bucket = "";
    result.enabled = false;
    result.include_cookies = false;
    result.prefix = "";
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IncludeCookies")) {
                    result.include_cookies = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedCertificateDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedCertificateDetails {
    var result: ManagedCertificateDetails = undefined;
    result.certificate_arn = null;
    result.certificate_status = null;
    result.validation_token_details = null;
    result.validation_token_host = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateArn")) {
                    result.certificate_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateStatus")) {
                    result.certificate_status = std.meta.stringToEnum(ManagedCertificateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationTokenDetails")) {
                    result.validation_token_details = try deserializeValidationTokenDetailList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ValidationTokenHost")) {
                    result.validation_token_host = std.meta.stringToEnum(ValidationTokenHost, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMonitoringSubscription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MonitoringSubscription {
    var result: MonitoringSubscription = undefined;
    result.realtime_metrics_subscription_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RealtimeMetricsSubscriptionConfig")) {
                    result.realtime_metrics_subscription_config = try deserializeRealtimeMetricsSubscriptionConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOrigin(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Origin {
    var result: Origin = undefined;
    result.connection_attempts = null;
    result.connection_timeout = null;
    result.custom_headers = null;
    result.custom_origin_config = null;
    result.origin_access_control_id = null;
    result.origin_path = null;
    result.origin_shield = null;
    result.response_completion_timeout = null;
    result.s3_origin_config = null;
    result.vpc_origin_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConnectionAttempts")) {
                    result.connection_attempts = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ConnectionTimeout")) {
                    result.connection_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CustomHeaders")) {
                    result.custom_headers = try deserializeCustomHeaders(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CustomOriginConfig")) {
                    result.custom_origin_config = try deserializeCustomOriginConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlId")) {
                    result.origin_access_control_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginPath")) {
                    result.origin_path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginShield")) {
                    result.origin_shield = try deserializeOriginShield(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ResponseCompletionTimeout")) {
                    result.response_completion_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "S3OriginConfig")) {
                    result.s3_origin_config = try deserializeS3OriginConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "VpcOriginConfig")) {
                    result.vpc_origin_config = try deserializeVpcOriginConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginAccessControl(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginAccessControl {
    var result: OriginAccessControl = undefined;
    result.origin_access_control_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlConfig")) {
                    result.origin_access_control_config = try deserializeOriginAccessControlConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginAccessControlConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginAccessControlConfig {
    var result: OriginAccessControlConfig = undefined;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlOriginType")) {
                    result.origin_access_control_origin_type = std.meta.stringToEnum(OriginAccessControlOriginTypes, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningBehavior")) {
                    result.signing_behavior = std.meta.stringToEnum(OriginAccessControlSigningBehaviors, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningProtocol")) {
                    result.signing_protocol = std.meta.stringToEnum(OriginAccessControlSigningProtocols, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginAccessControlList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginAccessControlList {
    var result: OriginAccessControlList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginAccessControlSummaryList(reader, alloc, "OriginAccessControlSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginAccessControlSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginAccessControlSummary {
    var result: OriginAccessControlSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlOriginType")) {
                    result.origin_access_control_origin_type = std.meta.stringToEnum(OriginAccessControlOriginTypes, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningBehavior")) {
                    result.signing_behavior = std.meta.stringToEnum(OriginAccessControlSigningBehaviors, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SigningProtocol")) {
                    result.signing_protocol = std.meta.stringToEnum(OriginAccessControlSigningProtocols, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginCustomHeader(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginCustomHeader {
    var result: OriginCustomHeader = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderName")) {
                    result.header_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HeaderValue")) {
                    result.header_value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginGroup {
    var result: OriginGroup = undefined;
    result.selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailoverCriteria")) {
                    result.failover_criteria = try deserializeOriginGroupFailoverCriteria(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Members")) {
                    result.members = try deserializeOriginGroupMembers(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SelectionCriteria")) {
                    result.selection_criteria = std.meta.stringToEnum(OriginGroupSelectionCriteria, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginGroupFailoverCriteria(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginGroupFailoverCriteria {
    var result: OriginGroupFailoverCriteria = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StatusCodes")) {
                    result.status_codes = try deserializeStatusCodes(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginGroupMember(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginGroupMember {
    var result: OriginGroupMember = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginId")) {
                    result.origin_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginGroupMembers(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginGroupMembers {
    var result: OriginGroupMembers = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginGroupMemberList(reader, alloc, "OriginGroupMember");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginGroups {
    var result: OriginGroups = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginGroupList(reader, alloc, "OriginGroup");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginMtlsConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginMtlsConfig {
    var result: OriginMtlsConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClientCertificateArn")) {
                    result.client_certificate_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicy {
    var result: OriginRequestPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginRequestPolicyConfig")) {
                    result.origin_request_policy_config = try deserializeOriginRequestPolicyConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicyConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicyConfig {
    var result: OriginRequestPolicyConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CookiesConfig")) {
                    result.cookies_config = try deserializeOriginRequestPolicyCookiesConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "HeadersConfig")) {
                    result.headers_config = try deserializeOriginRequestPolicyHeadersConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryStringsConfig")) {
                    result.query_strings_config = try deserializeOriginRequestPolicyQueryStringsConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicyCookiesConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicyCookiesConfig {
    var result: OriginRequestPolicyCookiesConfig = undefined;
    result.cookies = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieBehavior")) {
                    result.cookie_behavior = std.meta.stringToEnum(OriginRequestPolicyCookieBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cookies")) {
                    result.cookies = try deserializeCookieNames(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicyHeadersConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicyHeadersConfig {
    var result: OriginRequestPolicyHeadersConfig = undefined;
    result.headers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderBehavior")) {
                    result.header_behavior = std.meta.stringToEnum(OriginRequestPolicyHeaderBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Headers")) {
                    result.headers = try deserializeHeaders(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicyList {
    var result: OriginRequestPolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginRequestPolicySummaryList(reader, alloc, "OriginRequestPolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicyQueryStringsConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicyQueryStringsConfig {
    var result: OriginRequestPolicyQueryStringsConfig = undefined;
    result.query_strings = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "QueryStringBehavior")) {
                    result.query_string_behavior = std.meta.stringToEnum(OriginRequestPolicyQueryStringBehavior, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryStrings")) {
                    result.query_strings = try deserializeQueryStringNames(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginRequestPolicySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginRequestPolicySummary {
    var result: OriginRequestPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginRequestPolicy")) {
                    result.origin_request_policy = try deserializeOriginRequestPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(OriginRequestPolicyType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginShield(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginShield {
    var result: OriginShield = undefined;
    result.origin_shield_region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OriginShieldRegion")) {
                    result.origin_shield_region = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOriginSslProtocols(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OriginSslProtocols {
    var result: OriginSslProtocols = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeSslProtocolsList(reader, alloc, "SslProtocol");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOrigins(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Origins {
    var result: Origins = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginList(reader, alloc, "Origin");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Parameter {
    var result: Parameter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeParameterDefinition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ParameterDefinition {
    var result: ParameterDefinition = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Definition")) {
                    result.definition = try deserializeParameterDefinitionSchema(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeParameterDefinitionSchema(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ParameterDefinitionSchema {
    var result: ParameterDefinitionSchema = undefined;
    result.string_schema = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StringSchema")) {
                    result.string_schema = try deserializeStringSchemaConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeParametersInCacheKeyAndForwardedToOrigin(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ParametersInCacheKeyAndForwardedToOrigin {
    var result: ParametersInCacheKeyAndForwardedToOrigin = undefined;
    result.enable_accept_encoding_brotli = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookiesConfig")) {
                    result.cookies_config = try deserializeCachePolicyCookiesConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "EnableAcceptEncodingBrotli")) {
                    result.enable_accept_encoding_brotli = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EnableAcceptEncodingGzip")) {
                    result.enable_accept_encoding_gzip = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HeadersConfig")) {
                    result.headers_config = try deserializeCachePolicyHeadersConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "QueryStringsConfig")) {
                    result.query_strings_config = try deserializeCachePolicyQueryStringsConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePaths(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Paths {
    var result: Paths = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializePathList(reader, alloc, "Path");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePublicKey(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PublicKey {
    var result: PublicKey = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicKeyConfig")) {
                    result.public_key_config = try deserializePublicKeyConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePublicKeyConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PublicKeyConfig {
    var result: PublicKeyConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodedKey")) {
                    result.encoded_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePublicKeyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PublicKeyList {
    var result: PublicKeyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializePublicKeySummaryList(reader, alloc, "PublicKeySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePublicKeySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PublicKeySummary {
    var result: PublicKeySummary = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodedKey")) {
                    result.encoded_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryArgProfile(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryArgProfile {
    var result: QueryArgProfile = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProfileId")) {
                    result.profile_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryArg")) {
                    result.query_arg = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryArgProfileConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryArgProfileConfig {
    var result: QueryArgProfileConfig = undefined;
    result.query_arg_profiles = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ForwardWhenQueryArgProfileIsUnknown")) {
                    result.forward_when_query_arg_profile_is_unknown = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "QueryArgProfiles")) {
                    result.query_arg_profiles = try deserializeQueryArgProfiles(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryArgProfiles(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryArgProfiles {
    var result: QueryArgProfiles = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeQueryArgProfileList(reader, alloc, "QueryArgProfile");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryStringCacheKeys(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryStringCacheKeys {
    var result: QueryStringCacheKeys = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeQueryStringCacheKeysList(reader, alloc, "Name");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeQueryStringNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !QueryStringNames {
    var result: QueryStringNames = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeQueryStringNamesList(reader, alloc, "Name");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRealtimeLogConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RealtimeLogConfig {
    var result: RealtimeLogConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndPoints")) {
                    result.end_points = try deserializeEndPointList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Fields")) {
                    result.fields = try deserializeFieldList(reader, alloc, "Field");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SamplingRate")) {
                    result.sampling_rate = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRealtimeLogConfigs(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RealtimeLogConfigs {
    var result: RealtimeLogConfigs = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeRealtimeLogConfigList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRealtimeMetricsSubscriptionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RealtimeMetricsSubscriptionConfig {
    _ = alloc;
    var result: RealtimeMetricsSubscriptionConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RealtimeMetricsSubscriptionStatus")) {
                    result.realtime_metrics_subscription_status = std.meta.stringToEnum(RealtimeMetricsSubscriptionStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicy {
    var result: ResponseHeadersPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseHeadersPolicyConfig")) {
                    result.response_headers_policy_config = try deserializeResponseHeadersPolicyConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyAccessControlAllowHeaders(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyAccessControlAllowHeaders {
    var result: ResponseHeadersPolicyAccessControlAllowHeaders = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlAllowHeadersList(reader, alloc, "Header");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyAccessControlAllowMethods(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyAccessControlAllowMethods {
    var result: ResponseHeadersPolicyAccessControlAllowMethods = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlAllowMethodsList(reader, alloc, "Method");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyAccessControlAllowOrigins(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyAccessControlAllowOrigins {
    var result: ResponseHeadersPolicyAccessControlAllowOrigins = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlAllowOriginsList(reader, alloc, "Origin");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyAccessControlExposeHeaders(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyAccessControlExposeHeaders {
    var result: ResponseHeadersPolicyAccessControlExposeHeaders = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlExposeHeadersList(reader, alloc, "Header");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyConfig {
    var result: ResponseHeadersPolicyConfig = undefined;
    result.comment = null;
    result.cors_config = null;
    result.custom_headers_config = null;
    result.remove_headers_config = null;
    result.security_headers_config = null;
    result.server_timing_headers_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CorsConfig")) {
                    result.cors_config = try deserializeResponseHeadersPolicyCorsConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CustomHeadersConfig")) {
                    result.custom_headers_config = try deserializeResponseHeadersPolicyCustomHeadersConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RemoveHeadersConfig")) {
                    result.remove_headers_config = try deserializeResponseHeadersPolicyRemoveHeadersConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SecurityHeadersConfig")) {
                    result.security_headers_config = try deserializeResponseHeadersPolicySecurityHeadersConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ServerTimingHeadersConfig")) {
                    result.server_timing_headers_config = try deserializeResponseHeadersPolicyServerTimingHeadersConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyContentSecurityPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyContentSecurityPolicy {
    var result: ResponseHeadersPolicyContentSecurityPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentSecurityPolicy")) {
                    result.content_security_policy = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyContentTypeOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyContentTypeOptions {
    _ = alloc;
    var result: ResponseHeadersPolicyContentTypeOptions = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyCorsConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyCorsConfig {
    var result: ResponseHeadersPolicyCorsConfig = undefined;
    result.access_control_expose_headers = null;
    result.access_control_max_age_sec = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlAllowCredentials")) {
                    result.access_control_allow_credentials = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AccessControlAllowHeaders")) {
                    result.access_control_allow_headers = try deserializeResponseHeadersPolicyAccessControlAllowHeaders(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AccessControlAllowMethods")) {
                    result.access_control_allow_methods = try deserializeResponseHeadersPolicyAccessControlAllowMethods(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AccessControlAllowOrigins")) {
                    result.access_control_allow_origins = try deserializeResponseHeadersPolicyAccessControlAllowOrigins(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AccessControlExposeHeaders")) {
                    result.access_control_expose_headers = try deserializeResponseHeadersPolicyAccessControlExposeHeaders(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AccessControlMaxAgeSec")) {
                    result.access_control_max_age_sec = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginOverride")) {
                    result.origin_override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyCustomHeader(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyCustomHeader {
    var result: ResponseHeadersPolicyCustomHeader = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Header")) {
                    result.header = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyCustomHeadersConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyCustomHeadersConfig {
    var result: ResponseHeadersPolicyCustomHeadersConfig = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeResponseHeadersPolicyCustomHeaderList(reader, alloc, "ResponseHeadersPolicyCustomHeader");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyFrameOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyFrameOptions {
    _ = alloc;
    var result: ResponseHeadersPolicyFrameOptions = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FrameOption")) {
                    result.frame_option = std.meta.stringToEnum(FrameOptionsList, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyList {
    var result: ResponseHeadersPolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeResponseHeadersPolicySummaryList(reader, alloc, "ResponseHeadersPolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyReferrerPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyReferrerPolicy {
    _ = alloc;
    var result: ResponseHeadersPolicyReferrerPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReferrerPolicy")) {
                    result.referrer_policy = std.meta.stringToEnum(ReferrerPolicyList, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyRemoveHeader(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyRemoveHeader {
    var result: ResponseHeadersPolicyRemoveHeader = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Header")) {
                    result.header = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyRemoveHeadersConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyRemoveHeadersConfig {
    var result: ResponseHeadersPolicyRemoveHeadersConfig = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeResponseHeadersPolicyRemoveHeaderList(reader, alloc, "ResponseHeadersPolicyRemoveHeader");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicySecurityHeadersConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicySecurityHeadersConfig {
    var result: ResponseHeadersPolicySecurityHeadersConfig = undefined;
    result.content_security_policy = null;
    result.content_type_options = null;
    result.frame_options = null;
    result.referrer_policy = null;
    result.strict_transport_security = null;
    result.xss_protection = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentSecurityPolicy")) {
                    result.content_security_policy = try deserializeResponseHeadersPolicyContentSecurityPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ContentTypeOptions")) {
                    result.content_type_options = try deserializeResponseHeadersPolicyContentTypeOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "FrameOptions")) {
                    result.frame_options = try deserializeResponseHeadersPolicyFrameOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ReferrerPolicy")) {
                    result.referrer_policy = try deserializeResponseHeadersPolicyReferrerPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StrictTransportSecurity")) {
                    result.strict_transport_security = try deserializeResponseHeadersPolicyStrictTransportSecurity(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "XSSProtection")) {
                    result.xss_protection = try deserializeResponseHeadersPolicyXSSProtection(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyServerTimingHeadersConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyServerTimingHeadersConfig {
    _ = alloc;
    var result: ResponseHeadersPolicyServerTimingHeadersConfig = undefined;
    result.sampling_rate = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SamplingRate")) {
                    result.sampling_rate = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyStrictTransportSecurity(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyStrictTransportSecurity {
    _ = alloc;
    var result: ResponseHeadersPolicyStrictTransportSecurity = undefined;
    result.include_subdomains = null;
    result.preload = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlMaxAgeSec")) {
                    result.access_control_max_age_sec = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "IncludeSubdomains")) {
                    result.include_subdomains = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Preload")) {
                    result.preload = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicySummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicySummary {
    var result: ResponseHeadersPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResponseHeadersPolicy")) {
                    result.response_headers_policy = try deserializeResponseHeadersPolicy(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(ResponseHeadersPolicyType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResponseHeadersPolicyXSSProtection(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResponseHeadersPolicyXSSProtection {
    var result: ResponseHeadersPolicyXSSProtection = undefined;
    result.mode_block = null;
    result.report_uri = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModeBlock")) {
                    result.mode_block = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Protection")) {
                    result.protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReportUri")) {
                    result.report_uri = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRestrictions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Restrictions {
    var result: Restrictions = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GeoRestriction")) {
                    result.geo_restriction = try deserializeGeoRestriction(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3Origin(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3Origin {
    var result: S3Origin = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessIdentity")) {
                    result.origin_access_identity = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeS3OriginConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !S3OriginConfig {
    var result: S3OriginConfig = undefined;
    result.origin_read_timeout = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginAccessIdentity")) {
                    result.origin_access_identity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginReadTimeout")) {
                    result.origin_read_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSessionStickinessConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SessionStickinessConfig {
    _ = alloc;
    var result: SessionStickinessConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IdleTTL")) {
                    result.idle_ttl = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MaximumTTL")) {
                    result.maximum_ttl = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSigner(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Signer {
    var result: Signer = undefined;
    result.aws_account_number = null;
    result.key_pair_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AwsAccountNumber")) {
                    result.aws_account_number = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyPairIds")) {
                    result.key_pair_ids = try deserializeKeyPairIds(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStagingDistributionDnsNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StagingDistributionDnsNames {
    var result: StagingDistributionDnsNames = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeStagingDistributionDnsNameList(reader, alloc, "DnsName");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStatusCodes(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StatusCodes {
    var result: StatusCodes = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeStatusCodeList(reader, alloc, "StatusCode");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStreamingDistribution(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StreamingDistribution {
    var result: StreamingDistribution = undefined;
    result.last_modified_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActiveTrustedSigners")) {
                    result.active_trusted_signers = try deserializeActiveTrustedSigners(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StreamingDistributionConfig")) {
                    result.streaming_distribution_config = try deserializeStreamingDistributionConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStreamingDistributionConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StreamingDistributionConfig {
    var result: StreamingDistributionConfig = undefined;
    result.aliases = null;
    result.logging = null;
    result.price_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Aliases")) {
                    result.aliases = try deserializeAliases(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Logging")) {
                    result.logging = try deserializeStreamingLoggingConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = std.meta.stringToEnum(PriceClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Origin")) {
                    result.s3_origin = try deserializeS3Origin(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStreamingDistributionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StreamingDistributionList {
    var result: StreamingDistributionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeStreamingDistributionSummaryList(reader, alloc, "StreamingDistributionSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStreamingDistributionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StreamingDistributionSummary {
    var result: StreamingDistributionSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Aliases")) {
                    result.aliases = try deserializeAliases(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = std.meta.stringToEnum(PriceClass, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Origin")) {
                    result.s3_origin = try deserializeS3Origin(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStreamingLoggingConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StreamingLoggingConfig {
    var result: StreamingLoggingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStringSchemaConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StringSchemaConfig {
    var result: StringSchemaConfig = undefined;
    result.comment = null;
    result.default_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Required")) {
                    result.required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {
    var result: Tag = undefined;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTags(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tags {
    var result: Tags = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeTagList(reader, alloc, "Tag");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTenantConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TenantConfig {
    var result: TenantConfig = undefined;
    result.parameter_definitions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ParameterDefinitions")) {
                    result.parameter_definitions = try deserializeParameterDefinitions(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTestResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TestResult {
    var result: TestResult = undefined;
    result.compute_utilization = null;
    result.function_error_message = null;
    result.function_execution_logs = null;
    result.function_output = null;
    result.function_summary = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ComputeUtilization")) {
                    result.compute_utilization = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionErrorMessage")) {
                    result.function_error_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionExecutionLogs")) {
                    result.function_execution_logs = try deserializeFunctionExecutionLogList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "FunctionOutput")) {
                    result.function_output = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionSummary")) {
                    result.function_summary = try deserializeFunctionSummary(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrafficConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrafficConfig {
    var result: TrafficConfig = undefined;
    result.single_header_config = null;
    result.single_weight_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SingleHeaderConfig")) {
                    result.single_header_config = try deserializeContinuousDeploymentSingleHeaderConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SingleWeightConfig")) {
                    result.single_weight_config = try deserializeContinuousDeploymentSingleWeightConfig(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(ContinuousDeploymentPolicyType, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStore(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustStore {
    var result: TrustStore = undefined;
    result.arn = null;
    result.id = null;
    result.last_modified_time = null;
    result.name = null;
    result.number_of_ca_certificates = null;
    result.reason = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfCaCertificates")) {
                    result.number_of_ca_certificates = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(TrustStoreStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStoreConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustStoreConfig {
    var result: TrustStoreConfig = undefined;
    result.advertise_trust_store_ca_names = null;
    result.ignore_certificate_expiry = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdvertiseTrustStoreCaNames")) {
                    result.advertise_trust_store_ca_names = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IgnoreCertificateExpiry")) {
                    result.ignore_certificate_expiry = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TrustStoreId")) {
                    result.trust_store_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustStoreSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustStoreSummary {
    var result: TrustStoreSummary = undefined;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfCaCertificates")) {
                    result.number_of_ca_certificates = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(TrustStoreStatus, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustedKeyGroups(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustedKeyGroups {
    var result: TrustedKeyGroups = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeTrustedKeyGroupIdList(reader, alloc, "KeyGroup");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrustedSigners(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrustedSigners {
    var result: TrustedSigners = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAwsAccountNumberList(reader, alloc, "AwsAccountNumber");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeValidationTokenDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ValidationTokenDetail {
    var result: ValidationTokenDetail = undefined;
    result.redirect_from = null;
    result.redirect_to = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedirectFrom")) {
                    result.redirect_from = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedirectTo")) {
                    result.redirect_to = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeViewerCertificate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ViewerCertificate {
    var result: ViewerCertificate = undefined;
    result.acm_certificate_arn = null;
    result.certificate = null;
    result.certificate_source = null;
    result.cloud_front_default_certificate = null;
    result.iam_certificate_id = null;
    result.minimum_protocol_version = null;
    result.ssl_support_method = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ACMCertificateArn")) {
                    result.acm_certificate_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Certificate")) {
                    result.certificate = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateSource")) {
                    result.certificate_source = std.meta.stringToEnum(CertificateSource, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloudFrontDefaultCertificate")) {
                    result.cloud_front_default_certificate = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IAMCertificateId")) {
                    result.iam_certificate_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumProtocolVersion")) {
                    result.minimum_protocol_version = std.meta.stringToEnum(MinimumProtocolVersion, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSLSupportMethod")) {
                    result.ssl_support_method = std.meta.stringToEnum(SSLSupportMethod, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeViewerMtlsConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ViewerMtlsConfig {
    var result: ViewerMtlsConfig = undefined;
    result.mode = "required";
    result.trust_store_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = std.meta.stringToEnum(ViewerMtlsMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreConfig")) {
                    result.trust_store_config = try deserializeTrustStoreConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcOrigin(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcOrigin {
    var result: VpcOrigin = undefined;
    result.account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcOriginEndpointConfig")) {
                    result.vpc_origin_endpoint_config = try deserializeVpcOriginEndpointConfig(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcOriginConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcOriginConfig {
    var result: VpcOriginConfig = undefined;
    result.origin_keepalive_timeout = null;
    result.origin_read_timeout = null;
    result.owner_account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginKeepaliveTimeout")) {
                    result.origin_keepalive_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginReadTimeout")) {
                    result.origin_read_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OwnerAccountId")) {
                    result.owner_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcOriginId")) {
                    result.vpc_origin_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcOriginEndpointConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcOriginEndpointConfig {
    var result: VpcOriginEndpointConfig = undefined;
    result.origin_ssl_protocols = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HTTPPort")) {
                    result.http_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "HTTPSPort")) {
                    result.https_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginProtocolPolicy")) {
                    result.origin_protocol_policy = std.meta.stringToEnum(OriginProtocolPolicy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginSslProtocols")) {
                    result.origin_ssl_protocols = try deserializeOriginSslProtocols(reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcOriginList(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcOriginList {
    var result: VpcOriginList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeVpcOriginSummaryList(reader, alloc, "VpcOriginSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVpcOriginSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VpcOriginSummary {
    var result: VpcOriginSummary = undefined;
    result.account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginEndpointArn")) {
                    result.origin_endpoint_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeWebAclCustomization(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !WebAclCustomization {
    var result: WebAclCustomization = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(CustomizationActionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAccessControlAllowHeadersList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAccessControlAllowMethodsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResponseHeadersPolicyAccessControlAllowMethodsValues, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAccessControlAllowOriginsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAccessControlExposeHeadersList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAliasList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAwsAccountNumberList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCacheBehaviorList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CacheBehavior, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeCacheBehavior(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeContentTypeProfileList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ContentTypeProfile, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeContentTypeProfile(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCookieNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCustomErrorResponseList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CustomErrorResponse, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeCustomErrorResponse(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeDomainList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DomainItem, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeDomainItem(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEncryptionEntityList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EncryptionEntity, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeEncryptionEntity(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEndPointList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EndPoint, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeEndPoint(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeFieldList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeFieldPatternList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeFunctionAssociationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const FunctionAssociation, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeFunctionAssociation(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeHeaderList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeIpamCidrConfigList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const IpamCidrConfig, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeIpamCidrConfig(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeKeyValueStoreAssociationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const KeyValueStoreAssociation, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeKeyValueStoreAssociation(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLambdaFunctionAssociationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LambdaFunctionAssociation, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeLambdaFunctionAssociation(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeLocationList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMethodsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Method, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOriginCustomHeadersList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OriginCustomHeader, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOriginCustomHeader(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOriginGroupList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OriginGroup, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOriginGroup(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOriginGroupMemberList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OriginGroupMember, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOriginGroupMember(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOriginList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Origin, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOrigin(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeParameterDefinitions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ParameterDefinition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeParameterDefinition(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeParameters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Parameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeParameter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePathList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializePublicKeyIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeQueryArgProfileList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const QueryArgProfile, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeQueryArgProfile(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeQueryStringCacheKeysList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeQueryStringNamesList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeResponseHeadersPolicyCustomHeaderList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResponseHeadersPolicyCustomHeader, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeResponseHeadersPolicyCustomHeader(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeResponseHeadersPolicyRemoveHeaderList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResponseHeadersPolicyRemoveHeader, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeResponseHeadersPolicyRemoveHeader(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeSslProtocolsList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SslProtocol, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStagingDistributionDnsNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStatusCodeList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i32, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{item}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagKeyList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTrustedKeyGroupIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAliases(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Aliases) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeAliasList(alloc, buf, v, "CNAME");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeAllowedMethods(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AllowedMethods) !void {
    if (value.cached_methods) |v| {
        try buf.appendSlice(alloc, "<CachedMethods>");
        try serializeCachedMethods(alloc, buf, v);
        try buf.appendSlice(alloc, "</CachedMethods>");
    }
    try buf.appendSlice(alloc, "<Items>");
    try serializeMethodsList(alloc, buf, value.items, "Method");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeCacheBehavior(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CacheBehavior) !void {
    if (value.allowed_methods) |v| {
        try buf.appendSlice(alloc, "<AllowedMethods>");
        try serializeAllowedMethods(alloc, buf, v);
        try buf.appendSlice(alloc, "</AllowedMethods>");
    }
    if (value.cache_policy_id) |v| {
        try buf.appendSlice(alloc, "<CachePolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</CachePolicyId>");
    }
    if (value.compress) |v| {
        try buf.appendSlice(alloc, "<Compress>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Compress>");
    }
    if (value.default_ttl) |v| {
        try buf.appendSlice(alloc, "<DefaultTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultTTL>");
    }
    if (value.field_level_encryption_id) |v| {
        try buf.appendSlice(alloc, "<FieldLevelEncryptionId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</FieldLevelEncryptionId>");
    }
    if (value.forwarded_values) |v| {
        try buf.appendSlice(alloc, "<ForwardedValues>");
        try serializeForwardedValues(alloc, buf, v);
        try buf.appendSlice(alloc, "</ForwardedValues>");
    }
    if (value.function_associations) |v| {
        try buf.appendSlice(alloc, "<FunctionAssociations>");
        try serializeFunctionAssociations(alloc, buf, v);
        try buf.appendSlice(alloc, "</FunctionAssociations>");
    }
    if (value.grpc_config) |v| {
        try buf.appendSlice(alloc, "<GrpcConfig>");
        try serializeGrpcConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</GrpcConfig>");
    }
    if (value.lambda_function_associations) |v| {
        try buf.appendSlice(alloc, "<LambdaFunctionAssociations>");
        try serializeLambdaFunctionAssociations(alloc, buf, v);
        try buf.appendSlice(alloc, "</LambdaFunctionAssociations>");
    }
    if (value.max_ttl) |v| {
        try buf.appendSlice(alloc, "<MaxTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxTTL>");
    }
    if (value.min_ttl) |v| {
        try buf.appendSlice(alloc, "<MinTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinTTL>");
    }
    if (value.origin_request_policy_id) |v| {
        try buf.appendSlice(alloc, "<OriginRequestPolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginRequestPolicyId>");
    }
    try buf.appendSlice(alloc, "<PathPattern>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.path_pattern);
    try buf.appendSlice(alloc, "</PathPattern>");
    if (value.realtime_log_config_arn) |v| {
        try buf.appendSlice(alloc, "<RealtimeLogConfigArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RealtimeLogConfigArn>");
    }
    if (value.response_headers_policy_id) |v| {
        try buf.appendSlice(alloc, "<ResponseHeadersPolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResponseHeadersPolicyId>");
    }
    if (value.smooth_streaming) |v| {
        try buf.appendSlice(alloc, "<SmoothStreaming>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SmoothStreaming>");
    }
    try buf.appendSlice(alloc, "<TargetOriginId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.target_origin_id);
    try buf.appendSlice(alloc, "</TargetOriginId>");
    if (value.trusted_key_groups) |v| {
        try buf.appendSlice(alloc, "<TrustedKeyGroups>");
        try serializeTrustedKeyGroups(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrustedKeyGroups>");
    }
    if (value.trusted_signers) |v| {
        try buf.appendSlice(alloc, "<TrustedSigners>");
        try serializeTrustedSigners(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrustedSigners>");
    }
    try buf.appendSlice(alloc, "<ViewerProtocolPolicy>");
    try buf.appendSlice(alloc, @tagName(value.viewer_protocol_policy));
    try buf.appendSlice(alloc, "</ViewerProtocolPolicy>");
}

pub fn serializeCacheBehaviors(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CacheBehaviors) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeCacheBehaviorList(alloc, buf, v, "CacheBehavior");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeCachePolicyConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    if (value.default_ttl) |v| {
        try buf.appendSlice(alloc, "<DefaultTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultTTL>");
    }
    if (value.max_ttl) |v| {
        try buf.appendSlice(alloc, "<MaxTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxTTL>");
    }
    try buf.appendSlice(alloc, "<MinTTL>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.min_ttl}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</MinTTL>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.parameters_in_cache_key_and_forwarded_to_origin) |v| {
        try buf.appendSlice(alloc, "<ParametersInCacheKeyAndForwardedToOrigin>");
        try serializeParametersInCacheKeyAndForwardedToOrigin(alloc, buf, v);
        try buf.appendSlice(alloc, "</ParametersInCacheKeyAndForwardedToOrigin>");
    }
}

pub fn serializeCachePolicyCookiesConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyCookiesConfig) !void {
    try buf.appendSlice(alloc, "<CookieBehavior>");
    try buf.appendSlice(alloc, @tagName(value.cookie_behavior));
    try buf.appendSlice(alloc, "</CookieBehavior>");
    if (value.cookies) |v| {
        try buf.appendSlice(alloc, "<Cookies>");
        try serializeCookieNames(alloc, buf, v);
        try buf.appendSlice(alloc, "</Cookies>");
    }
}

pub fn serializeCachePolicyHeadersConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyHeadersConfig) !void {
    try buf.appendSlice(alloc, "<HeaderBehavior>");
    try buf.appendSlice(alloc, @tagName(value.header_behavior));
    try buf.appendSlice(alloc, "</HeaderBehavior>");
    if (value.headers) |v| {
        try buf.appendSlice(alloc, "<Headers>");
        try serializeHeaders(alloc, buf, v);
        try buf.appendSlice(alloc, "</Headers>");
    }
}

pub fn serializeCachePolicyQueryStringsConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyQueryStringsConfig) !void {
    try buf.appendSlice(alloc, "<QueryStringBehavior>");
    try buf.appendSlice(alloc, @tagName(value.query_string_behavior));
    try buf.appendSlice(alloc, "</QueryStringBehavior>");
    if (value.query_strings) |v| {
        try buf.appendSlice(alloc, "<QueryStrings>");
        try serializeQueryStringNames(alloc, buf, v);
        try buf.appendSlice(alloc, "</QueryStrings>");
    }
}

pub fn serializeCachedMethods(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachedMethods) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeMethodsList(alloc, buf, value.items, "Method");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeCertificate(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Certificate) !void {
    try buf.appendSlice(alloc, "<Arn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.arn);
    try buf.appendSlice(alloc, "</Arn>");
}

pub fn serializeCloudFrontOriginAccessIdentityConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudFrontOriginAccessIdentityConfig) !void {
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    try buf.appendSlice(alloc, "<Comment>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.comment);
    try buf.appendSlice(alloc, "</Comment>");
}

pub fn serializeConnectionFunctionAssociation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionFunctionAssociation) !void {
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
}

pub fn serializeConnectionGroupAssociationFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionGroupAssociationFilter) !void {
    if (value.anycast_ip_list_id) |v| {
        try buf.appendSlice(alloc, "<AnycastIpListId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AnycastIpListId>");
    }
}

pub fn serializeContentTypeProfile(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContentTypeProfile) !void {
    try buf.appendSlice(alloc, "<ContentType>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.content_type);
    try buf.appendSlice(alloc, "</ContentType>");
    try buf.appendSlice(alloc, "<Format>");
    try buf.appendSlice(alloc, @tagName(value.format));
    try buf.appendSlice(alloc, "</Format>");
    if (value.profile_id) |v| {
        try buf.appendSlice(alloc, "<ProfileId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ProfileId>");
    }
}

pub fn serializeContentTypeProfileConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContentTypeProfileConfig) !void {
    if (value.content_type_profiles) |v| {
        try buf.appendSlice(alloc, "<ContentTypeProfiles>");
        try serializeContentTypeProfiles(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentTypeProfiles>");
    }
    try buf.appendSlice(alloc, "<ForwardWhenContentTypeIsUnknown>");
    try buf.appendSlice(alloc, if (value.forward_when_content_type_is_unknown) "true" else "false");
    try buf.appendSlice(alloc, "</ForwardWhenContentTypeIsUnknown>");
}

pub fn serializeContentTypeProfiles(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContentTypeProfiles) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeContentTypeProfileList(alloc, buf, v, "ContentTypeProfile");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeContinuousDeploymentPolicyConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContinuousDeploymentPolicyConfig) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    try buf.appendSlice(alloc, "<StagingDistributionDnsNames>");
    try serializeStagingDistributionDnsNames(alloc, buf, value.staging_distribution_dns_names);
    try buf.appendSlice(alloc, "</StagingDistributionDnsNames>");
    if (value.traffic_config) |v| {
        try buf.appendSlice(alloc, "<TrafficConfig>");
        try serializeTrafficConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrafficConfig>");
    }
}

pub fn serializeContinuousDeploymentSingleHeaderConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContinuousDeploymentSingleHeaderConfig) !void {
    try buf.appendSlice(alloc, "<Header>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header);
    try buf.appendSlice(alloc, "</Header>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeContinuousDeploymentSingleWeightConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContinuousDeploymentSingleWeightConfig) !void {
    if (value.session_stickiness_config) |v| {
        try buf.appendSlice(alloc, "<SessionStickinessConfig>");
        try serializeSessionStickinessConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</SessionStickinessConfig>");
    }
    try buf.appendSlice(alloc, "<Weight>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.weight}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Weight>");
}

pub fn serializeCookieNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CookieNames) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeCookieNameList(alloc, buf, v, "Name");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeCookiePreference(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CookiePreference) !void {
    try buf.appendSlice(alloc, "<Forward>");
    try buf.appendSlice(alloc, @tagName(value.forward));
    try buf.appendSlice(alloc, "</Forward>");
    if (value.whitelisted_names) |v| {
        try buf.appendSlice(alloc, "<WhitelistedNames>");
        try serializeCookieNames(alloc, buf, v);
        try buf.appendSlice(alloc, "</WhitelistedNames>");
    }
}

pub fn serializeCustomErrorResponse(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomErrorResponse) !void {
    if (value.error_caching_min_ttl) |v| {
        try buf.appendSlice(alloc, "<ErrorCachingMinTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ErrorCachingMinTTL>");
    }
    try buf.appendSlice(alloc, "<ErrorCode>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.error_code}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</ErrorCode>");
    if (value.response_code) |v| {
        try buf.appendSlice(alloc, "<ResponseCode>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResponseCode>");
    }
    if (value.response_page_path) |v| {
        try buf.appendSlice(alloc, "<ResponsePagePath>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResponsePagePath>");
    }
}

pub fn serializeCustomErrorResponses(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomErrorResponses) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeCustomErrorResponseList(alloc, buf, v, "CustomErrorResponse");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeCustomHeaders(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomHeaders) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeOriginCustomHeadersList(alloc, buf, v, "OriginCustomHeader");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeCustomOriginConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomOriginConfig) !void {
    try buf.appendSlice(alloc, "<HTTPPort>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.http_port}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</HTTPPort>");
    try buf.appendSlice(alloc, "<HTTPSPort>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.https_port}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</HTTPSPort>");
    if (value.ip_address_type) |v| {
        try buf.appendSlice(alloc, "<IpAddressType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</IpAddressType>");
    }
    if (value.origin_keepalive_timeout) |v| {
        try buf.appendSlice(alloc, "<OriginKeepaliveTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OriginKeepaliveTimeout>");
    }
    if (value.origin_mtls_config) |v| {
        try buf.appendSlice(alloc, "<OriginMtlsConfig>");
        try serializeOriginMtlsConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginMtlsConfig>");
    }
    try buf.appendSlice(alloc, "<OriginProtocolPolicy>");
    try buf.appendSlice(alloc, @tagName(value.origin_protocol_policy));
    try buf.appendSlice(alloc, "</OriginProtocolPolicy>");
    if (value.origin_read_timeout) |v| {
        try buf.appendSlice(alloc, "<OriginReadTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OriginReadTimeout>");
    }
    if (value.origin_ssl_protocols) |v| {
        try buf.appendSlice(alloc, "<OriginSslProtocols>");
        try serializeOriginSslProtocols(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginSslProtocols>");
    }
}

pub fn serializeCustomizations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Customizations) !void {
    if (value.certificate) |v| {
        try buf.appendSlice(alloc, "<Certificate>");
        try serializeCertificate(alloc, buf, v);
        try buf.appendSlice(alloc, "</Certificate>");
    }
    if (value.geo_restrictions) |v| {
        try buf.appendSlice(alloc, "<GeoRestrictions>");
        try serializeGeoRestrictionCustomization(alloc, buf, v);
        try buf.appendSlice(alloc, "</GeoRestrictions>");
    }
    if (value.web_acl) |v| {
        try buf.appendSlice(alloc, "<WebAcl>");
        try serializeWebAclCustomization(alloc, buf, v);
        try buf.appendSlice(alloc, "</WebAcl>");
    }
}

pub fn serializeDefaultCacheBehavior(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DefaultCacheBehavior) !void {
    if (value.allowed_methods) |v| {
        try buf.appendSlice(alloc, "<AllowedMethods>");
        try serializeAllowedMethods(alloc, buf, v);
        try buf.appendSlice(alloc, "</AllowedMethods>");
    }
    if (value.cache_policy_id) |v| {
        try buf.appendSlice(alloc, "<CachePolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</CachePolicyId>");
    }
    if (value.compress) |v| {
        try buf.appendSlice(alloc, "<Compress>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Compress>");
    }
    if (value.default_ttl) |v| {
        try buf.appendSlice(alloc, "<DefaultTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultTTL>");
    }
    if (value.field_level_encryption_id) |v| {
        try buf.appendSlice(alloc, "<FieldLevelEncryptionId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</FieldLevelEncryptionId>");
    }
    if (value.forwarded_values) |v| {
        try buf.appendSlice(alloc, "<ForwardedValues>");
        try serializeForwardedValues(alloc, buf, v);
        try buf.appendSlice(alloc, "</ForwardedValues>");
    }
    if (value.function_associations) |v| {
        try buf.appendSlice(alloc, "<FunctionAssociations>");
        try serializeFunctionAssociations(alloc, buf, v);
        try buf.appendSlice(alloc, "</FunctionAssociations>");
    }
    if (value.grpc_config) |v| {
        try buf.appendSlice(alloc, "<GrpcConfig>");
        try serializeGrpcConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</GrpcConfig>");
    }
    if (value.lambda_function_associations) |v| {
        try buf.appendSlice(alloc, "<LambdaFunctionAssociations>");
        try serializeLambdaFunctionAssociations(alloc, buf, v);
        try buf.appendSlice(alloc, "</LambdaFunctionAssociations>");
    }
    if (value.max_ttl) |v| {
        try buf.appendSlice(alloc, "<MaxTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxTTL>");
    }
    if (value.min_ttl) |v| {
        try buf.appendSlice(alloc, "<MinTTL>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MinTTL>");
    }
    if (value.origin_request_policy_id) |v| {
        try buf.appendSlice(alloc, "<OriginRequestPolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginRequestPolicyId>");
    }
    if (value.realtime_log_config_arn) |v| {
        try buf.appendSlice(alloc, "<RealtimeLogConfigArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</RealtimeLogConfigArn>");
    }
    if (value.response_headers_policy_id) |v| {
        try buf.appendSlice(alloc, "<ResponseHeadersPolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResponseHeadersPolicyId>");
    }
    if (value.smooth_streaming) |v| {
        try buf.appendSlice(alloc, "<SmoothStreaming>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SmoothStreaming>");
    }
    try buf.appendSlice(alloc, "<TargetOriginId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.target_origin_id);
    try buf.appendSlice(alloc, "</TargetOriginId>");
    if (value.trusted_key_groups) |v| {
        try buf.appendSlice(alloc, "<TrustedKeyGroups>");
        try serializeTrustedKeyGroups(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrustedKeyGroups>");
    }
    if (value.trusted_signers) |v| {
        try buf.appendSlice(alloc, "<TrustedSigners>");
        try serializeTrustedSigners(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrustedSigners>");
    }
    try buf.appendSlice(alloc, "<ViewerProtocolPolicy>");
    try buf.appendSlice(alloc, @tagName(value.viewer_protocol_policy));
    try buf.appendSlice(alloc, "</ViewerProtocolPolicy>");
}

pub fn serializeDistributionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionConfig) !void {
    if (value.aliases) |v| {
        try buf.appendSlice(alloc, "<Aliases>");
        try serializeAliases(alloc, buf, v);
        try buf.appendSlice(alloc, "</Aliases>");
    }
    if (value.anycast_ip_list_id) |v| {
        try buf.appendSlice(alloc, "<AnycastIpListId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AnycastIpListId>");
    }
    if (value.cache_behaviors) |v| {
        try buf.appendSlice(alloc, "<CacheBehaviors>");
        try serializeCacheBehaviors(alloc, buf, v);
        try buf.appendSlice(alloc, "</CacheBehaviors>");
    }
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    try buf.appendSlice(alloc, "<Comment>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.comment);
    try buf.appendSlice(alloc, "</Comment>");
    if (value.connection_function_association) |v| {
        try buf.appendSlice(alloc, "<ConnectionFunctionAssociation>");
        try serializeConnectionFunctionAssociation(alloc, buf, v);
        try buf.appendSlice(alloc, "</ConnectionFunctionAssociation>");
    }
    if (value.connection_mode) |v| {
        try buf.appendSlice(alloc, "<ConnectionMode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ConnectionMode>");
    }
    if (value.continuous_deployment_policy_id) |v| {
        try buf.appendSlice(alloc, "<ContinuousDeploymentPolicyId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContinuousDeploymentPolicyId>");
    }
    if (value.custom_error_responses) |v| {
        try buf.appendSlice(alloc, "<CustomErrorResponses>");
        try serializeCustomErrorResponses(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomErrorResponses>");
    }
    try buf.appendSlice(alloc, "<DefaultCacheBehavior>");
    try serializeDefaultCacheBehavior(alloc, buf, value.default_cache_behavior);
    try buf.appendSlice(alloc, "</DefaultCacheBehavior>");
    if (value.default_root_object) |v| {
        try buf.appendSlice(alloc, "<DefaultRootObject>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultRootObject>");
    }
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.http_version) |v| {
        try buf.appendSlice(alloc, "<HttpVersion>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</HttpVersion>");
    }
    if (value.is_ipv6_enabled) |v| {
        try buf.appendSlice(alloc, "<IsIPV6Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IsIPV6Enabled>");
    }
    if (value.logging) |v| {
        try buf.appendSlice(alloc, "<Logging>");
        try serializeLoggingConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</Logging>");
    }
    if (value.origin_groups) |v| {
        try buf.appendSlice(alloc, "<OriginGroups>");
        try serializeOriginGroups(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginGroups>");
    }
    try buf.appendSlice(alloc, "<Origins>");
    try serializeOrigins(alloc, buf, value.origins);
    try buf.appendSlice(alloc, "</Origins>");
    if (value.price_class) |v| {
        try buf.appendSlice(alloc, "<PriceClass>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</PriceClass>");
    }
    if (value.restrictions) |v| {
        try buf.appendSlice(alloc, "<Restrictions>");
        try serializeRestrictions(alloc, buf, v);
        try buf.appendSlice(alloc, "</Restrictions>");
    }
    if (value.staging) |v| {
        try buf.appendSlice(alloc, "<Staging>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Staging>");
    }
    if (value.tenant_config) |v| {
        try buf.appendSlice(alloc, "<TenantConfig>");
        try serializeTenantConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</TenantConfig>");
    }
    if (value.viewer_certificate) |v| {
        try buf.appendSlice(alloc, "<ViewerCertificate>");
        try serializeViewerCertificate(alloc, buf, v);
        try buf.appendSlice(alloc, "</ViewerCertificate>");
    }
    if (value.viewer_mtls_config) |v| {
        try buf.appendSlice(alloc, "<ViewerMtlsConfig>");
        try serializeViewerMtlsConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</ViewerMtlsConfig>");
    }
    if (value.web_acl_id) |v| {
        try buf.appendSlice(alloc, "<WebACLId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</WebACLId>");
    }
}

pub fn serializeDistributionConfigWithTags(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionConfigWithTags) !void {
    try buf.appendSlice(alloc, "<DistributionConfig>");
    try serializeDistributionConfig(alloc, buf, value.distribution_config);
    try buf.appendSlice(alloc, "</DistributionConfig>");
    try buf.appendSlice(alloc, "<Tags>");
    try serializeTags(alloc, buf, value.tags);
    try buf.appendSlice(alloc, "</Tags>");
}

pub fn serializeDistributionResourceId(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionResourceId) !void {
    if (value.distribution_id) |v| {
        try buf.appendSlice(alloc, "<DistributionId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DistributionId>");
    }
    if (value.distribution_tenant_id) |v| {
        try buf.appendSlice(alloc, "<DistributionTenantId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DistributionTenantId>");
    }
}

pub fn serializeDistributionTenantAssociationFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionTenantAssociationFilter) !void {
    if (value.connection_group_id) |v| {
        try buf.appendSlice(alloc, "<ConnectionGroupId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ConnectionGroupId>");
    }
    if (value.distribution_id) |v| {
        try buf.appendSlice(alloc, "<DistributionId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DistributionId>");
    }
}

pub fn serializeDomainItem(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DomainItem) !void {
    try buf.appendSlice(alloc, "<Domain>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.domain);
    try buf.appendSlice(alloc, "</Domain>");
}

pub fn serializeEncryptionEntities(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionEntities) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeEncryptionEntityList(alloc, buf, v, "EncryptionEntity");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeEncryptionEntity(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionEntity) !void {
    try buf.appendSlice(alloc, "<FieldPatterns>");
    try serializeFieldPatterns(alloc, buf, value.field_patterns);
    try buf.appendSlice(alloc, "</FieldPatterns>");
    try buf.appendSlice(alloc, "<ProviderId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.provider_id);
    try buf.appendSlice(alloc, "</ProviderId>");
    try buf.appendSlice(alloc, "<PublicKeyId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.public_key_id);
    try buf.appendSlice(alloc, "</PublicKeyId>");
}

pub fn serializeEndPoint(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EndPoint) !void {
    if (value.kinesis_stream_config) |v| {
        try buf.appendSlice(alloc, "<KinesisStreamConfig>");
        try serializeKinesisStreamConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</KinesisStreamConfig>");
    }
    try buf.appendSlice(alloc, "<StreamType>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.stream_type);
    try buf.appendSlice(alloc, "</StreamType>");
}

pub fn serializeFieldLevelEncryptionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FieldLevelEncryptionConfig) !void {
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    if (value.content_type_profile_config) |v| {
        try buf.appendSlice(alloc, "<ContentTypeProfileConfig>");
        try serializeContentTypeProfileConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentTypeProfileConfig>");
    }
    if (value.query_arg_profile_config) |v| {
        try buf.appendSlice(alloc, "<QueryArgProfileConfig>");
        try serializeQueryArgProfileConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</QueryArgProfileConfig>");
    }
}

pub fn serializeFieldLevelEncryptionProfileConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FieldLevelEncryptionProfileConfig) !void {
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    try buf.appendSlice(alloc, "<EncryptionEntities>");
    try serializeEncryptionEntities(alloc, buf, value.encryption_entities);
    try buf.appendSlice(alloc, "</EncryptionEntities>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeFieldPatterns(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FieldPatterns) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeFieldPatternList(alloc, buf, v, "FieldPattern");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeForwardedValues(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ForwardedValues) !void {
    try buf.appendSlice(alloc, "<Cookies>");
    try serializeCookiePreference(alloc, buf, value.cookies);
    try buf.appendSlice(alloc, "</Cookies>");
    if (value.headers) |v| {
        try buf.appendSlice(alloc, "<Headers>");
        try serializeHeaders(alloc, buf, v);
        try buf.appendSlice(alloc, "</Headers>");
    }
    try buf.appendSlice(alloc, "<QueryString>");
    try buf.appendSlice(alloc, if (value.query_string) "true" else "false");
    try buf.appendSlice(alloc, "</QueryString>");
    if (value.query_string_cache_keys) |v| {
        try buf.appendSlice(alloc, "<QueryStringCacheKeys>");
        try serializeQueryStringCacheKeys(alloc, buf, v);
        try buf.appendSlice(alloc, "</QueryStringCacheKeys>");
    }
}

pub fn serializeFunctionAssociation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FunctionAssociation) !void {
    try buf.appendSlice(alloc, "<EventType>");
    try buf.appendSlice(alloc, @tagName(value.event_type));
    try buf.appendSlice(alloc, "</EventType>");
    try buf.appendSlice(alloc, "<FunctionARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.function_arn);
    try buf.appendSlice(alloc, "</FunctionARN>");
}

pub fn serializeFunctionAssociations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FunctionAssociations) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeFunctionAssociationList(alloc, buf, v, "FunctionAssociation");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeFunctionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: FunctionConfig) !void {
    try buf.appendSlice(alloc, "<Comment>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.comment);
    try buf.appendSlice(alloc, "</Comment>");
    if (value.key_value_store_associations) |v| {
        try buf.appendSlice(alloc, "<KeyValueStoreAssociations>");
        try serializeKeyValueStoreAssociations(alloc, buf, v);
        try buf.appendSlice(alloc, "</KeyValueStoreAssociations>");
    }
    try buf.appendSlice(alloc, "<Runtime>");
    try buf.appendSlice(alloc, @tagName(value.runtime));
    try buf.appendSlice(alloc, "</Runtime>");
}

pub fn serializeGeoRestriction(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoRestriction) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeLocationList(alloc, buf, v, "Location");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
    try buf.appendSlice(alloc, "<RestrictionType>");
    try buf.appendSlice(alloc, @tagName(value.restriction_type));
    try buf.appendSlice(alloc, "</RestrictionType>");
}

pub fn serializeGeoRestrictionCustomization(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoRestrictionCustomization) !void {
    if (value.locations) |v| {
        try buf.appendSlice(alloc, "<Locations>");
        try serializeLocationList(alloc, buf, v, "Location");
        try buf.appendSlice(alloc, "</Locations>");
    }
    try buf.appendSlice(alloc, "<RestrictionType>");
    try buf.appendSlice(alloc, @tagName(value.restriction_type));
    try buf.appendSlice(alloc, "</RestrictionType>");
}

pub fn serializeGrpcConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: GrpcConfig) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
}

pub fn serializeHeaders(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Headers) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeHeaderList(alloc, buf, v, "Name");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeImportSource(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ImportSource) !void {
    try buf.appendSlice(alloc, "<SourceARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.source_arn);
    try buf.appendSlice(alloc, "</SourceARN>");
    try buf.appendSlice(alloc, "<SourceType>");
    try buf.appendSlice(alloc, @tagName(value.source_type));
    try buf.appendSlice(alloc, "</SourceType>");
}

pub fn serializeInvalidationBatch(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: InvalidationBatch) !void {
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    try buf.appendSlice(alloc, "<Paths>");
    try serializePaths(alloc, buf, value.paths);
    try buf.appendSlice(alloc, "</Paths>");
}

pub fn serializeIpamCidrConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: IpamCidrConfig) !void {
    if (value.anycast_ip) |v| {
        try buf.appendSlice(alloc, "<AnycastIp>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AnycastIp>");
    }
    try buf.appendSlice(alloc, "<Cidr>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.cidr);
    try buf.appendSlice(alloc, "</Cidr>");
    try buf.appendSlice(alloc, "<IpamPoolArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.ipam_pool_arn);
    try buf.appendSlice(alloc, "</IpamPoolArn>");
    if (value.status) |v| {
        try buf.appendSlice(alloc, "<Status>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Status>");
    }
}

pub fn serializeKeyGroupConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: KeyGroupConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    try buf.appendSlice(alloc, "<Items>");
    try serializePublicKeyIdList(alloc, buf, value.items, "PublicKey");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeKeyValueStoreAssociation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: KeyValueStoreAssociation) !void {
    try buf.appendSlice(alloc, "<KeyValueStoreARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key_value_store_arn);
    try buf.appendSlice(alloc, "</KeyValueStoreARN>");
}

pub fn serializeKeyValueStoreAssociations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: KeyValueStoreAssociations) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeKeyValueStoreAssociationList(alloc, buf, v, "KeyValueStoreAssociation");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeKinesisStreamConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: KinesisStreamConfig) !void {
    try buf.appendSlice(alloc, "<RoleARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.role_arn);
    try buf.appendSlice(alloc, "</RoleARN>");
    try buf.appendSlice(alloc, "<StreamARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.stream_arn);
    try buf.appendSlice(alloc, "</StreamARN>");
}

pub fn serializeLambdaFunctionAssociation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaFunctionAssociation) !void {
    try buf.appendSlice(alloc, "<EventType>");
    try buf.appendSlice(alloc, @tagName(value.event_type));
    try buf.appendSlice(alloc, "</EventType>");
    if (value.include_body) |v| {
        try buf.appendSlice(alloc, "<IncludeBody>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IncludeBody>");
    }
    try buf.appendSlice(alloc, "<LambdaFunctionARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.lambda_function_arn);
    try buf.appendSlice(alloc, "</LambdaFunctionARN>");
}

pub fn serializeLambdaFunctionAssociations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaFunctionAssociations) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeLambdaFunctionAssociationList(alloc, buf, v, "LambdaFunctionAssociation");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeLoggingConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoggingConfig) !void {
    if (value.bucket) |v| {
        try buf.appendSlice(alloc, "<Bucket>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Bucket>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
    if (value.include_cookies) |v| {
        try buf.appendSlice(alloc, "<IncludeCookies>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IncludeCookies>");
    }
    if (value.prefix) |v| {
        try buf.appendSlice(alloc, "<Prefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Prefix>");
    }
}

pub fn serializeManagedCertificateRequest(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ManagedCertificateRequest) !void {
    if (value.certificate_transparency_logging_preference) |v| {
        try buf.appendSlice(alloc, "<CertificateTransparencyLoggingPreference>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</CertificateTransparencyLoggingPreference>");
    }
    if (value.primary_domain_name) |v| {
        try buf.appendSlice(alloc, "<PrimaryDomainName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</PrimaryDomainName>");
    }
    try buf.appendSlice(alloc, "<ValidationTokenHost>");
    try buf.appendSlice(alloc, @tagName(value.validation_token_host));
    try buf.appendSlice(alloc, "</ValidationTokenHost>");
}

pub fn serializeMonitoringSubscription(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MonitoringSubscription) !void {
    if (value.realtime_metrics_subscription_config) |v| {
        try buf.appendSlice(alloc, "<RealtimeMetricsSubscriptionConfig>");
        try serializeRealtimeMetricsSubscriptionConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</RealtimeMetricsSubscriptionConfig>");
    }
}

pub fn serializeOrigin(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Origin) !void {
    if (value.connection_attempts) |v| {
        try buf.appendSlice(alloc, "<ConnectionAttempts>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ConnectionAttempts>");
    }
    if (value.connection_timeout) |v| {
        try buf.appendSlice(alloc, "<ConnectionTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ConnectionTimeout>");
    }
    if (value.custom_headers) |v| {
        try buf.appendSlice(alloc, "<CustomHeaders>");
        try serializeCustomHeaders(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomHeaders>");
    }
    if (value.custom_origin_config) |v| {
        try buf.appendSlice(alloc, "<CustomOriginConfig>");
        try serializeCustomOriginConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomOriginConfig>");
    }
    try buf.appendSlice(alloc, "<DomainName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.domain_name);
    try buf.appendSlice(alloc, "</DomainName>");
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    if (value.origin_access_control_id) |v| {
        try buf.appendSlice(alloc, "<OriginAccessControlId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginAccessControlId>");
    }
    if (value.origin_path) |v| {
        try buf.appendSlice(alloc, "<OriginPath>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginPath>");
    }
    if (value.origin_shield) |v| {
        try buf.appendSlice(alloc, "<OriginShield>");
        try serializeOriginShield(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginShield>");
    }
    if (value.response_completion_timeout) |v| {
        try buf.appendSlice(alloc, "<ResponseCompletionTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</ResponseCompletionTimeout>");
    }
    if (value.s3_origin_config) |v| {
        try buf.appendSlice(alloc, "<S3OriginConfig>");
        try serializeS3OriginConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</S3OriginConfig>");
    }
    if (value.vpc_origin_config) |v| {
        try buf.appendSlice(alloc, "<VpcOriginConfig>");
        try serializeVpcOriginConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</VpcOriginConfig>");
    }
}

pub fn serializeOriginAccessControlConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginAccessControlConfig) !void {
    if (value.description) |v| {
        try buf.appendSlice(alloc, "<Description>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Description>");
    }
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<OriginAccessControlOriginType>");
    try buf.appendSlice(alloc, @tagName(value.origin_access_control_origin_type));
    try buf.appendSlice(alloc, "</OriginAccessControlOriginType>");
    try buf.appendSlice(alloc, "<SigningBehavior>");
    try buf.appendSlice(alloc, @tagName(value.signing_behavior));
    try buf.appendSlice(alloc, "</SigningBehavior>");
    try buf.appendSlice(alloc, "<SigningProtocol>");
    try buf.appendSlice(alloc, @tagName(value.signing_protocol));
    try buf.appendSlice(alloc, "</SigningProtocol>");
}

pub fn serializeOriginCustomHeader(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginCustomHeader) !void {
    try buf.appendSlice(alloc, "<HeaderName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header_name);
    try buf.appendSlice(alloc, "</HeaderName>");
    try buf.appendSlice(alloc, "<HeaderValue>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header_value);
    try buf.appendSlice(alloc, "</HeaderValue>");
}

pub fn serializeOriginGroup(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroup) !void {
    try buf.appendSlice(alloc, "<FailoverCriteria>");
    try serializeOriginGroupFailoverCriteria(alloc, buf, value.failover_criteria);
    try buf.appendSlice(alloc, "</FailoverCriteria>");
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    try buf.appendSlice(alloc, "<Members>");
    try serializeOriginGroupMembers(alloc, buf, value.members);
    try buf.appendSlice(alloc, "</Members>");
    if (value.selection_criteria) |v| {
        try buf.appendSlice(alloc, "<SelectionCriteria>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</SelectionCriteria>");
    }
}

pub fn serializeOriginGroupFailoverCriteria(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroupFailoverCriteria) !void {
    try buf.appendSlice(alloc, "<StatusCodes>");
    try serializeStatusCodes(alloc, buf, value.status_codes);
    try buf.appendSlice(alloc, "</StatusCodes>");
}

pub fn serializeOriginGroupMember(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroupMember) !void {
    try buf.appendSlice(alloc, "<OriginId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.origin_id);
    try buf.appendSlice(alloc, "</OriginId>");
}

pub fn serializeOriginGroupMembers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroupMembers) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeOriginGroupMemberList(alloc, buf, value.items, "OriginGroupMember");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeOriginGroups(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroups) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeOriginGroupList(alloc, buf, v, "OriginGroup");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeOriginMtlsConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginMtlsConfig) !void {
    try buf.appendSlice(alloc, "<ClientCertificateArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.client_certificate_arn);
    try buf.appendSlice(alloc, "</ClientCertificateArn>");
}

pub fn serializeOriginRequestPolicyConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    try buf.appendSlice(alloc, "<CookiesConfig>");
    try serializeOriginRequestPolicyCookiesConfig(alloc, buf, value.cookies_config);
    try buf.appendSlice(alloc, "</CookiesConfig>");
    try buf.appendSlice(alloc, "<HeadersConfig>");
    try serializeOriginRequestPolicyHeadersConfig(alloc, buf, value.headers_config);
    try buf.appendSlice(alloc, "</HeadersConfig>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<QueryStringsConfig>");
    try serializeOriginRequestPolicyQueryStringsConfig(alloc, buf, value.query_strings_config);
    try buf.appendSlice(alloc, "</QueryStringsConfig>");
}

pub fn serializeOriginRequestPolicyCookiesConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyCookiesConfig) !void {
    try buf.appendSlice(alloc, "<CookieBehavior>");
    try buf.appendSlice(alloc, @tagName(value.cookie_behavior));
    try buf.appendSlice(alloc, "</CookieBehavior>");
    if (value.cookies) |v| {
        try buf.appendSlice(alloc, "<Cookies>");
        try serializeCookieNames(alloc, buf, v);
        try buf.appendSlice(alloc, "</Cookies>");
    }
}

pub fn serializeOriginRequestPolicyHeadersConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyHeadersConfig) !void {
    try buf.appendSlice(alloc, "<HeaderBehavior>");
    try buf.appendSlice(alloc, @tagName(value.header_behavior));
    try buf.appendSlice(alloc, "</HeaderBehavior>");
    if (value.headers) |v| {
        try buf.appendSlice(alloc, "<Headers>");
        try serializeHeaders(alloc, buf, v);
        try buf.appendSlice(alloc, "</Headers>");
    }
}

pub fn serializeOriginRequestPolicyQueryStringsConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyQueryStringsConfig) !void {
    try buf.appendSlice(alloc, "<QueryStringBehavior>");
    try buf.appendSlice(alloc, @tagName(value.query_string_behavior));
    try buf.appendSlice(alloc, "</QueryStringBehavior>");
    if (value.query_strings) |v| {
        try buf.appendSlice(alloc, "<QueryStrings>");
        try serializeQueryStringNames(alloc, buf, v);
        try buf.appendSlice(alloc, "</QueryStrings>");
    }
}

pub fn serializeOriginShield(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginShield) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.origin_shield_region) |v| {
        try buf.appendSlice(alloc, "<OriginShieldRegion>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginShieldRegion>");
    }
}

pub fn serializeOriginSslProtocols(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginSslProtocols) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeSslProtocolsList(alloc, buf, value.items, "SslProtocol");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeOrigins(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Origins) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeOriginList(alloc, buf, value.items, "Origin");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeParameter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeParameterDefinition(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParameterDefinition) !void {
    try buf.appendSlice(alloc, "<Definition>");
    try serializeParameterDefinitionSchema(alloc, buf, value.definition);
    try buf.appendSlice(alloc, "</Definition>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeParameterDefinitionSchema(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParameterDefinitionSchema) !void {
    if (value.string_schema) |v| {
        try buf.appendSlice(alloc, "<StringSchema>");
        try serializeStringSchemaConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</StringSchema>");
    }
}

pub fn serializeParametersInCacheKeyAndForwardedToOrigin(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParametersInCacheKeyAndForwardedToOrigin) !void {
    try buf.appendSlice(alloc, "<CookiesConfig>");
    try serializeCachePolicyCookiesConfig(alloc, buf, value.cookies_config);
    try buf.appendSlice(alloc, "</CookiesConfig>");
    if (value.enable_accept_encoding_brotli) |v| {
        try buf.appendSlice(alloc, "<EnableAcceptEncodingBrotli>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</EnableAcceptEncodingBrotli>");
    }
    try buf.appendSlice(alloc, "<EnableAcceptEncodingGzip>");
    try buf.appendSlice(alloc, if (value.enable_accept_encoding_gzip) "true" else "false");
    try buf.appendSlice(alloc, "</EnableAcceptEncodingGzip>");
    try buf.appendSlice(alloc, "<HeadersConfig>");
    try serializeCachePolicyHeadersConfig(alloc, buf, value.headers_config);
    try buf.appendSlice(alloc, "</HeadersConfig>");
    try buf.appendSlice(alloc, "<QueryStringsConfig>");
    try serializeCachePolicyQueryStringsConfig(alloc, buf, value.query_strings_config);
    try buf.appendSlice(alloc, "</QueryStringsConfig>");
}

pub fn serializePaths(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Paths) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializePathList(alloc, buf, v, "Path");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializePublicKeyConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: PublicKeyConfig) !void {
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    try buf.appendSlice(alloc, "<EncodedKey>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.encoded_key);
    try buf.appendSlice(alloc, "</EncodedKey>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
}

pub fn serializeQueryArgProfile(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryArgProfile) !void {
    try buf.appendSlice(alloc, "<ProfileId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.profile_id);
    try buf.appendSlice(alloc, "</ProfileId>");
    try buf.appendSlice(alloc, "<QueryArg>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.query_arg);
    try buf.appendSlice(alloc, "</QueryArg>");
}

pub fn serializeQueryArgProfileConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryArgProfileConfig) !void {
    try buf.appendSlice(alloc, "<ForwardWhenQueryArgProfileIsUnknown>");
    try buf.appendSlice(alloc, if (value.forward_when_query_arg_profile_is_unknown) "true" else "false");
    try buf.appendSlice(alloc, "</ForwardWhenQueryArgProfileIsUnknown>");
    if (value.query_arg_profiles) |v| {
        try buf.appendSlice(alloc, "<QueryArgProfiles>");
        try serializeQueryArgProfiles(alloc, buf, v);
        try buf.appendSlice(alloc, "</QueryArgProfiles>");
    }
}

pub fn serializeQueryArgProfiles(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryArgProfiles) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeQueryArgProfileList(alloc, buf, v, "QueryArgProfile");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeQueryStringCacheKeys(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringCacheKeys) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeQueryStringCacheKeysList(alloc, buf, v, "Name");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeQueryStringNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringNames) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeQueryStringNamesList(alloc, buf, v, "Name");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeRealtimeMetricsSubscriptionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RealtimeMetricsSubscriptionConfig) !void {
    try buf.appendSlice(alloc, "<RealtimeMetricsSubscriptionStatus>");
    try buf.appendSlice(alloc, @tagName(value.realtime_metrics_subscription_status));
    try buf.appendSlice(alloc, "</RealtimeMetricsSubscriptionStatus>");
}

pub fn serializeResponseHeadersPolicyAccessControlAllowHeaders(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlAllowHeaders) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeAccessControlAllowHeadersList(alloc, buf, value.items, "Header");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyAccessControlAllowMethods(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlAllowMethods) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeAccessControlAllowMethodsList(alloc, buf, value.items, "Method");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyAccessControlAllowOrigins(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlAllowOrigins) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeAccessControlAllowOriginsList(alloc, buf, value.items, "Origin");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyAccessControlExposeHeaders(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlExposeHeaders) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeAccessControlExposeHeadersList(alloc, buf, v, "Header");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    if (value.cors_config) |v| {
        try buf.appendSlice(alloc, "<CorsConfig>");
        try serializeResponseHeadersPolicyCorsConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</CorsConfig>");
    }
    if (value.custom_headers_config) |v| {
        try buf.appendSlice(alloc, "<CustomHeadersConfig>");
        try serializeResponseHeadersPolicyCustomHeadersConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</CustomHeadersConfig>");
    }
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.remove_headers_config) |v| {
        try buf.appendSlice(alloc, "<RemoveHeadersConfig>");
        try serializeResponseHeadersPolicyRemoveHeadersConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</RemoveHeadersConfig>");
    }
    if (value.security_headers_config) |v| {
        try buf.appendSlice(alloc, "<SecurityHeadersConfig>");
        try serializeResponseHeadersPolicySecurityHeadersConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</SecurityHeadersConfig>");
    }
    if (value.server_timing_headers_config) |v| {
        try buf.appendSlice(alloc, "<ServerTimingHeadersConfig>");
        try serializeResponseHeadersPolicyServerTimingHeadersConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</ServerTimingHeadersConfig>");
    }
}

pub fn serializeResponseHeadersPolicyContentSecurityPolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyContentSecurityPolicy) !void {
    try buf.appendSlice(alloc, "<ContentSecurityPolicy>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.content_security_policy);
    try buf.appendSlice(alloc, "</ContentSecurityPolicy>");
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
}

pub fn serializeResponseHeadersPolicyContentTypeOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyContentTypeOptions) !void {
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
}

pub fn serializeResponseHeadersPolicyCorsConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyCorsConfig) !void {
    try buf.appendSlice(alloc, "<AccessControlAllowCredentials>");
    try buf.appendSlice(alloc, if (value.access_control_allow_credentials) "true" else "false");
    try buf.appendSlice(alloc, "</AccessControlAllowCredentials>");
    try buf.appendSlice(alloc, "<AccessControlAllowHeaders>");
    try serializeResponseHeadersPolicyAccessControlAllowHeaders(alloc, buf, value.access_control_allow_headers);
    try buf.appendSlice(alloc, "</AccessControlAllowHeaders>");
    try buf.appendSlice(alloc, "<AccessControlAllowMethods>");
    try serializeResponseHeadersPolicyAccessControlAllowMethods(alloc, buf, value.access_control_allow_methods);
    try buf.appendSlice(alloc, "</AccessControlAllowMethods>");
    try buf.appendSlice(alloc, "<AccessControlAllowOrigins>");
    try serializeResponseHeadersPolicyAccessControlAllowOrigins(alloc, buf, value.access_control_allow_origins);
    try buf.appendSlice(alloc, "</AccessControlAllowOrigins>");
    if (value.access_control_expose_headers) |v| {
        try buf.appendSlice(alloc, "<AccessControlExposeHeaders>");
        try serializeResponseHeadersPolicyAccessControlExposeHeaders(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccessControlExposeHeaders>");
    }
    if (value.access_control_max_age_sec) |v| {
        try buf.appendSlice(alloc, "<AccessControlMaxAgeSec>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</AccessControlMaxAgeSec>");
    }
    try buf.appendSlice(alloc, "<OriginOverride>");
    try buf.appendSlice(alloc, if (value.origin_override) "true" else "false");
    try buf.appendSlice(alloc, "</OriginOverride>");
}

pub fn serializeResponseHeadersPolicyCustomHeader(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyCustomHeader) !void {
    try buf.appendSlice(alloc, "<Header>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header);
    try buf.appendSlice(alloc, "</Header>");
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeResponseHeadersPolicyCustomHeadersConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyCustomHeadersConfig) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeResponseHeadersPolicyCustomHeaderList(alloc, buf, v, "ResponseHeadersPolicyCustomHeader");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyFrameOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyFrameOptions) !void {
    try buf.appendSlice(alloc, "<FrameOption>");
    try buf.appendSlice(alloc, @tagName(value.frame_option));
    try buf.appendSlice(alloc, "</FrameOption>");
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
}

pub fn serializeResponseHeadersPolicyReferrerPolicy(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyReferrerPolicy) !void {
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
    try buf.appendSlice(alloc, "<ReferrerPolicy>");
    try buf.appendSlice(alloc, @tagName(value.referrer_policy));
    try buf.appendSlice(alloc, "</ReferrerPolicy>");
}

pub fn serializeResponseHeadersPolicyRemoveHeader(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyRemoveHeader) !void {
    try buf.appendSlice(alloc, "<Header>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.header);
    try buf.appendSlice(alloc, "</Header>");
}

pub fn serializeResponseHeadersPolicyRemoveHeadersConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyRemoveHeadersConfig) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeResponseHeadersPolicyRemoveHeaderList(alloc, buf, v, "ResponseHeadersPolicyRemoveHeader");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeResponseHeadersPolicySecurityHeadersConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicySecurityHeadersConfig) !void {
    if (value.content_security_policy) |v| {
        try buf.appendSlice(alloc, "<ContentSecurityPolicy>");
        try serializeResponseHeadersPolicyContentSecurityPolicy(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentSecurityPolicy>");
    }
    if (value.content_type_options) |v| {
        try buf.appendSlice(alloc, "<ContentTypeOptions>");
        try serializeResponseHeadersPolicyContentTypeOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</ContentTypeOptions>");
    }
    if (value.frame_options) |v| {
        try buf.appendSlice(alloc, "<FrameOptions>");
        try serializeResponseHeadersPolicyFrameOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</FrameOptions>");
    }
    if (value.referrer_policy) |v| {
        try buf.appendSlice(alloc, "<ReferrerPolicy>");
        try serializeResponseHeadersPolicyReferrerPolicy(alloc, buf, v);
        try buf.appendSlice(alloc, "</ReferrerPolicy>");
    }
    if (value.strict_transport_security) |v| {
        try buf.appendSlice(alloc, "<StrictTransportSecurity>");
        try serializeResponseHeadersPolicyStrictTransportSecurity(alloc, buf, v);
        try buf.appendSlice(alloc, "</StrictTransportSecurity>");
    }
    if (value.xss_protection) |v| {
        try buf.appendSlice(alloc, "<XSSProtection>");
        try serializeResponseHeadersPolicyXSSProtection(alloc, buf, v);
        try buf.appendSlice(alloc, "</XSSProtection>");
    }
}

pub fn serializeResponseHeadersPolicyServerTimingHeadersConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyServerTimingHeadersConfig) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.sampling_rate) |v| {
        try buf.appendSlice(alloc, "<SamplingRate>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</SamplingRate>");
    }
}

pub fn serializeResponseHeadersPolicyStrictTransportSecurity(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyStrictTransportSecurity) !void {
    try buf.appendSlice(alloc, "<AccessControlMaxAgeSec>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.access_control_max_age_sec}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</AccessControlMaxAgeSec>");
    if (value.include_subdomains) |v| {
        try buf.appendSlice(alloc, "<IncludeSubdomains>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IncludeSubdomains>");
    }
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
    if (value.preload) |v| {
        try buf.appendSlice(alloc, "<Preload>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Preload>");
    }
}

pub fn serializeResponseHeadersPolicyXSSProtection(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyXSSProtection) !void {
    if (value.mode_block) |v| {
        try buf.appendSlice(alloc, "<ModeBlock>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ModeBlock>");
    }
    try buf.appendSlice(alloc, "<Override>");
    try buf.appendSlice(alloc, if (value.override) "true" else "false");
    try buf.appendSlice(alloc, "</Override>");
    try buf.appendSlice(alloc, "<Protection>");
    try buf.appendSlice(alloc, if (value.protection) "true" else "false");
    try buf.appendSlice(alloc, "</Protection>");
    if (value.report_uri) |v| {
        try buf.appendSlice(alloc, "<ReportUri>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ReportUri>");
    }
}

pub fn serializeRestrictions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Restrictions) !void {
    try buf.appendSlice(alloc, "<GeoRestriction>");
    try serializeGeoRestriction(alloc, buf, value.geo_restriction);
    try buf.appendSlice(alloc, "</GeoRestriction>");
}

pub fn serializeS3Origin(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Origin) !void {
    try buf.appendSlice(alloc, "<DomainName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.domain_name);
    try buf.appendSlice(alloc, "</DomainName>");
    try buf.appendSlice(alloc, "<OriginAccessIdentity>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.origin_access_identity);
    try buf.appendSlice(alloc, "</OriginAccessIdentity>");
}

pub fn serializeS3OriginConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3OriginConfig) !void {
    try buf.appendSlice(alloc, "<OriginAccessIdentity>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.origin_access_identity);
    try buf.appendSlice(alloc, "</OriginAccessIdentity>");
    if (value.origin_read_timeout) |v| {
        try buf.appendSlice(alloc, "<OriginReadTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OriginReadTimeout>");
    }
}

pub fn serializeSessionStickinessConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SessionStickinessConfig) !void {
    try buf.appendSlice(alloc, "<IdleTTL>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.idle_ttl}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</IdleTTL>");
    try buf.appendSlice(alloc, "<MaximumTTL>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.maximum_ttl}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</MaximumTTL>");
}

pub fn serializeStagingDistributionDnsNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StagingDistributionDnsNames) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeStagingDistributionDnsNameList(alloc, buf, v, "DnsName");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeStatusCodes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StatusCodes) !void {
    try buf.appendSlice(alloc, "<Items>");
    try serializeStatusCodeList(alloc, buf, value.items, "StatusCode");
    try buf.appendSlice(alloc, "</Items>");
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeStreamingDistributionConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StreamingDistributionConfig) !void {
    if (value.aliases) |v| {
        try buf.appendSlice(alloc, "<Aliases>");
        try serializeAliases(alloc, buf, v);
        try buf.appendSlice(alloc, "</Aliases>");
    }
    try buf.appendSlice(alloc, "<CallerReference>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.caller_reference);
    try buf.appendSlice(alloc, "</CallerReference>");
    try buf.appendSlice(alloc, "<Comment>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.comment);
    try buf.appendSlice(alloc, "</Comment>");
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.logging) |v| {
        try buf.appendSlice(alloc, "<Logging>");
        try serializeStreamingLoggingConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</Logging>");
    }
    if (value.price_class) |v| {
        try buf.appendSlice(alloc, "<PriceClass>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</PriceClass>");
    }
    try buf.appendSlice(alloc, "<S3Origin>");
    try serializeS3Origin(alloc, buf, value.s3_origin);
    try buf.appendSlice(alloc, "</S3Origin>");
    try buf.appendSlice(alloc, "<TrustedSigners>");
    try serializeTrustedSigners(alloc, buf, value.trusted_signers);
    try buf.appendSlice(alloc, "</TrustedSigners>");
}

pub fn serializeStreamingDistributionConfigWithTags(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StreamingDistributionConfigWithTags) !void {
    try buf.appendSlice(alloc, "<StreamingDistributionConfig>");
    try serializeStreamingDistributionConfig(alloc, buf, value.streaming_distribution_config);
    try buf.appendSlice(alloc, "</StreamingDistributionConfig>");
    try buf.appendSlice(alloc, "<Tags>");
    try serializeTags(alloc, buf, value.tags);
    try buf.appendSlice(alloc, "</Tags>");
}

pub fn serializeStreamingLoggingConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StreamingLoggingConfig) !void {
    try buf.appendSlice(alloc, "<Bucket>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.bucket);
    try buf.appendSlice(alloc, "</Bucket>");
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    try buf.appendSlice(alloc, "<Prefix>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.prefix);
    try buf.appendSlice(alloc, "</Prefix>");
}

pub fn serializeStringSchemaConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StringSchemaConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(alloc, "<Comment>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Comment>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    try buf.appendSlice(alloc, "<Required>");
    try buf.appendSlice(alloc, if (value.required) "true" else "false");
    try buf.appendSlice(alloc, "</Required>");
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeTagKeys(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TagKeys) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeTagKeyList(alloc, buf, v, "Key");
        try buf.appendSlice(alloc, "</Items>");
    }
}

pub fn serializeTags(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tags) !void {
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeTagList(alloc, buf, v, "Tag");
        try buf.appendSlice(alloc, "</Items>");
    }
}

pub fn serializeTenantConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TenantConfig) !void {
    if (value.parameter_definitions) |v| {
        try buf.appendSlice(alloc, "<ParameterDefinitions>");
        try serializeParameterDefinitions(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ParameterDefinitions>");
    }
}

pub fn serializeTrafficConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrafficConfig) !void {
    if (value.single_header_config) |v| {
        try buf.appendSlice(alloc, "<SingleHeaderConfig>");
        try serializeContinuousDeploymentSingleHeaderConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</SingleHeaderConfig>");
    }
    if (value.single_weight_config) |v| {
        try buf.appendSlice(alloc, "<SingleWeightConfig>");
        try serializeContinuousDeploymentSingleWeightConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</SingleWeightConfig>");
    }
    try buf.appendSlice(alloc, "<Type>");
    try buf.appendSlice(alloc, @tagName(value.@"type"));
    try buf.appendSlice(alloc, "</Type>");
}

pub fn serializeTrustStoreConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrustStoreConfig) !void {
    if (value.advertise_trust_store_ca_names) |v| {
        try buf.appendSlice(alloc, "<AdvertiseTrustStoreCaNames>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</AdvertiseTrustStoreCaNames>");
    }
    if (value.ignore_certificate_expiry) |v| {
        try buf.appendSlice(alloc, "<IgnoreCertificateExpiry>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</IgnoreCertificateExpiry>");
    }
    try buf.appendSlice(alloc, "<TrustStoreId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.trust_store_id);
    try buf.appendSlice(alloc, "</TrustStoreId>");
}

pub fn serializeTrustedKeyGroups(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrustedKeyGroups) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeTrustedKeyGroupIdList(alloc, buf, v, "KeyGroup");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeTrustedSigners(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrustedSigners) !void {
    try buf.appendSlice(alloc, "<Enabled>");
    try buf.appendSlice(alloc, if (value.enabled) "true" else "false");
    try buf.appendSlice(alloc, "</Enabled>");
    if (value.items) |v| {
        try buf.appendSlice(alloc, "<Items>");
        try serializeAwsAccountNumberList(alloc, buf, v, "AwsAccountNumber");
        try buf.appendSlice(alloc, "</Items>");
    }
    try buf.appendSlice(alloc, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Quantity>");
}

pub fn serializeViewerCertificate(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ViewerCertificate) !void {
    if (value.acm_certificate_arn) |v| {
        try buf.appendSlice(alloc, "<ACMCertificateArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ACMCertificateArn>");
    }
    if (value.certificate) |v| {
        try buf.appendSlice(alloc, "<Certificate>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Certificate>");
    }
    if (value.certificate_source) |v| {
        try buf.appendSlice(alloc, "<CertificateSource>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</CertificateSource>");
    }
    if (value.cloud_front_default_certificate) |v| {
        try buf.appendSlice(alloc, "<CloudFrontDefaultCertificate>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</CloudFrontDefaultCertificate>");
    }
    if (value.iam_certificate_id) |v| {
        try buf.appendSlice(alloc, "<IAMCertificateId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</IAMCertificateId>");
    }
    if (value.minimum_protocol_version) |v| {
        try buf.appendSlice(alloc, "<MinimumProtocolVersion>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</MinimumProtocolVersion>");
    }
    if (value.ssl_support_method) |v| {
        try buf.appendSlice(alloc, "<SSLSupportMethod>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</SSLSupportMethod>");
    }
}

pub fn serializeViewerMtlsConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ViewerMtlsConfig) !void {
    if (value.mode) |v| {
        try buf.appendSlice(alloc, "<Mode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Mode>");
    }
    if (value.trust_store_config) |v| {
        try buf.appendSlice(alloc, "<TrustStoreConfig>");
        try serializeTrustStoreConfig(alloc, buf, v);
        try buf.appendSlice(alloc, "</TrustStoreConfig>");
    }
}

pub fn serializeVpcOriginConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: VpcOriginConfig) !void {
    if (value.origin_keepalive_timeout) |v| {
        try buf.appendSlice(alloc, "<OriginKeepaliveTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OriginKeepaliveTimeout>");
    }
    if (value.origin_read_timeout) |v| {
        try buf.appendSlice(alloc, "<OriginReadTimeout>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</OriginReadTimeout>");
    }
    if (value.owner_account_id) |v| {
        try buf.appendSlice(alloc, "<OwnerAccountId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</OwnerAccountId>");
    }
    try buf.appendSlice(alloc, "<VpcOriginId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.vpc_origin_id);
    try buf.appendSlice(alloc, "</VpcOriginId>");
}

pub fn serializeVpcOriginEndpointConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: VpcOriginEndpointConfig) !void {
    try buf.appendSlice(alloc, "<Arn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.arn);
    try buf.appendSlice(alloc, "</Arn>");
    try buf.appendSlice(alloc, "<HTTPPort>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.http_port}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</HTTPPort>");
    try buf.appendSlice(alloc, "<HTTPSPort>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.https_port}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</HTTPSPort>");
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<OriginProtocolPolicy>");
    try buf.appendSlice(alloc, @tagName(value.origin_protocol_policy));
    try buf.appendSlice(alloc, "</OriginProtocolPolicy>");
    if (value.origin_ssl_protocols) |v| {
        try buf.appendSlice(alloc, "<OriginSslProtocols>");
        try serializeOriginSslProtocols(alloc, buf, v);
        try buf.appendSlice(alloc, "</OriginSslProtocols>");
    }
}

pub fn serializeWebAclCustomization(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: WebAclCustomization) !void {
    try buf.appendSlice(alloc, "<Action>");
    try buf.appendSlice(alloc, @tagName(value.action));
    try buf.appendSlice(alloc, "</Action>");
    if (value.arn) |v| {
        try buf.appendSlice(alloc, "<Arn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Arn>");
    }
}

