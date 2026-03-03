const aws = @import("aws");
const std = @import("std");

const associate_web_acl = @import("associate_web_acl.zig");
const check_capacity = @import("check_capacity.zig");
const create_api_key = @import("create_api_key.zig");
const create_ip_set = @import("create_ip_set.zig");
const create_regex_pattern_set = @import("create_regex_pattern_set.zig");
const create_rule_group = @import("create_rule_group.zig");
const create_web_acl = @import("create_web_acl.zig");
const delete_api_key = @import("delete_api_key.zig");
const delete_firewall_manager_rule_groups = @import("delete_firewall_manager_rule_groups.zig");
const delete_ip_set = @import("delete_ip_set.zig");
const delete_logging_configuration = @import("delete_logging_configuration.zig");
const delete_permission_policy = @import("delete_permission_policy.zig");
const delete_regex_pattern_set = @import("delete_regex_pattern_set.zig");
const delete_rule_group = @import("delete_rule_group.zig");
const delete_web_acl = @import("delete_web_acl.zig");
const describe_all_managed_products = @import("describe_all_managed_products.zig");
const describe_managed_products_by_vendor = @import("describe_managed_products_by_vendor.zig");
const describe_managed_rule_group = @import("describe_managed_rule_group.zig");
const disassociate_web_acl = @import("disassociate_web_acl.zig");
const generate_mobile_sdk_release_url = @import("generate_mobile_sdk_release_url.zig");
const get_decrypted_api_key = @import("get_decrypted_api_key.zig");
const get_ip_set = @import("get_ip_set.zig");
const get_logging_configuration = @import("get_logging_configuration.zig");
const get_managed_rule_set = @import("get_managed_rule_set.zig");
const get_mobile_sdk_release = @import("get_mobile_sdk_release.zig");
const get_permission_policy = @import("get_permission_policy.zig");
const get_rate_based_statement_managed_keys = @import("get_rate_based_statement_managed_keys.zig");
const get_regex_pattern_set = @import("get_regex_pattern_set.zig");
const get_rule_group = @import("get_rule_group.zig");
const get_sampled_requests = @import("get_sampled_requests.zig");
const get_web_acl = @import("get_web_acl.zig");
const get_web_acl_for_resource = @import("get_web_acl_for_resource.zig");
const list_api_keys = @import("list_api_keys.zig");
const list_available_managed_rule_group_versions = @import("list_available_managed_rule_group_versions.zig");
const list_available_managed_rule_groups = @import("list_available_managed_rule_groups.zig");
const list_ip_sets = @import("list_ip_sets.zig");
const list_logging_configurations = @import("list_logging_configurations.zig");
const list_managed_rule_sets = @import("list_managed_rule_sets.zig");
const list_mobile_sdk_releases = @import("list_mobile_sdk_releases.zig");
const list_regex_pattern_sets = @import("list_regex_pattern_sets.zig");
const list_resources_for_web_acl = @import("list_resources_for_web_acl.zig");
const list_rule_groups = @import("list_rule_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_web_ac_ls = @import("list_web_ac_ls.zig");
const put_logging_configuration = @import("put_logging_configuration.zig");
const put_managed_rule_set_versions = @import("put_managed_rule_set_versions.zig");
const put_permission_policy = @import("put_permission_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_ip_set = @import("update_ip_set.zig");
const update_managed_rule_set_version_expiry_date = @import("update_managed_rule_set_version_expiry_date.zig");
const update_regex_pattern_set = @import("update_regex_pattern_set.zig");
const update_rule_group = @import("update_rule_group.zig");
const update_web_acl = @import("update_web_acl.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WAFV2";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates a web ACL with a resource, to protect the resource.
    ///
    /// Use this for all resource types except for Amazon CloudFront distributions.
    /// For Amazon CloudFront, call `UpdateDistribution` for the distribution and
    /// provide the Amazon Resource Name (ARN) of the web ACL in the web ACL ID. For
    /// information, see
    /// [UpdateDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDistribution.html) in the *Amazon CloudFront Developer Guide*.
    ///
    /// **Required permissions for customer-managed IAM policies**
    ///
    /// This call requires permissions that are specific to the protected resource
    /// type.
    /// For details, see [Permissions for
    /// AssociateWebACL](https://docs.aws.amazon.com/waf/latest/developerguide/security_iam_service-with-iam.html#security_iam_action-AssociateWebACL) in the *WAF Developer Guide*.
    ///
    /// **Temporary inconsistencies during updates**
    ///
    /// When you create or change a web ACL or other WAF resources, the changes take
    /// a small amount of time to propagate to all areas where the resources are
    /// stored. The propagation time can be from a few seconds to a number of
    /// minutes.
    ///
    /// The following are examples of the temporary inconsistencies that you might
    /// notice during change propagation:
    ///
    /// * After you create a web ACL, if you try to associate it with a resource,
    ///   you might get an exception indicating that the web ACL is unavailable.
    ///
    /// * After you add a rule group to a web ACL, the new rule group rules might be
    ///   in effect in one area where the web ACL is used and not in another.
    ///
    /// * After you change a rule action setting, you might see the old action in
    ///   some places and the new action in others.
    ///
    /// * After you add an IP address to an IP set that is in use in a blocking
    ///   rule, the new address might be blocked in one area while still allowed in
    ///   another.
    pub fn associateWebAcl(self: *Self, allocator: std.mem.Allocator, input: associate_web_acl.AssociateWebACLInput, options: associate_web_acl.Options) !associate_web_acl.AssociateWebACLOutput {
        return associate_web_acl.execute(self, allocator, input, options);
    }

    /// Returns the web ACL capacity unit (WCU) requirements for a specified scope
    /// and set of rules.
    /// You can use this to check the capacity requirements for the rules you want
    /// to use in a
    /// RuleGroup or WebACL.
    ///
    /// WAF uses WCUs to calculate and control the operating
    /// resources that are used to run your rules, rule groups, and web ACLs. WAF
    /// calculates capacity differently for each rule type, to reflect the relative
    /// cost of each rule.
    /// Simple rules that cost little to run use fewer WCUs than more complex rules
    /// that use more processing power.
    /// Rule group capacity is fixed at creation, which helps users plan their
    /// web ACL WCU usage when they use a rule group. For more information, see [WAF
    /// web ACL capacity units
    /// (WCU)](https://docs.aws.amazon.com/waf/latest/developerguide/aws-waf-capacity-units.html)
    /// in the *WAF Developer Guide*.
    pub fn checkCapacity(self: *Self, allocator: std.mem.Allocator, input: check_capacity.CheckCapacityInput, options: check_capacity.Options) !check_capacity.CheckCapacityOutput {
        return check_capacity.execute(self, allocator, input, options);
    }

    /// Creates an API key that contains a set of token domains.
    ///
    /// API keys are required for the integration of the CAPTCHA API in your
    /// JavaScript client applications.
    /// The API lets you customize the placement and characteristics of the CAPTCHA
    /// puzzle for your end users.
    /// For more information about the CAPTCHA JavaScript integration, see [WAF
    /// client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
    ///
    /// You can use a single key for up to 5 domains. After you generate a key, you
    /// can copy it for use in your JavaScript
    /// integration.
    pub fn createApiKey(self: *Self, allocator: std.mem.Allocator, input: create_api_key.CreateAPIKeyInput, options: create_api_key.Options) !create_api_key.CreateAPIKeyOutput {
        return create_api_key.execute(self, allocator, input, options);
    }

    /// Creates an IPSet, which you use to identify web requests that
    /// originate from specific IP addresses or ranges of IP addresses. For example,
    /// if you're
    /// receiving a lot of requests from a ranges of IP addresses, you can configure
    /// WAF to
    /// block them using an IPSet that lists those IP addresses.
    pub fn createIpSet(self: *Self, allocator: std.mem.Allocator, input: create_ip_set.CreateIPSetInput, options: create_ip_set.Options) !create_ip_set.CreateIPSetOutput {
        return create_ip_set.execute(self, allocator, input, options);
    }

    /// Creates a RegexPatternSet, which you reference in a
    /// RegexPatternSetReferenceStatement, to have WAF inspect a web request
    /// component for the specified patterns.
    pub fn createRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: create_regex_pattern_set.CreateRegexPatternSetInput, options: create_regex_pattern_set.Options) !create_regex_pattern_set.CreateRegexPatternSetOutput {
        return create_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// Creates a RuleGroup per the specifications provided.
    ///
    /// A rule group defines a collection of rules to inspect and control web
    /// requests that you can use in a WebACL. When you create a rule group, you
    /// define an immutable capacity limit. If you update a rule group, you must
    /// stay within the capacity. This allows others to reuse the rule group with
    /// confidence in its capacity requirements.
    pub fn createRuleGroup(self: *Self, allocator: std.mem.Allocator, input: create_rule_group.CreateRuleGroupInput, options: create_rule_group.Options) !create_rule_group.CreateRuleGroupOutput {
        return create_rule_group.execute(self, allocator, input, options);
    }

    /// Creates a WebACL per the specifications provided.
    ///
    /// A web ACL defines a collection of rules to use to inspect and control web
    /// requests. Each rule has a statement that defines what to look for in web
    /// requests and an action that WAF applies to requests that match the
    /// statement. In the web ACL, you assign a default action to take (allow,
    /// block) for any request that does not match any of the rules. The rules in a
    /// web ACL can be a combination of the types Rule, RuleGroup, and managed rule
    /// group. You can associate a web ACL with one or more Amazon Web Services
    /// resources to protect. The resource types include Amazon CloudFront
    /// distribution, Amazon API Gateway REST API, Application Load Balancer,
    /// AppSync GraphQL API, Amazon Cognito user pool, App Runner service, Amplify
    /// application, and Amazon Web Services Verified Access instance.
    pub fn createWebAcl(self: *Self, allocator: std.mem.Allocator, input: create_web_acl.CreateWebACLInput, options: create_web_acl.Options) !create_web_acl.CreateWebACLOutput {
        return create_web_acl.execute(self, allocator, input, options);
    }

    /// Deletes the specified API key.
    ///
    /// After you delete a key, it can take up to 24 hours for WAF to disallow use
    /// of the key in all regions.
    pub fn deleteApiKey(self: *Self, allocator: std.mem.Allocator, input: delete_api_key.DeleteAPIKeyInput, options: delete_api_key.Options) !delete_api_key.DeleteAPIKeyOutput {
        return delete_api_key.execute(self, allocator, input, options);
    }

    /// Deletes all rule groups that are managed by Firewall Manager from the
    /// specified WebACL.
    ///
    /// You can only use this if `ManagedByFirewallManager` and
    /// `RetrofittedByFirewallManager` are both false in the web ACL.
    pub fn deleteFirewallManagerRuleGroups(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_manager_rule_groups.DeleteFirewallManagerRuleGroupsInput, options: delete_firewall_manager_rule_groups.Options) !delete_firewall_manager_rule_groups.DeleteFirewallManagerRuleGroupsOutput {
        return delete_firewall_manager_rule_groups.execute(self, allocator, input, options);
    }

    /// Deletes the specified IPSet.
    pub fn deleteIpSet(self: *Self, allocator: std.mem.Allocator, input: delete_ip_set.DeleteIPSetInput, options: delete_ip_set.Options) !delete_ip_set.DeleteIPSetOutput {
        return delete_ip_set.execute(self, allocator, input, options);
    }

    /// Deletes the LoggingConfiguration from the specified web ACL.
    pub fn deleteLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_logging_configuration.DeleteLoggingConfigurationInput, options: delete_logging_configuration.Options) !delete_logging_configuration.DeleteLoggingConfigurationOutput {
        return delete_logging_configuration.execute(self, allocator, input, options);
    }

    /// Permanently deletes an IAM policy from the specified rule group.
    ///
    /// You must be the owner of the rule group to perform this operation.
    pub fn deletePermissionPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_permission_policy.DeletePermissionPolicyInput, options: delete_permission_policy.Options) !delete_permission_policy.DeletePermissionPolicyOutput {
        return delete_permission_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified RegexPatternSet.
    pub fn deleteRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: delete_regex_pattern_set.DeleteRegexPatternSetInput, options: delete_regex_pattern_set.Options) !delete_regex_pattern_set.DeleteRegexPatternSetOutput {
        return delete_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// Deletes the specified RuleGroup.
    pub fn deleteRuleGroup(self: *Self, allocator: std.mem.Allocator, input: delete_rule_group.DeleteRuleGroupInput, options: delete_rule_group.Options) !delete_rule_group.DeleteRuleGroupOutput {
        return delete_rule_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified WebACL.
    ///
    /// You can only use this if `ManagedByFirewallManager` is false in the web ACL.
    ///
    /// Before deleting any web ACL, first disassociate it from all resources.
    ///
    /// * To retrieve a list of the resources that are associated with a web ACL,
    ///   use the
    /// following calls:
    ///
    /// * For Amazon CloudFront distributions, use the CloudFront call
    /// `ListDistributionsByWebACLId`. For information, see
    /// [ListDistributionsByWebACLId](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ListDistributionsByWebACLId.html)
    /// in the *Amazon CloudFront API Reference*.
    ///
    /// * For all other resources, call ListResourcesForWebACL.
    ///
    /// * To disassociate a resource from a web ACL, use the following calls:
    ///
    /// * For Amazon CloudFront distributions, provide an empty web ACL ID in the
    ///   CloudFront call
    /// `UpdateDistribution`. For information, see
    /// [UpdateDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDistribution.html)
    /// in the *Amazon CloudFront API Reference*.
    ///
    /// * For all other resources, call DisassociateWebACL.
    pub fn deleteWebAcl(self: *Self, allocator: std.mem.Allocator, input: delete_web_acl.DeleteWebACLInput, options: delete_web_acl.Options) !delete_web_acl.DeleteWebACLOutput {
        return delete_web_acl.execute(self, allocator, input, options);
    }

    /// Provides high-level information for the Amazon Web Services Managed Rules
    /// rule groups and Amazon Web Services Marketplace managed rule groups.
    pub fn describeAllManagedProducts(self: *Self, allocator: std.mem.Allocator, input: describe_all_managed_products.DescribeAllManagedProductsInput, options: describe_all_managed_products.Options) !describe_all_managed_products.DescribeAllManagedProductsOutput {
        return describe_all_managed_products.execute(self, allocator, input, options);
    }

    /// Provides high-level information for the managed rule groups owned by a
    /// specific vendor.
    pub fn describeManagedProductsByVendor(self: *Self, allocator: std.mem.Allocator, input: describe_managed_products_by_vendor.DescribeManagedProductsByVendorInput, options: describe_managed_products_by_vendor.Options) !describe_managed_products_by_vendor.DescribeManagedProductsByVendorOutput {
        return describe_managed_products_by_vendor.execute(self, allocator, input, options);
    }

    /// Provides high-level information for a managed rule group, including
    /// descriptions of the rules.
    pub fn describeManagedRuleGroup(self: *Self, allocator: std.mem.Allocator, input: describe_managed_rule_group.DescribeManagedRuleGroupInput, options: describe_managed_rule_group.Options) !describe_managed_rule_group.DescribeManagedRuleGroupOutput {
        return describe_managed_rule_group.execute(self, allocator, input, options);
    }

    /// Disassociates the specified resource from its web ACL
    /// association, if it has one.
    ///
    /// Use this for all resource types except for Amazon CloudFront distributions.
    /// For Amazon CloudFront, call `UpdateDistribution` for the distribution and
    /// provide an empty web ACL ID. For information, see
    /// [UpdateDistribution](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDistribution.html) in the *Amazon CloudFront API Reference*.
    ///
    /// **Required permissions for customer-managed IAM policies**
    ///
    /// This call requires permissions that are specific to the protected resource
    /// type.
    /// For details, see [Permissions for
    /// DisassociateWebACL](https://docs.aws.amazon.com/waf/latest/developerguide/security_iam_service-with-iam.html#security_iam_action-DisassociateWebACL) in the *WAF Developer Guide*.
    pub fn disassociateWebAcl(self: *Self, allocator: std.mem.Allocator, input: disassociate_web_acl.DisassociateWebACLInput, options: disassociate_web_acl.Options) !disassociate_web_acl.DisassociateWebACLOutput {
        return disassociate_web_acl.execute(self, allocator, input, options);
    }

    /// Generates a presigned download URL for the specified release of the mobile
    /// SDK.
    ///
    /// The mobile SDK is not generally available. Customers who have access to the
    /// mobile SDK can use it to establish and manage WAF tokens for use in HTTP(S)
    /// requests from a mobile device to WAF. For more information, see
    /// [WAF client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
    pub fn generateMobileSdkReleaseUrl(self: *Self, allocator: std.mem.Allocator, input: generate_mobile_sdk_release_url.GenerateMobileSdkReleaseUrlInput, options: generate_mobile_sdk_release_url.Options) !generate_mobile_sdk_release_url.GenerateMobileSdkReleaseUrlOutput {
        return generate_mobile_sdk_release_url.execute(self, allocator, input, options);
    }

    /// Returns your API key in decrypted form. Use this to check the token domains
    /// that you have defined for the key.
    ///
    /// API keys are required for the integration of the CAPTCHA API in your
    /// JavaScript client applications.
    /// The API lets you customize the placement and characteristics of the CAPTCHA
    /// puzzle for your end users.
    /// For more information about the CAPTCHA JavaScript integration, see [WAF
    /// client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
    pub fn getDecryptedApiKey(self: *Self, allocator: std.mem.Allocator, input: get_decrypted_api_key.GetDecryptedAPIKeyInput, options: get_decrypted_api_key.Options) !get_decrypted_api_key.GetDecryptedAPIKeyOutput {
        return get_decrypted_api_key.execute(self, allocator, input, options);
    }

    /// Retrieves the specified IPSet.
    pub fn getIpSet(self: *Self, allocator: std.mem.Allocator, input: get_ip_set.GetIPSetInput, options: get_ip_set.Options) !get_ip_set.GetIPSetOutput {
        return get_ip_set.execute(self, allocator, input, options);
    }

    /// Returns the LoggingConfiguration for the specified web ACL.
    pub fn getLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_logging_configuration.GetLoggingConfigurationInput, options: get_logging_configuration.Options) !get_logging_configuration.GetLoggingConfigurationOutput {
        return get_logging_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the specified managed rule set.
    ///
    /// This is intended for use only by vendors of managed rule sets. Vendors are
    /// Amazon Web Services and Amazon Web Services Marketplace sellers.
    ///
    /// Vendors, you can use the managed rule set APIs to provide controlled rollout
    /// of your versioned managed rule group offerings for your customers. The APIs
    /// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
    /// and `UpdateManagedRuleSetVersionExpiryDate`.
    pub fn getManagedRuleSet(self: *Self, allocator: std.mem.Allocator, input: get_managed_rule_set.GetManagedRuleSetInput, options: get_managed_rule_set.Options) !get_managed_rule_set.GetManagedRuleSetOutput {
        return get_managed_rule_set.execute(self, allocator, input, options);
    }

    /// Retrieves information for the specified mobile SDK release, including
    /// release notes and
    /// tags.
    ///
    /// The mobile SDK is not generally available. Customers who have access to the
    /// mobile SDK can use it to establish and manage WAF tokens for use in HTTP(S)
    /// requests from a mobile device to WAF. For more information, see
    /// [WAF client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
    pub fn getMobileSdkRelease(self: *Self, allocator: std.mem.Allocator, input: get_mobile_sdk_release.GetMobileSdkReleaseInput, options: get_mobile_sdk_release.Options) !get_mobile_sdk_release.GetMobileSdkReleaseOutput {
        return get_mobile_sdk_release.execute(self, allocator, input, options);
    }

    /// Returns the IAM policy that is attached to the specified rule group.
    ///
    /// You must be the owner of the rule group to perform this operation.
    pub fn getPermissionPolicy(self: *Self, allocator: std.mem.Allocator, input: get_permission_policy.GetPermissionPolicyInput, options: get_permission_policy.Options) !get_permission_policy.GetPermissionPolicyOutput {
        return get_permission_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the IP addresses that are currently blocked by a rate-based rule
    /// instance. This
    /// is only available for rate-based rules that aggregate solely on the IP
    /// address or on the forwarded IP
    /// address.
    ///
    /// The maximum
    /// number of addresses that can be blocked for a single rate-based rule
    /// instance is 10,000.
    /// If more than 10,000 addresses exceed the rate limit, those with the highest
    /// rates are
    /// blocked.
    ///
    /// For a rate-based rule that you've defined inside a rule group, provide the
    /// name of the
    /// rule group reference statement in your request, in addition to the
    /// rate-based rule name and
    /// the web ACL name.
    ///
    /// WAF monitors web requests and manages keys independently for each unique
    /// combination
    /// of web ACL, optional rule group, and rate-based rule. For example, if you
    /// define a
    /// rate-based rule inside a rule group, and then use the rule group in a web
    /// ACL, WAF
    /// monitors web requests and manages keys for that web ACL, rule group
    /// reference statement,
    /// and rate-based rule instance. If you use the same rule group in a second web
    /// ACL, WAF
    /// monitors web requests and manages keys for this second usage completely
    /// independent of your
    /// first.
    pub fn getRateBasedStatementManagedKeys(self: *Self, allocator: std.mem.Allocator, input: get_rate_based_statement_managed_keys.GetRateBasedStatementManagedKeysInput, options: get_rate_based_statement_managed_keys.Options) !get_rate_based_statement_managed_keys.GetRateBasedStatementManagedKeysOutput {
        return get_rate_based_statement_managed_keys.execute(self, allocator, input, options);
    }

    /// Retrieves the specified RegexPatternSet.
    pub fn getRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: get_regex_pattern_set.GetRegexPatternSetInput, options: get_regex_pattern_set.Options) !get_regex_pattern_set.GetRegexPatternSetOutput {
        return get_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// Retrieves the specified RuleGroup.
    pub fn getRuleGroup(self: *Self, allocator: std.mem.Allocator, input: get_rule_group.GetRuleGroupInput, options: get_rule_group.Options) !get_rule_group.GetRuleGroupOutput {
        return get_rule_group.execute(self, allocator, input, options);
    }

    /// Gets detailed information about a specified number of requests--a
    /// sample--that WAF
    /// randomly selects from among the first 5,000 requests that your Amazon Web
    /// Services resource received
    /// during a time range that you choose. You can specify a sample size of up to
    /// 500 requests,
    /// and you can specify any time range in the previous three hours.
    ///
    /// `GetSampledRequests` returns a time range, which is usually the time range
    /// that
    /// you specified. However, if your resource (such as a CloudFront distribution)
    /// received 5,000
    /// requests before the specified time range elapsed, `GetSampledRequests`
    /// returns
    /// an updated time range. This new time range indicates the actual period
    /// during which WAF
    /// selected the requests in the sample.
    pub fn getSampledRequests(self: *Self, allocator: std.mem.Allocator, input: get_sampled_requests.GetSampledRequestsInput, options: get_sampled_requests.Options) !get_sampled_requests.GetSampledRequestsOutput {
        return get_sampled_requests.execute(self, allocator, input, options);
    }

    /// Retrieves the specified WebACL.
    pub fn getWebAcl(self: *Self, allocator: std.mem.Allocator, input: get_web_acl.GetWebACLInput, options: get_web_acl.Options) !get_web_acl.GetWebACLOutput {
        return get_web_acl.execute(self, allocator, input, options);
    }

    /// Retrieves the WebACL for the specified resource.
    ///
    /// This call uses `GetWebACL`, to verify that your account has permission to
    /// access the retrieved web ACL.
    /// If you get an error that indicates that your account isn't authorized to
    /// perform `wafv2:GetWebACL` on the resource,
    /// that error won't be included in your CloudTrail event history.
    ///
    /// For Amazon CloudFront, don't use this call. Instead, call the CloudFront
    /// action
    /// `GetDistributionConfig`. For information, see
    /// [GetDistributionConfig](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_GetDistributionConfig.html) in the *Amazon CloudFront API Reference*.
    ///
    /// **Required permissions for customer-managed IAM policies**
    ///
    /// This call requires permissions that are specific to the protected resource
    /// type.
    /// For details, see [Permissions for
    /// GetWebACLForResource](https://docs.aws.amazon.com/waf/latest/developerguide/security_iam_service-with-iam.html#security_iam_action-GetWebACLForResource) in the *WAF Developer Guide*.
    pub fn getWebAclForResource(self: *Self, allocator: std.mem.Allocator, input: get_web_acl_for_resource.GetWebACLForResourceInput, options: get_web_acl_for_resource.Options) !get_web_acl_for_resource.GetWebACLForResourceOutput {
        return get_web_acl_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the API keys that you've defined for the specified
    /// scope.
    ///
    /// API keys are required for the integration of the CAPTCHA API in your
    /// JavaScript client applications.
    /// The API lets you customize the placement and characteristics of the CAPTCHA
    /// puzzle for your end users.
    /// For more information about the CAPTCHA JavaScript integration, see [WAF
    /// client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
    pub fn listApiKeys(self: *Self, allocator: std.mem.Allocator, input: list_api_keys.ListAPIKeysInput, options: list_api_keys.Options) !list_api_keys.ListAPIKeysOutput {
        return list_api_keys.execute(self, allocator, input, options);
    }

    /// Returns a list of the available versions for the specified managed rule
    /// group.
    pub fn listAvailableManagedRuleGroupVersions(self: *Self, allocator: std.mem.Allocator, input: list_available_managed_rule_group_versions.ListAvailableManagedRuleGroupVersionsInput, options: list_available_managed_rule_group_versions.Options) !list_available_managed_rule_group_versions.ListAvailableManagedRuleGroupVersionsOutput {
        return list_available_managed_rule_group_versions.execute(self, allocator, input, options);
    }

    /// Retrieves an array of managed rule groups that are available for you to use.
    /// This list
    /// includes all Amazon Web Services Managed Rules rule groups and all of the
    /// Amazon Web Services Marketplace managed rule groups that you're
    /// subscribed to.
    pub fn listAvailableManagedRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_available_managed_rule_groups.ListAvailableManagedRuleGroupsInput, options: list_available_managed_rule_groups.Options) !list_available_managed_rule_groups.ListAvailableManagedRuleGroupsOutput {
        return list_available_managed_rule_groups.execute(self, allocator, input, options);
    }

    /// Retrieves an array of IPSetSummary objects for the IP sets that you
    /// manage.
    pub fn listIpSets(self: *Self, allocator: std.mem.Allocator, input: list_ip_sets.ListIPSetsInput, options: list_ip_sets.Options) !list_ip_sets.ListIPSetsOutput {
        return list_ip_sets.execute(self, allocator, input, options);
    }

    /// Retrieves an array of your LoggingConfiguration objects.
    pub fn listLoggingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_logging_configurations.ListLoggingConfigurationsInput, options: list_logging_configurations.Options) !list_logging_configurations.ListLoggingConfigurationsOutput {
        return list_logging_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves the managed rule sets that you own.
    ///
    /// This is intended for use only by vendors of managed rule sets. Vendors are
    /// Amazon Web Services and Amazon Web Services Marketplace sellers.
    ///
    /// Vendors, you can use the managed rule set APIs to provide controlled rollout
    /// of your versioned managed rule group offerings for your customers. The APIs
    /// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
    /// and `UpdateManagedRuleSetVersionExpiryDate`.
    pub fn listManagedRuleSets(self: *Self, allocator: std.mem.Allocator, input: list_managed_rule_sets.ListManagedRuleSetsInput, options: list_managed_rule_sets.Options) !list_managed_rule_sets.ListManagedRuleSetsOutput {
        return list_managed_rule_sets.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the available releases for the mobile SDK and the
    /// specified device
    /// platform.
    ///
    /// The mobile SDK is not generally available. Customers who have access to the
    /// mobile SDK can use it to establish and manage WAF tokens for use in HTTP(S)
    /// requests from a mobile device to WAF. For more information, see
    /// [WAF client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html) in the *WAF Developer Guide*.
    pub fn listMobileSdkReleases(self: *Self, allocator: std.mem.Allocator, input: list_mobile_sdk_releases.ListMobileSdkReleasesInput, options: list_mobile_sdk_releases.Options) !list_mobile_sdk_releases.ListMobileSdkReleasesOutput {
        return list_mobile_sdk_releases.execute(self, allocator, input, options);
    }

    /// Retrieves an array of RegexPatternSetSummary objects for the regex
    /// pattern sets that you manage.
    pub fn listRegexPatternSets(self: *Self, allocator: std.mem.Allocator, input: list_regex_pattern_sets.ListRegexPatternSetsInput, options: list_regex_pattern_sets.Options) !list_regex_pattern_sets.ListRegexPatternSetsOutput {
        return list_regex_pattern_sets.execute(self, allocator, input, options);
    }

    /// Retrieves an array of the Amazon Resource Names (ARNs) for the resources
    /// that
    /// are associated with the specified web ACL.
    ///
    /// For Amazon CloudFront, don't use this call. Instead, use the CloudFront call
    /// `ListDistributionsByWebACLId`. For information, see
    /// [ListDistributionsByWebACLId](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ListDistributionsByWebACLId.html)
    /// in the *Amazon CloudFront API Reference*.
    ///
    /// **Required permissions for customer-managed IAM policies**
    ///
    /// This call requires permissions that are specific to the protected resource
    /// type.
    /// For details, see [Permissions for
    /// ListResourcesForWebACL](https://docs.aws.amazon.com/waf/latest/developerguide/security_iam_service-with-iam.html#security_iam_action-ListResourcesForWebACL) in the *WAF Developer Guide*.
    pub fn listResourcesForWebAcl(self: *Self, allocator: std.mem.Allocator, input: list_resources_for_web_acl.ListResourcesForWebACLInput, options: list_resources_for_web_acl.Options) !list_resources_for_web_acl.ListResourcesForWebACLOutput {
        return list_resources_for_web_acl.execute(self, allocator, input, options);
    }

    /// Retrieves an array of RuleGroupSummary objects for the rule groups
    /// that you manage.
    pub fn listRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_rule_groups.ListRuleGroupsInput, options: list_rule_groups.Options) !list_rule_groups.ListRuleGroupsOutput {
        return list_rule_groups.execute(self, allocator, input, options);
    }

    /// Retrieves the TagInfoForResource for the specified resource. Tags are
    /// key:value pairs that you can use to categorize and manage your resources,
    /// for purposes like
    /// billing. For example, you might set the tag key to "customer" and the value
    /// to the customer
    /// name or ID. You can specify one or more tags to add to each Amazon Web
    /// Services resource, up to 50 tags
    /// for a resource.
    ///
    /// You can tag the Amazon Web Services resources that you manage through WAF:
    /// web ACLs, rule
    /// groups, IP sets, and regex pattern sets. You can't manage or view tags
    /// through the WAF
    /// console.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves an array of WebACLSummary objects for the web ACLs that you
    /// manage.
    pub fn listWebAcLs(self: *Self, allocator: std.mem.Allocator, input: list_web_ac_ls.ListWebACLsInput, options: list_web_ac_ls.Options) !list_web_ac_ls.ListWebACLsOutput {
        return list_web_ac_ls.execute(self, allocator, input, options);
    }

    /// Enables the specified LoggingConfiguration, to start logging from a
    /// web ACL, according to the configuration provided.
    ///
    /// If you configure data protection for the web ACL, the protection applies to
    /// the data that WAF sends to the logs.
    ///
    /// This operation completely replaces any mutable specifications that you
    /// already have for a logging configuration with the ones that you provide to
    /// this call.
    ///
    /// To modify an existing logging configuration, do the following:
    ///
    /// * Retrieve it by calling GetLoggingConfiguration
    ///
    /// * Update its settings as needed
    ///
    /// * Provide the complete logging configuration specification to this call
    ///
    /// You can define one logging destination per web ACL.
    ///
    /// You can access information about the traffic that WAF inspects using the
    /// following
    /// steps:
    ///
    /// * Create your logging destination. You can use an Amazon CloudWatch Logs log
    ///   group, an Amazon Simple Storage Service (Amazon S3) bucket, or an Amazon
    ///   Kinesis Data Firehose.
    ///
    /// The name that you give the destination must start with `aws-waf-logs-`.
    /// Depending on the type of destination, you might need to configure additional
    /// settings or permissions.
    ///
    /// For configuration requirements and pricing information for each destination
    /// type, see
    /// [Logging web ACL
    /// traffic](https://docs.aws.amazon.com/waf/latest/developerguide/logging.html)
    /// in the *WAF Developer Guide*.
    ///
    /// * Associate your logging destination to your web ACL using a
    /// `PutLoggingConfiguration` request.
    ///
    /// When you successfully enable logging using a `PutLoggingConfiguration`
    /// request, WAF creates an additional role or policy that is required to write
    /// logs to the logging destination. For an Amazon CloudWatch Logs log group,
    /// WAF creates a resource policy on the log group.
    /// For an Amazon S3 bucket, WAF creates a bucket policy. For an Amazon Kinesis
    /// Data Firehose, WAF creates a service-linked role.
    ///
    /// For additional information about web ACL logging, see
    /// [Logging web ACL traffic
    /// information](https://docs.aws.amazon.com/waf/latest/developerguide/logging.html)
    /// in the *WAF Developer Guide*.
    pub fn putLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_logging_configuration.PutLoggingConfigurationInput, options: put_logging_configuration.Options) !put_logging_configuration.PutLoggingConfigurationOutput {
        return put_logging_configuration.execute(self, allocator, input, options);
    }

    /// Defines the versions of your managed rule set that you are offering to the
    /// customers.
    /// Customers see your offerings as managed rule groups with versioning.
    ///
    /// This is intended for use only by vendors of managed rule sets. Vendors are
    /// Amazon Web Services and Amazon Web Services Marketplace sellers.
    ///
    /// Vendors, you can use the managed rule set APIs to provide controlled rollout
    /// of your versioned managed rule group offerings for your customers. The APIs
    /// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
    /// and `UpdateManagedRuleSetVersionExpiryDate`.
    ///
    /// Customers retrieve their managed rule group list by calling
    /// ListAvailableManagedRuleGroups. The name that you provide here for your
    /// managed rule set is the name the customer sees for the corresponding managed
    /// rule group.
    /// Customers can retrieve the available versions for a managed rule group by
    /// calling ListAvailableManagedRuleGroupVersions. You provide a rule group
    /// specification for each version. For each managed rule set, you must specify
    /// a version that
    /// you recommend using.
    ///
    /// To initiate the expiration of a managed rule group version, use
    /// UpdateManagedRuleSetVersionExpiryDate.
    pub fn putManagedRuleSetVersions(self: *Self, allocator: std.mem.Allocator, input: put_managed_rule_set_versions.PutManagedRuleSetVersionsInput, options: put_managed_rule_set_versions.Options) !put_managed_rule_set_versions.PutManagedRuleSetVersionsOutput {
        return put_managed_rule_set_versions.execute(self, allocator, input, options);
    }

    /// Use this to share a rule group with other accounts.
    ///
    /// This action attaches an IAM policy to the specified resource. You must be
    /// the owner of the rule group to perform this operation.
    ///
    /// This action is subject to the following restrictions:
    ///
    /// * You can attach only one policy with each `PutPermissionPolicy`
    /// request.
    ///
    /// * The ARN in the request must be a valid WAF RuleGroup ARN and the
    /// rule group must exist in the same Region.
    ///
    /// * The user making the request must be the owner of the rule group.
    ///
    /// If a rule group has been shared with your account, you can access it through
    /// the call `GetRuleGroup`,
    /// and you can reference it in `CreateWebACL` and `UpdateWebACL`.
    /// Rule groups that are shared with you don't appear in your WAF console rule
    /// groups listing.
    pub fn putPermissionPolicy(self: *Self, allocator: std.mem.Allocator, input: put_permission_policy.PutPermissionPolicyInput, options: put_permission_policy.Options) !put_permission_policy.PutPermissionPolicyOutput {
        return put_permission_policy.execute(self, allocator, input, options);
    }

    /// Associates tags with the specified Amazon Web Services resource. Tags are
    /// key:value pairs that you can
    /// use to categorize and manage your resources, for purposes like billing. For
    /// example, you
    /// might set the tag key to "customer" and the value to the customer name or
    /// ID. You can
    /// specify one or more tags to add to each Amazon Web Services resource, up to
    /// 50 tags for a
    /// resource.
    ///
    /// You can tag the Amazon Web Services resources that you manage through WAF:
    /// web ACLs, rule
    /// groups, IP sets, and regex pattern sets. You can't manage or view tags
    /// through the WAF
    /// console.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Disassociates tags from an Amazon Web Services resource. Tags are key:value
    /// pairs that you can
    /// associate with Amazon Web Services resources. For example, the tag key might
    /// be "customer" and the tag
    /// value might be "companyA." You can specify one or more tags to add to each
    /// container. You
    /// can add up to 50 tags to each Amazon Web Services resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified IPSet.
    ///
    /// This operation completely replaces the mutable specifications that you
    /// already have for the IP set with the ones that you provide to this call.
    ///
    /// To modify an IP set, do the following:
    ///
    /// * Retrieve it by calling GetIPSet
    ///
    /// * Update its settings as needed
    ///
    /// * Provide the complete IP set specification to this call
    ///
    /// **Temporary inconsistencies during updates**
    ///
    /// When you create or change a web ACL or other WAF resources, the changes take
    /// a small amount of time to propagate to all areas where the resources are
    /// stored. The propagation time can be from a few seconds to a number of
    /// minutes.
    ///
    /// The following are examples of the temporary inconsistencies that you might
    /// notice during change propagation:
    ///
    /// * After you create a web ACL, if you try to associate it with a resource,
    ///   you might get an exception indicating that the web ACL is unavailable.
    ///
    /// * After you add a rule group to a web ACL, the new rule group rules might be
    ///   in effect in one area where the web ACL is used and not in another.
    ///
    /// * After you change a rule action setting, you might see the old action in
    ///   some places and the new action in others.
    ///
    /// * After you add an IP address to an IP set that is in use in a blocking
    ///   rule, the new address might be blocked in one area while still allowed in
    ///   another.
    pub fn updateIpSet(self: *Self, allocator: std.mem.Allocator, input: update_ip_set.UpdateIPSetInput, options: update_ip_set.Options) !update_ip_set.UpdateIPSetOutput {
        return update_ip_set.execute(self, allocator, input, options);
    }

    /// Updates the expiration information for your managed rule set. Use this to
    /// initiate the
    /// expiration of a managed rule group version. After you initiate expiration
    /// for a version,
    /// WAF excludes it from the response to ListAvailableManagedRuleGroupVersions
    /// for the managed rule group.
    ///
    /// This is intended for use only by vendors of managed rule sets. Vendors are
    /// Amazon Web Services and Amazon Web Services Marketplace sellers.
    ///
    /// Vendors, you can use the managed rule set APIs to provide controlled rollout
    /// of your versioned managed rule group offerings for your customers. The APIs
    /// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
    /// and `UpdateManagedRuleSetVersionExpiryDate`.
    pub fn updateManagedRuleSetVersionExpiryDate(self: *Self, allocator: std.mem.Allocator, input: update_managed_rule_set_version_expiry_date.UpdateManagedRuleSetVersionExpiryDateInput, options: update_managed_rule_set_version_expiry_date.Options) !update_managed_rule_set_version_expiry_date.UpdateManagedRuleSetVersionExpiryDateOutput {
        return update_managed_rule_set_version_expiry_date.execute(self, allocator, input, options);
    }

    /// Updates the specified RegexPatternSet.
    ///
    /// This operation completely replaces the mutable specifications that you
    /// already have for the regex pattern set with the ones that you provide to
    /// this call.
    ///
    /// To modify a regex pattern set, do the following:
    ///
    /// * Retrieve it by calling GetRegexPatternSet
    ///
    /// * Update its settings as needed
    ///
    /// * Provide the complete regex pattern set specification to this call
    ///
    /// **Temporary inconsistencies during updates**
    ///
    /// When you create or change a web ACL or other WAF resources, the changes take
    /// a small amount of time to propagate to all areas where the resources are
    /// stored. The propagation time can be from a few seconds to a number of
    /// minutes.
    ///
    /// The following are examples of the temporary inconsistencies that you might
    /// notice during change propagation:
    ///
    /// * After you create a web ACL, if you try to associate it with a resource,
    ///   you might get an exception indicating that the web ACL is unavailable.
    ///
    /// * After you add a rule group to a web ACL, the new rule group rules might be
    ///   in effect in one area where the web ACL is used and not in another.
    ///
    /// * After you change a rule action setting, you might see the old action in
    ///   some places and the new action in others.
    ///
    /// * After you add an IP address to an IP set that is in use in a blocking
    ///   rule, the new address might be blocked in one area while still allowed in
    ///   another.
    pub fn updateRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: update_regex_pattern_set.UpdateRegexPatternSetInput, options: update_regex_pattern_set.Options) !update_regex_pattern_set.UpdateRegexPatternSetOutput {
        return update_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// Updates the specified RuleGroup.
    ///
    /// This operation completely replaces the mutable specifications that you
    /// already have for the rule group with the ones that you provide to this call.
    ///
    /// To modify a rule group, do the following:
    ///
    /// * Retrieve it by calling GetRuleGroup
    ///
    /// * Update its settings as needed
    ///
    /// * Provide the complete rule group specification to this call
    ///
    /// A rule group defines a collection of rules to inspect and control web
    /// requests that you can use in a WebACL. When you create a rule group, you
    /// define an immutable capacity limit. If you update a rule group, you must
    /// stay within the capacity. This allows others to reuse the rule group with
    /// confidence in its capacity requirements.
    ///
    /// **Temporary inconsistencies during updates**
    ///
    /// When you create or change a web ACL or other WAF resources, the changes take
    /// a small amount of time to propagate to all areas where the resources are
    /// stored. The propagation time can be from a few seconds to a number of
    /// minutes.
    ///
    /// The following are examples of the temporary inconsistencies that you might
    /// notice during change propagation:
    ///
    /// * After you create a web ACL, if you try to associate it with a resource,
    ///   you might get an exception indicating that the web ACL is unavailable.
    ///
    /// * After you add a rule group to a web ACL, the new rule group rules might be
    ///   in effect in one area where the web ACL is used and not in another.
    ///
    /// * After you change a rule action setting, you might see the old action in
    ///   some places and the new action in others.
    ///
    /// * After you add an IP address to an IP set that is in use in a blocking
    ///   rule, the new address might be blocked in one area while still allowed in
    ///   another.
    pub fn updateRuleGroup(self: *Self, allocator: std.mem.Allocator, input: update_rule_group.UpdateRuleGroupInput, options: update_rule_group.Options) !update_rule_group.UpdateRuleGroupOutput {
        return update_rule_group.execute(self, allocator, input, options);
    }

    /// Updates the specified WebACL. While updating a web ACL, WAF provides
    /// continuous coverage to the resources that you have associated with the web
    /// ACL.
    ///
    /// This operation completely replaces the mutable specifications that you
    /// already have for the web ACL with the ones that you provide to this call.
    ///
    /// To modify a web ACL, do the following:
    ///
    /// * Retrieve it by calling GetWebACL
    ///
    /// * Update its settings as needed
    ///
    /// * Provide the complete web ACL specification to this call
    ///
    /// A web ACL defines a collection of rules to use to inspect and control web
    /// requests. Each rule has a statement that defines what to look for in web
    /// requests and an action that WAF applies to requests that match the
    /// statement. In the web ACL, you assign a default action to take (allow,
    /// block) for any request that does not match any of the rules. The rules in a
    /// web ACL can be a combination of the types Rule, RuleGroup, and managed rule
    /// group. You can associate a web ACL with one or more Amazon Web Services
    /// resources to protect. The resource types include Amazon CloudFront
    /// distribution, Amazon API Gateway REST API, Application Load Balancer,
    /// AppSync GraphQL API, Amazon Cognito user pool, App Runner service, Amplify
    /// application, and Amazon Web Services Verified Access instance.
    ///
    /// **Temporary inconsistencies during updates**
    ///
    /// When you create or change a web ACL or other WAF resources, the changes take
    /// a small amount of time to propagate to all areas where the resources are
    /// stored. The propagation time can be from a few seconds to a number of
    /// minutes.
    ///
    /// The following are examples of the temporary inconsistencies that you might
    /// notice during change propagation:
    ///
    /// * After you create a web ACL, if you try to associate it with a resource,
    ///   you might get an exception indicating that the web ACL is unavailable.
    ///
    /// * After you add a rule group to a web ACL, the new rule group rules might be
    ///   in effect in one area where the web ACL is used and not in another.
    ///
    /// * After you change a rule action setting, you might see the old action in
    ///   some places and the new action in others.
    ///
    /// * After you add an IP address to an IP set that is in use in a blocking
    ///   rule, the new address might be blocked in one area while still allowed in
    ///   another.
    pub fn updateWebAcl(self: *Self, allocator: std.mem.Allocator, input: update_web_acl.UpdateWebACLInput, options: update_web_acl.Options) !update_web_acl.UpdateWebACLOutput {
        return update_web_acl.execute(self, allocator, input, options);
    }
};
