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

pub fn deserializeAccessControlAllowHeadersList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccessControlAllowMethodsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResponseHeadersPolicyAccessControlAllowMethodsValues {
    var list: std.ArrayList(ResponseHeadersPolicyAccessControlAllowMethodsValues) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (ResponseHeadersPolicyAccessControlAllowMethodsValues.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccessControlAllowOriginsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccessControlExposeHeadersList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAliasICPRecordals(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AliasICPRecordal {
    var list: std.ArrayList(AliasICPRecordal) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAliasICPRecordal(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAliasList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAnycastIpListSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AnycastIpListSummary {
    var list: std.ArrayList(AnycastIpListSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAnycastIpListSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAnycastIps(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAwsAccountNumberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCacheBehaviorList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CacheBehavior {
    var list: std.ArrayList(CacheBehavior) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCacheBehavior(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCachePolicySummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CachePolicySummary {
    var list: std.ArrayList(CachePolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCachePolicySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCloudFrontOriginAccessIdentitySummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CloudFrontOriginAccessIdentitySummary {
    var list: std.ArrayList(CloudFrontOriginAccessIdentitySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCloudFrontOriginAccessIdentitySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeConflictingAliases(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConflictingAlias {
    var list: std.ArrayList(ConflictingAlias) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConflictingAlias(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeConnectionFunctionSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConnectionFunctionSummary {
    var list: std.ArrayList(ConnectionFunctionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConnectionFunctionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeConnectionGroupSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ConnectionGroupSummary {
    var list: std.ArrayList(ConnectionGroupSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeConnectionGroupSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeContentTypeProfileList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ContentTypeProfile {
    var list: std.ArrayList(ContentTypeProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeContentTypeProfile(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeContinuousDeploymentPolicySummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ContinuousDeploymentPolicySummary {
    var list: std.ArrayList(ContinuousDeploymentPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeContinuousDeploymentPolicySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCookieNameList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCustomErrorResponseList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CustomErrorResponse {
    var list: std.ArrayList(CustomErrorResponse) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCustomErrorResponse(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDistributionIdListSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDistributionIdOwnerItemList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DistributionIdOwner {
    var list: std.ArrayList(DistributionIdOwner) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDistributionIdOwner(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDistributionSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DistributionSummary {
    var list: std.ArrayList(DistributionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDistributionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDistributionTenantList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DistributionTenantSummary {
    var list: std.ArrayList(DistributionTenantSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDistributionTenantSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDnsConfigurationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DnsConfiguration {
    var list: std.ArrayList(DnsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDnsConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDomainConflictsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DomainConflict {
    var list: std.ArrayList(DomainConflict) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDomainConflict(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDomainResultList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DomainResult {
    var list: std.ArrayList(DomainResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDomainResult(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEncryptionEntityList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EncryptionEntity {
    var list: std.ArrayList(EncryptionEntity) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEncryptionEntity(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEndPointList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EndPoint {
    var list: std.ArrayList(EndPoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEndPoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFieldLevelEncryptionProfileSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FieldLevelEncryptionProfileSummary {
    var list: std.ArrayList(FieldLevelEncryptionProfileSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeFieldLevelEncryptionProfileSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFieldLevelEncryptionSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FieldLevelEncryptionSummary {
    var list: std.ArrayList(FieldLevelEncryptionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeFieldLevelEncryptionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFieldList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFieldPatternList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFunctionAssociationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FunctionAssociation {
    var list: std.ArrayList(FunctionAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeFunctionAssociation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFunctionExecutionLogList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFunctionSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FunctionSummary {
    var list: std.ArrayList(FunctionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeFunctionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHeaderList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInvalidationSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InvalidationSummary {
    var list: std.ArrayList(InvalidationSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInvalidationSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeIpamCidrConfigList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const IpamCidrConfig {
    var list: std.ArrayList(IpamCidrConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeIpamCidrConfig(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeKGKeyPairIdsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const KGKeyPairIds {
    var list: std.ArrayList(KGKeyPairIds) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeKGKeyPairIds(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeKeyGroupSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const KeyGroupSummary {
    var list: std.ArrayList(KeyGroupSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeKeyGroupSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeKeyPairIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeKeyValueStoreAssociationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const KeyValueStoreAssociation {
    var list: std.ArrayList(KeyValueStoreAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeKeyValueStoreAssociation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeKeyValueStoreSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const KeyValueStore {
    var list: std.ArrayList(KeyValueStore) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeKeyValueStore(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLambdaFunctionAssociationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const LambdaFunctionAssociation {
    var list: std.ArrayList(LambdaFunctionAssociation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeLambdaFunctionAssociation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLocationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMethodsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Method {
    var list: std.ArrayList(Method) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (Method.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOriginAccessControlSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OriginAccessControlSummary {
    var list: std.ArrayList(OriginAccessControlSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOriginAccessControlSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOriginCustomHeadersList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OriginCustomHeader {
    var list: std.ArrayList(OriginCustomHeader) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOriginCustomHeader(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOriginGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OriginGroup {
    var list: std.ArrayList(OriginGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOriginGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOriginGroupMemberList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OriginGroupMember {
    var list: std.ArrayList(OriginGroupMember) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOriginGroupMember(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOriginList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Origin {
    var list: std.ArrayList(Origin) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOrigin(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOriginRequestPolicySummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OriginRequestPolicySummary {
    var list: std.ArrayList(OriginRequestPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOriginRequestPolicySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParameterDefinitions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ParameterDefinition {
    var list: std.ArrayList(ParameterDefinition) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeParameterDefinition(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParameters(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Parameter {
    var list: std.ArrayList(Parameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeParameter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePathList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePublicKeyIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePublicKeySummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PublicKeySummary {
    var list: std.ArrayList(PublicKeySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePublicKeySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeQueryArgProfileList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const QueryArgProfile {
    var list: std.ArrayList(QueryArgProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeQueryArgProfile(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeQueryStringCacheKeysList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeQueryStringNamesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRealtimeLogConfigList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RealtimeLogConfig {
    var list: std.ArrayList(RealtimeLogConfig) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRealtimeLogConfig(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResponseHeadersPolicyCustomHeaderList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResponseHeadersPolicyCustomHeader {
    var list: std.ArrayList(ResponseHeadersPolicyCustomHeader) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResponseHeadersPolicyCustomHeader(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResponseHeadersPolicyRemoveHeaderList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResponseHeadersPolicyRemoveHeader {
    var list: std.ArrayList(ResponseHeadersPolicyRemoveHeader) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResponseHeadersPolicyRemoveHeader(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResponseHeadersPolicySummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResponseHeadersPolicySummary {
    var list: std.ArrayList(ResponseHeadersPolicySummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResponseHeadersPolicySummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSignerList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Signer {
    var list: std.ArrayList(Signer) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSigner(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSslProtocolsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SslProtocol {
    var list: std.ArrayList(SslProtocol) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (SslProtocol.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStagingDistributionDnsNameList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStatusCodeList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i32 {
    var list: std.ArrayList(i32) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStreamingDistributionSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StreamingDistributionSummary {
    var list: std.ArrayList(StreamingDistributionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStreamingDistributionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTagList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTrustStoreList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrustStoreSummary {
    var list: std.ArrayList(TrustStoreSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrustStoreSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTrustedKeyGroupIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeValidationTokenDetailList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ValidationTokenDetail {
    var list: std.ArrayList(ValidationTokenDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeValidationTokenDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeVpcOriginSummaryList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const VpcOriginSummary {
    var list: std.ArrayList(VpcOriginSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeVpcOriginSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeActiveTrustedKeyGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ActiveTrustedKeyGroups {
    var result: ActiveTrustedKeyGroups = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKGKeyPairIdsList(allocator, reader, "KeyGroup");
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

pub fn deserializeActiveTrustedSigners(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ActiveTrustedSigners {
    var result: ActiveTrustedSigners = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeSignerList(allocator, reader, "Signer");
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

pub fn deserializeAliasICPRecordal(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AliasICPRecordal {
    var result: AliasICPRecordal = undefined;
    result.cname = null;
    result.icp_recordal_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CNAME")) {
                    result.cname = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ICPRecordalStatus")) {
                    result.icp_recordal_status = ICPRecordalStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeAliases(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Aliases {
    var result: Aliases = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAliasList(allocator, reader, "CNAME");
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

pub fn deserializeAllowedMethods(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AllowedMethods {
    var result: AllowedMethods = undefined;
    result.cached_methods = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CachedMethods")) {
                    result.cached_methods = try deserializeCachedMethods(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeMethodsList(allocator, reader, "Method");
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

pub fn deserializeAnycastIpList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnycastIpList {
    var result: AnycastIpList = undefined;
    result.ip_address_type = null;
    result.ipam_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIps")) {
                    result.anycast_ips = try deserializeAnycastIps(allocator, reader, "AnycastIp");
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = IpAddressType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamConfig")) {
                    result.ipam_config = try deserializeIpamConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IpCount")) {
                    result.ip_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnycastIpListCollection(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnycastIpListCollection {
    var result: AnycastIpListCollection = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAnycastIpListSummaries(allocator, reader, "AnycastIpListSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnycastIpListSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnycastIpListSummary {
    var result: AnycastIpListSummary = undefined;
    result.e_tag = null;
    result.ip_address_type = null;
    result.ipam_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = IpAddressType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamConfig")) {
                    result.ipam_config = try deserializeIpamConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IpCount")) {
                    result.ip_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCacheBehavior(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheBehavior {
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
                    result.allowed_methods = try deserializeAllowedMethods(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CachePolicyId")) {
                    result.cache_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Compress")) {
                    result.compress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultTTL")) {
                    result.default_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FieldLevelEncryptionId")) {
                    result.field_level_encryption_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForwardedValues")) {
                    result.forwarded_values = try deserializeForwardedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "FunctionAssociations")) {
                    result.function_associations = try deserializeFunctionAssociations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "GrpcConfig")) {
                    result.grpc_config = try deserializeGrpcConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LambdaFunctionAssociations")) {
                    result.lambda_function_associations = try deserializeLambdaFunctionAssociations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MaxTTL")) {
                    result.max_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinTTL")) {
                    result.min_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginRequestPolicyId")) {
                    result.origin_request_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PathPattern")) {
                    result.path_pattern = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RealtimeLogConfigArn")) {
                    result.realtime_log_config_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseHeadersPolicyId")) {
                    result.response_headers_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SmoothStreaming")) {
                    result.smooth_streaming = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TargetOriginId")) {
                    result.target_origin_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustedKeyGroups")) {
                    result.trusted_key_groups = try deserializeTrustedKeyGroups(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ViewerProtocolPolicy")) {
                    result.viewer_protocol_policy = ViewerProtocolPolicy.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeCacheBehaviors(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CacheBehaviors {
    var result: CacheBehaviors = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCacheBehaviorList(allocator, reader, "CacheBehavior");
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

pub fn deserializeCachePolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicy {
    var result: CachePolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CachePolicyConfig")) {
                    result.cache_policy_config = try deserializeCachePolicyConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCachePolicyConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicyConfig {
    var result: CachePolicyConfig = undefined;
    result.comment = null;
    result.default_ttl = null;
    result.max_ttl = null;
    result.parameters_in_cache_key_and_forwarded_to_origin = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultTTL")) {
                    result.default_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxTTL")) {
                    result.max_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinTTL")) {
                    result.min_ttl = try std.fmt.parseInt(i64, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParametersInCacheKeyAndForwardedToOrigin")) {
                    result.parameters_in_cache_key_and_forwarded_to_origin = try deserializeParametersInCacheKeyAndForwardedToOrigin(allocator, reader);
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

pub fn deserializeCachePolicyCookiesConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicyCookiesConfig {
    var result: CachePolicyCookiesConfig = undefined;
    result.cookies = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieBehavior")) {
                    result.cookie_behavior = CachePolicyCookieBehavior.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Cookies")) {
                    result.cookies = try deserializeCookieNames(allocator, reader);
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

pub fn deserializeCachePolicyHeadersConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicyHeadersConfig {
    var result: CachePolicyHeadersConfig = undefined;
    result.headers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderBehavior")) {
                    result.header_behavior = CachePolicyHeaderBehavior.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Headers")) {
                    result.headers = try deserializeHeaders(allocator, reader);
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

pub fn deserializeCachePolicyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicyList {
    var result: CachePolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCachePolicySummaryList(allocator, reader, "CachePolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCachePolicyQueryStringsConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicyQueryStringsConfig {
    var result: CachePolicyQueryStringsConfig = undefined;
    result.query_strings = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "QueryStringBehavior")) {
                    result.query_string_behavior = CachePolicyQueryStringBehavior.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "QueryStrings")) {
                    result.query_strings = try deserializeQueryStringNames(allocator, reader);
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

pub fn deserializeCachePolicySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachePolicySummary {
    var result: CachePolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CachePolicy")) {
                    result.cache_policy = try deserializeCachePolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = CachePolicyType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeCachedMethods(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CachedMethods {
    var result: CachedMethods = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeMethodsList(allocator, reader, "Method");
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

pub fn deserializeCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Certificate {
    var result: Certificate = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCloudFrontOriginAccessIdentity(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudFrontOriginAccessIdentity {
    var result: CloudFrontOriginAccessIdentity = undefined;
    result.cloud_front_origin_access_identity_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CloudFrontOriginAccessIdentityConfig")) {
                    result.cloud_front_origin_access_identity_config = try deserializeCloudFrontOriginAccessIdentityConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3CanonicalUserId")) {
                    result.s3_canonical_user_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCloudFrontOriginAccessIdentityConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudFrontOriginAccessIdentityConfig {
    var result: CloudFrontOriginAccessIdentityConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCloudFrontOriginAccessIdentityList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudFrontOriginAccessIdentityList {
    var result: CloudFrontOriginAccessIdentityList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCloudFrontOriginAccessIdentitySummaryList(allocator, reader, "CloudFrontOriginAccessIdentitySummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCloudFrontOriginAccessIdentitySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CloudFrontOriginAccessIdentitySummary {
    var result: CloudFrontOriginAccessIdentitySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3CanonicalUserId")) {
                    result.s3_canonical_user_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeConflictingAlias(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConflictingAlias {
    var result: ConflictingAlias = undefined;
    result.account_id = null;
    result.alias = null;
    result.distribution_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeConflictingAliasesList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConflictingAliasesList {
    var result: ConflictingAliasesList = undefined;
    result.items = null;
    result.max_items = null;
    result.next_marker = null;
    result.quantity = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeConflictingAliases(allocator, reader, "ConflictingAlias");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeConnectionFunctionAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionFunctionAssociation {
    var result: ConnectionFunctionAssociation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeConnectionFunctionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionFunctionSummary {
    var result: ConnectionFunctionSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConnectionFunctionArn")) {
                    result.connection_function_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionConfig")) {
                    result.connection_function_config = try deserializeFunctionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stage")) {
                    result.stage = FunctionStage.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeConnectionFunctionTestResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionFunctionTestResult {
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
                    result.compute_utilization = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionErrorMessage")) {
                    result.connection_function_error_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionExecutionLogs")) {
                    result.connection_function_execution_logs = try deserializeFunctionExecutionLogList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionOutput")) {
                    result.connection_function_output = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionSummary")) {
                    result.connection_function_summary = try deserializeConnectionFunctionSummary(allocator, reader);
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

pub fn deserializeConnectionGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionGroup {
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
                    result.anycast_ip_list_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Ipv6Enabled")) {
                    result.ipv_6_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoutingEndpoint")) {
                    result.routing_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(allocator, reader);
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

pub fn deserializeConnectionGroupSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ConnectionGroupSummary {
    var result: ConnectionGroupSummary = undefined;
    result.anycast_ip_list_id = null;
    result.enabled = null;
    result.is_default = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefault")) {
                    result.is_default = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoutingEndpoint")) {
                    result.routing_endpoint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeContentTypeProfile(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContentTypeProfile {
    var result: ContentTypeProfile = undefined;
    result.profile_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentType")) {
                    result.content_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Format")) {
                    result.format = Format.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "ProfileId")) {
                    result.profile_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeContentTypeProfileConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContentTypeProfileConfig {
    var result: ContentTypeProfileConfig = undefined;
    result.content_type_profiles = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentTypeProfiles")) {
                    result.content_type_profiles = try deserializeContentTypeProfiles(allocator, reader);
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

pub fn deserializeContentTypeProfiles(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContentTypeProfiles {
    var result: ContentTypeProfiles = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeContentTypeProfileList(allocator, reader, "ContentTypeProfile");
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

pub fn deserializeContinuousDeploymentPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContinuousDeploymentPolicy {
    var result: ContinuousDeploymentPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinuousDeploymentPolicyConfig")) {
                    result.continuous_deployment_policy_config = try deserializeContinuousDeploymentPolicyConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeContinuousDeploymentPolicyConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContinuousDeploymentPolicyConfig {
    var result: ContinuousDeploymentPolicyConfig = undefined;
    result.traffic_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StagingDistributionDnsNames")) {
                    result.staging_distribution_dns_names = try deserializeStagingDistributionDnsNames(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TrafficConfig")) {
                    result.traffic_config = try deserializeTrafficConfig(allocator, reader);
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

pub fn deserializeContinuousDeploymentPolicyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContinuousDeploymentPolicyList {
    var result: ContinuousDeploymentPolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeContinuousDeploymentPolicySummaryList(allocator, reader, "ContinuousDeploymentPolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeContinuousDeploymentPolicySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContinuousDeploymentPolicySummary {
    var result: ContinuousDeploymentPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContinuousDeploymentPolicy")) {
                    result.continuous_deployment_policy = try deserializeContinuousDeploymentPolicy(allocator, reader);
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

pub fn deserializeContinuousDeploymentSingleHeaderConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContinuousDeploymentSingleHeaderConfig {
    var result: ContinuousDeploymentSingleHeaderConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Header")) {
                    result.header = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeContinuousDeploymentSingleWeightConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ContinuousDeploymentSingleWeightConfig {
    var result: ContinuousDeploymentSingleWeightConfig = undefined;
    result.session_stickiness_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SessionStickinessConfig")) {
                    result.session_stickiness_config = try deserializeSessionStickinessConfig(allocator, reader);
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

pub fn deserializeCookieNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CookieNames {
    var result: CookieNames = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCookieNameList(allocator, reader, "Name");
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

pub fn deserializeCookiePreference(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CookiePreference {
    var result: CookiePreference = undefined;
    result.whitelisted_names = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Forward")) {
                    result.forward = ItemSelection.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "WhitelistedNames")) {
                    result.whitelisted_names = try deserializeCookieNames(allocator, reader);
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

pub fn deserializeCustomErrorResponse(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomErrorResponse {
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
                    result.response_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponsePagePath")) {
                    result.response_page_path = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeCustomErrorResponses(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomErrorResponses {
    var result: CustomErrorResponses = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeCustomErrorResponseList(allocator, reader, "CustomErrorResponse");
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

pub fn deserializeCustomHeaders(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomHeaders {
    var result: CustomHeaders = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginCustomHeadersList(allocator, reader, "OriginCustomHeader");
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

pub fn deserializeCustomOriginConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CustomOriginConfig {
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
                    result.ip_address_type = IpAddressType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginKeepaliveTimeout")) {
                    result.origin_keepalive_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginMtlsConfig")) {
                    result.origin_mtls_config = try deserializeOriginMtlsConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "OriginProtocolPolicy")) {
                    result.origin_protocol_policy = OriginProtocolPolicy.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "OriginReadTimeout")) {
                    result.origin_read_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginSslProtocols")) {
                    result.origin_ssl_protocols = try deserializeOriginSslProtocols(allocator, reader);
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

pub fn deserializeCustomizations(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Customizations {
    var result: Customizations = undefined;
    result.certificate = null;
    result.geo_restrictions = null;
    result.web_acl = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Certificate")) {
                    result.certificate = try deserializeCertificate(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "GeoRestrictions")) {
                    result.geo_restrictions = try deserializeGeoRestrictionCustomization(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WebAcl")) {
                    result.web_acl = try deserializeWebAclCustomization(allocator, reader);
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

pub fn deserializeDefaultCacheBehavior(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DefaultCacheBehavior {
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
                    result.allowed_methods = try deserializeAllowedMethods(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CachePolicyId")) {
                    result.cache_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Compress")) {
                    result.compress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DefaultTTL")) {
                    result.default_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FieldLevelEncryptionId")) {
                    result.field_level_encryption_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ForwardedValues")) {
                    result.forwarded_values = try deserializeForwardedValues(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "FunctionAssociations")) {
                    result.function_associations = try deserializeFunctionAssociations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "GrpcConfig")) {
                    result.grpc_config = try deserializeGrpcConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LambdaFunctionAssociations")) {
                    result.lambda_function_associations = try deserializeLambdaFunctionAssociations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MaxTTL")) {
                    result.max_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinTTL")) {
                    result.min_ttl = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginRequestPolicyId")) {
                    result.origin_request_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RealtimeLogConfigArn")) {
                    result.realtime_log_config_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseHeadersPolicyId")) {
                    result.response_headers_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SmoothStreaming")) {
                    result.smooth_streaming = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TargetOriginId")) {
                    result.target_origin_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustedKeyGroups")) {
                    result.trusted_key_groups = try deserializeTrustedKeyGroups(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ViewerProtocolPolicy")) {
                    result.viewer_protocol_policy = ViewerProtocolPolicy.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeDistribution(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Distribution {
    var result: Distribution = undefined;
    result.active_trusted_key_groups = null;
    result.active_trusted_signers = null;
    result.alias_icp_recordals = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActiveTrustedKeyGroups")) {
                    result.active_trusted_key_groups = try deserializeActiveTrustedKeyGroups(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ActiveTrustedSigners")) {
                    result.active_trusted_signers = try deserializeActiveTrustedSigners(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AliasICPRecordals")) {
                    result.alias_icp_recordals = try deserializeAliasICPRecordals(allocator, reader, "AliasICPRecordal");
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DistributionConfig")) {
                    result.distribution_config = try deserializeDistributionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InProgressInvalidationBatches")) {
                    result.in_progress_invalidation_batches = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionConfig {
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
                    result.aliases = try deserializeAliases(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheBehaviors")) {
                    result.cache_behaviors = try deserializeCacheBehaviors(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionAssociation")) {
                    result.connection_function_association = try deserializeConnectionFunctionAssociation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ConnectionMode")) {
                    result.connection_mode = ConnectionMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContinuousDeploymentPolicyId")) {
                    result.continuous_deployment_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomErrorResponses")) {
                    result.custom_error_responses = try deserializeCustomErrorResponses(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DefaultCacheBehavior")) {
                    result.default_cache_behavior = try deserializeDefaultCacheBehavior(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DefaultRootObject")) {
                    result.default_root_object = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HttpVersion")) {
                    result.http_version = HttpVersion.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsIPV6Enabled")) {
                    result.is_ipv6_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Logging")) {
                    result.logging = try deserializeLoggingConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "OriginGroups")) {
                    result.origin_groups = try deserializeOriginGroups(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Origins")) {
                    result.origins = try deserializeOrigins(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = PriceClass.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Restrictions")) {
                    result.restrictions = try deserializeRestrictions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Staging")) {
                    result.staging = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TenantConfig")) {
                    result.tenant_config = try deserializeTenantConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ViewerCertificate")) {
                    result.viewer_certificate = try deserializeViewerCertificate(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ViewerMtlsConfig")) {
                    result.viewer_mtls_config = try deserializeViewerMtlsConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WebACLId")) {
                    result.web_acl_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionIdList {
    var result: DistributionIdList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeDistributionIdListSummary(allocator, reader, "DistributionId");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionIdOwner(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionIdOwner {
    var result: DistributionIdOwner = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwnerAccountId")) {
                    result.owner_account_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionIdOwnerList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionIdOwnerList {
    var result: DistributionIdOwnerList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeDistributionIdOwnerItemList(allocator, reader, "DistributionIdOwner");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionList {
    var result: DistributionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeDistributionSummaryList(allocator, reader, "DistributionSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionSummary {
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
                    result.aliases = try deserializeAliases(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AliasICPRecordals")) {
                    result.alias_icp_recordals = try deserializeAliasICPRecordals(allocator, reader, "AliasICPRecordal");
                } else if (std.mem.eql(u8, e.local, "AnycastIpListId")) {
                    result.anycast_ip_list_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CacheBehaviors")) {
                    result.cache_behaviors = try deserializeCacheBehaviors(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionFunctionAssociation")) {
                    result.connection_function_association = try deserializeConnectionFunctionAssociation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ConnectionMode")) {
                    result.connection_mode = ConnectionMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CustomErrorResponses")) {
                    result.custom_error_responses = try deserializeCustomErrorResponses(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DefaultCacheBehavior")) {
                    result.default_cache_behavior = try deserializeDefaultCacheBehavior(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HttpVersion")) {
                    result.http_version = HttpVersion.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsIPV6Enabled")) {
                    result.is_ipv6_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginGroups")) {
                    result.origin_groups = try deserializeOriginGroups(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Origins")) {
                    result.origins = try deserializeOrigins(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = PriceClass.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Restrictions")) {
                    result.restrictions = try deserializeRestrictions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Staging")) {
                    result.staging = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ViewerCertificate")) {
                    result.viewer_certificate = try deserializeViewerCertificate(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ViewerMtlsConfig")) {
                    result.viewer_mtls_config = try deserializeViewerMtlsConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "WebACLId")) {
                    result.web_acl_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDistributionTenant(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionTenant {
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
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionGroupId")) {
                    result.connection_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Customizations")) {
                    result.customizations = try deserializeCustomizations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Domains")) {
                    result.domains = try deserializeDomainResultList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParameters(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(allocator, reader);
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

pub fn deserializeDistributionTenantSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DistributionTenantSummary {
    var result: DistributionTenantSummary = undefined;
    result.connection_group_id = null;
    result.customizations = null;
    result.enabled = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ConnectionGroupId")) {
                    result.connection_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Customizations")) {
                    result.customizations = try deserializeCustomizations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DistributionId")) {
                    result.distribution_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Domains")) {
                    result.domains = try deserializeDomainResultList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDnsConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DnsConfiguration {
    var result: DnsConfiguration = undefined;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DnsConfigurationStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeDomainConflict(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DomainConflict {
    var result: DomainConflict = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceId")) {
                    result.resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = DistributionResourceType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeDomainResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DomainResult {
    var result: DomainResult = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DomainStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeEncryptionEntities(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EncryptionEntities {
    var result: EncryptionEntities = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeEncryptionEntityList(allocator, reader, "EncryptionEntity");
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

pub fn deserializeEncryptionEntity(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EncryptionEntity {
    var result: EncryptionEntity = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FieldPatterns")) {
                    result.field_patterns = try deserializeFieldPatterns(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ProviderId")) {
                    result.provider_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicKeyId")) {
                    result.public_key_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeEndPoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EndPoint {
    var result: EndPoint = undefined;
    result.kinesis_stream_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KinesisStreamConfig")) {
                    result.kinesis_stream_config = try deserializeKinesisStreamConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StreamType")) {
                    result.stream_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryption(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryption {
    var result: FieldLevelEncryption = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FieldLevelEncryptionConfig")) {
                    result.field_level_encryption_config = try deserializeFieldLevelEncryptionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryptionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionConfig {
    var result: FieldLevelEncryptionConfig = undefined;
    result.comment = null;
    result.content_type_profile_config = null;
    result.query_arg_profile_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentTypeProfileConfig")) {
                    result.content_type_profile_config = try deserializeContentTypeProfileConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "QueryArgProfileConfig")) {
                    result.query_arg_profile_config = try deserializeQueryArgProfileConfig(allocator, reader);
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

pub fn deserializeFieldLevelEncryptionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionList {
    var result: FieldLevelEncryptionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFieldLevelEncryptionSummaryList(allocator, reader, "FieldLevelEncryptionSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryptionProfile(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionProfile {
    var result: FieldLevelEncryptionProfile = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FieldLevelEncryptionProfileConfig")) {
                    result.field_level_encryption_profile_config = try deserializeFieldLevelEncryptionProfileConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryptionProfileConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionProfileConfig {
    var result: FieldLevelEncryptionProfileConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionEntities")) {
                    result.encryption_entities = try deserializeEncryptionEntities(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryptionProfileList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionProfileList {
    var result: FieldLevelEncryptionProfileList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFieldLevelEncryptionProfileSummaryList(allocator, reader, "FieldLevelEncryptionProfileSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryptionProfileSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionProfileSummary {
    var result: FieldLevelEncryptionProfileSummary = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncryptionEntities")) {
                    result.encryption_entities = try deserializeEncryptionEntities(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFieldLevelEncryptionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldLevelEncryptionSummary {
    var result: FieldLevelEncryptionSummary = undefined;
    result.comment = null;
    result.content_type_profile_config = null;
    result.query_arg_profile_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContentTypeProfileConfig")) {
                    result.content_type_profile_config = try deserializeContentTypeProfileConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryArgProfileConfig")) {
                    result.query_arg_profile_config = try deserializeQueryArgProfileConfig(allocator, reader);
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

pub fn deserializeFieldPatterns(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FieldPatterns {
    var result: FieldPatterns = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFieldPatternList(allocator, reader, "FieldPattern");
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

pub fn deserializeForwardedValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ForwardedValues {
    var result: ForwardedValues = undefined;
    result.headers = null;
    result.query_string_cache_keys = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cookies")) {
                    result.cookies = try deserializeCookiePreference(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Headers")) {
                    result.headers = try deserializeHeaders(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "QueryString")) {
                    result.query_string = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "QueryStringCacheKeys")) {
                    result.query_string_cache_keys = try deserializeQueryStringCacheKeys(allocator, reader);
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

pub fn deserializeFunctionAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FunctionAssociation {
    var result: FunctionAssociation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventType")) {
                    result.event_type = EventType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "FunctionARN")) {
                    result.function_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFunctionAssociations(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FunctionAssociations {
    var result: FunctionAssociations = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFunctionAssociationList(allocator, reader, "FunctionAssociation");
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

pub fn deserializeFunctionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FunctionConfig {
    var result: FunctionConfig = undefined;
    result.key_value_store_associations = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyValueStoreAssociations")) {
                    result.key_value_store_associations = try deserializeKeyValueStoreAssociations(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Runtime")) {
                    result.runtime = FunctionRuntime.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeFunctionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FunctionList {
    var result: FunctionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeFunctionSummaryList(allocator, reader, "FunctionSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeFunctionMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FunctionMetadata {
    var result: FunctionMetadata = undefined;
    result.created_time = null;
    result.stage = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FunctionARN")) {
                    result.function_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stage")) {
                    result.stage = FunctionStage.fromWireName(try reader.readElementText());
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

pub fn deserializeFunctionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !FunctionSummary {
    var result: FunctionSummary = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FunctionConfig")) {
                    result.function_config = try deserializeFunctionConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "FunctionMetadata")) {
                    result.function_metadata = try deserializeFunctionMetadata(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeGeoRestriction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GeoRestriction {
    var result: GeoRestriction = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeLocationList(allocator, reader, "Location");
                } else if (std.mem.eql(u8, e.local, "Quantity")) {
                    result.quantity = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "RestrictionType")) {
                    result.restriction_type = GeoRestrictionType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeGeoRestrictionCustomization(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GeoRestrictionCustomization {
    var result: GeoRestrictionCustomization = undefined;
    result.locations = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Locations")) {
                    result.locations = try deserializeLocationList(allocator, reader, "Location");
                } else if (std.mem.eql(u8, e.local, "RestrictionType")) {
                    result.restriction_type = GeoRestrictionType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeGrpcConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GrpcConfig {
    _ = allocator;
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

pub fn deserializeHeaders(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Headers {
    var result: Headers = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeHeaderList(allocator, reader, "Name");
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

pub fn deserializeInvalidation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Invalidation {
    var result: Invalidation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvalidationBatch")) {
                    result.invalidation_batch = try deserializeInvalidationBatch(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInvalidationBatch(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InvalidationBatch {
    var result: InvalidationBatch = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Paths")) {
                    result.paths = try deserializePaths(allocator, reader);
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

pub fn deserializeInvalidationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InvalidationList {
    var result: InvalidationList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeInvalidationSummaryList(allocator, reader, "InvalidationSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeInvalidationSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InvalidationSummary {
    var result: InvalidationSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeIpamCidrConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IpamCidrConfig {
    var result: IpamCidrConfig = undefined;
    result.anycast_ip = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnycastIp")) {
                    result.anycast_ip = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Cidr")) {
                    result.cidr = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpamPoolArn")) {
                    result.ipam_pool_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = IpamCidrStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeIpamConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IpamConfig {
    var result: IpamConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IpamCidrConfigs")) {
                    result.ipam_cidr_configs = try deserializeIpamCidrConfigList(allocator, reader, "IpamCidrConfig");
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

pub fn deserializeKGKeyPairIds(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KGKeyPairIds {
    var result: KGKeyPairIds = undefined;
    result.key_group_id = null;
    result.key_pair_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyGroupId")) {
                    result.key_group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyPairIds")) {
                    result.key_pair_ids = try deserializeKeyPairIds(allocator, reader);
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

pub fn deserializeKeyGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyGroup {
    var result: KeyGroup = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyGroupConfig")) {
                    result.key_group_config = try deserializeKeyGroupConfig(allocator, reader);
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

pub fn deserializeKeyGroupConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyGroupConfig {
    var result: KeyGroupConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializePublicKeyIdList(allocator, reader, "PublicKey");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeKeyGroupList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyGroupList {
    var result: KeyGroupList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyGroupSummaryList(allocator, reader, "KeyGroupSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeKeyGroupSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyGroupSummary {
    var result: KeyGroupSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyGroup")) {
                    result.key_group = try deserializeKeyGroup(allocator, reader);
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

pub fn deserializeKeyPairIds(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyPairIds {
    var result: KeyPairIds = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyPairIdList(allocator, reader, "KeyPairId");
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

pub fn deserializeKeyValueStore(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyValueStore {
    var result: KeyValueStore = undefined;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeKeyValueStoreAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyValueStoreAssociation {
    var result: KeyValueStoreAssociation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyValueStoreARN")) {
                    result.key_value_store_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeKeyValueStoreAssociations(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyValueStoreAssociations {
    var result: KeyValueStoreAssociations = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyValueStoreAssociationList(allocator, reader, "KeyValueStoreAssociation");
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

pub fn deserializeKeyValueStoreList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KeyValueStoreList {
    var result: KeyValueStoreList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeKeyValueStoreSummaryList(allocator, reader, "KeyValueStore");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeKinesisStreamConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !KinesisStreamConfig {
    var result: KinesisStreamConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RoleARN")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StreamARN")) {
                    result.stream_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLambdaFunctionAssociation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LambdaFunctionAssociation {
    var result: LambdaFunctionAssociation = undefined;
    result.include_body = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventType")) {
                    result.event_type = EventType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "IncludeBody")) {
                    result.include_body = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LambdaFunctionARN")) {
                    result.lambda_function_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLambdaFunctionAssociations(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LambdaFunctionAssociations {
    var result: LambdaFunctionAssociations = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeLambdaFunctionAssociationList(allocator, reader, "LambdaFunctionAssociation");
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

pub fn deserializeLoggingConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoggingConfig {
    var result: LoggingConfig = undefined;
    result.bucket = "";
    result.enabled = false;
    result.include_cookies = false;
    result.prefix = "";
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IncludeCookies")) {
                    result.include_cookies = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeManagedCertificateDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedCertificateDetails {
    var result: ManagedCertificateDetails = undefined;
    result.certificate_arn = null;
    result.certificate_status = null;
    result.validation_token_details = null;
    result.validation_token_host = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateArn")) {
                    result.certificate_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateStatus")) {
                    result.certificate_status = ManagedCertificateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationTokenDetails")) {
                    result.validation_token_details = try deserializeValidationTokenDetailList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ValidationTokenHost")) {
                    result.validation_token_host = ValidationTokenHost.fromWireName(try reader.readElementText());
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

pub fn deserializeMonitoringSubscription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MonitoringSubscription {
    var result: MonitoringSubscription = undefined;
    result.realtime_metrics_subscription_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RealtimeMetricsSubscriptionConfig")) {
                    result.realtime_metrics_subscription_config = try deserializeRealtimeMetricsSubscriptionConfig(allocator, reader);
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

pub fn deserializeOrigin(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Origin {
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
                    result.custom_headers = try deserializeCustomHeaders(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CustomOriginConfig")) {
                    result.custom_origin_config = try deserializeCustomOriginConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlId")) {
                    result.origin_access_control_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginPath")) {
                    result.origin_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginShield")) {
                    result.origin_shield = try deserializeOriginShield(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ResponseCompletionTimeout")) {
                    result.response_completion_timeout = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "S3OriginConfig")) {
                    result.s3_origin_config = try deserializeS3OriginConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "VpcOriginConfig")) {
                    result.vpc_origin_config = try deserializeVpcOriginConfig(allocator, reader);
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

pub fn deserializeOriginAccessControl(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginAccessControl {
    var result: OriginAccessControl = undefined;
    result.origin_access_control_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlConfig")) {
                    result.origin_access_control_config = try deserializeOriginAccessControlConfig(allocator, reader);
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

pub fn deserializeOriginAccessControlConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginAccessControlConfig {
    var result: OriginAccessControlConfig = undefined;
    result.description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlOriginType")) {
                    result.origin_access_control_origin_type = OriginAccessControlOriginTypes.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "SigningBehavior")) {
                    result.signing_behavior = OriginAccessControlSigningBehaviors.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "SigningProtocol")) {
                    result.signing_protocol = OriginAccessControlSigningProtocols.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeOriginAccessControlList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginAccessControlList {
    var result: OriginAccessControlList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginAccessControlSummaryList(allocator, reader, "OriginAccessControlSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOriginAccessControlSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginAccessControlSummary {
    var result: OriginAccessControlSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessControlOriginType")) {
                    result.origin_access_control_origin_type = OriginAccessControlOriginTypes.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "SigningBehavior")) {
                    result.signing_behavior = OriginAccessControlSigningBehaviors.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "SigningProtocol")) {
                    result.signing_protocol = OriginAccessControlSigningProtocols.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeOriginCustomHeader(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginCustomHeader {
    var result: OriginCustomHeader = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderName")) {
                    result.header_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HeaderValue")) {
                    result.header_value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOriginGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginGroup {
    var result: OriginGroup = undefined;
    result.selection_criteria = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailoverCriteria")) {
                    result.failover_criteria = try deserializeOriginGroupFailoverCriteria(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Members")) {
                    result.members = try deserializeOriginGroupMembers(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SelectionCriteria")) {
                    result.selection_criteria = OriginGroupSelectionCriteria.fromWireName(try reader.readElementText());
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

pub fn deserializeOriginGroupFailoverCriteria(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginGroupFailoverCriteria {
    var result: OriginGroupFailoverCriteria = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StatusCodes")) {
                    result.status_codes = try deserializeStatusCodes(allocator, reader);
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

pub fn deserializeOriginGroupMember(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginGroupMember {
    var result: OriginGroupMember = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginId")) {
                    result.origin_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOriginGroupMembers(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginGroupMembers {
    var result: OriginGroupMembers = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginGroupMemberList(allocator, reader, "OriginGroupMember");
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

pub fn deserializeOriginGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginGroups {
    var result: OriginGroups = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginGroupList(allocator, reader, "OriginGroup");
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

pub fn deserializeOriginMtlsConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginMtlsConfig {
    var result: OriginMtlsConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClientCertificateArn")) {
                    result.client_certificate_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOriginRequestPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicy {
    var result: OriginRequestPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginRequestPolicyConfig")) {
                    result.origin_request_policy_config = try deserializeOriginRequestPolicyConfig(allocator, reader);
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

pub fn deserializeOriginRequestPolicyConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicyConfig {
    var result: OriginRequestPolicyConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CookiesConfig")) {
                    result.cookies_config = try deserializeOriginRequestPolicyCookiesConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "HeadersConfig")) {
                    result.headers_config = try deserializeOriginRequestPolicyHeadersConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryStringsConfig")) {
                    result.query_strings_config = try deserializeOriginRequestPolicyQueryStringsConfig(allocator, reader);
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

pub fn deserializeOriginRequestPolicyCookiesConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicyCookiesConfig {
    var result: OriginRequestPolicyCookiesConfig = undefined;
    result.cookies = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookieBehavior")) {
                    result.cookie_behavior = OriginRequestPolicyCookieBehavior.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Cookies")) {
                    result.cookies = try deserializeCookieNames(allocator, reader);
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

pub fn deserializeOriginRequestPolicyHeadersConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicyHeadersConfig {
    var result: OriginRequestPolicyHeadersConfig = undefined;
    result.headers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HeaderBehavior")) {
                    result.header_behavior = OriginRequestPolicyHeaderBehavior.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Headers")) {
                    result.headers = try deserializeHeaders(allocator, reader);
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

pub fn deserializeOriginRequestPolicyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicyList {
    var result: OriginRequestPolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginRequestPolicySummaryList(allocator, reader, "OriginRequestPolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOriginRequestPolicyQueryStringsConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicyQueryStringsConfig {
    var result: OriginRequestPolicyQueryStringsConfig = undefined;
    result.query_strings = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "QueryStringBehavior")) {
                    result.query_string_behavior = OriginRequestPolicyQueryStringBehavior.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "QueryStrings")) {
                    result.query_strings = try deserializeQueryStringNames(allocator, reader);
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

pub fn deserializeOriginRequestPolicySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginRequestPolicySummary {
    var result: OriginRequestPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginRequestPolicy")) {
                    result.origin_request_policy = try deserializeOriginRequestPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = OriginRequestPolicyType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeOriginShield(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginShield {
    var result: OriginShield = undefined;
    result.origin_shield_region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OriginShieldRegion")) {
                    result.origin_shield_region = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOriginSslProtocols(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OriginSslProtocols {
    var result: OriginSslProtocols = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeSslProtocolsList(allocator, reader, "SslProtocol");
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

pub fn deserializeOrigins(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Origins {
    var result: Origins = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeOriginList(allocator, reader, "Origin");
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

pub fn deserializeParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Parameter {
    var result: Parameter = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeParameterDefinition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ParameterDefinition {
    var result: ParameterDefinition = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Definition")) {
                    result.definition = try deserializeParameterDefinitionSchema(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeParameterDefinitionSchema(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ParameterDefinitionSchema {
    var result: ParameterDefinitionSchema = undefined;
    result.string_schema = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StringSchema")) {
                    result.string_schema = try deserializeStringSchemaConfig(allocator, reader);
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

pub fn deserializeParametersInCacheKeyAndForwardedToOrigin(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ParametersInCacheKeyAndForwardedToOrigin {
    var result: ParametersInCacheKeyAndForwardedToOrigin = undefined;
    result.enable_accept_encoding_brotli = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CookiesConfig")) {
                    result.cookies_config = try deserializeCachePolicyCookiesConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EnableAcceptEncodingBrotli")) {
                    result.enable_accept_encoding_brotli = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "EnableAcceptEncodingGzip")) {
                    result.enable_accept_encoding_gzip = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HeadersConfig")) {
                    result.headers_config = try deserializeCachePolicyHeadersConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "QueryStringsConfig")) {
                    result.query_strings_config = try deserializeCachePolicyQueryStringsConfig(allocator, reader);
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

pub fn deserializePaths(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Paths {
    var result: Paths = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializePathList(allocator, reader, "Path");
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

pub fn deserializePublicKey(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PublicKey {
    var result: PublicKey = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicKeyConfig")) {
                    result.public_key_config = try deserializePublicKeyConfig(allocator, reader);
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

pub fn deserializePublicKeyConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PublicKeyConfig {
    var result: PublicKeyConfig = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodedKey")) {
                    result.encoded_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePublicKeyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PublicKeyList {
    var result: PublicKeyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializePublicKeySummaryList(allocator, reader, "PublicKeySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePublicKeySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PublicKeySummary {
    var result: PublicKeySummary = undefined;
    result.comment = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodedKey")) {
                    result.encoded_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeQueryArgProfile(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryArgProfile {
    var result: QueryArgProfile = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ProfileId")) {
                    result.profile_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryArg")) {
                    result.query_arg = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeQueryArgProfileConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryArgProfileConfig {
    var result: QueryArgProfileConfig = undefined;
    result.query_arg_profiles = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ForwardWhenQueryArgProfileIsUnknown")) {
                    result.forward_when_query_arg_profile_is_unknown = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "QueryArgProfiles")) {
                    result.query_arg_profiles = try deserializeQueryArgProfiles(allocator, reader);
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

pub fn deserializeQueryArgProfiles(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryArgProfiles {
    var result: QueryArgProfiles = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeQueryArgProfileList(allocator, reader, "QueryArgProfile");
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

pub fn deserializeQueryStringCacheKeys(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryStringCacheKeys {
    var result: QueryStringCacheKeys = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeQueryStringCacheKeysList(allocator, reader, "Name");
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

pub fn deserializeQueryStringNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !QueryStringNames {
    var result: QueryStringNames = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeQueryStringNamesList(allocator, reader, "Name");
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

pub fn deserializeRealtimeLogConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RealtimeLogConfig {
    var result: RealtimeLogConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndPoints")) {
                    result.end_points = try deserializeEndPointList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Fields")) {
                    result.fields = try deserializeFieldList(allocator, reader, "Field");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRealtimeLogConfigs(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RealtimeLogConfigs {
    var result: RealtimeLogConfigs = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeRealtimeLogConfigList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRealtimeMetricsSubscriptionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RealtimeMetricsSubscriptionConfig {
    _ = allocator;
    var result: RealtimeMetricsSubscriptionConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RealtimeMetricsSubscriptionStatus")) {
                    result.realtime_metrics_subscription_status = RealtimeMetricsSubscriptionStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeResponseHeadersPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicy {
    var result: ResponseHeadersPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResponseHeadersPolicyConfig")) {
                    result.response_headers_policy_config = try deserializeResponseHeadersPolicyConfig(allocator, reader);
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

pub fn deserializeResponseHeadersPolicyAccessControlAllowHeaders(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyAccessControlAllowHeaders {
    var result: ResponseHeadersPolicyAccessControlAllowHeaders = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlAllowHeadersList(allocator, reader, "Header");
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

pub fn deserializeResponseHeadersPolicyAccessControlAllowMethods(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyAccessControlAllowMethods {
    var result: ResponseHeadersPolicyAccessControlAllowMethods = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlAllowMethodsList(allocator, reader, "Method");
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

pub fn deserializeResponseHeadersPolicyAccessControlAllowOrigins(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyAccessControlAllowOrigins {
    var result: ResponseHeadersPolicyAccessControlAllowOrigins = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlAllowOriginsList(allocator, reader, "Origin");
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

pub fn deserializeResponseHeadersPolicyAccessControlExposeHeaders(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyAccessControlExposeHeaders {
    var result: ResponseHeadersPolicyAccessControlExposeHeaders = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAccessControlExposeHeadersList(allocator, reader, "Header");
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

pub fn deserializeResponseHeadersPolicyConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyConfig {
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
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CorsConfig")) {
                    result.cors_config = try deserializeResponseHeadersPolicyCorsConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CustomHeadersConfig")) {
                    result.custom_headers_config = try deserializeResponseHeadersPolicyCustomHeadersConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RemoveHeadersConfig")) {
                    result.remove_headers_config = try deserializeResponseHeadersPolicyRemoveHeadersConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SecurityHeadersConfig")) {
                    result.security_headers_config = try deserializeResponseHeadersPolicySecurityHeadersConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ServerTimingHeadersConfig")) {
                    result.server_timing_headers_config = try deserializeResponseHeadersPolicyServerTimingHeadersConfig(allocator, reader);
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

pub fn deserializeResponseHeadersPolicyContentSecurityPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyContentSecurityPolicy {
    var result: ResponseHeadersPolicyContentSecurityPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContentSecurityPolicy")) {
                    result.content_security_policy = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResponseHeadersPolicyContentTypeOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyContentTypeOptions {
    _ = allocator;
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

pub fn deserializeResponseHeadersPolicyCorsConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyCorsConfig {
    var result: ResponseHeadersPolicyCorsConfig = undefined;
    result.access_control_expose_headers = null;
    result.access_control_max_age_sec = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessControlAllowCredentials")) {
                    result.access_control_allow_credentials = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AccessControlAllowHeaders")) {
                    result.access_control_allow_headers = try deserializeResponseHeadersPolicyAccessControlAllowHeaders(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AccessControlAllowMethods")) {
                    result.access_control_allow_methods = try deserializeResponseHeadersPolicyAccessControlAllowMethods(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AccessControlAllowOrigins")) {
                    result.access_control_allow_origins = try deserializeResponseHeadersPolicyAccessControlAllowOrigins(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AccessControlExposeHeaders")) {
                    result.access_control_expose_headers = try deserializeResponseHeadersPolicyAccessControlExposeHeaders(allocator, reader);
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

pub fn deserializeResponseHeadersPolicyCustomHeader(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyCustomHeader {
    var result: ResponseHeadersPolicyCustomHeader = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Header")) {
                    result.header = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResponseHeadersPolicyCustomHeadersConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyCustomHeadersConfig {
    var result: ResponseHeadersPolicyCustomHeadersConfig = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeResponseHeadersPolicyCustomHeaderList(allocator, reader, "ResponseHeadersPolicyCustomHeader");
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

pub fn deserializeResponseHeadersPolicyFrameOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyFrameOptions {
    _ = allocator;
    var result: ResponseHeadersPolicyFrameOptions = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FrameOption")) {
                    result.frame_option = FrameOptionsList.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeResponseHeadersPolicyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyList {
    var result: ResponseHeadersPolicyList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeResponseHeadersPolicySummaryList(allocator, reader, "ResponseHeadersPolicySummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResponseHeadersPolicyReferrerPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyReferrerPolicy {
    _ = allocator;
    var result: ResponseHeadersPolicyReferrerPolicy = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Override")) {
                    result.override = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReferrerPolicy")) {
                    result.referrer_policy = ReferrerPolicyList.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeResponseHeadersPolicyRemoveHeader(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyRemoveHeader {
    var result: ResponseHeadersPolicyRemoveHeader = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Header")) {
                    result.header = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResponseHeadersPolicyRemoveHeadersConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyRemoveHeadersConfig {
    var result: ResponseHeadersPolicyRemoveHeadersConfig = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeResponseHeadersPolicyRemoveHeaderList(allocator, reader, "ResponseHeadersPolicyRemoveHeader");
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

pub fn deserializeResponseHeadersPolicySecurityHeadersConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicySecurityHeadersConfig {
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
                    result.content_security_policy = try deserializeResponseHeadersPolicyContentSecurityPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ContentTypeOptions")) {
                    result.content_type_options = try deserializeResponseHeadersPolicyContentTypeOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "FrameOptions")) {
                    result.frame_options = try deserializeResponseHeadersPolicyFrameOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ReferrerPolicy")) {
                    result.referrer_policy = try deserializeResponseHeadersPolicyReferrerPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StrictTransportSecurity")) {
                    result.strict_transport_security = try deserializeResponseHeadersPolicyStrictTransportSecurity(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "XSSProtection")) {
                    result.xss_protection = try deserializeResponseHeadersPolicyXSSProtection(allocator, reader);
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

pub fn deserializeResponseHeadersPolicyServerTimingHeadersConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyServerTimingHeadersConfig {
    _ = allocator;
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

pub fn deserializeResponseHeadersPolicyStrictTransportSecurity(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyStrictTransportSecurity {
    _ = allocator;
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

pub fn deserializeResponseHeadersPolicySummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicySummary {
    var result: ResponseHeadersPolicySummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResponseHeadersPolicy")) {
                    result.response_headers_policy = try deserializeResponseHeadersPolicy(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = ResponseHeadersPolicyType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeResponseHeadersPolicyXSSProtection(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResponseHeadersPolicyXSSProtection {
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
                    result.report_uri = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRestrictions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Restrictions {
    var result: Restrictions = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GeoRestriction")) {
                    result.geo_restriction = try deserializeGeoRestriction(allocator, reader);
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

pub fn deserializeS3Origin(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3Origin {
    var result: S3Origin = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginAccessIdentity")) {
                    result.origin_access_identity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeS3OriginConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !S3OriginConfig {
    var result: S3OriginConfig = undefined;
    result.origin_read_timeout = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginAccessIdentity")) {
                    result.origin_access_identity = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSessionStickinessConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SessionStickinessConfig {
    _ = allocator;
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

pub fn deserializeSigner(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Signer {
    var result: Signer = undefined;
    result.aws_account_number = null;
    result.key_pair_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AwsAccountNumber")) {
                    result.aws_account_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KeyPairIds")) {
                    result.key_pair_ids = try deserializeKeyPairIds(allocator, reader);
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

pub fn deserializeStagingDistributionDnsNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StagingDistributionDnsNames {
    var result: StagingDistributionDnsNames = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeStagingDistributionDnsNameList(allocator, reader, "DnsName");
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

pub fn deserializeStatusCodes(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StatusCodes {
    var result: StatusCodes = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeStatusCodeList(allocator, reader, "StatusCode");
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

pub fn deserializeStreamingDistribution(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StreamingDistribution {
    var result: StreamingDistribution = undefined;
    result.last_modified_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActiveTrustedSigners")) {
                    result.active_trusted_signers = try deserializeActiveTrustedSigners(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StreamingDistributionConfig")) {
                    result.streaming_distribution_config = try deserializeStreamingDistributionConfig(allocator, reader);
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

pub fn deserializeStreamingDistributionConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StreamingDistributionConfig {
    var result: StreamingDistributionConfig = undefined;
    result.aliases = null;
    result.logging = null;
    result.price_class = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Aliases")) {
                    result.aliases = try deserializeAliases(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "CallerReference")) {
                    result.caller_reference = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Logging")) {
                    result.logging = try deserializeStreamingLoggingConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = PriceClass.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Origin")) {
                    result.s3_origin = try deserializeS3Origin(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(allocator, reader);
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

pub fn deserializeStreamingDistributionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StreamingDistributionList {
    var result: StreamingDistributionList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeStreamingDistributionSummaryList(allocator, reader, "StreamingDistributionSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStreamingDistributionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StreamingDistributionSummary {
    var result: StreamingDistributionSummary = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Aliases")) {
                    result.aliases = try deserializeAliases(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PriceClass")) {
                    result.price_class = PriceClass.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "S3Origin")) {
                    result.s3_origin = try deserializeS3Origin(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustedSigners")) {
                    result.trusted_signers = try deserializeTrustedSigners(allocator, reader);
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

pub fn deserializeStreamingLoggingConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StreamingLoggingConfig {
    var result: StreamingLoggingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStringSchemaConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StringSchemaConfig {
    var result: StringSchemaConfig = undefined;
    result.comment = null;
    result.default_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Comment")) {
                    result.comment = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTags(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tags {
    var result: Tags = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeTagList(allocator, reader, "Tag");
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

pub fn deserializeTenantConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TenantConfig {
    var result: TenantConfig = undefined;
    result.parameter_definitions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ParameterDefinitions")) {
                    result.parameter_definitions = try deserializeParameterDefinitions(allocator, reader, "member");
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

pub fn deserializeTestResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TestResult {
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
                    result.compute_utilization = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionErrorMessage")) {
                    result.function_error_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionExecutionLogs")) {
                    result.function_execution_logs = try deserializeFunctionExecutionLogList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "FunctionOutput")) {
                    result.function_output = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FunctionSummary")) {
                    result.function_summary = try deserializeFunctionSummary(allocator, reader);
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

pub fn deserializeTrafficConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrafficConfig {
    var result: TrafficConfig = undefined;
    result.single_header_config = null;
    result.single_weight_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SingleHeaderConfig")) {
                    result.single_header_config = try deserializeContinuousDeploymentSingleHeaderConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SingleWeightConfig")) {
                    result.single_weight_config = try deserializeContinuousDeploymentSingleWeightConfig(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = ContinuousDeploymentPolicyType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeTrustStore(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustStore {
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
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfCaCertificates")) {
                    result.number_of_ca_certificates = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = TrustStoreStatus.fromWireName(try reader.readElementText());
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

pub fn deserializeTrustStoreConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustStoreConfig {
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
                    result.trust_store_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTrustStoreSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustStoreSummary {
    var result: TrustStoreSummary = undefined;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NumberOfCaCertificates")) {
                    result.number_of_ca_certificates = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = TrustStoreStatus.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
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

pub fn deserializeTrustedKeyGroups(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustedKeyGroups {
    var result: TrustedKeyGroups = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeTrustedKeyGroupIdList(allocator, reader, "KeyGroup");
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

pub fn deserializeTrustedSigners(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrustedSigners {
    var result: TrustedSigners = undefined;
    result.items = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeAwsAccountNumberList(allocator, reader, "AwsAccountNumber");
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

pub fn deserializeValidationTokenDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ValidationTokenDetail {
    var result: ValidationTokenDetail = undefined;
    result.redirect_from = null;
    result.redirect_to = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Domain")) {
                    result.domain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedirectFrom")) {
                    result.redirect_from = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RedirectTo")) {
                    result.redirect_to = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeViewerCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ViewerCertificate {
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
                    result.acm_certificate_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Certificate")) {
                    result.certificate = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateSource")) {
                    result.certificate_source = CertificateSource.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CloudFrontDefaultCertificate")) {
                    result.cloud_front_default_certificate = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IAMCertificateId")) {
                    result.iam_certificate_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumProtocolVersion")) {
                    result.minimum_protocol_version = MinimumProtocolVersion.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSLSupportMethod")) {
                    result.ssl_support_method = SSLSupportMethod.fromWireName(try reader.readElementText());
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

pub fn deserializeViewerMtlsConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ViewerMtlsConfig {
    var result: ViewerMtlsConfig = undefined;
    result.mode = "required";
    result.trust_store_config = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Mode")) {
                    result.mode = ViewerMtlsMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TrustStoreConfig")) {
                    result.trust_store_config = try deserializeTrustStoreConfig(allocator, reader);
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

pub fn deserializeVpcOrigin(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcOrigin {
    var result: VpcOrigin = undefined;
    result.account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcOriginEndpointConfig")) {
                    result.vpc_origin_endpoint_config = try deserializeVpcOriginEndpointConfig(allocator, reader);
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

pub fn deserializeVpcOriginConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcOriginConfig {
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
                    result.owner_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VpcOriginId")) {
                    result.vpc_origin_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeVpcOriginEndpointConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcOriginEndpointConfig {
    var result: VpcOriginEndpointConfig = undefined;
    result.origin_ssl_protocols = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HTTPPort")) {
                    result.http_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "HTTPSPort")) {
                    result.https_port = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginProtocolPolicy")) {
                    result.origin_protocol_policy = OriginProtocolPolicy.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "OriginSslProtocols")) {
                    result.origin_ssl_protocols = try deserializeOriginSslProtocols(allocator, reader);
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

pub fn deserializeVpcOriginList(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcOriginList {
    var result: VpcOriginList = undefined;
    result.items = null;
    result.next_marker = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Items")) {
                    result.items = try deserializeVpcOriginSummaryList(allocator, reader, "VpcOriginSummary");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeVpcOriginSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VpcOriginSummary {
    var result: VpcOriginSummary = undefined;
    result.account_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedTime")) {
                    result.created_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginEndpointArn")) {
                    result.origin_endpoint_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeWebAclCustomization(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !WebAclCustomization {
    var result: WebAclCustomization = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = CustomizationActionType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn serializeAccessControlAllowHeadersList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAccessControlAllowMethodsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResponseHeadersPolicyAccessControlAllowMethodsValues, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAccessControlAllowOriginsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAccessControlExposeHeadersList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAliasList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAwsAccountNumberList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCacheBehaviorList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CacheBehavior, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCacheBehavior(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeContentTypeProfileList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ContentTypeProfile, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeContentTypeProfile(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCookieNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCustomErrorResponseList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const CustomErrorResponse, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeCustomErrorResponse(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDomainList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DomainItem, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeDomainItem(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEncryptionEntityList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EncryptionEntity, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeEncryptionEntity(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEndPointList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EndPoint, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeEndPoint(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeFieldList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeFieldPatternList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeFunctionAssociationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const FunctionAssociation, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeFunctionAssociation(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeHeaderList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeIpamCidrConfigList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const IpamCidrConfig, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeIpamCidrConfig(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeKeyValueStoreAssociationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const KeyValueStoreAssociation, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeKeyValueStoreAssociation(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLambdaFunctionAssociationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const LambdaFunctionAssociation, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeLambdaFunctionAssociation(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLocationList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMethodsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Method, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOriginCustomHeadersList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OriginCustomHeader, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOriginCustomHeader(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOriginGroupList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OriginGroup, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOriginGroup(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOriginGroupMemberList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OriginGroupMember, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOriginGroupMember(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOriginList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Origin, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOrigin(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeParameterDefinitions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ParameterDefinition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeParameterDefinition(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeParameters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Parameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeParameter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePathList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializePublicKeyIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeQueryArgProfileList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const QueryArgProfile, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeQueryArgProfile(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeQueryStringCacheKeysList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeQueryStringNamesList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResponseHeadersPolicyCustomHeaderList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResponseHeadersPolicyCustomHeader, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeResponseHeadersPolicyCustomHeader(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResponseHeadersPolicyRemoveHeaderList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResponseHeadersPolicyRemoveHeader, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeResponseHeadersPolicyRemoveHeader(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSslProtocolsList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const SslProtocol, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStagingDistributionDnsNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStatusCodeList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const i32, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{item}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTrustedKeyGroupIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAliases(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Aliases) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeAliasList(allocator, buf, v, "CNAME");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeAllowedMethods(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AllowedMethods) !void {
    if (value.cached_methods) |v| {
        try buf.appendSlice(allocator, "<CachedMethods>");
        try serializeCachedMethods(allocator, buf, v);
        try buf.appendSlice(allocator, "</CachedMethods>");
    }
    try buf.appendSlice(allocator, "<Items>");
    try serializeMethodsList(allocator, buf, value.items, "Method");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeCacheBehavior(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CacheBehavior) !void {
    if (value.allowed_methods) |v| {
        try buf.appendSlice(allocator, "<AllowedMethods>");
        try serializeAllowedMethods(allocator, buf, v);
        try buf.appendSlice(allocator, "</AllowedMethods>");
    }
    if (value.cache_policy_id) |v| {
        try buf.appendSlice(allocator, "<CachePolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</CachePolicyId>");
    }
    if (value.compress) |v| {
        try buf.appendSlice(allocator, "<Compress>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Compress>");
    }
    if (value.default_ttl) |v| {
        try buf.appendSlice(allocator, "<DefaultTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultTTL>");
    }
    if (value.field_level_encryption_id) |v| {
        try buf.appendSlice(allocator, "<FieldLevelEncryptionId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FieldLevelEncryptionId>");
    }
    if (value.forwarded_values) |v| {
        try buf.appendSlice(allocator, "<ForwardedValues>");
        try serializeForwardedValues(allocator, buf, v);
        try buf.appendSlice(allocator, "</ForwardedValues>");
    }
    if (value.function_associations) |v| {
        try buf.appendSlice(allocator, "<FunctionAssociations>");
        try serializeFunctionAssociations(allocator, buf, v);
        try buf.appendSlice(allocator, "</FunctionAssociations>");
    }
    if (value.grpc_config) |v| {
        try buf.appendSlice(allocator, "<GrpcConfig>");
        try serializeGrpcConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</GrpcConfig>");
    }
    if (value.lambda_function_associations) |v| {
        try buf.appendSlice(allocator, "<LambdaFunctionAssociations>");
        try serializeLambdaFunctionAssociations(allocator, buf, v);
        try buf.appendSlice(allocator, "</LambdaFunctionAssociations>");
    }
    if (value.max_ttl) |v| {
        try buf.appendSlice(allocator, "<MaxTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxTTL>");
    }
    if (value.min_ttl) |v| {
        try buf.appendSlice(allocator, "<MinTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinTTL>");
    }
    if (value.origin_request_policy_id) |v| {
        try buf.appendSlice(allocator, "<OriginRequestPolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginRequestPolicyId>");
    }
    try buf.appendSlice(allocator, "<PathPattern>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.path_pattern);
    try buf.appendSlice(allocator, "</PathPattern>");
    if (value.realtime_log_config_arn) |v| {
        try buf.appendSlice(allocator, "<RealtimeLogConfigArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RealtimeLogConfigArn>");
    }
    if (value.response_headers_policy_id) |v| {
        try buf.appendSlice(allocator, "<ResponseHeadersPolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResponseHeadersPolicyId>");
    }
    if (value.smooth_streaming) |v| {
        try buf.appendSlice(allocator, "<SmoothStreaming>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SmoothStreaming>");
    }
    try buf.appendSlice(allocator, "<TargetOriginId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.target_origin_id);
    try buf.appendSlice(allocator, "</TargetOriginId>");
    if (value.trusted_key_groups) |v| {
        try buf.appendSlice(allocator, "<TrustedKeyGroups>");
        try serializeTrustedKeyGroups(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustedKeyGroups>");
    }
    if (value.trusted_signers) |v| {
        try buf.appendSlice(allocator, "<TrustedSigners>");
        try serializeTrustedSigners(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustedSigners>");
    }
    try buf.appendSlice(allocator, "<ViewerProtocolPolicy>");
    try buf.appendSlice(allocator, value.viewer_protocol_policy.wireName());
    try buf.appendSlice(allocator, "</ViewerProtocolPolicy>");
}

pub fn serializeCacheBehaviors(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CacheBehaviors) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeCacheBehaviorList(allocator, buf, v, "CacheBehavior");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeCachePolicyConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    if (value.default_ttl) |v| {
        try buf.appendSlice(allocator, "<DefaultTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultTTL>");
    }
    if (value.max_ttl) |v| {
        try buf.appendSlice(allocator, "<MaxTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxTTL>");
    }
    try buf.appendSlice(allocator, "<MinTTL>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.min_ttl}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</MinTTL>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.parameters_in_cache_key_and_forwarded_to_origin) |v| {
        try buf.appendSlice(allocator, "<ParametersInCacheKeyAndForwardedToOrigin>");
        try serializeParametersInCacheKeyAndForwardedToOrigin(allocator, buf, v);
        try buf.appendSlice(allocator, "</ParametersInCacheKeyAndForwardedToOrigin>");
    }
}

pub fn serializeCachePolicyCookiesConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyCookiesConfig) !void {
    try buf.appendSlice(allocator, "<CookieBehavior>");
    try buf.appendSlice(allocator, value.cookie_behavior.wireName());
    try buf.appendSlice(allocator, "</CookieBehavior>");
    if (value.cookies) |v| {
        try buf.appendSlice(allocator, "<Cookies>");
        try serializeCookieNames(allocator, buf, v);
        try buf.appendSlice(allocator, "</Cookies>");
    }
}

pub fn serializeCachePolicyHeadersConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyHeadersConfig) !void {
    try buf.appendSlice(allocator, "<HeaderBehavior>");
    try buf.appendSlice(allocator, value.header_behavior.wireName());
    try buf.appendSlice(allocator, "</HeaderBehavior>");
    if (value.headers) |v| {
        try buf.appendSlice(allocator, "<Headers>");
        try serializeHeaders(allocator, buf, v);
        try buf.appendSlice(allocator, "</Headers>");
    }
}

pub fn serializeCachePolicyQueryStringsConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachePolicyQueryStringsConfig) !void {
    try buf.appendSlice(allocator, "<QueryStringBehavior>");
    try buf.appendSlice(allocator, value.query_string_behavior.wireName());
    try buf.appendSlice(allocator, "</QueryStringBehavior>");
    if (value.query_strings) |v| {
        try buf.appendSlice(allocator, "<QueryStrings>");
        try serializeQueryStringNames(allocator, buf, v);
        try buf.appendSlice(allocator, "</QueryStrings>");
    }
}

pub fn serializeCachedMethods(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CachedMethods) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeMethodsList(allocator, buf, value.items, "Method");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeCertificate(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Certificate) !void {
    try buf.appendSlice(allocator, "<Arn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.arn);
    try buf.appendSlice(allocator, "</Arn>");
}

pub fn serializeCloudFrontOriginAccessIdentityConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CloudFrontOriginAccessIdentityConfig) !void {
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    try buf.appendSlice(allocator, "<Comment>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.comment);
    try buf.appendSlice(allocator, "</Comment>");
}

pub fn serializeConnectionFunctionAssociation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionFunctionAssociation) !void {
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
}

pub fn serializeConnectionGroupAssociationFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ConnectionGroupAssociationFilter) !void {
    if (value.anycast_ip_list_id) |v| {
        try buf.appendSlice(allocator, "<AnycastIpListId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AnycastIpListId>");
    }
}

pub fn serializeContentTypeProfile(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContentTypeProfile) !void {
    try buf.appendSlice(allocator, "<ContentType>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.content_type);
    try buf.appendSlice(allocator, "</ContentType>");
    try buf.appendSlice(allocator, "<Format>");
    try buf.appendSlice(allocator, value.format.wireName());
    try buf.appendSlice(allocator, "</Format>");
    if (value.profile_id) |v| {
        try buf.appendSlice(allocator, "<ProfileId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ProfileId>");
    }
}

pub fn serializeContentTypeProfileConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContentTypeProfileConfig) !void {
    if (value.content_type_profiles) |v| {
        try buf.appendSlice(allocator, "<ContentTypeProfiles>");
        try serializeContentTypeProfiles(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentTypeProfiles>");
    }
    try buf.appendSlice(allocator, "<ForwardWhenContentTypeIsUnknown>");
    try buf.appendSlice(allocator, if (value.forward_when_content_type_is_unknown) "true" else "false");
    try buf.appendSlice(allocator, "</ForwardWhenContentTypeIsUnknown>");
}

pub fn serializeContentTypeProfiles(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContentTypeProfiles) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeContentTypeProfileList(allocator, buf, v, "ContentTypeProfile");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeContinuousDeploymentPolicyConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContinuousDeploymentPolicyConfig) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    try buf.appendSlice(allocator, "<StagingDistributionDnsNames>");
    try serializeStagingDistributionDnsNames(allocator, buf, value.staging_distribution_dns_names);
    try buf.appendSlice(allocator, "</StagingDistributionDnsNames>");
    if (value.traffic_config) |v| {
        try buf.appendSlice(allocator, "<TrafficConfig>");
        try serializeTrafficConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrafficConfig>");
    }
}

pub fn serializeContinuousDeploymentSingleHeaderConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContinuousDeploymentSingleHeaderConfig) !void {
    try buf.appendSlice(allocator, "<Header>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header);
    try buf.appendSlice(allocator, "</Header>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeContinuousDeploymentSingleWeightConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContinuousDeploymentSingleWeightConfig) !void {
    if (value.session_stickiness_config) |v| {
        try buf.appendSlice(allocator, "<SessionStickinessConfig>");
        try serializeSessionStickinessConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</SessionStickinessConfig>");
    }
    try buf.appendSlice(allocator, "<Weight>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.weight}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Weight>");
}

pub fn serializeCookieNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CookieNames) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeCookieNameList(allocator, buf, v, "Name");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeCookiePreference(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CookiePreference) !void {
    try buf.appendSlice(allocator, "<Forward>");
    try buf.appendSlice(allocator, value.forward.wireName());
    try buf.appendSlice(allocator, "</Forward>");
    if (value.whitelisted_names) |v| {
        try buf.appendSlice(allocator, "<WhitelistedNames>");
        try serializeCookieNames(allocator, buf, v);
        try buf.appendSlice(allocator, "</WhitelistedNames>");
    }
}

pub fn serializeCustomErrorResponse(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomErrorResponse) !void {
    if (value.error_caching_min_ttl) |v| {
        try buf.appendSlice(allocator, "<ErrorCachingMinTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ErrorCachingMinTTL>");
    }
    try buf.appendSlice(allocator, "<ErrorCode>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.error_code}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</ErrorCode>");
    if (value.response_code) |v| {
        try buf.appendSlice(allocator, "<ResponseCode>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResponseCode>");
    }
    if (value.response_page_path) |v| {
        try buf.appendSlice(allocator, "<ResponsePagePath>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResponsePagePath>");
    }
}

pub fn serializeCustomErrorResponses(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomErrorResponses) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeCustomErrorResponseList(allocator, buf, v, "CustomErrorResponse");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeCustomHeaders(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomHeaders) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeOriginCustomHeadersList(allocator, buf, v, "OriginCustomHeader");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeCustomOriginConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: CustomOriginConfig) !void {
    try buf.appendSlice(allocator, "<HTTPPort>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.http_port}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</HTTPPort>");
    try buf.appendSlice(allocator, "<HTTPSPort>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.https_port}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</HTTPSPort>");
    if (value.ip_address_type) |v| {
        try buf.appendSlice(allocator, "<IpAddressType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</IpAddressType>");
    }
    if (value.origin_keepalive_timeout) |v| {
        try buf.appendSlice(allocator, "<OriginKeepaliveTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OriginKeepaliveTimeout>");
    }
    if (value.origin_mtls_config) |v| {
        try buf.appendSlice(allocator, "<OriginMtlsConfig>");
        try serializeOriginMtlsConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginMtlsConfig>");
    }
    try buf.appendSlice(allocator, "<OriginProtocolPolicy>");
    try buf.appendSlice(allocator, value.origin_protocol_policy.wireName());
    try buf.appendSlice(allocator, "</OriginProtocolPolicy>");
    if (value.origin_read_timeout) |v| {
        try buf.appendSlice(allocator, "<OriginReadTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OriginReadTimeout>");
    }
    if (value.origin_ssl_protocols) |v| {
        try buf.appendSlice(allocator, "<OriginSslProtocols>");
        try serializeOriginSslProtocols(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginSslProtocols>");
    }
}

pub fn serializeCustomizations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Customizations) !void {
    if (value.certificate) |v| {
        try buf.appendSlice(allocator, "<Certificate>");
        try serializeCertificate(allocator, buf, v);
        try buf.appendSlice(allocator, "</Certificate>");
    }
    if (value.geo_restrictions) |v| {
        try buf.appendSlice(allocator, "<GeoRestrictions>");
        try serializeGeoRestrictionCustomization(allocator, buf, v);
        try buf.appendSlice(allocator, "</GeoRestrictions>");
    }
    if (value.web_acl) |v| {
        try buf.appendSlice(allocator, "<WebAcl>");
        try serializeWebAclCustomization(allocator, buf, v);
        try buf.appendSlice(allocator, "</WebAcl>");
    }
}

pub fn serializeDefaultCacheBehavior(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DefaultCacheBehavior) !void {
    if (value.allowed_methods) |v| {
        try buf.appendSlice(allocator, "<AllowedMethods>");
        try serializeAllowedMethods(allocator, buf, v);
        try buf.appendSlice(allocator, "</AllowedMethods>");
    }
    if (value.cache_policy_id) |v| {
        try buf.appendSlice(allocator, "<CachePolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</CachePolicyId>");
    }
    if (value.compress) |v| {
        try buf.appendSlice(allocator, "<Compress>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Compress>");
    }
    if (value.default_ttl) |v| {
        try buf.appendSlice(allocator, "<DefaultTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultTTL>");
    }
    if (value.field_level_encryption_id) |v| {
        try buf.appendSlice(allocator, "<FieldLevelEncryptionId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</FieldLevelEncryptionId>");
    }
    if (value.forwarded_values) |v| {
        try buf.appendSlice(allocator, "<ForwardedValues>");
        try serializeForwardedValues(allocator, buf, v);
        try buf.appendSlice(allocator, "</ForwardedValues>");
    }
    if (value.function_associations) |v| {
        try buf.appendSlice(allocator, "<FunctionAssociations>");
        try serializeFunctionAssociations(allocator, buf, v);
        try buf.appendSlice(allocator, "</FunctionAssociations>");
    }
    if (value.grpc_config) |v| {
        try buf.appendSlice(allocator, "<GrpcConfig>");
        try serializeGrpcConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</GrpcConfig>");
    }
    if (value.lambda_function_associations) |v| {
        try buf.appendSlice(allocator, "<LambdaFunctionAssociations>");
        try serializeLambdaFunctionAssociations(allocator, buf, v);
        try buf.appendSlice(allocator, "</LambdaFunctionAssociations>");
    }
    if (value.max_ttl) |v| {
        try buf.appendSlice(allocator, "<MaxTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxTTL>");
    }
    if (value.min_ttl) |v| {
        try buf.appendSlice(allocator, "<MinTTL>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MinTTL>");
    }
    if (value.origin_request_policy_id) |v| {
        try buf.appendSlice(allocator, "<OriginRequestPolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginRequestPolicyId>");
    }
    if (value.realtime_log_config_arn) |v| {
        try buf.appendSlice(allocator, "<RealtimeLogConfigArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</RealtimeLogConfigArn>");
    }
    if (value.response_headers_policy_id) |v| {
        try buf.appendSlice(allocator, "<ResponseHeadersPolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResponseHeadersPolicyId>");
    }
    if (value.smooth_streaming) |v| {
        try buf.appendSlice(allocator, "<SmoothStreaming>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SmoothStreaming>");
    }
    try buf.appendSlice(allocator, "<TargetOriginId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.target_origin_id);
    try buf.appendSlice(allocator, "</TargetOriginId>");
    if (value.trusted_key_groups) |v| {
        try buf.appendSlice(allocator, "<TrustedKeyGroups>");
        try serializeTrustedKeyGroups(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustedKeyGroups>");
    }
    if (value.trusted_signers) |v| {
        try buf.appendSlice(allocator, "<TrustedSigners>");
        try serializeTrustedSigners(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustedSigners>");
    }
    try buf.appendSlice(allocator, "<ViewerProtocolPolicy>");
    try buf.appendSlice(allocator, value.viewer_protocol_policy.wireName());
    try buf.appendSlice(allocator, "</ViewerProtocolPolicy>");
}

pub fn serializeDistributionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionConfig) !void {
    if (value.aliases) |v| {
        try buf.appendSlice(allocator, "<Aliases>");
        try serializeAliases(allocator, buf, v);
        try buf.appendSlice(allocator, "</Aliases>");
    }
    if (value.anycast_ip_list_id) |v| {
        try buf.appendSlice(allocator, "<AnycastIpListId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AnycastIpListId>");
    }
    if (value.cache_behaviors) |v| {
        try buf.appendSlice(allocator, "<CacheBehaviors>");
        try serializeCacheBehaviors(allocator, buf, v);
        try buf.appendSlice(allocator, "</CacheBehaviors>");
    }
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    try buf.appendSlice(allocator, "<Comment>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.comment);
    try buf.appendSlice(allocator, "</Comment>");
    if (value.connection_function_association) |v| {
        try buf.appendSlice(allocator, "<ConnectionFunctionAssociation>");
        try serializeConnectionFunctionAssociation(allocator, buf, v);
        try buf.appendSlice(allocator, "</ConnectionFunctionAssociation>");
    }
    if (value.connection_mode) |v| {
        try buf.appendSlice(allocator, "<ConnectionMode>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ConnectionMode>");
    }
    if (value.continuous_deployment_policy_id) |v| {
        try buf.appendSlice(allocator, "<ContinuousDeploymentPolicyId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContinuousDeploymentPolicyId>");
    }
    if (value.custom_error_responses) |v| {
        try buf.appendSlice(allocator, "<CustomErrorResponses>");
        try serializeCustomErrorResponses(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomErrorResponses>");
    }
    try buf.appendSlice(allocator, "<DefaultCacheBehavior>");
    try serializeDefaultCacheBehavior(allocator, buf, value.default_cache_behavior);
    try buf.appendSlice(allocator, "</DefaultCacheBehavior>");
    if (value.default_root_object) |v| {
        try buf.appendSlice(allocator, "<DefaultRootObject>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultRootObject>");
    }
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.http_version) |v| {
        try buf.appendSlice(allocator, "<HttpVersion>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</HttpVersion>");
    }
    if (value.is_ipv6_enabled) |v| {
        try buf.appendSlice(allocator, "<IsIPV6Enabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IsIPV6Enabled>");
    }
    if (value.logging) |v| {
        try buf.appendSlice(allocator, "<Logging>");
        try serializeLoggingConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</Logging>");
    }
    if (value.origin_groups) |v| {
        try buf.appendSlice(allocator, "<OriginGroups>");
        try serializeOriginGroups(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginGroups>");
    }
    try buf.appendSlice(allocator, "<Origins>");
    try serializeOrigins(allocator, buf, value.origins);
    try buf.appendSlice(allocator, "</Origins>");
    if (value.price_class) |v| {
        try buf.appendSlice(allocator, "<PriceClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</PriceClass>");
    }
    if (value.restrictions) |v| {
        try buf.appendSlice(allocator, "<Restrictions>");
        try serializeRestrictions(allocator, buf, v);
        try buf.appendSlice(allocator, "</Restrictions>");
    }
    if (value.staging) |v| {
        try buf.appendSlice(allocator, "<Staging>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Staging>");
    }
    if (value.tenant_config) |v| {
        try buf.appendSlice(allocator, "<TenantConfig>");
        try serializeTenantConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</TenantConfig>");
    }
    if (value.viewer_certificate) |v| {
        try buf.appendSlice(allocator, "<ViewerCertificate>");
        try serializeViewerCertificate(allocator, buf, v);
        try buf.appendSlice(allocator, "</ViewerCertificate>");
    }
    if (value.viewer_mtls_config) |v| {
        try buf.appendSlice(allocator, "<ViewerMtlsConfig>");
        try serializeViewerMtlsConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</ViewerMtlsConfig>");
    }
    if (value.web_acl_id) |v| {
        try buf.appendSlice(allocator, "<WebACLId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</WebACLId>");
    }
}

pub fn serializeDistributionConfigWithTags(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionConfigWithTags) !void {
    try buf.appendSlice(allocator, "<DistributionConfig>");
    try serializeDistributionConfig(allocator, buf, value.distribution_config);
    try buf.appendSlice(allocator, "</DistributionConfig>");
    try buf.appendSlice(allocator, "<Tags>");
    try serializeTags(allocator, buf, value.tags);
    try buf.appendSlice(allocator, "</Tags>");
}

pub fn serializeDistributionResourceId(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionResourceId) !void {
    if (value.distribution_id) |v| {
        try buf.appendSlice(allocator, "<DistributionId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DistributionId>");
    }
    if (value.distribution_tenant_id) |v| {
        try buf.appendSlice(allocator, "<DistributionTenantId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DistributionTenantId>");
    }
}

pub fn serializeDistributionTenantAssociationFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DistributionTenantAssociationFilter) !void {
    if (value.connection_group_id) |v| {
        try buf.appendSlice(allocator, "<ConnectionGroupId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ConnectionGroupId>");
    }
    if (value.distribution_id) |v| {
        try buf.appendSlice(allocator, "<DistributionId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DistributionId>");
    }
}

pub fn serializeDomainItem(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DomainItem) !void {
    try buf.appendSlice(allocator, "<Domain>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.domain);
    try buf.appendSlice(allocator, "</Domain>");
}

pub fn serializeEncryptionEntities(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionEntities) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeEncryptionEntityList(allocator, buf, v, "EncryptionEntity");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeEncryptionEntity(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EncryptionEntity) !void {
    try buf.appendSlice(allocator, "<FieldPatterns>");
    try serializeFieldPatterns(allocator, buf, value.field_patterns);
    try buf.appendSlice(allocator, "</FieldPatterns>");
    try buf.appendSlice(allocator, "<ProviderId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.provider_id);
    try buf.appendSlice(allocator, "</ProviderId>");
    try buf.appendSlice(allocator, "<PublicKeyId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.public_key_id);
    try buf.appendSlice(allocator, "</PublicKeyId>");
}

pub fn serializeEndPoint(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EndPoint) !void {
    if (value.kinesis_stream_config) |v| {
        try buf.appendSlice(allocator, "<KinesisStreamConfig>");
        try serializeKinesisStreamConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</KinesisStreamConfig>");
    }
    try buf.appendSlice(allocator, "<StreamType>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.stream_type);
    try buf.appendSlice(allocator, "</StreamType>");
}

pub fn serializeFieldLevelEncryptionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FieldLevelEncryptionConfig) !void {
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    if (value.content_type_profile_config) |v| {
        try buf.appendSlice(allocator, "<ContentTypeProfileConfig>");
        try serializeContentTypeProfileConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentTypeProfileConfig>");
    }
    if (value.query_arg_profile_config) |v| {
        try buf.appendSlice(allocator, "<QueryArgProfileConfig>");
        try serializeQueryArgProfileConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</QueryArgProfileConfig>");
    }
}

pub fn serializeFieldLevelEncryptionProfileConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FieldLevelEncryptionProfileConfig) !void {
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    try buf.appendSlice(allocator, "<EncryptionEntities>");
    try serializeEncryptionEntities(allocator, buf, value.encryption_entities);
    try buf.appendSlice(allocator, "</EncryptionEntities>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
}

pub fn serializeFieldPatterns(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FieldPatterns) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeFieldPatternList(allocator, buf, v, "FieldPattern");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeForwardedValues(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ForwardedValues) !void {
    try buf.appendSlice(allocator, "<Cookies>");
    try serializeCookiePreference(allocator, buf, value.cookies);
    try buf.appendSlice(allocator, "</Cookies>");
    if (value.headers) |v| {
        try buf.appendSlice(allocator, "<Headers>");
        try serializeHeaders(allocator, buf, v);
        try buf.appendSlice(allocator, "</Headers>");
    }
    try buf.appendSlice(allocator, "<QueryString>");
    try buf.appendSlice(allocator, if (value.query_string) "true" else "false");
    try buf.appendSlice(allocator, "</QueryString>");
    if (value.query_string_cache_keys) |v| {
        try buf.appendSlice(allocator, "<QueryStringCacheKeys>");
        try serializeQueryStringCacheKeys(allocator, buf, v);
        try buf.appendSlice(allocator, "</QueryStringCacheKeys>");
    }
}

pub fn serializeFunctionAssociation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FunctionAssociation) !void {
    try buf.appendSlice(allocator, "<EventType>");
    try buf.appendSlice(allocator, value.event_type.wireName());
    try buf.appendSlice(allocator, "</EventType>");
    try buf.appendSlice(allocator, "<FunctionARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.function_arn);
    try buf.appendSlice(allocator, "</FunctionARN>");
}

pub fn serializeFunctionAssociations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FunctionAssociations) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeFunctionAssociationList(allocator, buf, v, "FunctionAssociation");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeFunctionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: FunctionConfig) !void {
    try buf.appendSlice(allocator, "<Comment>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.comment);
    try buf.appendSlice(allocator, "</Comment>");
    if (value.key_value_store_associations) |v| {
        try buf.appendSlice(allocator, "<KeyValueStoreAssociations>");
        try serializeKeyValueStoreAssociations(allocator, buf, v);
        try buf.appendSlice(allocator, "</KeyValueStoreAssociations>");
    }
    try buf.appendSlice(allocator, "<Runtime>");
    try buf.appendSlice(allocator, value.runtime.wireName());
    try buf.appendSlice(allocator, "</Runtime>");
}

pub fn serializeGeoRestriction(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoRestriction) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeLocationList(allocator, buf, v, "Location");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
    try buf.appendSlice(allocator, "<RestrictionType>");
    try buf.appendSlice(allocator, value.restriction_type.wireName());
    try buf.appendSlice(allocator, "</RestrictionType>");
}

pub fn serializeGeoRestrictionCustomization(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: GeoRestrictionCustomization) !void {
    if (value.locations) |v| {
        try buf.appendSlice(allocator, "<Locations>");
        try serializeLocationList(allocator, buf, v, "Location");
        try buf.appendSlice(allocator, "</Locations>");
    }
    try buf.appendSlice(allocator, "<RestrictionType>");
    try buf.appendSlice(allocator, value.restriction_type.wireName());
    try buf.appendSlice(allocator, "</RestrictionType>");
}

pub fn serializeGrpcConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: GrpcConfig) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
}

pub fn serializeHeaders(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Headers) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeHeaderList(allocator, buf, v, "Name");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeImportSource(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ImportSource) !void {
    try buf.appendSlice(allocator, "<SourceARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.source_arn);
    try buf.appendSlice(allocator, "</SourceARN>");
    try buf.appendSlice(allocator, "<SourceType>");
    try buf.appendSlice(allocator, value.source_type.wireName());
    try buf.appendSlice(allocator, "</SourceType>");
}

pub fn serializeInvalidationBatch(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: InvalidationBatch) !void {
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    try buf.appendSlice(allocator, "<Paths>");
    try serializePaths(allocator, buf, value.paths);
    try buf.appendSlice(allocator, "</Paths>");
}

pub fn serializeIpamCidrConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IpamCidrConfig) !void {
    if (value.anycast_ip) |v| {
        try buf.appendSlice(allocator, "<AnycastIp>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AnycastIp>");
    }
    try buf.appendSlice(allocator, "<Cidr>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.cidr);
    try buf.appendSlice(allocator, "</Cidr>");
    try buf.appendSlice(allocator, "<IpamPoolArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.ipam_pool_arn);
    try buf.appendSlice(allocator, "</IpamPoolArn>");
    if (value.status) |v| {
        try buf.appendSlice(allocator, "<Status>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Status>");
    }
}

pub fn serializeKeyGroupConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: KeyGroupConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    try buf.appendSlice(allocator, "<Items>");
    try serializePublicKeyIdList(allocator, buf, value.items, "PublicKey");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
}

pub fn serializeKeyValueStoreAssociation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: KeyValueStoreAssociation) !void {
    try buf.appendSlice(allocator, "<KeyValueStoreARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key_value_store_arn);
    try buf.appendSlice(allocator, "</KeyValueStoreARN>");
}

pub fn serializeKeyValueStoreAssociations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: KeyValueStoreAssociations) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeKeyValueStoreAssociationList(allocator, buf, v, "KeyValueStoreAssociation");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeKinesisStreamConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: KinesisStreamConfig) !void {
    try buf.appendSlice(allocator, "<RoleARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.role_arn);
    try buf.appendSlice(allocator, "</RoleARN>");
    try buf.appendSlice(allocator, "<StreamARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.stream_arn);
    try buf.appendSlice(allocator, "</StreamARN>");
}

pub fn serializeLambdaFunctionAssociation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaFunctionAssociation) !void {
    try buf.appendSlice(allocator, "<EventType>");
    try buf.appendSlice(allocator, value.event_type.wireName());
    try buf.appendSlice(allocator, "</EventType>");
    if (value.include_body) |v| {
        try buf.appendSlice(allocator, "<IncludeBody>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IncludeBody>");
    }
    try buf.appendSlice(allocator, "<LambdaFunctionARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.lambda_function_arn);
    try buf.appendSlice(allocator, "</LambdaFunctionARN>");
}

pub fn serializeLambdaFunctionAssociations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LambdaFunctionAssociations) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeLambdaFunctionAssociationList(allocator, buf, v, "LambdaFunctionAssociation");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeLoggingConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoggingConfig) !void {
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    try buf.appendSlice(allocator, "<IncludeCookies>");
    try buf.appendSlice(allocator, if (value.include_cookies) "true" else "false");
    try buf.appendSlice(allocator, "</IncludeCookies>");
    try buf.appendSlice(allocator, "<Prefix>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.prefix);
    try buf.appendSlice(allocator, "</Prefix>");
}

pub fn serializeManagedCertificateRequest(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ManagedCertificateRequest) !void {
    if (value.certificate_transparency_logging_preference) |v| {
        try buf.appendSlice(allocator, "<CertificateTransparencyLoggingPreference>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</CertificateTransparencyLoggingPreference>");
    }
    if (value.primary_domain_name) |v| {
        try buf.appendSlice(allocator, "<PrimaryDomainName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PrimaryDomainName>");
    }
    try buf.appendSlice(allocator, "<ValidationTokenHost>");
    try buf.appendSlice(allocator, value.validation_token_host.wireName());
    try buf.appendSlice(allocator, "</ValidationTokenHost>");
}

pub fn serializeMonitoringSubscription(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MonitoringSubscription) !void {
    if (value.realtime_metrics_subscription_config) |v| {
        try buf.appendSlice(allocator, "<RealtimeMetricsSubscriptionConfig>");
        try serializeRealtimeMetricsSubscriptionConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</RealtimeMetricsSubscriptionConfig>");
    }
}

pub fn serializeOrigin(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Origin) !void {
    if (value.connection_attempts) |v| {
        try buf.appendSlice(allocator, "<ConnectionAttempts>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ConnectionAttempts>");
    }
    if (value.connection_timeout) |v| {
        try buf.appendSlice(allocator, "<ConnectionTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ConnectionTimeout>");
    }
    if (value.custom_headers) |v| {
        try buf.appendSlice(allocator, "<CustomHeaders>");
        try serializeCustomHeaders(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomHeaders>");
    }
    if (value.custom_origin_config) |v| {
        try buf.appendSlice(allocator, "<CustomOriginConfig>");
        try serializeCustomOriginConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomOriginConfig>");
    }
    try buf.appendSlice(allocator, "<DomainName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.domain_name);
    try buf.appendSlice(allocator, "</DomainName>");
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    if (value.origin_access_control_id) |v| {
        try buf.appendSlice(allocator, "<OriginAccessControlId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginAccessControlId>");
    }
    if (value.origin_path) |v| {
        try buf.appendSlice(allocator, "<OriginPath>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginPath>");
    }
    if (value.origin_shield) |v| {
        try buf.appendSlice(allocator, "<OriginShield>");
        try serializeOriginShield(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginShield>");
    }
    if (value.response_completion_timeout) |v| {
        try buf.appendSlice(allocator, "<ResponseCompletionTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</ResponseCompletionTimeout>");
    }
    if (value.s3_origin_config) |v| {
        try buf.appendSlice(allocator, "<S3OriginConfig>");
        try serializeS3OriginConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</S3OriginConfig>");
    }
    if (value.vpc_origin_config) |v| {
        try buf.appendSlice(allocator, "<VpcOriginConfig>");
        try serializeVpcOriginConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</VpcOriginConfig>");
    }
}

pub fn serializeOriginAccessControlConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginAccessControlConfig) !void {
    if (value.description) |v| {
        try buf.appendSlice(allocator, "<Description>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Description>");
    }
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<OriginAccessControlOriginType>");
    try buf.appendSlice(allocator, value.origin_access_control_origin_type.wireName());
    try buf.appendSlice(allocator, "</OriginAccessControlOriginType>");
    try buf.appendSlice(allocator, "<SigningBehavior>");
    try buf.appendSlice(allocator, value.signing_behavior.wireName());
    try buf.appendSlice(allocator, "</SigningBehavior>");
    try buf.appendSlice(allocator, "<SigningProtocol>");
    try buf.appendSlice(allocator, value.signing_protocol.wireName());
    try buf.appendSlice(allocator, "</SigningProtocol>");
}

pub fn serializeOriginCustomHeader(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginCustomHeader) !void {
    try buf.appendSlice(allocator, "<HeaderName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header_name);
    try buf.appendSlice(allocator, "</HeaderName>");
    try buf.appendSlice(allocator, "<HeaderValue>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header_value);
    try buf.appendSlice(allocator, "</HeaderValue>");
}

pub fn serializeOriginGroup(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroup) !void {
    try buf.appendSlice(allocator, "<FailoverCriteria>");
    try serializeOriginGroupFailoverCriteria(allocator, buf, value.failover_criteria);
    try buf.appendSlice(allocator, "</FailoverCriteria>");
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    try buf.appendSlice(allocator, "<Members>");
    try serializeOriginGroupMembers(allocator, buf, value.members);
    try buf.appendSlice(allocator, "</Members>");
    if (value.selection_criteria) |v| {
        try buf.appendSlice(allocator, "<SelectionCriteria>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</SelectionCriteria>");
    }
}

pub fn serializeOriginGroupFailoverCriteria(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroupFailoverCriteria) !void {
    try buf.appendSlice(allocator, "<StatusCodes>");
    try serializeStatusCodes(allocator, buf, value.status_codes);
    try buf.appendSlice(allocator, "</StatusCodes>");
}

pub fn serializeOriginGroupMember(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroupMember) !void {
    try buf.appendSlice(allocator, "<OriginId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.origin_id);
    try buf.appendSlice(allocator, "</OriginId>");
}

pub fn serializeOriginGroupMembers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroupMembers) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeOriginGroupMemberList(allocator, buf, value.items, "OriginGroupMember");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeOriginGroups(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginGroups) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeOriginGroupList(allocator, buf, v, "OriginGroup");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeOriginMtlsConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginMtlsConfig) !void {
    try buf.appendSlice(allocator, "<ClientCertificateArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.client_certificate_arn);
    try buf.appendSlice(allocator, "</ClientCertificateArn>");
}

pub fn serializeOriginRequestPolicyConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    try buf.appendSlice(allocator, "<CookiesConfig>");
    try serializeOriginRequestPolicyCookiesConfig(allocator, buf, value.cookies_config);
    try buf.appendSlice(allocator, "</CookiesConfig>");
    try buf.appendSlice(allocator, "<HeadersConfig>");
    try serializeOriginRequestPolicyHeadersConfig(allocator, buf, value.headers_config);
    try buf.appendSlice(allocator, "</HeadersConfig>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<QueryStringsConfig>");
    try serializeOriginRequestPolicyQueryStringsConfig(allocator, buf, value.query_strings_config);
    try buf.appendSlice(allocator, "</QueryStringsConfig>");
}

pub fn serializeOriginRequestPolicyCookiesConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyCookiesConfig) !void {
    try buf.appendSlice(allocator, "<CookieBehavior>");
    try buf.appendSlice(allocator, value.cookie_behavior.wireName());
    try buf.appendSlice(allocator, "</CookieBehavior>");
    if (value.cookies) |v| {
        try buf.appendSlice(allocator, "<Cookies>");
        try serializeCookieNames(allocator, buf, v);
        try buf.appendSlice(allocator, "</Cookies>");
    }
}

pub fn serializeOriginRequestPolicyHeadersConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyHeadersConfig) !void {
    try buf.appendSlice(allocator, "<HeaderBehavior>");
    try buf.appendSlice(allocator, value.header_behavior.wireName());
    try buf.appendSlice(allocator, "</HeaderBehavior>");
    if (value.headers) |v| {
        try buf.appendSlice(allocator, "<Headers>");
        try serializeHeaders(allocator, buf, v);
        try buf.appendSlice(allocator, "</Headers>");
    }
}

pub fn serializeOriginRequestPolicyQueryStringsConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginRequestPolicyQueryStringsConfig) !void {
    try buf.appendSlice(allocator, "<QueryStringBehavior>");
    try buf.appendSlice(allocator, value.query_string_behavior.wireName());
    try buf.appendSlice(allocator, "</QueryStringBehavior>");
    if (value.query_strings) |v| {
        try buf.appendSlice(allocator, "<QueryStrings>");
        try serializeQueryStringNames(allocator, buf, v);
        try buf.appendSlice(allocator, "</QueryStrings>");
    }
}

pub fn serializeOriginShield(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginShield) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.origin_shield_region) |v| {
        try buf.appendSlice(allocator, "<OriginShieldRegion>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginShieldRegion>");
    }
}

pub fn serializeOriginSslProtocols(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OriginSslProtocols) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeSslProtocolsList(allocator, buf, value.items, "SslProtocol");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeOrigins(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Origins) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeOriginList(allocator, buf, value.items, "Origin");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeParameter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeParameterDefinition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParameterDefinition) !void {
    try buf.appendSlice(allocator, "<Definition>");
    try serializeParameterDefinitionSchema(allocator, buf, value.definition);
    try buf.appendSlice(allocator, "</Definition>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
}

pub fn serializeParameterDefinitionSchema(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParameterDefinitionSchema) !void {
    if (value.string_schema) |v| {
        try buf.appendSlice(allocator, "<StringSchema>");
        try serializeStringSchemaConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</StringSchema>");
    }
}

pub fn serializeParametersInCacheKeyAndForwardedToOrigin(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ParametersInCacheKeyAndForwardedToOrigin) !void {
    try buf.appendSlice(allocator, "<CookiesConfig>");
    try serializeCachePolicyCookiesConfig(allocator, buf, value.cookies_config);
    try buf.appendSlice(allocator, "</CookiesConfig>");
    if (value.enable_accept_encoding_brotli) |v| {
        try buf.appendSlice(allocator, "<EnableAcceptEncodingBrotli>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</EnableAcceptEncodingBrotli>");
    }
    try buf.appendSlice(allocator, "<EnableAcceptEncodingGzip>");
    try buf.appendSlice(allocator, if (value.enable_accept_encoding_gzip) "true" else "false");
    try buf.appendSlice(allocator, "</EnableAcceptEncodingGzip>");
    try buf.appendSlice(allocator, "<HeadersConfig>");
    try serializeCachePolicyHeadersConfig(allocator, buf, value.headers_config);
    try buf.appendSlice(allocator, "</HeadersConfig>");
    try buf.appendSlice(allocator, "<QueryStringsConfig>");
    try serializeCachePolicyQueryStringsConfig(allocator, buf, value.query_strings_config);
    try buf.appendSlice(allocator, "</QueryStringsConfig>");
}

pub fn serializePaths(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Paths) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializePathList(allocator, buf, v, "Path");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializePublicKeyConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PublicKeyConfig) !void {
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    try buf.appendSlice(allocator, "<EncodedKey>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.encoded_key);
    try buf.appendSlice(allocator, "</EncodedKey>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
}

pub fn serializeQueryArgProfile(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryArgProfile) !void {
    try buf.appendSlice(allocator, "<ProfileId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.profile_id);
    try buf.appendSlice(allocator, "</ProfileId>");
    try buf.appendSlice(allocator, "<QueryArg>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.query_arg);
    try buf.appendSlice(allocator, "</QueryArg>");
}

pub fn serializeQueryArgProfileConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryArgProfileConfig) !void {
    try buf.appendSlice(allocator, "<ForwardWhenQueryArgProfileIsUnknown>");
    try buf.appendSlice(allocator, if (value.forward_when_query_arg_profile_is_unknown) "true" else "false");
    try buf.appendSlice(allocator, "</ForwardWhenQueryArgProfileIsUnknown>");
    if (value.query_arg_profiles) |v| {
        try buf.appendSlice(allocator, "<QueryArgProfiles>");
        try serializeQueryArgProfiles(allocator, buf, v);
        try buf.appendSlice(allocator, "</QueryArgProfiles>");
    }
}

pub fn serializeQueryArgProfiles(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryArgProfiles) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeQueryArgProfileList(allocator, buf, v, "QueryArgProfile");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeQueryStringCacheKeys(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringCacheKeys) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeQueryStringCacheKeysList(allocator, buf, v, "Name");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeQueryStringNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: QueryStringNames) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeQueryStringNamesList(allocator, buf, v, "Name");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeRealtimeMetricsSubscriptionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RealtimeMetricsSubscriptionConfig) !void {
    try buf.appendSlice(allocator, "<RealtimeMetricsSubscriptionStatus>");
    try buf.appendSlice(allocator, value.realtime_metrics_subscription_status.wireName());
    try buf.appendSlice(allocator, "</RealtimeMetricsSubscriptionStatus>");
}

pub fn serializeResponseHeadersPolicyAccessControlAllowHeaders(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlAllowHeaders) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeAccessControlAllowHeadersList(allocator, buf, value.items, "Header");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyAccessControlAllowMethods(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlAllowMethods) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeAccessControlAllowMethodsList(allocator, buf, value.items, "Method");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyAccessControlAllowOrigins(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlAllowOrigins) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeAccessControlAllowOriginsList(allocator, buf, value.items, "Origin");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyAccessControlExposeHeaders(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyAccessControlExposeHeaders) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeAccessControlExposeHeadersList(allocator, buf, v, "Header");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    if (value.cors_config) |v| {
        try buf.appendSlice(allocator, "<CorsConfig>");
        try serializeResponseHeadersPolicyCorsConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</CorsConfig>");
    }
    if (value.custom_headers_config) |v| {
        try buf.appendSlice(allocator, "<CustomHeadersConfig>");
        try serializeResponseHeadersPolicyCustomHeadersConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</CustomHeadersConfig>");
    }
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.remove_headers_config) |v| {
        try buf.appendSlice(allocator, "<RemoveHeadersConfig>");
        try serializeResponseHeadersPolicyRemoveHeadersConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</RemoveHeadersConfig>");
    }
    if (value.security_headers_config) |v| {
        try buf.appendSlice(allocator, "<SecurityHeadersConfig>");
        try serializeResponseHeadersPolicySecurityHeadersConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</SecurityHeadersConfig>");
    }
    if (value.server_timing_headers_config) |v| {
        try buf.appendSlice(allocator, "<ServerTimingHeadersConfig>");
        try serializeResponseHeadersPolicyServerTimingHeadersConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</ServerTimingHeadersConfig>");
    }
}

pub fn serializeResponseHeadersPolicyContentSecurityPolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyContentSecurityPolicy) !void {
    try buf.appendSlice(allocator, "<ContentSecurityPolicy>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.content_security_policy);
    try buf.appendSlice(allocator, "</ContentSecurityPolicy>");
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
}

pub fn serializeResponseHeadersPolicyContentTypeOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyContentTypeOptions) !void {
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
}

pub fn serializeResponseHeadersPolicyCorsConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyCorsConfig) !void {
    try buf.appendSlice(allocator, "<AccessControlAllowCredentials>");
    try buf.appendSlice(allocator, if (value.access_control_allow_credentials) "true" else "false");
    try buf.appendSlice(allocator, "</AccessControlAllowCredentials>");
    try buf.appendSlice(allocator, "<AccessControlAllowHeaders>");
    try serializeResponseHeadersPolicyAccessControlAllowHeaders(allocator, buf, value.access_control_allow_headers);
    try buf.appendSlice(allocator, "</AccessControlAllowHeaders>");
    try buf.appendSlice(allocator, "<AccessControlAllowMethods>");
    try serializeResponseHeadersPolicyAccessControlAllowMethods(allocator, buf, value.access_control_allow_methods);
    try buf.appendSlice(allocator, "</AccessControlAllowMethods>");
    try buf.appendSlice(allocator, "<AccessControlAllowOrigins>");
    try serializeResponseHeadersPolicyAccessControlAllowOrigins(allocator, buf, value.access_control_allow_origins);
    try buf.appendSlice(allocator, "</AccessControlAllowOrigins>");
    if (value.access_control_expose_headers) |v| {
        try buf.appendSlice(allocator, "<AccessControlExposeHeaders>");
        try serializeResponseHeadersPolicyAccessControlExposeHeaders(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccessControlExposeHeaders>");
    }
    if (value.access_control_max_age_sec) |v| {
        try buf.appendSlice(allocator, "<AccessControlMaxAgeSec>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</AccessControlMaxAgeSec>");
    }
    try buf.appendSlice(allocator, "<OriginOverride>");
    try buf.appendSlice(allocator, if (value.origin_override) "true" else "false");
    try buf.appendSlice(allocator, "</OriginOverride>");
}

pub fn serializeResponseHeadersPolicyCustomHeader(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyCustomHeader) !void {
    try buf.appendSlice(allocator, "<Header>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header);
    try buf.appendSlice(allocator, "</Header>");
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeResponseHeadersPolicyCustomHeadersConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyCustomHeadersConfig) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeResponseHeadersPolicyCustomHeaderList(allocator, buf, v, "ResponseHeadersPolicyCustomHeader");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeResponseHeadersPolicyFrameOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyFrameOptions) !void {
    try buf.appendSlice(allocator, "<FrameOption>");
    try buf.appendSlice(allocator, value.frame_option.wireName());
    try buf.appendSlice(allocator, "</FrameOption>");
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
}

pub fn serializeResponseHeadersPolicyReferrerPolicy(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyReferrerPolicy) !void {
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
    try buf.appendSlice(allocator, "<ReferrerPolicy>");
    try buf.appendSlice(allocator, value.referrer_policy.wireName());
    try buf.appendSlice(allocator, "</ReferrerPolicy>");
}

pub fn serializeResponseHeadersPolicyRemoveHeader(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyRemoveHeader) !void {
    try buf.appendSlice(allocator, "<Header>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.header);
    try buf.appendSlice(allocator, "</Header>");
}

pub fn serializeResponseHeadersPolicyRemoveHeadersConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyRemoveHeadersConfig) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeResponseHeadersPolicyRemoveHeaderList(allocator, buf, v, "ResponseHeadersPolicyRemoveHeader");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeResponseHeadersPolicySecurityHeadersConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicySecurityHeadersConfig) !void {
    if (value.content_security_policy) |v| {
        try buf.appendSlice(allocator, "<ContentSecurityPolicy>");
        try serializeResponseHeadersPolicyContentSecurityPolicy(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentSecurityPolicy>");
    }
    if (value.content_type_options) |v| {
        try buf.appendSlice(allocator, "<ContentTypeOptions>");
        try serializeResponseHeadersPolicyContentTypeOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContentTypeOptions>");
    }
    if (value.frame_options) |v| {
        try buf.appendSlice(allocator, "<FrameOptions>");
        try serializeResponseHeadersPolicyFrameOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</FrameOptions>");
    }
    if (value.referrer_policy) |v| {
        try buf.appendSlice(allocator, "<ReferrerPolicy>");
        try serializeResponseHeadersPolicyReferrerPolicy(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReferrerPolicy>");
    }
    if (value.strict_transport_security) |v| {
        try buf.appendSlice(allocator, "<StrictTransportSecurity>");
        try serializeResponseHeadersPolicyStrictTransportSecurity(allocator, buf, v);
        try buf.appendSlice(allocator, "</StrictTransportSecurity>");
    }
    if (value.xss_protection) |v| {
        try buf.appendSlice(allocator, "<XSSProtection>");
        try serializeResponseHeadersPolicyXSSProtection(allocator, buf, v);
        try buf.appendSlice(allocator, "</XSSProtection>");
    }
}

pub fn serializeResponseHeadersPolicyServerTimingHeadersConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyServerTimingHeadersConfig) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.sampling_rate) |v| {
        try buf.appendSlice(allocator, "<SamplingRate>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</SamplingRate>");
    }
}

pub fn serializeResponseHeadersPolicyStrictTransportSecurity(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyStrictTransportSecurity) !void {
    try buf.appendSlice(allocator, "<AccessControlMaxAgeSec>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.access_control_max_age_sec}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</AccessControlMaxAgeSec>");
    if (value.include_subdomains) |v| {
        try buf.appendSlice(allocator, "<IncludeSubdomains>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IncludeSubdomains>");
    }
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
    if (value.preload) |v| {
        try buf.appendSlice(allocator, "<Preload>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Preload>");
    }
}

pub fn serializeResponseHeadersPolicyXSSProtection(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResponseHeadersPolicyXSSProtection) !void {
    if (value.mode_block) |v| {
        try buf.appendSlice(allocator, "<ModeBlock>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ModeBlock>");
    }
    try buf.appendSlice(allocator, "<Override>");
    try buf.appendSlice(allocator, if (value.override) "true" else "false");
    try buf.appendSlice(allocator, "</Override>");
    try buf.appendSlice(allocator, "<Protection>");
    try buf.appendSlice(allocator, if (value.protection) "true" else "false");
    try buf.appendSlice(allocator, "</Protection>");
    if (value.report_uri) |v| {
        try buf.appendSlice(allocator, "<ReportUri>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ReportUri>");
    }
}

pub fn serializeRestrictions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Restrictions) !void {
    try buf.appendSlice(allocator, "<GeoRestriction>");
    try serializeGeoRestriction(allocator, buf, value.geo_restriction);
    try buf.appendSlice(allocator, "</GeoRestriction>");
}

pub fn serializeS3Origin(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3Origin) !void {
    try buf.appendSlice(allocator, "<DomainName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.domain_name);
    try buf.appendSlice(allocator, "</DomainName>");
    try buf.appendSlice(allocator, "<OriginAccessIdentity>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.origin_access_identity);
    try buf.appendSlice(allocator, "</OriginAccessIdentity>");
}

pub fn serializeS3OriginConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: S3OriginConfig) !void {
    try buf.appendSlice(allocator, "<OriginAccessIdentity>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.origin_access_identity);
    try buf.appendSlice(allocator, "</OriginAccessIdentity>");
    if (value.origin_read_timeout) |v| {
        try buf.appendSlice(allocator, "<OriginReadTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OriginReadTimeout>");
    }
}

pub fn serializeSessionStickinessConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SessionStickinessConfig) !void {
    try buf.appendSlice(allocator, "<IdleTTL>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.idle_ttl}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</IdleTTL>");
    try buf.appendSlice(allocator, "<MaximumTTL>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.maximum_ttl}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</MaximumTTL>");
}

pub fn serializeStagingDistributionDnsNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StagingDistributionDnsNames) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeStagingDistributionDnsNameList(allocator, buf, v, "DnsName");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeStatusCodes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StatusCodes) !void {
    try buf.appendSlice(allocator, "<Items>");
    try serializeStatusCodeList(allocator, buf, value.items, "StatusCode");
    try buf.appendSlice(allocator, "</Items>");
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeStreamingDistributionConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StreamingDistributionConfig) !void {
    if (value.aliases) |v| {
        try buf.appendSlice(allocator, "<Aliases>");
        try serializeAliases(allocator, buf, v);
        try buf.appendSlice(allocator, "</Aliases>");
    }
    try buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.caller_reference);
    try buf.appendSlice(allocator, "</CallerReference>");
    try buf.appendSlice(allocator, "<Comment>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.comment);
    try buf.appendSlice(allocator, "</Comment>");
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.logging) |v| {
        try buf.appendSlice(allocator, "<Logging>");
        try serializeStreamingLoggingConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</Logging>");
    }
    if (value.price_class) |v| {
        try buf.appendSlice(allocator, "<PriceClass>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</PriceClass>");
    }
    try buf.appendSlice(allocator, "<S3Origin>");
    try serializeS3Origin(allocator, buf, value.s3_origin);
    try buf.appendSlice(allocator, "</S3Origin>");
    try buf.appendSlice(allocator, "<TrustedSigners>");
    try serializeTrustedSigners(allocator, buf, value.trusted_signers);
    try buf.appendSlice(allocator, "</TrustedSigners>");
}

pub fn serializeStreamingDistributionConfigWithTags(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StreamingDistributionConfigWithTags) !void {
    try buf.appendSlice(allocator, "<StreamingDistributionConfig>");
    try serializeStreamingDistributionConfig(allocator, buf, value.streaming_distribution_config);
    try buf.appendSlice(allocator, "</StreamingDistributionConfig>");
    try buf.appendSlice(allocator, "<Tags>");
    try serializeTags(allocator, buf, value.tags);
    try buf.appendSlice(allocator, "</Tags>");
}

pub fn serializeStreamingLoggingConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StreamingLoggingConfig) !void {
    try buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.bucket);
    try buf.appendSlice(allocator, "</Bucket>");
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    try buf.appendSlice(allocator, "<Prefix>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.prefix);
    try buf.appendSlice(allocator, "</Prefix>");
}

pub fn serializeStringSchemaConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StringSchemaConfig) !void {
    if (value.comment) |v| {
        try buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Comment>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    try buf.appendSlice(allocator, "<Required>");
    try buf.appendSlice(allocator, if (value.required) "true" else "false");
    try buf.appendSlice(allocator, "</Required>");
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeTagKeys(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TagKeys) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeTagKeyList(allocator, buf, v, "Key");
        try buf.appendSlice(allocator, "</Items>");
    }
}

pub fn serializeTags(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tags) !void {
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeTagList(allocator, buf, v, "Tag");
        try buf.appendSlice(allocator, "</Items>");
    }
}

pub fn serializeTenantConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TenantConfig) !void {
    if (value.parameter_definitions) |v| {
        try buf.appendSlice(allocator, "<ParameterDefinitions>");
        try serializeParameterDefinitions(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ParameterDefinitions>");
    }
}

pub fn serializeTrafficConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrafficConfig) !void {
    if (value.single_header_config) |v| {
        try buf.appendSlice(allocator, "<SingleHeaderConfig>");
        try serializeContinuousDeploymentSingleHeaderConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</SingleHeaderConfig>");
    }
    if (value.single_weight_config) |v| {
        try buf.appendSlice(allocator, "<SingleWeightConfig>");
        try serializeContinuousDeploymentSingleWeightConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</SingleWeightConfig>");
    }
    try buf.appendSlice(allocator, "<Type>");
    try buf.appendSlice(allocator, value.@"type".wireName());
    try buf.appendSlice(allocator, "</Type>");
}

pub fn serializeTrustStoreConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrustStoreConfig) !void {
    if (value.advertise_trust_store_ca_names) |v| {
        try buf.appendSlice(allocator, "<AdvertiseTrustStoreCaNames>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</AdvertiseTrustStoreCaNames>");
    }
    if (value.ignore_certificate_expiry) |v| {
        try buf.appendSlice(allocator, "<IgnoreCertificateExpiry>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</IgnoreCertificateExpiry>");
    }
    try buf.appendSlice(allocator, "<TrustStoreId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.trust_store_id);
    try buf.appendSlice(allocator, "</TrustStoreId>");
}

pub fn serializeTrustedKeyGroups(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrustedKeyGroups) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeTrustedKeyGroupIdList(allocator, buf, v, "KeyGroup");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeTrustedSigners(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TrustedSigners) !void {
    try buf.appendSlice(allocator, "<Enabled>");
    try buf.appendSlice(allocator, if (value.enabled) "true" else "false");
    try buf.appendSlice(allocator, "</Enabled>");
    if (value.items) |v| {
        try buf.appendSlice(allocator, "<Items>");
        try serializeAwsAccountNumberList(allocator, buf, v, "AwsAccountNumber");
        try buf.appendSlice(allocator, "</Items>");
    }
    try buf.appendSlice(allocator, "<Quantity>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.quantity}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Quantity>");
}

pub fn serializeViewerCertificate(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ViewerCertificate) !void {
    if (value.acm_certificate_arn) |v| {
        try buf.appendSlice(allocator, "<ACMCertificateArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ACMCertificateArn>");
    }
    if (value.certificate) |v| {
        try buf.appendSlice(allocator, "<Certificate>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Certificate>");
    }
    if (value.certificate_source) |v| {
        try buf.appendSlice(allocator, "<CertificateSource>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</CertificateSource>");
    }
    if (value.cloud_front_default_certificate) |v| {
        try buf.appendSlice(allocator, "<CloudFrontDefaultCertificate>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</CloudFrontDefaultCertificate>");
    }
    if (value.iam_certificate_id) |v| {
        try buf.appendSlice(allocator, "<IAMCertificateId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</IAMCertificateId>");
    }
    if (value.minimum_protocol_version) |v| {
        try buf.appendSlice(allocator, "<MinimumProtocolVersion>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</MinimumProtocolVersion>");
    }
    if (value.ssl_support_method) |v| {
        try buf.appendSlice(allocator, "<SSLSupportMethod>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</SSLSupportMethod>");
    }
}

pub fn serializeViewerMtlsConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ViewerMtlsConfig) !void {
    try buf.appendSlice(allocator, "<Mode>");
    try buf.appendSlice(allocator, value.mode.wireName());
    try buf.appendSlice(allocator, "</Mode>");
    if (value.trust_store_config) |v| {
        try buf.appendSlice(allocator, "<TrustStoreConfig>");
        try serializeTrustStoreConfig(allocator, buf, v);
        try buf.appendSlice(allocator, "</TrustStoreConfig>");
    }
}

pub fn serializeVpcOriginConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: VpcOriginConfig) !void {
    if (value.origin_keepalive_timeout) |v| {
        try buf.appendSlice(allocator, "<OriginKeepaliveTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OriginKeepaliveTimeout>");
    }
    if (value.origin_read_timeout) |v| {
        try buf.appendSlice(allocator, "<OriginReadTimeout>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</OriginReadTimeout>");
    }
    if (value.owner_account_id) |v| {
        try buf.appendSlice(allocator, "<OwnerAccountId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</OwnerAccountId>");
    }
    try buf.appendSlice(allocator, "<VpcOriginId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.vpc_origin_id);
    try buf.appendSlice(allocator, "</VpcOriginId>");
}

pub fn serializeVpcOriginEndpointConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: VpcOriginEndpointConfig) !void {
    try buf.appendSlice(allocator, "<Arn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.arn);
    try buf.appendSlice(allocator, "</Arn>");
    try buf.appendSlice(allocator, "<HTTPPort>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.http_port}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</HTTPPort>");
    try buf.appendSlice(allocator, "<HTTPSPort>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.https_port}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</HTTPSPort>");
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<OriginProtocolPolicy>");
    try buf.appendSlice(allocator, value.origin_protocol_policy.wireName());
    try buf.appendSlice(allocator, "</OriginProtocolPolicy>");
    if (value.origin_ssl_protocols) |v| {
        try buf.appendSlice(allocator, "<OriginSslProtocols>");
        try serializeOriginSslProtocols(allocator, buf, v);
        try buf.appendSlice(allocator, "</OriginSslProtocols>");
    }
}

pub fn serializeWebAclCustomization(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: WebAclCustomization) !void {
    try buf.appendSlice(allocator, "<Action>");
    try buf.appendSlice(allocator, value.action.wireName());
    try buf.appendSlice(allocator, "</Action>");
    if (value.arn) |v| {
        try buf.appendSlice(allocator, "<Arn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Arn>");
    }
}

