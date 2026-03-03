const aws = @import("aws");
const std = @import("std");

const associate_drt_log_bucket = @import("associate_drt_log_bucket.zig");
const associate_drt_role = @import("associate_drt_role.zig");
const associate_health_check = @import("associate_health_check.zig");
const associate_proactive_engagement_details = @import("associate_proactive_engagement_details.zig");
const create_protection = @import("create_protection.zig");
const create_protection_group = @import("create_protection_group.zig");
const create_subscription = @import("create_subscription.zig");
const delete_protection = @import("delete_protection.zig");
const delete_protection_group = @import("delete_protection_group.zig");
const delete_subscription = @import("delete_subscription.zig");
const describe_attack = @import("describe_attack.zig");
const describe_attack_statistics = @import("describe_attack_statistics.zig");
const describe_drt_access = @import("describe_drt_access.zig");
const describe_emergency_contact_settings = @import("describe_emergency_contact_settings.zig");
const describe_protection = @import("describe_protection.zig");
const describe_protection_group = @import("describe_protection_group.zig");
const describe_subscription = @import("describe_subscription.zig");
const disable_application_layer_automatic_response = @import("disable_application_layer_automatic_response.zig");
const disable_proactive_engagement = @import("disable_proactive_engagement.zig");
const disassociate_drt_log_bucket = @import("disassociate_drt_log_bucket.zig");
const disassociate_drt_role = @import("disassociate_drt_role.zig");
const disassociate_health_check = @import("disassociate_health_check.zig");
const enable_application_layer_automatic_response = @import("enable_application_layer_automatic_response.zig");
const enable_proactive_engagement = @import("enable_proactive_engagement.zig");
const get_subscription_state = @import("get_subscription_state.zig");
const list_attacks = @import("list_attacks.zig");
const list_protection_groups = @import("list_protection_groups.zig");
const list_protections = @import("list_protections.zig");
const list_resources_in_protection_group = @import("list_resources_in_protection_group.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application_layer_automatic_response = @import("update_application_layer_automatic_response.zig");
const update_emergency_contact_settings = @import("update_emergency_contact_settings.zig");
const update_protection_group = @import("update_protection_group.zig");
const update_subscription = @import("update_subscription.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Shield";

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

    /// Authorizes the Shield Response Team (SRT) to access the specified Amazon S3
    /// bucket containing log data such as Application Load Balancer access logs,
    /// CloudFront logs, or logs from third party sources. You can associate up to
    /// 10 Amazon S3 buckets with your subscription.
    ///
    /// To use the services of the SRT and make an `AssociateDRTLogBucket` request,
    /// you must be subscribed to the [Business Support
    /// plan](http://aws.amazon.com/premiumsupport/business-support/) or the
    /// [Enterprise Support
    /// plan](http://aws.amazon.com/premiumsupport/enterprise-support/).
    pub fn associateDrtLogBucket(self: *Self, allocator: std.mem.Allocator, input: associate_drt_log_bucket.AssociateDRTLogBucketInput, options: associate_drt_log_bucket.Options) !associate_drt_log_bucket.AssociateDRTLogBucketOutput {
        return associate_drt_log_bucket.execute(self, allocator, input, options);
    }

    /// Authorizes the Shield Response Team (SRT) using the specified role, to
    /// access your Amazon Web Services account to assist with DDoS attack
    /// mitigation during potential attacks. This enables the SRT to inspect your
    /// WAF configuration and create or update WAF rules and web ACLs.
    ///
    /// You can associate only one `RoleArn` with your subscription. If you submit
    /// an `AssociateDRTRole` request for an account that already has an associated
    /// role, the new `RoleArn` will replace the existing `RoleArn`.
    ///
    /// Prior to making the `AssociateDRTRole` request, you must attach the
    /// `AWSShieldDRTAccessPolicy` managed policy to the role that you'll specify in
    /// the request. You can access this policy in the IAM console at
    /// [AWSShieldDRTAccessPolicy](https://console.aws.amazon.com/iam/home?#/policies/arn:aws:iam::aws:policy/service-role/AWSShieldDRTAccessPolicy). For more information see [Adding and removing IAM identity permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage-attach-detach.html). The role must also trust the service principal
    /// `drt.shield.amazonaws.com`. For more information, see [IAM JSON policy
    /// elements:
    /// Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html).
    ///
    /// The SRT will have access only to your WAF and Shield resources. By
    /// submitting this request, you authorize the SRT to inspect your WAF and
    /// Shield configuration and create and update WAF rules and web ACLs on your
    /// behalf. The SRT takes these actions only if explicitly authorized by you.
    ///
    /// You must have the `iam:PassRole` permission to make an `AssociateDRTRole`
    /// request. For more information, see [Granting a user permissions to pass a
    /// role to an Amazon Web Services
    /// service](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html).
    ///
    /// To use the services of the SRT and make an `AssociateDRTRole` request, you
    /// must be subscribed to the [Business Support
    /// plan](http://aws.amazon.com/premiumsupport/business-support/) or the
    /// [Enterprise Support
    /// plan](http://aws.amazon.com/premiumsupport/enterprise-support/).
    pub fn associateDrtRole(self: *Self, allocator: std.mem.Allocator, input: associate_drt_role.AssociateDRTRoleInput, options: associate_drt_role.Options) !associate_drt_role.AssociateDRTRoleOutput {
        return associate_drt_role.execute(self, allocator, input, options);
    }

    /// Adds health-based detection to the Shield Advanced protection for a
    /// resource. Shield Advanced health-based detection uses the health of your
    /// Amazon Web Services resource to improve responsiveness and accuracy in
    /// attack detection and response.
    ///
    /// You define the health check in Route 53 and then associate it with your
    /// Shield Advanced protection. For more information, see [Shield Advanced
    /// Health-Based
    /// Detection](https://docs.aws.amazon.com/waf/latest/developerguide/ddos-overview.html#ddos-advanced-health-check-option) in the *WAF Developer Guide*.
    pub fn associateHealthCheck(self: *Self, allocator: std.mem.Allocator, input: associate_health_check.AssociateHealthCheckInput, options: associate_health_check.Options) !associate_health_check.AssociateHealthCheckOutput {
        return associate_health_check.execute(self, allocator, input, options);
    }

    /// Initializes proactive engagement and sets the list of contacts for the
    /// Shield Response Team (SRT) to use. You must provide at least one phone
    /// number in the emergency contact list.
    ///
    /// After you have initialized proactive engagement using this call, to disable
    /// or enable proactive engagement, use the calls `DisableProactiveEngagement`
    /// and `EnableProactiveEngagement`.
    ///
    /// This call defines the list of email addresses and phone numbers that the SRT
    /// can use to contact you for escalations to the SRT and to initiate proactive
    /// customer support.
    ///
    /// The contacts that you provide in the request replace any contacts that were
    /// already defined. If you already have contacts defined and want to use them,
    /// retrieve the list using `DescribeEmergencyContactSettings` and then provide
    /// it to this call.
    pub fn associateProactiveEngagementDetails(self: *Self, allocator: std.mem.Allocator, input: associate_proactive_engagement_details.AssociateProactiveEngagementDetailsInput, options: associate_proactive_engagement_details.Options) !associate_proactive_engagement_details.AssociateProactiveEngagementDetailsOutput {
        return associate_proactive_engagement_details.execute(self, allocator, input, options);
    }

    /// Enables Shield Advanced for a specific Amazon Web Services resource. The
    /// resource can be an Amazon CloudFront distribution, Amazon Route 53 hosted
    /// zone, Global Accelerator standard accelerator, Elastic IP Address,
    /// Application Load Balancer, or a Classic Load Balancer. You can protect
    /// Amazon EC2 instances and Network Load Balancers by association with
    /// protected Amazon EC2 Elastic IP addresses.
    ///
    /// You can add protection to only a single resource with each
    /// `CreateProtection` request. You can add protection to multiple resources
    /// at once through the Shield Advanced console at
    /// [https://console.aws.amazon.com/wafv2/shieldv2#/](https://console.aws.amazon.com/wafv2/shieldv2#/).
    /// For more information see
    /// [Getting Started with Shield
    /// Advanced](https://docs.aws.amazon.com/waf/latest/developerguide/getting-started-ddos.html)
    /// and [Adding Shield Advanced protection to Amazon Web Services
    /// resources](https://docs.aws.amazon.com/waf/latest/developerguide/configure-new-protection.html).
    pub fn createProtection(self: *Self, allocator: std.mem.Allocator, input: create_protection.CreateProtectionInput, options: create_protection.Options) !create_protection.CreateProtectionOutput {
        return create_protection.execute(self, allocator, input, options);
    }

    /// Creates a grouping of protected resources so they can be handled as a
    /// collective. This resource grouping improves the accuracy of detection and
    /// reduces false positives.
    pub fn createProtectionGroup(self: *Self, allocator: std.mem.Allocator, input: create_protection_group.CreateProtectionGroupInput, options: create_protection_group.Options) !create_protection_group.CreateProtectionGroupOutput {
        return create_protection_group.execute(self, allocator, input, options);
    }

    /// Activates Shield Advanced for an account.
    ///
    /// For accounts that are members of an Organizations organization, Shield
    /// Advanced subscriptions are billed against the organization's payer account,
    /// regardless of whether the payer account itself is subscribed.
    ///
    /// When you initially create a subscription, your subscription is set to be
    /// automatically renewed at the end of the existing subscription period. You
    /// can change this by submitting an `UpdateSubscription` request.
    pub fn createSubscription(self: *Self, allocator: std.mem.Allocator, input: create_subscription.CreateSubscriptionInput, options: create_subscription.Options) !create_subscription.CreateSubscriptionOutput {
        return create_subscription.execute(self, allocator, input, options);
    }

    /// Deletes an Shield Advanced Protection.
    pub fn deleteProtection(self: *Self, allocator: std.mem.Allocator, input: delete_protection.DeleteProtectionInput, options: delete_protection.Options) !delete_protection.DeleteProtectionOutput {
        return delete_protection.execute(self, allocator, input, options);
    }

    /// Removes the specified protection group.
    pub fn deleteProtectionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_protection_group.DeleteProtectionGroupInput, options: delete_protection_group.Options) !delete_protection_group.DeleteProtectionGroupOutput {
        return delete_protection_group.execute(self, allocator, input, options);
    }

    /// Removes Shield Advanced from an account. Shield Advanced requires a 1-year
    /// subscription commitment. You cannot delete a subscription prior to the
    /// completion of that commitment.
    pub fn deleteSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_subscription.DeleteSubscriptionInput, options: delete_subscription.Options) !delete_subscription.DeleteSubscriptionOutput {
        return delete_subscription.execute(self, allocator, input, options);
    }

    /// Describes the details of a DDoS attack.
    pub fn describeAttack(self: *Self, allocator: std.mem.Allocator, input: describe_attack.DescribeAttackInput, options: describe_attack.Options) !describe_attack.DescribeAttackOutput {
        return describe_attack.execute(self, allocator, input, options);
    }

    /// Provides information about the number and type of attacks Shield has
    /// detected in the last year for all resources that belong to your account,
    /// regardless of whether you've defined Shield protections for them. This
    /// operation is available to Shield customers as well as to Shield Advanced
    /// customers.
    ///
    /// The operation returns data for the time range of midnight UTC, one year ago,
    /// to midnight UTC, today. For example, if the current time is `2020-10-26
    /// 15:39:32 PDT`, equal to `2020-10-26 22:39:32 UTC`, then the time range for
    /// the attack data returned is from `2019-10-26 00:00:00 UTC` to `2020-10-26
    /// 00:00:00 UTC`.
    ///
    /// The time range indicates the period covered by the attack statistics data
    /// items.
    pub fn describeAttackStatistics(self: *Self, allocator: std.mem.Allocator, input: describe_attack_statistics.DescribeAttackStatisticsInput, options: describe_attack_statistics.Options) !describe_attack_statistics.DescribeAttackStatisticsOutput {
        return describe_attack_statistics.execute(self, allocator, input, options);
    }

    /// Returns the current role and list of Amazon S3 log buckets used by the
    /// Shield Response Team (SRT) to access your Amazon Web Services account while
    /// assisting with attack mitigation.
    pub fn describeDrtAccess(self: *Self, allocator: std.mem.Allocator, input: describe_drt_access.DescribeDRTAccessInput, options: describe_drt_access.Options) !describe_drt_access.DescribeDRTAccessOutput {
        return describe_drt_access.execute(self, allocator, input, options);
    }

    /// A list of email addresses and phone numbers that the Shield Response Team
    /// (SRT) can use to contact you if you have proactive engagement enabled, for
    /// escalations to the SRT and to initiate proactive customer support.
    pub fn describeEmergencyContactSettings(self: *Self, allocator: std.mem.Allocator, input: describe_emergency_contact_settings.DescribeEmergencyContactSettingsInput, options: describe_emergency_contact_settings.Options) !describe_emergency_contact_settings.DescribeEmergencyContactSettingsOutput {
        return describe_emergency_contact_settings.execute(self, allocator, input, options);
    }

    /// Lists the details of a Protection object.
    pub fn describeProtection(self: *Self, allocator: std.mem.Allocator, input: describe_protection.DescribeProtectionInput, options: describe_protection.Options) !describe_protection.DescribeProtectionOutput {
        return describe_protection.execute(self, allocator, input, options);
    }

    /// Returns the specification for the specified protection group.
    pub fn describeProtectionGroup(self: *Self, allocator: std.mem.Allocator, input: describe_protection_group.DescribeProtectionGroupInput, options: describe_protection_group.Options) !describe_protection_group.DescribeProtectionGroupOutput {
        return describe_protection_group.execute(self, allocator, input, options);
    }

    /// Provides details about the Shield Advanced subscription for an account.
    pub fn describeSubscription(self: *Self, allocator: std.mem.Allocator, input: describe_subscription.DescribeSubscriptionInput, options: describe_subscription.Options) !describe_subscription.DescribeSubscriptionOutput {
        return describe_subscription.execute(self, allocator, input, options);
    }

    /// Disable the Shield Advanced automatic application layer DDoS mitigation
    /// feature for the protected resource. This
    /// stops Shield Advanced from creating, verifying, and applying WAF rules for
    /// attacks that it detects for the resource.
    pub fn disableApplicationLayerAutomaticResponse(self: *Self, allocator: std.mem.Allocator, input: disable_application_layer_automatic_response.DisableApplicationLayerAutomaticResponseInput, options: disable_application_layer_automatic_response.Options) !disable_application_layer_automatic_response.DisableApplicationLayerAutomaticResponseOutput {
        return disable_application_layer_automatic_response.execute(self, allocator, input, options);
    }

    /// Removes authorization from the Shield Response Team (SRT) to notify contacts
    /// about escalations to the SRT and to initiate proactive customer support.
    pub fn disableProactiveEngagement(self: *Self, allocator: std.mem.Allocator, input: disable_proactive_engagement.DisableProactiveEngagementInput, options: disable_proactive_engagement.Options) !disable_proactive_engagement.DisableProactiveEngagementOutput {
        return disable_proactive_engagement.execute(self, allocator, input, options);
    }

    /// Removes the Shield Response Team's (SRT) access to the specified Amazon S3
    /// bucket containing the logs that you shared previously.
    pub fn disassociateDrtLogBucket(self: *Self, allocator: std.mem.Allocator, input: disassociate_drt_log_bucket.DisassociateDRTLogBucketInput, options: disassociate_drt_log_bucket.Options) !disassociate_drt_log_bucket.DisassociateDRTLogBucketOutput {
        return disassociate_drt_log_bucket.execute(self, allocator, input, options);
    }

    /// Removes the Shield Response Team's (SRT) access to your Amazon Web Services
    /// account.
    pub fn disassociateDrtRole(self: *Self, allocator: std.mem.Allocator, input: disassociate_drt_role.DisassociateDRTRoleInput, options: disassociate_drt_role.Options) !disassociate_drt_role.DisassociateDRTRoleOutput {
        return disassociate_drt_role.execute(self, allocator, input, options);
    }

    /// Removes health-based detection from the Shield Advanced protection for a
    /// resource. Shield Advanced health-based detection uses the health of your
    /// Amazon Web Services resource to improve responsiveness and accuracy in
    /// attack detection and response.
    ///
    /// You define the health check in Route 53 and then associate or disassociate
    /// it with your Shield Advanced protection. For more information, see [Shield
    /// Advanced Health-Based
    /// Detection](https://docs.aws.amazon.com/waf/latest/developerguide/ddos-overview.html#ddos-advanced-health-check-option) in the *WAF Developer Guide*.
    pub fn disassociateHealthCheck(self: *Self, allocator: std.mem.Allocator, input: disassociate_health_check.DisassociateHealthCheckInput, options: disassociate_health_check.Options) !disassociate_health_check.DisassociateHealthCheckOutput {
        return disassociate_health_check.execute(self, allocator, input, options);
    }

    /// Enable the Shield Advanced automatic application layer DDoS mitigation for
    /// the protected resource.
    ///
    /// This feature is available for Amazon CloudFront distributions and
    /// Application Load Balancers only.
    ///
    /// This causes Shield Advanced to create, verify, and apply WAF rules for DDoS
    /// attacks that it detects for the
    /// resource. Shield Advanced applies the rules in a Shield rule group inside
    /// the web ACL that you've associated
    /// with the resource. For information about how automatic mitigation works and
    /// the requirements for using it, see
    /// [Shield Advanced automatic application layer DDoS
    /// mitigation](https://docs.aws.amazon.com/waf/latest/developerguide/ddos-advanced-automatic-app-layer-response.html).
    ///
    /// Don't use this action to make changes to automatic mitigation settings when
    /// it's already enabled for a resource. Instead, use
    /// UpdateApplicationLayerAutomaticResponse.
    ///
    /// To use this feature, you must associate a web ACL with the protected
    /// resource. The web ACL must be created using the latest version of WAF (v2).
    /// You can associate the web ACL through the Shield Advanced console
    /// at
    /// [https://console.aws.amazon.com/wafv2/shieldv2#/](https://console.aws.amazon.com/wafv2/shieldv2#/). For more information,
    /// see [Getting Started with Shield
    /// Advanced](https://docs.aws.amazon.com/waf/latest/developerguide/getting-started-ddos.html). You can also associate the web ACL to the resource through the WAF console or the WAF API, but you must manage Shield Advanced automatic mitigation through Shield Advanced. For information about WAF, see
    /// [WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn enableApplicationLayerAutomaticResponse(self: *Self, allocator: std.mem.Allocator, input: enable_application_layer_automatic_response.EnableApplicationLayerAutomaticResponseInput, options: enable_application_layer_automatic_response.Options) !enable_application_layer_automatic_response.EnableApplicationLayerAutomaticResponseOutput {
        return enable_application_layer_automatic_response.execute(self, allocator, input, options);
    }

    /// Authorizes the Shield Response Team (SRT) to use email and phone to notify
    /// contacts about escalations to the SRT and to initiate proactive customer
    /// support.
    pub fn enableProactiveEngagement(self: *Self, allocator: std.mem.Allocator, input: enable_proactive_engagement.EnableProactiveEngagementInput, options: enable_proactive_engagement.Options) !enable_proactive_engagement.EnableProactiveEngagementOutput {
        return enable_proactive_engagement.execute(self, allocator, input, options);
    }

    /// Returns the `SubscriptionState`, either `Active` or `Inactive`.
    pub fn getSubscriptionState(self: *Self, allocator: std.mem.Allocator, input: get_subscription_state.GetSubscriptionStateInput, options: get_subscription_state.Options) !get_subscription_state.GetSubscriptionStateOutput {
        return get_subscription_state.execute(self, allocator, input, options);
    }

    /// Returns all ongoing DDoS attacks or all DDoS attacks during a specified time
    /// period.
    pub fn listAttacks(self: *Self, allocator: std.mem.Allocator, input: list_attacks.ListAttacksInput, options: list_attacks.Options) !list_attacks.ListAttacksOutput {
        return list_attacks.execute(self, allocator, input, options);
    }

    /// Retrieves ProtectionGroup objects for the account. You can retrieve all
    /// protection groups or you can provide
    /// filtering criteria and retrieve just the subset of protection groups that
    /// match the criteria.
    pub fn listProtectionGroups(self: *Self, allocator: std.mem.Allocator, input: list_protection_groups.ListProtectionGroupsInput, options: list_protection_groups.Options) !list_protection_groups.ListProtectionGroupsOutput {
        return list_protection_groups.execute(self, allocator, input, options);
    }

    /// Retrieves Protection objects for the account. You can retrieve all
    /// protections or you can provide
    /// filtering criteria and retrieve just the subset of protections that match
    /// the criteria.
    pub fn listProtections(self: *Self, allocator: std.mem.Allocator, input: list_protections.ListProtectionsInput, options: list_protections.Options) !list_protections.ListProtectionsOutput {
        return list_protections.execute(self, allocator, input, options);
    }

    /// Retrieves the resources that are included in the protection group.
    pub fn listResourcesInProtectionGroup(self: *Self, allocator: std.mem.Allocator, input: list_resources_in_protection_group.ListResourcesInProtectionGroupInput, options: list_resources_in_protection_group.Options) !list_resources_in_protection_group.ListResourcesInProtectionGroupOutput {
        return list_resources_in_protection_group.execute(self, allocator, input, options);
    }

    /// Gets information about Amazon Web Services tags for a specified Amazon
    /// Resource Name (ARN) in Shield.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a resource in Shield.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource in Shield.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Shield Advanced automatic application layer DDoS
    /// mitigation configuration for the specified resource.
    pub fn updateApplicationLayerAutomaticResponse(self: *Self, allocator: std.mem.Allocator, input: update_application_layer_automatic_response.UpdateApplicationLayerAutomaticResponseInput, options: update_application_layer_automatic_response.Options) !update_application_layer_automatic_response.UpdateApplicationLayerAutomaticResponseOutput {
        return update_application_layer_automatic_response.execute(self, allocator, input, options);
    }

    /// Updates the details of the list of email addresses and phone numbers that
    /// the Shield Response Team (SRT) can use to contact you if you have proactive
    /// engagement enabled, for escalations to the SRT and to initiate proactive
    /// customer support.
    pub fn updateEmergencyContactSettings(self: *Self, allocator: std.mem.Allocator, input: update_emergency_contact_settings.UpdateEmergencyContactSettingsInput, options: update_emergency_contact_settings.Options) !update_emergency_contact_settings.UpdateEmergencyContactSettingsOutput {
        return update_emergency_contact_settings.execute(self, allocator, input, options);
    }

    /// Updates an existing protection group. A protection group is a grouping of
    /// protected resources so they can be handled as a collective. This resource
    /// grouping improves the accuracy of detection and reduces false positives.
    pub fn updateProtectionGroup(self: *Self, allocator: std.mem.Allocator, input: update_protection_group.UpdateProtectionGroupInput, options: update_protection_group.Options) !update_protection_group.UpdateProtectionGroupOutput {
        return update_protection_group.execute(self, allocator, input, options);
    }

    /// Updates the details of an existing subscription. Only enter values for
    /// parameters you want to change. Empty parameters are not updated.
    ///
    /// For accounts that are members of an Organizations organization, Shield
    /// Advanced subscriptions are billed against the organization's payer account,
    /// regardless of whether the payer account itself is subscribed.
    pub fn updateSubscription(self: *Self, allocator: std.mem.Allocator, input: update_subscription.UpdateSubscriptionInput, options: update_subscription.Options) !update_subscription.UpdateSubscriptionOutput {
        return update_subscription.execute(self, allocator, input, options);
    }

    pub fn listAttacksPaginator(self: *Self, params: list_attacks.ListAttacksInput) paginator.ListAttacksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProtectionGroupsPaginator(self: *Self, params: list_protection_groups.ListProtectionGroupsInput) paginator.ListProtectionGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProtectionsPaginator(self: *Self, params: list_protections.ListProtectionsInput) paginator.ListProtectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesInProtectionGroupPaginator(self: *Self, params: list_resources_in_protection_group.ListResourcesInProtectionGroupInput) paginator.ListResourcesInProtectionGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
