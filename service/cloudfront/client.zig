const aws = @import("aws");
const std = @import("std");

const associate_alias = @import("associate_alias.zig");
const associate_distribution_tenant_web_acl = @import("associate_distribution_tenant_web_acl.zig");
const associate_distribution_web_acl = @import("associate_distribution_web_acl.zig");
const copy_distribution = @import("copy_distribution.zig");
const create_anycast_ip_list = @import("create_anycast_ip_list.zig");
const create_cache_policy = @import("create_cache_policy.zig");
const create_cloud_front_origin_access_identity = @import("create_cloud_front_origin_access_identity.zig");
const create_connection_function = @import("create_connection_function.zig");
const create_connection_group = @import("create_connection_group.zig");
const create_continuous_deployment_policy = @import("create_continuous_deployment_policy.zig");
const create_distribution = @import("create_distribution.zig");
const create_distribution_tenant = @import("create_distribution_tenant.zig");
const create_distribution_with_tags = @import("create_distribution_with_tags.zig");
const create_field_level_encryption_config = @import("create_field_level_encryption_config.zig");
const create_field_level_encryption_profile = @import("create_field_level_encryption_profile.zig");
const create_function = @import("create_function.zig");
const create_invalidation = @import("create_invalidation.zig");
const create_invalidation_for_distribution_tenant = @import("create_invalidation_for_distribution_tenant.zig");
const create_key_group = @import("create_key_group.zig");
const create_key_value_store = @import("create_key_value_store.zig");
const create_monitoring_subscription = @import("create_monitoring_subscription.zig");
const create_origin_access_control = @import("create_origin_access_control.zig");
const create_origin_request_policy = @import("create_origin_request_policy.zig");
const create_public_key = @import("create_public_key.zig");
const create_realtime_log_config = @import("create_realtime_log_config.zig");
const create_response_headers_policy = @import("create_response_headers_policy.zig");
const create_streaming_distribution = @import("create_streaming_distribution.zig");
const create_streaming_distribution_with_tags = @import("create_streaming_distribution_with_tags.zig");
const create_trust_store = @import("create_trust_store.zig");
const create_vpc_origin = @import("create_vpc_origin.zig");
const delete_anycast_ip_list = @import("delete_anycast_ip_list.zig");
const delete_cache_policy = @import("delete_cache_policy.zig");
const delete_cloud_front_origin_access_identity = @import("delete_cloud_front_origin_access_identity.zig");
const delete_connection_function = @import("delete_connection_function.zig");
const delete_connection_group = @import("delete_connection_group.zig");
const delete_continuous_deployment_policy = @import("delete_continuous_deployment_policy.zig");
const delete_distribution = @import("delete_distribution.zig");
const delete_distribution_tenant = @import("delete_distribution_tenant.zig");
const delete_field_level_encryption_config = @import("delete_field_level_encryption_config.zig");
const delete_field_level_encryption_profile = @import("delete_field_level_encryption_profile.zig");
const delete_function = @import("delete_function.zig");
const delete_key_group = @import("delete_key_group.zig");
const delete_key_value_store = @import("delete_key_value_store.zig");
const delete_monitoring_subscription = @import("delete_monitoring_subscription.zig");
const delete_origin_access_control = @import("delete_origin_access_control.zig");
const delete_origin_request_policy = @import("delete_origin_request_policy.zig");
const delete_public_key = @import("delete_public_key.zig");
const delete_realtime_log_config = @import("delete_realtime_log_config.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_response_headers_policy = @import("delete_response_headers_policy.zig");
const delete_streaming_distribution = @import("delete_streaming_distribution.zig");
const delete_trust_store = @import("delete_trust_store.zig");
const delete_vpc_origin = @import("delete_vpc_origin.zig");
const describe_connection_function = @import("describe_connection_function.zig");
const describe_function = @import("describe_function.zig");
const describe_key_value_store = @import("describe_key_value_store.zig");
const disassociate_distribution_tenant_web_acl = @import("disassociate_distribution_tenant_web_acl.zig");
const disassociate_distribution_web_acl = @import("disassociate_distribution_web_acl.zig");
const get_anycast_ip_list = @import("get_anycast_ip_list.zig");
const get_cache_policy = @import("get_cache_policy.zig");
const get_cache_policy_config = @import("get_cache_policy_config.zig");
const get_cloud_front_origin_access_identity = @import("get_cloud_front_origin_access_identity.zig");
const get_cloud_front_origin_access_identity_config = @import("get_cloud_front_origin_access_identity_config.zig");
const get_connection_function = @import("get_connection_function.zig");
const get_connection_group = @import("get_connection_group.zig");
const get_connection_group_by_routing_endpoint = @import("get_connection_group_by_routing_endpoint.zig");
const get_continuous_deployment_policy = @import("get_continuous_deployment_policy.zig");
const get_continuous_deployment_policy_config = @import("get_continuous_deployment_policy_config.zig");
const get_distribution = @import("get_distribution.zig");
const get_distribution_config = @import("get_distribution_config.zig");
const get_distribution_tenant = @import("get_distribution_tenant.zig");
const get_distribution_tenant_by_domain = @import("get_distribution_tenant_by_domain.zig");
const get_field_level_encryption = @import("get_field_level_encryption.zig");
const get_field_level_encryption_config = @import("get_field_level_encryption_config.zig");
const get_field_level_encryption_profile = @import("get_field_level_encryption_profile.zig");
const get_field_level_encryption_profile_config = @import("get_field_level_encryption_profile_config.zig");
const get_function = @import("get_function.zig");
const get_invalidation = @import("get_invalidation.zig");
const get_invalidation_for_distribution_tenant = @import("get_invalidation_for_distribution_tenant.zig");
const get_key_group = @import("get_key_group.zig");
const get_key_group_config = @import("get_key_group_config.zig");
const get_managed_certificate_details = @import("get_managed_certificate_details.zig");
const get_monitoring_subscription = @import("get_monitoring_subscription.zig");
const get_origin_access_control = @import("get_origin_access_control.zig");
const get_origin_access_control_config = @import("get_origin_access_control_config.zig");
const get_origin_request_policy = @import("get_origin_request_policy.zig");
const get_origin_request_policy_config = @import("get_origin_request_policy_config.zig");
const get_public_key = @import("get_public_key.zig");
const get_public_key_config = @import("get_public_key_config.zig");
const get_realtime_log_config = @import("get_realtime_log_config.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_response_headers_policy = @import("get_response_headers_policy.zig");
const get_response_headers_policy_config = @import("get_response_headers_policy_config.zig");
const get_streaming_distribution = @import("get_streaming_distribution.zig");
const get_streaming_distribution_config = @import("get_streaming_distribution_config.zig");
const get_trust_store = @import("get_trust_store.zig");
const get_vpc_origin = @import("get_vpc_origin.zig");
const list_anycast_ip_lists = @import("list_anycast_ip_lists.zig");
const list_cache_policies = @import("list_cache_policies.zig");
const list_cloud_front_origin_access_identities = @import("list_cloud_front_origin_access_identities.zig");
const list_conflicting_aliases = @import("list_conflicting_aliases.zig");
const list_connection_functions = @import("list_connection_functions.zig");
const list_connection_groups = @import("list_connection_groups.zig");
const list_continuous_deployment_policies = @import("list_continuous_deployment_policies.zig");
const list_distribution_tenants = @import("list_distribution_tenants.zig");
const list_distribution_tenants_by_customization = @import("list_distribution_tenants_by_customization.zig");
const list_distributions = @import("list_distributions.zig");
const list_distributions_by_anycast_ip_list_id = @import("list_distributions_by_anycast_ip_list_id.zig");
const list_distributions_by_cache_policy_id = @import("list_distributions_by_cache_policy_id.zig");
const list_distributions_by_connection_function = @import("list_distributions_by_connection_function.zig");
const list_distributions_by_connection_mode = @import("list_distributions_by_connection_mode.zig");
const list_distributions_by_key_group = @import("list_distributions_by_key_group.zig");
const list_distributions_by_origin_request_policy_id = @import("list_distributions_by_origin_request_policy_id.zig");
const list_distributions_by_owned_resource = @import("list_distributions_by_owned_resource.zig");
const list_distributions_by_realtime_log_config = @import("list_distributions_by_realtime_log_config.zig");
const list_distributions_by_response_headers_policy_id = @import("list_distributions_by_response_headers_policy_id.zig");
const list_distributions_by_trust_store = @import("list_distributions_by_trust_store.zig");
const list_distributions_by_vpc_origin_id = @import("list_distributions_by_vpc_origin_id.zig");
const list_distributions_by_web_acl_id = @import("list_distributions_by_web_acl_id.zig");
const list_domain_conflicts = @import("list_domain_conflicts.zig");
const list_field_level_encryption_configs = @import("list_field_level_encryption_configs.zig");
const list_field_level_encryption_profiles = @import("list_field_level_encryption_profiles.zig");
const list_functions = @import("list_functions.zig");
const list_invalidations = @import("list_invalidations.zig");
const list_invalidations_for_distribution_tenant = @import("list_invalidations_for_distribution_tenant.zig");
const list_key_groups = @import("list_key_groups.zig");
const list_key_value_stores = @import("list_key_value_stores.zig");
const list_origin_access_controls = @import("list_origin_access_controls.zig");
const list_origin_request_policies = @import("list_origin_request_policies.zig");
const list_public_keys = @import("list_public_keys.zig");
const list_realtime_log_configs = @import("list_realtime_log_configs.zig");
const list_response_headers_policies = @import("list_response_headers_policies.zig");
const list_streaming_distributions = @import("list_streaming_distributions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_trust_stores = @import("list_trust_stores.zig");
const list_vpc_origins = @import("list_vpc_origins.zig");
const publish_connection_function = @import("publish_connection_function.zig");
const publish_function = @import("publish_function.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const tag_resource = @import("tag_resource.zig");
const test_connection_function = @import("test_connection_function.zig");
const test_function = @import("test_function.zig");
const untag_resource = @import("untag_resource.zig");
const update_anycast_ip_list = @import("update_anycast_ip_list.zig");
const update_cache_policy = @import("update_cache_policy.zig");
const update_cloud_front_origin_access_identity = @import("update_cloud_front_origin_access_identity.zig");
const update_connection_function = @import("update_connection_function.zig");
const update_connection_group = @import("update_connection_group.zig");
const update_continuous_deployment_policy = @import("update_continuous_deployment_policy.zig");
const update_distribution = @import("update_distribution.zig");
const update_distribution_tenant = @import("update_distribution_tenant.zig");
const update_distribution_with_staging_config = @import("update_distribution_with_staging_config.zig");
const update_domain_association = @import("update_domain_association.zig");
const update_field_level_encryption_config = @import("update_field_level_encryption_config.zig");
const update_field_level_encryption_profile = @import("update_field_level_encryption_profile.zig");
const update_function = @import("update_function.zig");
const update_key_group = @import("update_key_group.zig");
const update_key_value_store = @import("update_key_value_store.zig");
const update_origin_access_control = @import("update_origin_access_control.zig");
const update_origin_request_policy = @import("update_origin_request_policy.zig");
const update_public_key = @import("update_public_key.zig");
const update_realtime_log_config = @import("update_realtime_log_config.zig");
const update_response_headers_policy = @import("update_response_headers_policy.zig");
const update_streaming_distribution = @import("update_streaming_distribution.zig");
const update_trust_store = @import("update_trust_store.zig");
const update_vpc_origin = @import("update_vpc_origin.zig");
const verify_dns_configuration = @import("verify_dns_configuration.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudFront";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// The `AssociateAlias` API operation only supports standard distributions. To
    /// move domains between distribution tenants and/or standard distributions, we
    /// recommend that you use the
    /// [UpdateDomainAssociation](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDomainAssociation.html) API operation instead.
    ///
    /// Associates an alias with a CloudFront standard distribution. An alias is
    /// commonly known as a custom domain or vanity domain. It can also be called a
    /// CNAME or alternate domain name.
    ///
    /// With this operation, you can move an alias that's already used for a
    /// standard distribution to a different standard distribution. This prevents
    /// the downtime that could occur if you first remove the alias from one
    /// standard distribution and then separately add the alias to another standard
    /// distribution.
    ///
    /// To use this operation, specify the alias and the ID of the target standard
    /// distribution.
    ///
    /// For more information, including how to set up the target standard
    /// distribution, prerequisites that you must complete, and other restrictions,
    /// see [Moving an alternate domain name to a different standard distribution or
    /// distribution
    /// tenant](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/CNAMEs.html#alternate-domain-names-move) in the *Amazon CloudFront Developer Guide*.
    pub fn associateAlias(self: *Self, allocator: std.mem.Allocator, input: associate_alias.AssociateAliasInput, options: associate_alias.Options) !associate_alias.AssociateAliasOutput {
        return associate_alias.execute(self, allocator, input, options);
    }

    /// Associates the WAF web ACL with a distribution tenant.
    pub fn associateDistributionTenantWebAcl(self: *Self, allocator: std.mem.Allocator, input: associate_distribution_tenant_web_acl.AssociateDistributionTenantWebACLInput, options: associate_distribution_tenant_web_acl.Options) !associate_distribution_tenant_web_acl.AssociateDistributionTenantWebACLOutput {
        return associate_distribution_tenant_web_acl.execute(self, allocator, input, options);
    }

    /// Associates the WAF web ACL with a distribution.
    pub fn associateDistributionWebAcl(self: *Self, allocator: std.mem.Allocator, input: associate_distribution_web_acl.AssociateDistributionWebACLInput, options: associate_distribution_web_acl.Options) !associate_distribution_web_acl.AssociateDistributionWebACLOutput {
        return associate_distribution_web_acl.execute(self, allocator, input, options);
    }

    /// Creates a staging distribution using the configuration of the provided
    /// primary distribution. A staging distribution is a copy of an existing
    /// distribution (called the primary distribution) that you can use in a
    /// continuous deployment workflow.
    ///
    /// After you create a staging distribution, you can use `UpdateDistribution` to
    /// modify the staging distribution's configuration. Then you can use
    /// `CreateContinuousDeploymentPolicy` to incrementally move traffic to the
    /// staging distribution.
    ///
    /// This API operation requires the following IAM permissions:
    ///
    /// *
    ///   [GetDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_GetDistribution.html)
    /// *
    ///   [CreateDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_CreateDistribution.html)
    /// *
    ///   [CopyDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_CopyDistribution.html)
    pub fn copyDistribution(self: *Self, allocator: std.mem.Allocator, input: copy_distribution.CopyDistributionInput, options: copy_distribution.Options) !copy_distribution.CopyDistributionOutput {
        return copy_distribution.execute(self, allocator, input, options);
    }

    /// Creates an Anycast static IP list.
    pub fn createAnycastIpList(self: *Self, allocator: std.mem.Allocator, input: create_anycast_ip_list.CreateAnycastIpListInput, options: create_anycast_ip_list.Options) !create_anycast_ip_list.CreateAnycastIpListOutput {
        return create_anycast_ip_list.execute(self, allocator, input, options);
    }

    /// Creates a cache policy.
    ///
    /// After you create a cache policy, you can attach it to one or more cache
    /// behaviors. When it's attached to a cache behavior, the cache policy
    /// determines the following:
    ///
    /// * The values that CloudFront includes in the *cache key*. These values can
    ///   include HTTP headers, cookies, and URL query strings. CloudFront uses the
    ///   cache key to find an object in its cache that it can return to the viewer.
    /// * The default, minimum, and maximum time to live (TTL) values that you want
    ///   objects to stay in the CloudFront cache.
    ///
    /// If your minimum TTL is greater than 0, CloudFront will cache content for at
    /// least the duration specified in the cache policy's minimum TTL, even if the
    /// `Cache-Control: no-cache`, `no-store`, or `private` directives are present
    /// in the origin headers.
    ///
    /// The headers, cookies, and query strings that are included in the cache key
    /// are also included in requests that CloudFront sends to the origin.
    /// CloudFront sends a request when it can't find an object in its cache that
    /// matches the request's cache key. If you want to send values to the origin
    /// but *not* include them in the cache key, use `OriginRequestPolicy`.
    ///
    /// For more information about cache policies, see [Controlling the cache
    /// key](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createCachePolicy(self: *Self, allocator: std.mem.Allocator, input: create_cache_policy.CreateCachePolicyInput, options: create_cache_policy.Options) !create_cache_policy.CreateCachePolicyOutput {
        return create_cache_policy.execute(self, allocator, input, options);
    }

    /// Creates a new origin access identity. If you're using Amazon S3 for your
    /// origin, you can use an origin access identity to require users to access
    /// your content using a CloudFront URL instead of the Amazon S3 URL. For more
    /// information about how to use origin access identities, see [Serving Private
    /// Content through
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createCloudFrontOriginAccessIdentity(self: *Self, allocator: std.mem.Allocator, input: create_cloud_front_origin_access_identity.CreateCloudFrontOriginAccessIdentityInput, options: create_cloud_front_origin_access_identity.Options) !create_cloud_front_origin_access_identity.CreateCloudFrontOriginAccessIdentityOutput {
        return create_cloud_front_origin_access_identity.execute(self, allocator, input, options);
    }

    /// Creates a connection function.
    pub fn createConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: create_connection_function.CreateConnectionFunctionInput, options: create_connection_function.Options) !create_connection_function.CreateConnectionFunctionOutput {
        return create_connection_function.execute(self, allocator, input, options);
    }

    /// Creates a connection group.
    pub fn createConnectionGroup(self: *Self, allocator: std.mem.Allocator, input: create_connection_group.CreateConnectionGroupInput, options: create_connection_group.Options) !create_connection_group.CreateConnectionGroupOutput {
        return create_connection_group.execute(self, allocator, input, options);
    }

    /// Creates a continuous deployment policy that distributes traffic for a custom
    /// domain name to two different CloudFront distributions.
    ///
    /// To use a continuous deployment policy, first use `CopyDistribution` to
    /// create a staging distribution, then use `UpdateDistribution` to modify the
    /// staging distribution's configuration.
    ///
    /// After you create and update a staging distribution, you can use a continuous
    /// deployment policy to incrementally move traffic to the staging distribution.
    /// This workflow enables you to test changes to a distribution's configuration
    /// before moving all of your domain's production traffic to the new
    /// configuration.
    pub fn createContinuousDeploymentPolicy(self: *Self, allocator: std.mem.Allocator, input: create_continuous_deployment_policy.CreateContinuousDeploymentPolicyInput, options: create_continuous_deployment_policy.Options) !create_continuous_deployment_policy.CreateContinuousDeploymentPolicyOutput {
        return create_continuous_deployment_policy.execute(self, allocator, input, options);
    }

    /// Creates a CloudFront distribution.
    pub fn createDistribution(self: *Self, allocator: std.mem.Allocator, input: create_distribution.CreateDistributionInput, options: create_distribution.Options) !create_distribution.CreateDistributionOutput {
        return create_distribution.execute(self, allocator, input, options);
    }

    /// Creates a distribution tenant.
    pub fn createDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: create_distribution_tenant.CreateDistributionTenantInput, options: create_distribution_tenant.Options) !create_distribution_tenant.CreateDistributionTenantOutput {
        return create_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Create a new distribution with tags. This API operation requires the
    /// following IAM permissions:
    ///
    /// *
    ///   [CreateDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_CreateDistribution.html)
    /// *
    ///   [TagResource](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_TagResource.html)
    pub fn createDistributionWithTags(self: *Self, allocator: std.mem.Allocator, input: create_distribution_with_tags.CreateDistributionWithTagsInput, options: create_distribution_with_tags.Options) !create_distribution_with_tags.CreateDistributionWithTagsOutput {
        return create_distribution_with_tags.execute(self, allocator, input, options);
    }

    /// Create a new field-level encryption configuration.
    pub fn createFieldLevelEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: create_field_level_encryption_config.CreateFieldLevelEncryptionConfigInput, options: create_field_level_encryption_config.Options) !create_field_level_encryption_config.CreateFieldLevelEncryptionConfigOutput {
        return create_field_level_encryption_config.execute(self, allocator, input, options);
    }

    /// Create a field-level encryption profile.
    pub fn createFieldLevelEncryptionProfile(self: *Self, allocator: std.mem.Allocator, input: create_field_level_encryption_profile.CreateFieldLevelEncryptionProfileInput, options: create_field_level_encryption_profile.Options) !create_field_level_encryption_profile.CreateFieldLevelEncryptionProfileOutput {
        return create_field_level_encryption_profile.execute(self, allocator, input, options);
    }

    /// Creates a CloudFront function.
    ///
    /// To create a function, you provide the function code and some configuration
    /// information about the function. The response contains an Amazon Resource
    /// Name (ARN) that uniquely identifies the function.
    ///
    /// When you create a function, it's in the `DEVELOPMENT` stage. In this stage,
    /// you can test the function with `TestFunction`, and update it with
    /// `UpdateFunction`.
    ///
    /// When you're ready to use your function with a CloudFront distribution, use
    /// `PublishFunction` to copy the function from the `DEVELOPMENT` stage to
    /// `LIVE`. When it's live, you can attach the function to a distribution's
    /// cache behavior, using the function's ARN.
    pub fn createFunction(self: *Self, allocator: std.mem.Allocator, input: create_function.CreateFunctionInput, options: create_function.Options) !create_function.CreateFunctionOutput {
        return create_function.execute(self, allocator, input, options);
    }

    /// Create a new invalidation. For more information, see [Invalidating
    /// files](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createInvalidation(self: *Self, allocator: std.mem.Allocator, input: create_invalidation.CreateInvalidationInput, options: create_invalidation.Options) !create_invalidation.CreateInvalidationOutput {
        return create_invalidation.execute(self, allocator, input, options);
    }

    /// Creates an invalidation for a distribution tenant. For more information, see
    /// [Invalidating
    /// files](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createInvalidationForDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: create_invalidation_for_distribution_tenant.CreateInvalidationForDistributionTenantInput, options: create_invalidation_for_distribution_tenant.Options) !create_invalidation_for_distribution_tenant.CreateInvalidationForDistributionTenantOutput {
        return create_invalidation_for_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Creates a key group that you can use with [CloudFront signed URLs and signed
    /// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html).
    ///
    /// To create a key group, you must specify at least one public key for the key
    /// group. After you create a key group, you can reference it from one or more
    /// cache behaviors. When you reference a key group in a cache behavior,
    /// CloudFront requires signed URLs or signed cookies for all requests that
    /// match the cache behavior. The URLs or cookies must be signed with a private
    /// key whose corresponding public key is in the key group. The signed URL or
    /// cookie contains information about which public key CloudFront should use to
    /// verify the signature. For more information, see [Serving private
    /// content](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createKeyGroup(self: *Self, allocator: std.mem.Allocator, input: create_key_group.CreateKeyGroupInput, options: create_key_group.Options) !create_key_group.CreateKeyGroupOutput {
        return create_key_group.execute(self, allocator, input, options);
    }

    /// Specifies the key value store resource to add to your account. In your
    /// account, the key value store names must be unique. You can also import key
    /// value store data in JSON format from an S3 bucket by providing a valid
    /// `ImportSource` that you own.
    pub fn createKeyValueStore(self: *Self, allocator: std.mem.Allocator, input: create_key_value_store.CreateKeyValueStoreInput, options: create_key_value_store.Options) !create_key_value_store.CreateKeyValueStoreOutput {
        return create_key_value_store.execute(self, allocator, input, options);
    }

    /// Enables or disables additional Amazon CloudWatch metrics for the specified
    /// CloudFront distribution. The additional metrics incur an additional cost.
    ///
    /// For more information, see [Viewing additional CloudFront distribution
    /// metrics](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional) in the *Amazon CloudFront Developer Guide*.
    pub fn createMonitoringSubscription(self: *Self, allocator: std.mem.Allocator, input: create_monitoring_subscription.CreateMonitoringSubscriptionInput, options: create_monitoring_subscription.Options) !create_monitoring_subscription.CreateMonitoringSubscriptionOutput {
        return create_monitoring_subscription.execute(self, allocator, input, options);
    }

    /// Creates a new origin access control in CloudFront. After you create an
    /// origin access control, you can add it to an origin in a CloudFront
    /// distribution so that CloudFront sends authenticated (signed) requests to the
    /// origin.
    ///
    /// This makes it possible to block public access to the origin, allowing
    /// viewers (users) to access the origin's content only through CloudFront.
    ///
    /// For more information about using a CloudFront origin access control, see
    /// [Restricting access to an Amazon Web Services
    /// origin](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-origin.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createOriginAccessControl(self: *Self, allocator: std.mem.Allocator, input: create_origin_access_control.CreateOriginAccessControlInput, options: create_origin_access_control.Options) !create_origin_access_control.CreateOriginAccessControlOutput {
        return create_origin_access_control.execute(self, allocator, input, options);
    }

    /// Creates an origin request policy.
    ///
    /// After you create an origin request policy, you can attach it to one or more
    /// cache behaviors. When it's attached to a cache behavior, the origin request
    /// policy determines the values that CloudFront includes in requests that it
    /// sends to the origin. Each request that CloudFront sends to the origin
    /// includes the following:
    ///
    /// * The request body and the URL path (without the domain name) from the
    ///   viewer request.
    /// * The headers that CloudFront automatically includes in every origin
    ///   request, including `Host`, `User-Agent`, and `X-Amz-Cf-Id`.
    /// * All HTTP headers, cookies, and URL query strings that are specified in the
    ///   cache policy or the origin request policy. These can include items from
    ///   the viewer request and, in the case of headers, additional ones that are
    ///   added by CloudFront.
    ///
    /// CloudFront sends a request when it can't find a valid object in its cache
    /// that matches the request. If you want to send values to the origin and also
    /// include them in the cache key, use `CachePolicy`.
    ///
    /// For more information about origin request policies, see [Controlling origin
    /// requests](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createOriginRequestPolicy(self: *Self, allocator: std.mem.Allocator, input: create_origin_request_policy.CreateOriginRequestPolicyInput, options: create_origin_request_policy.Options) !create_origin_request_policy.CreateOriginRequestPolicyOutput {
        return create_origin_request_policy.execute(self, allocator, input, options);
    }

    /// Uploads a public key to CloudFront that you can use with [signed URLs and
    /// signed
    /// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html), or with [field-level encryption](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/field-level-encryption.html).
    pub fn createPublicKey(self: *Self, allocator: std.mem.Allocator, input: create_public_key.CreatePublicKeyInput, options: create_public_key.Options) !create_public_key.CreatePublicKeyOutput {
        return create_public_key.execute(self, allocator, input, options);
    }

    /// Creates a real-time log configuration.
    ///
    /// After you create a real-time log configuration, you can attach it to one or
    /// more cache behaviors to send real-time log data to the specified Amazon
    /// Kinesis data stream.
    ///
    /// For more information about real-time log configurations, see [Real-time
    /// logs](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/real-time-logs.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createRealtimeLogConfig(self: *Self, allocator: std.mem.Allocator, input: create_realtime_log_config.CreateRealtimeLogConfigInput, options: create_realtime_log_config.Options) !create_realtime_log_config.CreateRealtimeLogConfigOutput {
        return create_realtime_log_config.execute(self, allocator, input, options);
    }

    /// Creates a response headers policy.
    ///
    /// A response headers policy contains information about a set of HTTP headers.
    /// To create a response headers policy, you provide some metadata about the
    /// policy and a set of configurations that specify the headers.
    ///
    /// After you create a response headers policy, you can use its ID to attach it
    /// to one or more cache behaviors in a CloudFront distribution. When it's
    /// attached to a cache behavior, the response headers policy affects the HTTP
    /// headers that CloudFront includes in HTTP responses to requests that match
    /// the cache behavior. CloudFront adds or removes response headers according to
    /// the configuration of the response headers policy.
    ///
    /// For more information, see [Adding or removing HTTP headers in CloudFront
    /// responses](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/modifying-response-headers.html) in the *Amazon CloudFront Developer Guide*.
    pub fn createResponseHeadersPolicy(self: *Self, allocator: std.mem.Allocator, input: create_response_headers_policy.CreateResponseHeadersPolicyInput, options: create_response_headers_policy.Options) !create_response_headers_policy.CreateResponseHeadersPolicyOutput {
        return create_response_headers_policy.execute(self, allocator, input, options);
    }

    /// This API is deprecated. Amazon CloudFront is deprecating real-time messaging
    /// protocol (RTMP) distributions on December 31, 2020. For more information,
    /// [read the announcement](http://forums.aws.amazon.com/ann.jspa?annID=7356) on
    /// the Amazon CloudFront discussion forum.
    pub fn createStreamingDistribution(self: *Self, allocator: std.mem.Allocator, input: create_streaming_distribution.CreateStreamingDistributionInput, options: create_streaming_distribution.Options) !create_streaming_distribution.CreateStreamingDistributionOutput {
        return create_streaming_distribution.execute(self, allocator, input, options);
    }

    /// This API is deprecated. Amazon CloudFront is deprecating real-time messaging
    /// protocol (RTMP) distributions on December 31, 2020. For more information,
    /// [read the announcement](http://forums.aws.amazon.com/ann.jspa?annID=7356) on
    /// the Amazon CloudFront discussion forum.
    pub fn createStreamingDistributionWithTags(self: *Self, allocator: std.mem.Allocator, input: create_streaming_distribution_with_tags.CreateStreamingDistributionWithTagsInput, options: create_streaming_distribution_with_tags.Options) !create_streaming_distribution_with_tags.CreateStreamingDistributionWithTagsOutput {
        return create_streaming_distribution_with_tags.execute(self, allocator, input, options);
    }

    /// Creates a trust store.
    pub fn createTrustStore(self: *Self, allocator: std.mem.Allocator, input: create_trust_store.CreateTrustStoreInput, options: create_trust_store.Options) !create_trust_store.CreateTrustStoreOutput {
        return create_trust_store.execute(self, allocator, input, options);
    }

    /// Create an Amazon CloudFront VPC origin.
    pub fn createVpcOrigin(self: *Self, allocator: std.mem.Allocator, input: create_vpc_origin.CreateVpcOriginInput, options: create_vpc_origin.Options) !create_vpc_origin.CreateVpcOriginOutput {
        return create_vpc_origin.execute(self, allocator, input, options);
    }

    /// Deletes an Anycast static IP list.
    pub fn deleteAnycastIpList(self: *Self, allocator: std.mem.Allocator, input: delete_anycast_ip_list.DeleteAnycastIpListInput, options: delete_anycast_ip_list.Options) !delete_anycast_ip_list.DeleteAnycastIpListOutput {
        return delete_anycast_ip_list.execute(self, allocator, input, options);
    }

    /// Deletes a cache policy.
    ///
    /// You cannot delete a cache policy if it's attached to a cache behavior. First
    /// update your distributions to remove the cache policy from all cache
    /// behaviors, then delete the cache policy.
    ///
    /// To delete a cache policy, you must provide the policy's identifier and
    /// version. To get these values, you can use `ListCachePolicies` or
    /// `GetCachePolicy`.
    pub fn deleteCachePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_cache_policy.DeleteCachePolicyInput, options: delete_cache_policy.Options) !delete_cache_policy.DeleteCachePolicyOutput {
        return delete_cache_policy.execute(self, allocator, input, options);
    }

    /// Delete an origin access identity.
    pub fn deleteCloudFrontOriginAccessIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_front_origin_access_identity.DeleteCloudFrontOriginAccessIdentityInput, options: delete_cloud_front_origin_access_identity.Options) !delete_cloud_front_origin_access_identity.DeleteCloudFrontOriginAccessIdentityOutput {
        return delete_cloud_front_origin_access_identity.execute(self, allocator, input, options);
    }

    /// Deletes a connection function.
    pub fn deleteConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: delete_connection_function.DeleteConnectionFunctionInput, options: delete_connection_function.Options) !delete_connection_function.DeleteConnectionFunctionOutput {
        return delete_connection_function.execute(self, allocator, input, options);
    }

    /// Deletes a connection group.
    pub fn deleteConnectionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_connection_group.DeleteConnectionGroupInput, options: delete_connection_group.Options) !delete_connection_group.DeleteConnectionGroupOutput {
        return delete_connection_group.execute(self, allocator, input, options);
    }

    /// Deletes a continuous deployment policy.
    ///
    /// You cannot delete a continuous deployment policy that's attached to a
    /// primary distribution. First update your distribution to remove the
    /// continuous deployment policy, then you can delete the policy.
    pub fn deleteContinuousDeploymentPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_continuous_deployment_policy.DeleteContinuousDeploymentPolicyInput, options: delete_continuous_deployment_policy.Options) !delete_continuous_deployment_policy.DeleteContinuousDeploymentPolicyOutput {
        return delete_continuous_deployment_policy.execute(self, allocator, input, options);
    }

    /// Delete a distribution.
    ///
    /// Before you can delete a distribution, you must disable it, which requires
    /// permission to update the distribution. Once deleted, a distribution cannot
    /// be recovered.
    pub fn deleteDistribution(self: *Self, allocator: std.mem.Allocator, input: delete_distribution.DeleteDistributionInput, options: delete_distribution.Options) !delete_distribution.DeleteDistributionOutput {
        return delete_distribution.execute(self, allocator, input, options);
    }

    /// Deletes a distribution tenant. If you use this API operation to delete a
    /// distribution tenant that is currently enabled, the request will fail.
    ///
    /// To delete a distribution tenant, you must first disable the distribution
    /// tenant by using the `UpdateDistributionTenant` API operation.
    pub fn deleteDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: delete_distribution_tenant.DeleteDistributionTenantInput, options: delete_distribution_tenant.Options) !delete_distribution_tenant.DeleteDistributionTenantOutput {
        return delete_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Remove a field-level encryption configuration.
    pub fn deleteFieldLevelEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: delete_field_level_encryption_config.DeleteFieldLevelEncryptionConfigInput, options: delete_field_level_encryption_config.Options) !delete_field_level_encryption_config.DeleteFieldLevelEncryptionConfigOutput {
        return delete_field_level_encryption_config.execute(self, allocator, input, options);
    }

    /// Remove a field-level encryption profile.
    pub fn deleteFieldLevelEncryptionProfile(self: *Self, allocator: std.mem.Allocator, input: delete_field_level_encryption_profile.DeleteFieldLevelEncryptionProfileInput, options: delete_field_level_encryption_profile.Options) !delete_field_level_encryption_profile.DeleteFieldLevelEncryptionProfileOutput {
        return delete_field_level_encryption_profile.execute(self, allocator, input, options);
    }

    /// Deletes a CloudFront function.
    ///
    /// You cannot delete a function if it's associated with a cache behavior.
    /// First, update your distributions to remove the function association from all
    /// cache behaviors, then delete the function.
    ///
    /// To delete a function, you must provide the function's name and version
    /// (`ETag` value). To get these values, you can use `ListFunctions` and
    /// `DescribeFunction`.
    pub fn deleteFunction(self: *Self, allocator: std.mem.Allocator, input: delete_function.DeleteFunctionInput, options: delete_function.Options) !delete_function.DeleteFunctionOutput {
        return delete_function.execute(self, allocator, input, options);
    }

    /// Deletes a key group.
    ///
    /// You cannot delete a key group that is referenced in a cache behavior. First
    /// update your distributions to remove the key group from all cache behaviors,
    /// then delete the key group.
    ///
    /// To delete a key group, you must provide the key group's identifier and
    /// version. To get these values, use `ListKeyGroups` followed by `GetKeyGroup`
    /// or `GetKeyGroupConfig`.
    pub fn deleteKeyGroup(self: *Self, allocator: std.mem.Allocator, input: delete_key_group.DeleteKeyGroupInput, options: delete_key_group.Options) !delete_key_group.DeleteKeyGroupOutput {
        return delete_key_group.execute(self, allocator, input, options);
    }

    /// Specifies the key value store to delete.
    pub fn deleteKeyValueStore(self: *Self, allocator: std.mem.Allocator, input: delete_key_value_store.DeleteKeyValueStoreInput, options: delete_key_value_store.Options) !delete_key_value_store.DeleteKeyValueStoreOutput {
        return delete_key_value_store.execute(self, allocator, input, options);
    }

    /// Disables additional CloudWatch metrics for the specified CloudFront
    /// distribution.
    pub fn deleteMonitoringSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_monitoring_subscription.DeleteMonitoringSubscriptionInput, options: delete_monitoring_subscription.Options) !delete_monitoring_subscription.DeleteMonitoringSubscriptionOutput {
        return delete_monitoring_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a CloudFront origin access control.
    ///
    /// You cannot delete an origin access control if it's in use. First, update all
    /// distributions to remove the origin access control from all origins, then
    /// delete the origin access control.
    pub fn deleteOriginAccessControl(self: *Self, allocator: std.mem.Allocator, input: delete_origin_access_control.DeleteOriginAccessControlInput, options: delete_origin_access_control.Options) !delete_origin_access_control.DeleteOriginAccessControlOutput {
        return delete_origin_access_control.execute(self, allocator, input, options);
    }

    /// Deletes an origin request policy.
    ///
    /// You cannot delete an origin request policy if it's attached to any cache
    /// behaviors. First update your distributions to remove the origin request
    /// policy from all cache behaviors, then delete the origin request policy.
    ///
    /// To delete an origin request policy, you must provide the policy's identifier
    /// and version. To get the identifier, you can use `ListOriginRequestPolicies`
    /// or `GetOriginRequestPolicy`.
    pub fn deleteOriginRequestPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_origin_request_policy.DeleteOriginRequestPolicyInput, options: delete_origin_request_policy.Options) !delete_origin_request_policy.DeleteOriginRequestPolicyOutput {
        return delete_origin_request_policy.execute(self, allocator, input, options);
    }

    /// Remove a public key you previously added to CloudFront.
    pub fn deletePublicKey(self: *Self, allocator: std.mem.Allocator, input: delete_public_key.DeletePublicKeyInput, options: delete_public_key.Options) !delete_public_key.DeletePublicKeyOutput {
        return delete_public_key.execute(self, allocator, input, options);
    }

    /// Deletes a real-time log configuration.
    ///
    /// You cannot delete a real-time log configuration if it's attached to a cache
    /// behavior. First update your distributions to remove the real-time log
    /// configuration from all cache behaviors, then delete the real-time log
    /// configuration.
    ///
    /// To delete a real-time log configuration, you can provide the configuration's
    /// name or its Amazon Resource Name (ARN). You must provide at least one. If
    /// you provide both, CloudFront uses the name to identify the real-time log
    /// configuration to delete.
    pub fn deleteRealtimeLogConfig(self: *Self, allocator: std.mem.Allocator, input: delete_realtime_log_config.DeleteRealtimeLogConfigInput, options: delete_realtime_log_config.Options) !delete_realtime_log_config.DeleteRealtimeLogConfigOutput {
        return delete_realtime_log_config.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy attached to the CloudFront resource.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a response headers policy.
    ///
    /// You cannot delete a response headers policy if it's attached to a cache
    /// behavior. First update your distributions to remove the response headers
    /// policy from all cache behaviors, then delete the response headers policy.
    ///
    /// To delete a response headers policy, you must provide the policy's
    /// identifier and version. To get these values, you can use
    /// `ListResponseHeadersPolicies` or `GetResponseHeadersPolicy`.
    pub fn deleteResponseHeadersPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_response_headers_policy.DeleteResponseHeadersPolicyInput, options: delete_response_headers_policy.Options) !delete_response_headers_policy.DeleteResponseHeadersPolicyOutput {
        return delete_response_headers_policy.execute(self, allocator, input, options);
    }

    /// Delete a streaming distribution. To delete an RTMP distribution using the
    /// CloudFront API, perform the following steps.
    ///
    /// **To delete an RTMP distribution using the CloudFront API**:
    ///
    /// * Disable the RTMP distribution.
    /// * Submit a `GET Streaming Distribution Config` request to get the current
    ///   configuration and the `Etag` header for the distribution.
    /// * Update the XML document that was returned in the response to your `GET
    ///   Streaming Distribution Config` request to change the value of `Enabled` to
    ///   `false`.
    /// * Submit a `PUT Streaming Distribution Config` request to update the
    ///   configuration for your distribution. In the request body, include the XML
    ///   document that you updated in Step 3. Then set the value of the HTTP
    ///   `If-Match` header to the value of the `ETag` header that CloudFront
    ///   returned when you submitted the `GET Streaming Distribution Config`
    ///   request in Step 2.
    /// * Review the response to the `PUT Streaming Distribution Config` request to
    ///   confirm that the distribution was successfully disabled.
    /// * Submit a `GET Streaming Distribution Config` request to confirm that your
    ///   changes have propagated. When propagation is complete, the value of
    ///   `Status` is `Deployed`.
    /// * Submit a `DELETE Streaming Distribution` request. Set the value of the
    ///   HTTP `If-Match` header to the value of the `ETag` header that CloudFront
    ///   returned when you submitted the `GET Streaming Distribution Config`
    ///   request in Step 2.
    /// * Review the response to your `DELETE Streaming Distribution` request to
    ///   confirm that the distribution was successfully deleted.
    ///
    /// For information about deleting a distribution using the CloudFront console,
    /// see [Deleting a
    /// Distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/HowToDeleteDistribution.html) in the *Amazon CloudFront Developer Guide*.
    pub fn deleteStreamingDistribution(self: *Self, allocator: std.mem.Allocator, input: delete_streaming_distribution.DeleteStreamingDistributionInput, options: delete_streaming_distribution.Options) !delete_streaming_distribution.DeleteStreamingDistributionOutput {
        return delete_streaming_distribution.execute(self, allocator, input, options);
    }

    /// Deletes a trust store.
    pub fn deleteTrustStore(self: *Self, allocator: std.mem.Allocator, input: delete_trust_store.DeleteTrustStoreInput, options: delete_trust_store.Options) !delete_trust_store.DeleteTrustStoreOutput {
        return delete_trust_store.execute(self, allocator, input, options);
    }

    /// Delete an Amazon CloudFront VPC origin.
    pub fn deleteVpcOrigin(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_origin.DeleteVpcOriginInput, options: delete_vpc_origin.Options) !delete_vpc_origin.DeleteVpcOriginOutput {
        return delete_vpc_origin.execute(self, allocator, input, options);
    }

    /// Describes a connection function.
    pub fn describeConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: describe_connection_function.DescribeConnectionFunctionInput, options: describe_connection_function.Options) !describe_connection_function.DescribeConnectionFunctionOutput {
        return describe_connection_function.execute(self, allocator, input, options);
    }

    /// Gets configuration information and metadata about a CloudFront function, but
    /// not the function's code. To get a function's code, use `GetFunction`.
    ///
    /// To get configuration information and metadata about a function, you must
    /// provide the function's name and stage. To get these values, you can use
    /// `ListFunctions`.
    pub fn describeFunction(self: *Self, allocator: std.mem.Allocator, input: describe_function.DescribeFunctionInput, options: describe_function.Options) !describe_function.DescribeFunctionOutput {
        return describe_function.execute(self, allocator, input, options);
    }

    /// Specifies the key value store and its configuration.
    pub fn describeKeyValueStore(self: *Self, allocator: std.mem.Allocator, input: describe_key_value_store.DescribeKeyValueStoreInput, options: describe_key_value_store.Options) !describe_key_value_store.DescribeKeyValueStoreOutput {
        return describe_key_value_store.execute(self, allocator, input, options);
    }

    /// Disassociates a distribution tenant from the WAF web ACL.
    pub fn disassociateDistributionTenantWebAcl(self: *Self, allocator: std.mem.Allocator, input: disassociate_distribution_tenant_web_acl.DisassociateDistributionTenantWebACLInput, options: disassociate_distribution_tenant_web_acl.Options) !disassociate_distribution_tenant_web_acl.DisassociateDistributionTenantWebACLOutput {
        return disassociate_distribution_tenant_web_acl.execute(self, allocator, input, options);
    }

    /// Disassociates a distribution from the WAF web ACL.
    pub fn disassociateDistributionWebAcl(self: *Self, allocator: std.mem.Allocator, input: disassociate_distribution_web_acl.DisassociateDistributionWebACLInput, options: disassociate_distribution_web_acl.Options) !disassociate_distribution_web_acl.DisassociateDistributionWebACLOutput {
        return disassociate_distribution_web_acl.execute(self, allocator, input, options);
    }

    /// Gets an Anycast static IP list.
    pub fn getAnycastIpList(self: *Self, allocator: std.mem.Allocator, input: get_anycast_ip_list.GetAnycastIpListInput, options: get_anycast_ip_list.Options) !get_anycast_ip_list.GetAnycastIpListOutput {
        return get_anycast_ip_list.execute(self, allocator, input, options);
    }

    /// Gets a cache policy, including the following metadata:
    ///
    /// * The policy's identifier.
    /// * The date and time when the policy was last modified.
    ///
    /// To get a cache policy, you must provide the policy's identifier. If the
    /// cache policy is attached to a distribution's cache behavior, you can get the
    /// policy's identifier using `ListDistributions` or `GetDistribution`. If the
    /// cache policy is not attached to a cache behavior, you can get the identifier
    /// using `ListCachePolicies`.
    pub fn getCachePolicy(self: *Self, allocator: std.mem.Allocator, input: get_cache_policy.GetCachePolicyInput, options: get_cache_policy.Options) !get_cache_policy.GetCachePolicyOutput {
        return get_cache_policy.execute(self, allocator, input, options);
    }

    /// Gets a cache policy configuration.
    ///
    /// To get a cache policy configuration, you must provide the policy's
    /// identifier. If the cache policy is attached to a distribution's cache
    /// behavior, you can get the policy's identifier using `ListDistributions` or
    /// `GetDistribution`. If the cache policy is not attached to a cache behavior,
    /// you can get the identifier using `ListCachePolicies`.
    pub fn getCachePolicyConfig(self: *Self, allocator: std.mem.Allocator, input: get_cache_policy_config.GetCachePolicyConfigInput, options: get_cache_policy_config.Options) !get_cache_policy_config.GetCachePolicyConfigOutput {
        return get_cache_policy_config.execute(self, allocator, input, options);
    }

    /// Get the information about an origin access identity.
    pub fn getCloudFrontOriginAccessIdentity(self: *Self, allocator: std.mem.Allocator, input: get_cloud_front_origin_access_identity.GetCloudFrontOriginAccessIdentityInput, options: get_cloud_front_origin_access_identity.Options) !get_cloud_front_origin_access_identity.GetCloudFrontOriginAccessIdentityOutput {
        return get_cloud_front_origin_access_identity.execute(self, allocator, input, options);
    }

    /// Get the configuration information about an origin access identity.
    pub fn getCloudFrontOriginAccessIdentityConfig(self: *Self, allocator: std.mem.Allocator, input: get_cloud_front_origin_access_identity_config.GetCloudFrontOriginAccessIdentityConfigInput, options: get_cloud_front_origin_access_identity_config.Options) !get_cloud_front_origin_access_identity_config.GetCloudFrontOriginAccessIdentityConfigOutput {
        return get_cloud_front_origin_access_identity_config.execute(self, allocator, input, options);
    }

    /// Gets a connection function.
    pub fn getConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: get_connection_function.GetConnectionFunctionInput, options: get_connection_function.Options) !get_connection_function.GetConnectionFunctionOutput {
        return get_connection_function.execute(self, allocator, input, options);
    }

    /// Gets information about a connection group.
    pub fn getConnectionGroup(self: *Self, allocator: std.mem.Allocator, input: get_connection_group.GetConnectionGroupInput, options: get_connection_group.Options) !get_connection_group.GetConnectionGroupOutput {
        return get_connection_group.execute(self, allocator, input, options);
    }

    /// Gets information about a connection group by using the endpoint that you
    /// specify.
    pub fn getConnectionGroupByRoutingEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_connection_group_by_routing_endpoint.GetConnectionGroupByRoutingEndpointInput, options: get_connection_group_by_routing_endpoint.Options) !get_connection_group_by_routing_endpoint.GetConnectionGroupByRoutingEndpointOutput {
        return get_connection_group_by_routing_endpoint.execute(self, allocator, input, options);
    }

    /// Gets a continuous deployment policy, including metadata (the policy's
    /// identifier and the date and time when the policy was last modified).
    pub fn getContinuousDeploymentPolicy(self: *Self, allocator: std.mem.Allocator, input: get_continuous_deployment_policy.GetContinuousDeploymentPolicyInput, options: get_continuous_deployment_policy.Options) !get_continuous_deployment_policy.GetContinuousDeploymentPolicyOutput {
        return get_continuous_deployment_policy.execute(self, allocator, input, options);
    }

    /// Gets configuration information about a continuous deployment policy.
    pub fn getContinuousDeploymentPolicyConfig(self: *Self, allocator: std.mem.Allocator, input: get_continuous_deployment_policy_config.GetContinuousDeploymentPolicyConfigInput, options: get_continuous_deployment_policy_config.Options) !get_continuous_deployment_policy_config.GetContinuousDeploymentPolicyConfigOutput {
        return get_continuous_deployment_policy_config.execute(self, allocator, input, options);
    }

    /// Get the information about a distribution.
    pub fn getDistribution(self: *Self, allocator: std.mem.Allocator, input: get_distribution.GetDistributionInput, options: get_distribution.Options) !get_distribution.GetDistributionOutput {
        return get_distribution.execute(self, allocator, input, options);
    }

    /// Get the configuration information about a distribution.
    pub fn getDistributionConfig(self: *Self, allocator: std.mem.Allocator, input: get_distribution_config.GetDistributionConfigInput, options: get_distribution_config.Options) !get_distribution_config.GetDistributionConfigOutput {
        return get_distribution_config.execute(self, allocator, input, options);
    }

    /// Gets information about a distribution tenant.
    pub fn getDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: get_distribution_tenant.GetDistributionTenantInput, options: get_distribution_tenant.Options) !get_distribution_tenant.GetDistributionTenantOutput {
        return get_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Gets information about a distribution tenant by the associated domain.
    pub fn getDistributionTenantByDomain(self: *Self, allocator: std.mem.Allocator, input: get_distribution_tenant_by_domain.GetDistributionTenantByDomainInput, options: get_distribution_tenant_by_domain.Options) !get_distribution_tenant_by_domain.GetDistributionTenantByDomainOutput {
        return get_distribution_tenant_by_domain.execute(self, allocator, input, options);
    }

    /// Get the field-level encryption configuration information.
    pub fn getFieldLevelEncryption(self: *Self, allocator: std.mem.Allocator, input: get_field_level_encryption.GetFieldLevelEncryptionInput, options: get_field_level_encryption.Options) !get_field_level_encryption.GetFieldLevelEncryptionOutput {
        return get_field_level_encryption.execute(self, allocator, input, options);
    }

    /// Get the field-level encryption configuration information.
    pub fn getFieldLevelEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: get_field_level_encryption_config.GetFieldLevelEncryptionConfigInput, options: get_field_level_encryption_config.Options) !get_field_level_encryption_config.GetFieldLevelEncryptionConfigOutput {
        return get_field_level_encryption_config.execute(self, allocator, input, options);
    }

    /// Get the field-level encryption profile information.
    pub fn getFieldLevelEncryptionProfile(self: *Self, allocator: std.mem.Allocator, input: get_field_level_encryption_profile.GetFieldLevelEncryptionProfileInput, options: get_field_level_encryption_profile.Options) !get_field_level_encryption_profile.GetFieldLevelEncryptionProfileOutput {
        return get_field_level_encryption_profile.execute(self, allocator, input, options);
    }

    /// Get the field-level encryption profile configuration information.
    pub fn getFieldLevelEncryptionProfileConfig(self: *Self, allocator: std.mem.Allocator, input: get_field_level_encryption_profile_config.GetFieldLevelEncryptionProfileConfigInput, options: get_field_level_encryption_profile_config.Options) !get_field_level_encryption_profile_config.GetFieldLevelEncryptionProfileConfigOutput {
        return get_field_level_encryption_profile_config.execute(self, allocator, input, options);
    }

    /// Gets the code of a CloudFront function. To get configuration information and
    /// metadata about a function, use `DescribeFunction`.
    ///
    /// To get a function's code, you must provide the function's name and stage. To
    /// get these values, you can use `ListFunctions`.
    pub fn getFunction(self: *Self, allocator: std.mem.Allocator, input: get_function.GetFunctionInput, options: get_function.Options) !get_function.GetFunctionOutput {
        return get_function.execute(self, allocator, input, options);
    }

    /// Get the information about an invalidation.
    pub fn getInvalidation(self: *Self, allocator: std.mem.Allocator, input: get_invalidation.GetInvalidationInput, options: get_invalidation.Options) !get_invalidation.GetInvalidationOutput {
        return get_invalidation.execute(self, allocator, input, options);
    }

    /// Gets information about a specific invalidation for a distribution tenant.
    pub fn getInvalidationForDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: get_invalidation_for_distribution_tenant.GetInvalidationForDistributionTenantInput, options: get_invalidation_for_distribution_tenant.Options) !get_invalidation_for_distribution_tenant.GetInvalidationForDistributionTenantOutput {
        return get_invalidation_for_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Gets a key group, including the date and time when the key group was last
    /// modified.
    ///
    /// To get a key group, you must provide the key group's identifier. If the key
    /// group is referenced in a distribution's cache behavior, you can get the key
    /// group's identifier using `ListDistributions` or `GetDistribution`. If the
    /// key group is not referenced in a cache behavior, you can get the identifier
    /// using `ListKeyGroups`.
    pub fn getKeyGroup(self: *Self, allocator: std.mem.Allocator, input: get_key_group.GetKeyGroupInput, options: get_key_group.Options) !get_key_group.GetKeyGroupOutput {
        return get_key_group.execute(self, allocator, input, options);
    }

    /// Gets a key group configuration.
    ///
    /// To get a key group configuration, you must provide the key group's
    /// identifier. If the key group is referenced in a distribution's cache
    /// behavior, you can get the key group's identifier using `ListDistributions`
    /// or `GetDistribution`. If the key group is not referenced in a cache
    /// behavior, you can get the identifier using `ListKeyGroups`.
    pub fn getKeyGroupConfig(self: *Self, allocator: std.mem.Allocator, input: get_key_group_config.GetKeyGroupConfigInput, options: get_key_group_config.Options) !get_key_group_config.GetKeyGroupConfigOutput {
        return get_key_group_config.execute(self, allocator, input, options);
    }

    /// Gets details about the CloudFront managed ACM certificate.
    pub fn getManagedCertificateDetails(self: *Self, allocator: std.mem.Allocator, input: get_managed_certificate_details.GetManagedCertificateDetailsInput, options: get_managed_certificate_details.Options) !get_managed_certificate_details.GetManagedCertificateDetailsOutput {
        return get_managed_certificate_details.execute(self, allocator, input, options);
    }

    /// Gets information about whether additional CloudWatch metrics are enabled for
    /// the specified CloudFront distribution.
    pub fn getMonitoringSubscription(self: *Self, allocator: std.mem.Allocator, input: get_monitoring_subscription.GetMonitoringSubscriptionInput, options: get_monitoring_subscription.Options) !get_monitoring_subscription.GetMonitoringSubscriptionOutput {
        return get_monitoring_subscription.execute(self, allocator, input, options);
    }

    /// Gets a CloudFront origin access control, including its unique identifier.
    pub fn getOriginAccessControl(self: *Self, allocator: std.mem.Allocator, input: get_origin_access_control.GetOriginAccessControlInput, options: get_origin_access_control.Options) !get_origin_access_control.GetOriginAccessControlOutput {
        return get_origin_access_control.execute(self, allocator, input, options);
    }

    /// Gets a CloudFront origin access control configuration.
    pub fn getOriginAccessControlConfig(self: *Self, allocator: std.mem.Allocator, input: get_origin_access_control_config.GetOriginAccessControlConfigInput, options: get_origin_access_control_config.Options) !get_origin_access_control_config.GetOriginAccessControlConfigOutput {
        return get_origin_access_control_config.execute(self, allocator, input, options);
    }

    /// Gets an origin request policy, including the following metadata:
    ///
    /// * The policy's identifier.
    /// * The date and time when the policy was last modified.
    ///
    /// To get an origin request policy, you must provide the policy's identifier.
    /// If the origin request policy is attached to a distribution's cache behavior,
    /// you can get the policy's identifier using `ListDistributions` or
    /// `GetDistribution`. If the origin request policy is not attached to a cache
    /// behavior, you can get the identifier using `ListOriginRequestPolicies`.
    pub fn getOriginRequestPolicy(self: *Self, allocator: std.mem.Allocator, input: get_origin_request_policy.GetOriginRequestPolicyInput, options: get_origin_request_policy.Options) !get_origin_request_policy.GetOriginRequestPolicyOutput {
        return get_origin_request_policy.execute(self, allocator, input, options);
    }

    /// Gets an origin request policy configuration.
    ///
    /// To get an origin request policy configuration, you must provide the policy's
    /// identifier. If the origin request policy is attached to a distribution's
    /// cache behavior, you can get the policy's identifier using
    /// `ListDistributions` or `GetDistribution`. If the origin request policy is
    /// not attached to a cache behavior, you can get the identifier using
    /// `ListOriginRequestPolicies`.
    pub fn getOriginRequestPolicyConfig(self: *Self, allocator: std.mem.Allocator, input: get_origin_request_policy_config.GetOriginRequestPolicyConfigInput, options: get_origin_request_policy_config.Options) !get_origin_request_policy_config.GetOriginRequestPolicyConfigOutput {
        return get_origin_request_policy_config.execute(self, allocator, input, options);
    }

    /// Gets a public key.
    pub fn getPublicKey(self: *Self, allocator: std.mem.Allocator, input: get_public_key.GetPublicKeyInput, options: get_public_key.Options) !get_public_key.GetPublicKeyOutput {
        return get_public_key.execute(self, allocator, input, options);
    }

    /// Gets a public key configuration.
    pub fn getPublicKeyConfig(self: *Self, allocator: std.mem.Allocator, input: get_public_key_config.GetPublicKeyConfigInput, options: get_public_key_config.Options) !get_public_key_config.GetPublicKeyConfigOutput {
        return get_public_key_config.execute(self, allocator, input, options);
    }

    /// Gets a real-time log configuration.
    ///
    /// To get a real-time log configuration, you can provide the configuration's
    /// name or its Amazon Resource Name (ARN). You must provide at least one. If
    /// you provide both, CloudFront uses the name to identify the real-time log
    /// configuration to get.
    pub fn getRealtimeLogConfig(self: *Self, allocator: std.mem.Allocator, input: get_realtime_log_config.GetRealtimeLogConfigInput, options: get_realtime_log_config.Options) !get_realtime_log_config.GetRealtimeLogConfigOutput {
        return get_realtime_log_config.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policy for the specified CloudFront resource that you
    /// own and have shared.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Gets a response headers policy, including metadata (the policy's identifier
    /// and the date and time when the policy was last modified).
    ///
    /// To get a response headers policy, you must provide the policy's identifier.
    /// If the response headers policy is attached to a distribution's cache
    /// behavior, you can get the policy's identifier using `ListDistributions` or
    /// `GetDistribution`. If the response headers policy is not attached to a cache
    /// behavior, you can get the identifier using `ListResponseHeadersPolicies`.
    pub fn getResponseHeadersPolicy(self: *Self, allocator: std.mem.Allocator, input: get_response_headers_policy.GetResponseHeadersPolicyInput, options: get_response_headers_policy.Options) !get_response_headers_policy.GetResponseHeadersPolicyOutput {
        return get_response_headers_policy.execute(self, allocator, input, options);
    }

    /// Gets a response headers policy configuration.
    ///
    /// To get a response headers policy configuration, you must provide the
    /// policy's identifier. If the response headers policy is attached to a
    /// distribution's cache behavior, you can get the policy's identifier using
    /// `ListDistributions` or `GetDistribution`. If the response headers policy is
    /// not attached to a cache behavior, you can get the identifier using
    /// `ListResponseHeadersPolicies`.
    pub fn getResponseHeadersPolicyConfig(self: *Self, allocator: std.mem.Allocator, input: get_response_headers_policy_config.GetResponseHeadersPolicyConfigInput, options: get_response_headers_policy_config.Options) !get_response_headers_policy_config.GetResponseHeadersPolicyConfigOutput {
        return get_response_headers_policy_config.execute(self, allocator, input, options);
    }

    /// Gets information about a specified RTMP distribution, including the
    /// distribution configuration.
    pub fn getStreamingDistribution(self: *Self, allocator: std.mem.Allocator, input: get_streaming_distribution.GetStreamingDistributionInput, options: get_streaming_distribution.Options) !get_streaming_distribution.GetStreamingDistributionOutput {
        return get_streaming_distribution.execute(self, allocator, input, options);
    }

    /// Get the configuration information about a streaming distribution.
    pub fn getStreamingDistributionConfig(self: *Self, allocator: std.mem.Allocator, input: get_streaming_distribution_config.GetStreamingDistributionConfigInput, options: get_streaming_distribution_config.Options) !get_streaming_distribution_config.GetStreamingDistributionConfigOutput {
        return get_streaming_distribution_config.execute(self, allocator, input, options);
    }

    /// Gets a trust store.
    pub fn getTrustStore(self: *Self, allocator: std.mem.Allocator, input: get_trust_store.GetTrustStoreInput, options: get_trust_store.Options) !get_trust_store.GetTrustStoreOutput {
        return get_trust_store.execute(self, allocator, input, options);
    }

    /// Get the details of an Amazon CloudFront VPC origin.
    pub fn getVpcOrigin(self: *Self, allocator: std.mem.Allocator, input: get_vpc_origin.GetVpcOriginInput, options: get_vpc_origin.Options) !get_vpc_origin.GetVpcOriginOutput {
        return get_vpc_origin.execute(self, allocator, input, options);
    }

    /// Lists your Anycast static IP lists.
    pub fn listAnycastIpLists(self: *Self, allocator: std.mem.Allocator, input: list_anycast_ip_lists.ListAnycastIpListsInput, options: list_anycast_ip_lists.Options) !list_anycast_ip_lists.ListAnycastIpListsOutput {
        return list_anycast_ip_lists.execute(self, allocator, input, options);
    }

    /// Gets a list of cache policies.
    ///
    /// You can optionally apply a filter to return only the managed policies
    /// created by Amazon Web Services, or only the custom policies created in your
    /// Amazon Web Services account.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listCachePolicies(self: *Self, allocator: std.mem.Allocator, input: list_cache_policies.ListCachePoliciesInput, options: list_cache_policies.Options) !list_cache_policies.ListCachePoliciesOutput {
        return list_cache_policies.execute(self, allocator, input, options);
    }

    /// Lists origin access identities.
    pub fn listCloudFrontOriginAccessIdentities(self: *Self, allocator: std.mem.Allocator, input: list_cloud_front_origin_access_identities.ListCloudFrontOriginAccessIdentitiesInput, options: list_cloud_front_origin_access_identities.Options) !list_cloud_front_origin_access_identities.ListCloudFrontOriginAccessIdentitiesOutput {
        return list_cloud_front_origin_access_identities.execute(self, allocator, input, options);
    }

    /// The `ListConflictingAliases` API operation only supports standard
    /// distributions. To list domain conflicts for both standard distributions and
    /// distribution tenants, we recommend that you use the
    /// [ListDomainConflicts](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ListDomainConflicts.html) API operation instead.
    ///
    /// Gets a list of aliases that conflict or overlap with the provided alias, and
    /// the associated CloudFront standard distribution and Amazon Web Services
    /// accounts for each conflicting alias. An alias is commonly known as a custom
    /// domain or vanity domain. It can also be called a CNAME or alternate domain
    /// name.
    ///
    /// In the returned list, the standard distribution and account IDs are
    /// partially hidden, which allows you to identify the standard distribution and
    /// accounts that you own, and helps to protect the information of ones that you
    /// don't own.
    ///
    /// Use this operation to find aliases that are in use in CloudFront that
    /// conflict or overlap with the provided alias. For example, if you provide
    /// `www.example.com` as input, the returned list can include `www.example.com`
    /// and the overlapping wildcard alternate domain name (`*.example.com`), if
    /// they exist. If you provide `*.example.com` as input, the returned list can
    /// include `*.example.com` and any alternate domain names covered by that
    /// wildcard (for example, `www.example.com`, `test.example.com`,
    /// `dev.example.com`, and so on), if they exist.
    ///
    /// To list conflicting aliases, specify the alias to search and the ID of a
    /// standard distribution in your account that has an attached TLS certificate
    /// that includes the provided alias. For more information, including how to set
    /// up the standard distribution and certificate, see [Moving an alternate
    /// domain name to a different standard distribution or distribution
    /// tenant](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/CNAMEs.html#alternate-domain-names-move) in the *Amazon CloudFront Developer Guide*.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listConflictingAliases(self: *Self, allocator: std.mem.Allocator, input: list_conflicting_aliases.ListConflictingAliasesInput, options: list_conflicting_aliases.Options) !list_conflicting_aliases.ListConflictingAliasesOutput {
        return list_conflicting_aliases.execute(self, allocator, input, options);
    }

    /// Lists connection functions.
    pub fn listConnectionFunctions(self: *Self, allocator: std.mem.Allocator, input: list_connection_functions.ListConnectionFunctionsInput, options: list_connection_functions.Options) !list_connection_functions.ListConnectionFunctionsOutput {
        return list_connection_functions.execute(self, allocator, input, options);
    }

    /// Lists the connection groups in your Amazon Web Services account.
    pub fn listConnectionGroups(self: *Self, allocator: std.mem.Allocator, input: list_connection_groups.ListConnectionGroupsInput, options: list_connection_groups.Options) !list_connection_groups.ListConnectionGroupsOutput {
        return list_connection_groups.execute(self, allocator, input, options);
    }

    /// Gets a list of the continuous deployment policies in your Amazon Web
    /// Services account.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listContinuousDeploymentPolicies(self: *Self, allocator: std.mem.Allocator, input: list_continuous_deployment_policies.ListContinuousDeploymentPoliciesInput, options: list_continuous_deployment_policies.Options) !list_continuous_deployment_policies.ListContinuousDeploymentPoliciesOutput {
        return list_continuous_deployment_policies.execute(self, allocator, input, options);
    }

    /// Lists the distribution tenants in your Amazon Web Services account.
    pub fn listDistributionTenants(self: *Self, allocator: std.mem.Allocator, input: list_distribution_tenants.ListDistributionTenantsInput, options: list_distribution_tenants.Options) !list_distribution_tenants.ListDistributionTenantsOutput {
        return list_distribution_tenants.execute(self, allocator, input, options);
    }

    /// Lists distribution tenants by the customization that you specify.
    ///
    /// You must specify either the `CertificateArn` parameter or `WebACLArn`
    /// parameter, but not both in the same request.
    pub fn listDistributionTenantsByCustomization(self: *Self, allocator: std.mem.Allocator, input: list_distribution_tenants_by_customization.ListDistributionTenantsByCustomizationInput, options: list_distribution_tenants_by_customization.Options) !list_distribution_tenants_by_customization.ListDistributionTenantsByCustomizationOutput {
        return list_distribution_tenants_by_customization.execute(self, allocator, input, options);
    }

    /// List CloudFront distributions.
    pub fn listDistributions(self: *Self, allocator: std.mem.Allocator, input: list_distributions.ListDistributionsInput, options: list_distributions.Options) !list_distributions.ListDistributionsOutput {
        return list_distributions.execute(self, allocator, input, options);
    }

    /// Lists the distributions in your account that are associated with the
    /// specified `AnycastIpListId`.
    pub fn listDistributionsByAnycastIpListId(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_anycast_ip_list_id.ListDistributionsByAnycastIpListIdInput, options: list_distributions_by_anycast_ip_list_id.Options) !list_distributions_by_anycast_ip_list_id.ListDistributionsByAnycastIpListIdOutput {
        return list_distributions_by_anycast_ip_list_id.execute(self, allocator, input, options);
    }

    /// Gets a list of distribution IDs for distributions that have a cache behavior
    /// that's associated with the specified cache policy.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listDistributionsByCachePolicyId(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_cache_policy_id.ListDistributionsByCachePolicyIdInput, options: list_distributions_by_cache_policy_id.Options) !list_distributions_by_cache_policy_id.ListDistributionsByCachePolicyIdOutput {
        return list_distributions_by_cache_policy_id.execute(self, allocator, input, options);
    }

    /// Lists distributions by connection function.
    pub fn listDistributionsByConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_connection_function.ListDistributionsByConnectionFunctionInput, options: list_distributions_by_connection_function.Options) !list_distributions_by_connection_function.ListDistributionsByConnectionFunctionOutput {
        return list_distributions_by_connection_function.execute(self, allocator, input, options);
    }

    /// Lists the distributions by the connection mode that you specify.
    pub fn listDistributionsByConnectionMode(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_connection_mode.ListDistributionsByConnectionModeInput, options: list_distributions_by_connection_mode.Options) !list_distributions_by_connection_mode.ListDistributionsByConnectionModeOutput {
        return list_distributions_by_connection_mode.execute(self, allocator, input, options);
    }

    /// Gets a list of distribution IDs for distributions that have a cache behavior
    /// that references the specified key group.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listDistributionsByKeyGroup(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_key_group.ListDistributionsByKeyGroupInput, options: list_distributions_by_key_group.Options) !list_distributions_by_key_group.ListDistributionsByKeyGroupOutput {
        return list_distributions_by_key_group.execute(self, allocator, input, options);
    }

    /// Gets a list of distribution IDs for distributions that have a cache behavior
    /// that's associated with the specified origin request policy.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listDistributionsByOriginRequestPolicyId(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_origin_request_policy_id.ListDistributionsByOriginRequestPolicyIdInput, options: list_distributions_by_origin_request_policy_id.Options) !list_distributions_by_origin_request_policy_id.ListDistributionsByOriginRequestPolicyIdOutput {
        return list_distributions_by_origin_request_policy_id.execute(self, allocator, input, options);
    }

    /// Lists the CloudFront distributions that are associated with the specified
    /// resource that you own.
    pub fn listDistributionsByOwnedResource(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_owned_resource.ListDistributionsByOwnedResourceInput, options: list_distributions_by_owned_resource.Options) !list_distributions_by_owned_resource.ListDistributionsByOwnedResourceOutput {
        return list_distributions_by_owned_resource.execute(self, allocator, input, options);
    }

    /// Gets a list of distributions that have a cache behavior that's associated
    /// with the specified real-time log configuration.
    ///
    /// You can specify the real-time log configuration by its name or its Amazon
    /// Resource Name (ARN). You must provide at least one. If you provide both,
    /// CloudFront uses the name to identify the real-time log configuration to list
    /// distributions for.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listDistributionsByRealtimeLogConfig(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_realtime_log_config.ListDistributionsByRealtimeLogConfigInput, options: list_distributions_by_realtime_log_config.Options) !list_distributions_by_realtime_log_config.ListDistributionsByRealtimeLogConfigOutput {
        return list_distributions_by_realtime_log_config.execute(self, allocator, input, options);
    }

    /// Gets a list of distribution IDs for distributions that have a cache behavior
    /// that's associated with the specified response headers policy.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listDistributionsByResponseHeadersPolicyId(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_response_headers_policy_id.ListDistributionsByResponseHeadersPolicyIdInput, options: list_distributions_by_response_headers_policy_id.Options) !list_distributions_by_response_headers_policy_id.ListDistributionsByResponseHeadersPolicyIdOutput {
        return list_distributions_by_response_headers_policy_id.execute(self, allocator, input, options);
    }

    /// Lists distributions by trust store.
    pub fn listDistributionsByTrustStore(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_trust_store.ListDistributionsByTrustStoreInput, options: list_distributions_by_trust_store.Options) !list_distributions_by_trust_store.ListDistributionsByTrustStoreOutput {
        return list_distributions_by_trust_store.execute(self, allocator, input, options);
    }

    /// List CloudFront distributions by their VPC origin ID.
    pub fn listDistributionsByVpcOriginId(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_vpc_origin_id.ListDistributionsByVpcOriginIdInput, options: list_distributions_by_vpc_origin_id.Options) !list_distributions_by_vpc_origin_id.ListDistributionsByVpcOriginIdOutput {
        return list_distributions_by_vpc_origin_id.execute(self, allocator, input, options);
    }

    /// List the distributions that are associated with a specified WAF web ACL.
    pub fn listDistributionsByWebAclId(self: *Self, allocator: std.mem.Allocator, input: list_distributions_by_web_acl_id.ListDistributionsByWebACLIdInput, options: list_distributions_by_web_acl_id.Options) !list_distributions_by_web_acl_id.ListDistributionsByWebACLIdOutput {
        return list_distributions_by_web_acl_id.execute(self, allocator, input, options);
    }

    /// We recommend that you use the `ListDomainConflicts` API operation to check
    /// for domain conflicts, as it supports both standard distributions and
    /// distribution tenants.
    /// [ListConflictingAliases](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ListConflictingAliases.html) performs similar checks but only supports standard distributions.
    ///
    /// Lists existing domain associations that conflict with the domain that you
    /// specify.
    ///
    /// You can use this API operation to identify potential domain conflicts when
    /// moving domains between standard distributions and/or distribution tenants.
    /// Domain conflicts must be resolved first before they can be moved.
    ///
    /// For example, if you provide `www.example.com` as input, the returned list
    /// can include `www.example.com` and the overlapping wildcard alternate domain
    /// name (`*.example.com`), if they exist. If you provide `*.example.com` as
    /// input, the returned list can include `*.example.com` and any alternate
    /// domain names covered by that wildcard (for example, `www.example.com`,
    /// `test.example.com`, `dev.example.com`, and so on), if they exist.
    ///
    /// To list conflicting domains, specify the following:
    ///
    /// * The domain to search for
    /// * The ID of a standard distribution or distribution tenant in your account
    ///   that has an attached TLS certificate, which covers the specified domain
    ///
    /// For more information, including how to set up the standard distribution or
    /// distribution tenant, and the certificate, see [Moving an alternate domain
    /// name to a different standard distribution or distribution
    /// tenant](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/CNAMEs.html#alternate-domain-names-move) in the *Amazon CloudFront Developer Guide*.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listDomainConflicts(self: *Self, allocator: std.mem.Allocator, input: list_domain_conflicts.ListDomainConflictsInput, options: list_domain_conflicts.Options) !list_domain_conflicts.ListDomainConflictsOutput {
        return list_domain_conflicts.execute(self, allocator, input, options);
    }

    /// List all field-level encryption configurations that have been created in
    /// CloudFront for this account.
    pub fn listFieldLevelEncryptionConfigs(self: *Self, allocator: std.mem.Allocator, input: list_field_level_encryption_configs.ListFieldLevelEncryptionConfigsInput, options: list_field_level_encryption_configs.Options) !list_field_level_encryption_configs.ListFieldLevelEncryptionConfigsOutput {
        return list_field_level_encryption_configs.execute(self, allocator, input, options);
    }

    /// Request a list of field-level encryption profiles that have been created in
    /// CloudFront for this account.
    pub fn listFieldLevelEncryptionProfiles(self: *Self, allocator: std.mem.Allocator, input: list_field_level_encryption_profiles.ListFieldLevelEncryptionProfilesInput, options: list_field_level_encryption_profiles.Options) !list_field_level_encryption_profiles.ListFieldLevelEncryptionProfilesOutput {
        return list_field_level_encryption_profiles.execute(self, allocator, input, options);
    }

    /// Gets a list of all CloudFront functions in your Amazon Web Services account.
    ///
    /// You can optionally apply a filter to return only the functions that are in
    /// the specified stage, either `DEVELOPMENT` or `LIVE`.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listFunctions(self: *Self, allocator: std.mem.Allocator, input: list_functions.ListFunctionsInput, options: list_functions.Options) !list_functions.ListFunctionsOutput {
        return list_functions.execute(self, allocator, input, options);
    }

    /// Lists invalidation batches.
    pub fn listInvalidations(self: *Self, allocator: std.mem.Allocator, input: list_invalidations.ListInvalidationsInput, options: list_invalidations.Options) !list_invalidations.ListInvalidationsOutput {
        return list_invalidations.execute(self, allocator, input, options);
    }

    /// Lists the invalidations for a distribution tenant.
    pub fn listInvalidationsForDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: list_invalidations_for_distribution_tenant.ListInvalidationsForDistributionTenantInput, options: list_invalidations_for_distribution_tenant.Options) !list_invalidations_for_distribution_tenant.ListInvalidationsForDistributionTenantOutput {
        return list_invalidations_for_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Gets a list of key groups.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listKeyGroups(self: *Self, allocator: std.mem.Allocator, input: list_key_groups.ListKeyGroupsInput, options: list_key_groups.Options) !list_key_groups.ListKeyGroupsOutput {
        return list_key_groups.execute(self, allocator, input, options);
    }

    /// Specifies the key value stores to list.
    pub fn listKeyValueStores(self: *Self, allocator: std.mem.Allocator, input: list_key_value_stores.ListKeyValueStoresInput, options: list_key_value_stores.Options) !list_key_value_stores.ListKeyValueStoresOutput {
        return list_key_value_stores.execute(self, allocator, input, options);
    }

    /// Gets the list of CloudFront origin access controls (OACs) in this Amazon Web
    /// Services account.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send another request that specifies the `NextMarker`
    /// value from the current response as the `Marker` value in the next request.
    ///
    /// If you're not using origin access controls for your Amazon Web Services
    /// account, the `ListOriginAccessControls` operation doesn't return the `Items`
    /// element in the response.
    pub fn listOriginAccessControls(self: *Self, allocator: std.mem.Allocator, input: list_origin_access_controls.ListOriginAccessControlsInput, options: list_origin_access_controls.Options) !list_origin_access_controls.ListOriginAccessControlsOutput {
        return list_origin_access_controls.execute(self, allocator, input, options);
    }

    /// Gets a list of origin request policies.
    ///
    /// You can optionally apply a filter to return only the managed policies
    /// created by Amazon Web Services, or only the custom policies created in your
    /// Amazon Web Services account.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listOriginRequestPolicies(self: *Self, allocator: std.mem.Allocator, input: list_origin_request_policies.ListOriginRequestPoliciesInput, options: list_origin_request_policies.Options) !list_origin_request_policies.ListOriginRequestPoliciesOutput {
        return list_origin_request_policies.execute(self, allocator, input, options);
    }

    /// List all public keys that have been added to CloudFront for this account.
    pub fn listPublicKeys(self: *Self, allocator: std.mem.Allocator, input: list_public_keys.ListPublicKeysInput, options: list_public_keys.Options) !list_public_keys.ListPublicKeysOutput {
        return list_public_keys.execute(self, allocator, input, options);
    }

    /// Gets a list of real-time log configurations.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listRealtimeLogConfigs(self: *Self, allocator: std.mem.Allocator, input: list_realtime_log_configs.ListRealtimeLogConfigsInput, options: list_realtime_log_configs.Options) !list_realtime_log_configs.ListRealtimeLogConfigsOutput {
        return list_realtime_log_configs.execute(self, allocator, input, options);
    }

    /// Gets a list of response headers policies.
    ///
    /// You can optionally apply a filter to get only the managed policies created
    /// by Amazon Web Services, or only the custom policies created in your Amazon
    /// Web Services account.
    ///
    /// You can optionally specify the maximum number of items to receive in the
    /// response. If the total number of items in the list exceeds the maximum that
    /// you specify, or the default maximum, the response is paginated. To get the
    /// next page of items, send a subsequent request that specifies the
    /// `NextMarker` value from the current response as the `Marker` value in the
    /// subsequent request.
    pub fn listResponseHeadersPolicies(self: *Self, allocator: std.mem.Allocator, input: list_response_headers_policies.ListResponseHeadersPoliciesInput, options: list_response_headers_policies.Options) !list_response_headers_policies.ListResponseHeadersPoliciesOutput {
        return list_response_headers_policies.execute(self, allocator, input, options);
    }

    /// List streaming distributions.
    pub fn listStreamingDistributions(self: *Self, allocator: std.mem.Allocator, input: list_streaming_distributions.ListStreamingDistributionsInput, options: list_streaming_distributions.Options) !list_streaming_distributions.ListStreamingDistributionsOutput {
        return list_streaming_distributions.execute(self, allocator, input, options);
    }

    /// List tags for a CloudFront resource. For more information, see [Tagging a
    /// distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/tagging.html) in the *Amazon CloudFront Developer Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists trust stores.
    pub fn listTrustStores(self: *Self, allocator: std.mem.Allocator, input: list_trust_stores.ListTrustStoresInput, options: list_trust_stores.Options) !list_trust_stores.ListTrustStoresOutput {
        return list_trust_stores.execute(self, allocator, input, options);
    }

    /// List the CloudFront VPC origins in your account.
    pub fn listVpcOrigins(self: *Self, allocator: std.mem.Allocator, input: list_vpc_origins.ListVpcOriginsInput, options: list_vpc_origins.Options) !list_vpc_origins.ListVpcOriginsOutput {
        return list_vpc_origins.execute(self, allocator, input, options);
    }

    /// Publishes a connection function.
    pub fn publishConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: publish_connection_function.PublishConnectionFunctionInput, options: publish_connection_function.Options) !publish_connection_function.PublishConnectionFunctionOutput {
        return publish_connection_function.execute(self, allocator, input, options);
    }

    /// Publishes a CloudFront function by copying the function code from the
    /// `DEVELOPMENT` stage to `LIVE`. This automatically updates all cache
    /// behaviors that are using this function to use the newly published copy in
    /// the `LIVE` stage.
    ///
    /// When a function is published to the `LIVE` stage, you can attach the
    /// function to a distribution's cache behavior, using the function's Amazon
    /// Resource Name (ARN).
    ///
    /// To publish a function, you must provide the function's name and version
    /// (`ETag` value). To get these values, you can use `ListFunctions` and
    /// `DescribeFunction`.
    pub fn publishFunction(self: *Self, allocator: std.mem.Allocator, input: publish_function.PublishFunctionInput, options: publish_function.Options) !publish_function.PublishFunctionOutput {
        return publish_function.execute(self, allocator, input, options);
    }

    /// Creates a resource control policy for a given CloudFront resource.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Add tags to a CloudFront resource. For more information, see [Tagging a
    /// distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/tagging.html) in the *Amazon CloudFront Developer Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests a connection function.
    pub fn testConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: test_connection_function.TestConnectionFunctionInput, options: test_connection_function.Options) !test_connection_function.TestConnectionFunctionOutput {
        return test_connection_function.execute(self, allocator, input, options);
    }

    /// Tests a CloudFront function.
    ///
    /// To test a function, you provide an *event object* that represents an HTTP
    /// request or response that your CloudFront distribution could receive in
    /// production. CloudFront runs the function, passing it the event object that
    /// you provided, and returns the function's result (the modified event object)
    /// in the response. The response also contains function logs and error
    /// messages, if any exist. For more information about testing functions, see
    /// [Testing
    /// functions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/managing-functions.html#test-function) in the *Amazon CloudFront Developer Guide*.
    ///
    /// To test a function, you provide the function's name and version (`ETag`
    /// value) along with the event object. To get the function's name and version,
    /// you can use `ListFunctions` and `DescribeFunction`.
    pub fn testFunction(self: *Self, allocator: std.mem.Allocator, input: test_function.TestFunctionInput, options: test_function.Options) !test_function.TestFunctionOutput {
        return test_function.execute(self, allocator, input, options);
    }

    /// Remove tags from a CloudFront resource. For more information, see [Tagging a
    /// distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/tagging.html) in the *Amazon CloudFront Developer Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Anycast static IP list.
    pub fn updateAnycastIpList(self: *Self, allocator: std.mem.Allocator, input: update_anycast_ip_list.UpdateAnycastIpListInput, options: update_anycast_ip_list.Options) !update_anycast_ip_list.UpdateAnycastIpListOutput {
        return update_anycast_ip_list.execute(self, allocator, input, options);
    }

    /// Updates a cache policy configuration.
    ///
    /// When you update a cache policy configuration, all the fields are updated
    /// with the values provided in the request. You cannot update some fields
    /// independent of others. To update a cache policy configuration:
    ///
    /// * Use `GetCachePolicyConfig` to get the current configuration.
    /// * Locally modify the fields in the cache policy configuration that you want
    ///   to update.
    /// * Call `UpdateCachePolicy` by providing the entire cache policy
    ///   configuration, including the fields that you modified and those that you
    ///   didn't.
    ///
    /// If your minimum TTL is greater than 0, CloudFront will cache content for at
    /// least the duration specified in the cache policy's minimum TTL, even if the
    /// `Cache-Control: no-cache`, `no-store`, or `private` directives are present
    /// in the origin headers.
    pub fn updateCachePolicy(self: *Self, allocator: std.mem.Allocator, input: update_cache_policy.UpdateCachePolicyInput, options: update_cache_policy.Options) !update_cache_policy.UpdateCachePolicyOutput {
        return update_cache_policy.execute(self, allocator, input, options);
    }

    /// Update an origin access identity.
    pub fn updateCloudFrontOriginAccessIdentity(self: *Self, allocator: std.mem.Allocator, input: update_cloud_front_origin_access_identity.UpdateCloudFrontOriginAccessIdentityInput, options: update_cloud_front_origin_access_identity.Options) !update_cloud_front_origin_access_identity.UpdateCloudFrontOriginAccessIdentityOutput {
        return update_cloud_front_origin_access_identity.execute(self, allocator, input, options);
    }

    /// Updates a connection function.
    pub fn updateConnectionFunction(self: *Self, allocator: std.mem.Allocator, input: update_connection_function.UpdateConnectionFunctionInput, options: update_connection_function.Options) !update_connection_function.UpdateConnectionFunctionOutput {
        return update_connection_function.execute(self, allocator, input, options);
    }

    /// Updates a connection group.
    pub fn updateConnectionGroup(self: *Self, allocator: std.mem.Allocator, input: update_connection_group.UpdateConnectionGroupInput, options: update_connection_group.Options) !update_connection_group.UpdateConnectionGroupOutput {
        return update_connection_group.execute(self, allocator, input, options);
    }

    /// Updates a continuous deployment policy. You can update a continuous
    /// deployment policy to enable or disable it, to change the percentage of
    /// traffic that it sends to the staging distribution, or to change the staging
    /// distribution that it sends traffic to.
    ///
    /// When you update a continuous deployment policy configuration, all the fields
    /// are updated with the values that are provided in the request. You cannot
    /// update some fields independent of others. To update a continuous deployment
    /// policy configuration:
    ///
    /// * Use `GetContinuousDeploymentPolicyConfig` to get the current
    ///   configuration.
    /// * Locally modify the fields in the continuous deployment policy
    ///   configuration that you want to update.
    /// * Use `UpdateContinuousDeploymentPolicy`, providing the entire continuous
    ///   deployment policy configuration, including the fields that you modified
    ///   and those that you didn't.
    pub fn updateContinuousDeploymentPolicy(self: *Self, allocator: std.mem.Allocator, input: update_continuous_deployment_policy.UpdateContinuousDeploymentPolicyInput, options: update_continuous_deployment_policy.Options) !update_continuous_deployment_policy.UpdateContinuousDeploymentPolicyOutput {
        return update_continuous_deployment_policy.execute(self, allocator, input, options);
    }

    /// Updates the configuration for a CloudFront distribution.
    ///
    /// The update process includes getting the current distribution configuration,
    /// updating it to make your changes, and then submitting an
    /// `UpdateDistribution` request to make the updates.
    ///
    /// **To update a web distribution using the CloudFront API**
    ///
    /// * Use `GetDistributionConfig` to get the current configuration, including
    ///   the version identifier (`ETag`).
    /// * Update the distribution configuration that was returned in the response.
    ///   Note the following important requirements and restrictions:
    ///
    /// * You must copy the `ETag` field value from the response. (You'll use it for
    ///   the `IfMatch` parameter in your request.) Then, remove the `ETag` field
    ///   from the distribution configuration.
    /// * You can't change the value of `CallerReference`.
    ///
    /// * Submit an `UpdateDistribution` request, providing the updated distribution
    ///   configuration. The new configuration replaces the existing configuration.
    ///   The values that you specify in an `UpdateDistribution` request are not
    ///   merged into your existing configuration. Make sure to include all fields:
    ///   the ones that you modified and also the ones that you didn't.
    pub fn updateDistribution(self: *Self, allocator: std.mem.Allocator, input: update_distribution.UpdateDistributionInput, options: update_distribution.Options) !update_distribution.UpdateDistributionOutput {
        return update_distribution.execute(self, allocator, input, options);
    }

    /// Updates a distribution tenant.
    pub fn updateDistributionTenant(self: *Self, allocator: std.mem.Allocator, input: update_distribution_tenant.UpdateDistributionTenantInput, options: update_distribution_tenant.Options) !update_distribution_tenant.UpdateDistributionTenantOutput {
        return update_distribution_tenant.execute(self, allocator, input, options);
    }

    /// Copies the staging distribution's configuration to its corresponding primary
    /// distribution. The primary distribution retains its `Aliases` (also known as
    /// alternate domain names or CNAMEs) and `ContinuousDeploymentPolicyId` value,
    /// but otherwise its configuration is overwritten to match the staging
    /// distribution.
    ///
    /// You can use this operation in a continuous deployment workflow after you
    /// have tested configuration changes on the staging distribution. After using a
    /// continuous deployment policy to move a portion of your domain name's traffic
    /// to the staging distribution and verifying that it works as intended, you can
    /// use this operation to copy the staging distribution's configuration to the
    /// primary distribution. This action will disable the continuous deployment
    /// policy and move your domain's traffic back to the primary distribution.
    ///
    /// This API operation requires the following IAM permissions:
    ///
    /// *
    ///   [GetDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_GetDistribution.html)
    /// *
    ///   [UpdateDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDistribution.html)
    pub fn updateDistributionWithStagingConfig(self: *Self, allocator: std.mem.Allocator, input: update_distribution_with_staging_config.UpdateDistributionWithStagingConfigInput, options: update_distribution_with_staging_config.Options) !update_distribution_with_staging_config.UpdateDistributionWithStagingConfigOutput {
        return update_distribution_with_staging_config.execute(self, allocator, input, options);
    }

    /// We recommend that you use the `UpdateDomainAssociation` API operation to
    /// move a domain association, as it supports both standard distributions and
    /// distribution tenants.
    /// [AssociateAlias](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_AssociateAlias.html) performs similar checks but only supports standard distributions.
    ///
    /// Moves a domain from its current standard distribution or distribution tenant
    /// to another one.
    ///
    /// You must first disable the source distribution (standard distribution or
    /// distribution tenant) and then separately call this operation to move the
    /// domain to another target distribution (standard distribution or distribution
    /// tenant).
    ///
    /// To use this operation, specify the domain and the ID of the target resource
    /// (standard distribution or distribution tenant). For more information,
    /// including how to set up the target resource, prerequisites that you must
    /// complete, and other restrictions, see [Moving an alternate domain name to a
    /// different standard distribution or distribution
    /// tenant](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/CNAMEs.html#alternate-domain-names-move) in the *Amazon CloudFront Developer Guide*.
    pub fn updateDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: update_domain_association.UpdateDomainAssociationInput, options: update_domain_association.Options) !update_domain_association.UpdateDomainAssociationOutput {
        return update_domain_association.execute(self, allocator, input, options);
    }

    /// Update a field-level encryption configuration.
    pub fn updateFieldLevelEncryptionConfig(self: *Self, allocator: std.mem.Allocator, input: update_field_level_encryption_config.UpdateFieldLevelEncryptionConfigInput, options: update_field_level_encryption_config.Options) !update_field_level_encryption_config.UpdateFieldLevelEncryptionConfigOutput {
        return update_field_level_encryption_config.execute(self, allocator, input, options);
    }

    /// Update a field-level encryption profile.
    pub fn updateFieldLevelEncryptionProfile(self: *Self, allocator: std.mem.Allocator, input: update_field_level_encryption_profile.UpdateFieldLevelEncryptionProfileInput, options: update_field_level_encryption_profile.Options) !update_field_level_encryption_profile.UpdateFieldLevelEncryptionProfileOutput {
        return update_field_level_encryption_profile.execute(self, allocator, input, options);
    }

    /// Updates a CloudFront function.
    ///
    /// You can update a function's code or the comment that describes the function.
    /// You cannot update a function's name.
    ///
    /// To update a function, you provide the function's name and version (`ETag`
    /// value) along with the updated function code. To get the name and version,
    /// you can use `ListFunctions` and `DescribeFunction`.
    pub fn updateFunction(self: *Self, allocator: std.mem.Allocator, input: update_function.UpdateFunctionInput, options: update_function.Options) !update_function.UpdateFunctionOutput {
        return update_function.execute(self, allocator, input, options);
    }

    /// Updates a key group.
    ///
    /// When you update a key group, all the fields are updated with the values
    /// provided in the request. You cannot update some fields independent of
    /// others. To update a key group:
    ///
    /// * Get the current key group with `GetKeyGroup` or `GetKeyGroupConfig`.
    /// * Locally modify the fields in the key group that you want to update. For
    ///   example, add or remove public key IDs.
    /// * Call `UpdateKeyGroup` with the entire key group object, including the
    ///   fields that you modified and those that you didn't.
    pub fn updateKeyGroup(self: *Self, allocator: std.mem.Allocator, input: update_key_group.UpdateKeyGroupInput, options: update_key_group.Options) !update_key_group.UpdateKeyGroupOutput {
        return update_key_group.execute(self, allocator, input, options);
    }

    /// Specifies the key value store to update.
    pub fn updateKeyValueStore(self: *Self, allocator: std.mem.Allocator, input: update_key_value_store.UpdateKeyValueStoreInput, options: update_key_value_store.Options) !update_key_value_store.UpdateKeyValueStoreOutput {
        return update_key_value_store.execute(self, allocator, input, options);
    }

    /// Updates a CloudFront origin access control.
    pub fn updateOriginAccessControl(self: *Self, allocator: std.mem.Allocator, input: update_origin_access_control.UpdateOriginAccessControlInput, options: update_origin_access_control.Options) !update_origin_access_control.UpdateOriginAccessControlOutput {
        return update_origin_access_control.execute(self, allocator, input, options);
    }

    /// Updates an origin request policy configuration.
    ///
    /// When you update an origin request policy configuration, all the fields are
    /// updated with the values provided in the request. You cannot update some
    /// fields independent of others. To update an origin request policy
    /// configuration:
    ///
    /// * Use `GetOriginRequestPolicyConfig` to get the current configuration.
    /// * Locally modify the fields in the origin request policy configuration that
    ///   you want to update.
    /// * Call `UpdateOriginRequestPolicy` by providing the entire origin request
    ///   policy configuration, including the fields that you modified and those
    ///   that you didn't.
    pub fn updateOriginRequestPolicy(self: *Self, allocator: std.mem.Allocator, input: update_origin_request_policy.UpdateOriginRequestPolicyInput, options: update_origin_request_policy.Options) !update_origin_request_policy.UpdateOriginRequestPolicyOutput {
        return update_origin_request_policy.execute(self, allocator, input, options);
    }

    /// Update public key information. Note that the only value you can change is
    /// the comment.
    pub fn updatePublicKey(self: *Self, allocator: std.mem.Allocator, input: update_public_key.UpdatePublicKeyInput, options: update_public_key.Options) !update_public_key.UpdatePublicKeyOutput {
        return update_public_key.execute(self, allocator, input, options);
    }

    /// Updates a real-time log configuration.
    ///
    /// When you update a real-time log configuration, all the parameters are
    /// updated with the values provided in the request. You cannot update some
    /// parameters independent of others. To update a real-time log configuration:
    ///
    /// * Call `GetRealtimeLogConfig` to get the current real-time log
    ///   configuration.
    /// * Locally modify the parameters in the real-time log configuration that you
    ///   want to update.
    /// * Call this API (`UpdateRealtimeLogConfig`) by providing the entire
    ///   real-time log configuration, including the parameters that you modified
    ///   and those that you didn't.
    ///
    /// You cannot update a real-time log configuration's `Name` or `ARN`.
    pub fn updateRealtimeLogConfig(self: *Self, allocator: std.mem.Allocator, input: update_realtime_log_config.UpdateRealtimeLogConfigInput, options: update_realtime_log_config.Options) !update_realtime_log_config.UpdateRealtimeLogConfigOutput {
        return update_realtime_log_config.execute(self, allocator, input, options);
    }

    /// Updates a response headers policy.
    ///
    /// When you update a response headers policy, the entire policy is replaced.
    /// You cannot update some policy fields independent of others. To update a
    /// response headers policy configuration:
    ///
    /// * Use `GetResponseHeadersPolicyConfig` to get the current policy's
    ///   configuration.
    /// * Modify the fields in the response headers policy configuration that you
    ///   want to update.
    /// * Call `UpdateResponseHeadersPolicy`, providing the entire response headers
    ///   policy configuration, including the fields that you modified and those
    ///   that you didn't.
    pub fn updateResponseHeadersPolicy(self: *Self, allocator: std.mem.Allocator, input: update_response_headers_policy.UpdateResponseHeadersPolicyInput, options: update_response_headers_policy.Options) !update_response_headers_policy.UpdateResponseHeadersPolicyOutput {
        return update_response_headers_policy.execute(self, allocator, input, options);
    }

    /// Update a streaming distribution.
    pub fn updateStreamingDistribution(self: *Self, allocator: std.mem.Allocator, input: update_streaming_distribution.UpdateStreamingDistributionInput, options: update_streaming_distribution.Options) !update_streaming_distribution.UpdateStreamingDistributionOutput {
        return update_streaming_distribution.execute(self, allocator, input, options);
    }

    /// Updates a trust store.
    pub fn updateTrustStore(self: *Self, allocator: std.mem.Allocator, input: update_trust_store.UpdateTrustStoreInput, options: update_trust_store.Options) !update_trust_store.UpdateTrustStoreOutput {
        return update_trust_store.execute(self, allocator, input, options);
    }

    /// Update an Amazon CloudFront VPC origin in your account.
    pub fn updateVpcOrigin(self: *Self, allocator: std.mem.Allocator, input: update_vpc_origin.UpdateVpcOriginInput, options: update_vpc_origin.Options) !update_vpc_origin.UpdateVpcOriginOutput {
        return update_vpc_origin.execute(self, allocator, input, options);
    }

    /// Verify the DNS configuration for your domain names. This API operation
    /// checks whether your domain name points to the correct routing endpoint of
    /// the connection group, such as d111111abcdef8.cloudfront.net. You can use
    /// this API operation to troubleshoot and resolve DNS configuration issues.
    pub fn verifyDnsConfiguration(self: *Self, allocator: std.mem.Allocator, input: verify_dns_configuration.VerifyDnsConfigurationInput, options: verify_dns_configuration.Options) !verify_dns_configuration.VerifyDnsConfigurationOutput {
        return verify_dns_configuration.execute(self, allocator, input, options);
    }

    pub fn listCloudFrontOriginAccessIdentitiesPaginator(self: *Self, params: list_cloud_front_origin_access_identities.ListCloudFrontOriginAccessIdentitiesInput) paginator.ListCloudFrontOriginAccessIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectionFunctionsPaginator(self: *Self, params: list_connection_functions.ListConnectionFunctionsInput) paginator.ListConnectionFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectionGroupsPaginator(self: *Self, params: list_connection_groups.ListConnectionGroupsInput) paginator.ListConnectionGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionTenantsPaginator(self: *Self, params: list_distribution_tenants.ListDistributionTenantsInput) paginator.ListDistributionTenantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionTenantsByCustomizationPaginator(self: *Self, params: list_distribution_tenants_by_customization.ListDistributionTenantsByCustomizationInput) paginator.ListDistributionTenantsByCustomizationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionsPaginator(self: *Self, params: list_distributions.ListDistributionsInput) paginator.ListDistributionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionsByConnectionFunctionPaginator(self: *Self, params: list_distributions_by_connection_function.ListDistributionsByConnectionFunctionInput) paginator.ListDistributionsByConnectionFunctionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionsByConnectionModePaginator(self: *Self, params: list_distributions_by_connection_mode.ListDistributionsByConnectionModeInput) paginator.ListDistributionsByConnectionModePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionsByTrustStorePaginator(self: *Self, params: list_distributions_by_trust_store.ListDistributionsByTrustStoreInput) paginator.ListDistributionsByTrustStorePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainConflictsPaginator(self: *Self, params: list_domain_conflicts.ListDomainConflictsInput) paginator.ListDomainConflictsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvalidationsPaginator(self: *Self, params: list_invalidations.ListInvalidationsInput) paginator.ListInvalidationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvalidationsForDistributionTenantPaginator(self: *Self, params: list_invalidations_for_distribution_tenant.ListInvalidationsForDistributionTenantInput) paginator.ListInvalidationsForDistributionTenantPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listKeyValueStoresPaginator(self: *Self, params: list_key_value_stores.ListKeyValueStoresInput) paginator.ListKeyValueStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOriginAccessControlsPaginator(self: *Self, params: list_origin_access_controls.ListOriginAccessControlsInput) paginator.ListOriginAccessControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPublicKeysPaginator(self: *Self, params: list_public_keys.ListPublicKeysInput) paginator.ListPublicKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamingDistributionsPaginator(self: *Self, params: list_streaming_distributions.ListStreamingDistributionsInput) paginator.ListStreamingDistributionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrustStoresPaginator(self: *Self, params: list_trust_stores.ListTrustStoresInput) paginator.ListTrustStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilDistributionDeployed(self: *Self, params: get_distribution.GetDistributionInput) aws.waiter.WaiterError!void {
        var w = waiters.DistributionDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInvalidationCompleted(self: *Self, params: get_invalidation.GetInvalidationInput) aws.waiter.WaiterError!void {
        var w = waiters.InvalidationCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInvalidationForDistributionTenantCompleted(self: *Self, params: get_invalidation_for_distribution_tenant.GetInvalidationForDistributionTenantInput) aws.waiter.WaiterError!void {
        var w = waiters.InvalidationForDistributionTenantCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStreamingDistributionDeployed(self: *Self, params: get_streaming_distribution.GetStreamingDistributionInput) aws.waiter.WaiterError!void {
        var w = waiters.StreamingDistributionDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
