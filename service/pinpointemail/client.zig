const aws = @import("aws");
const std = @import("std");

const create_configuration_set = @import("create_configuration_set.zig");
const create_configuration_set_event_destination = @import("create_configuration_set_event_destination.zig");
const create_dedicated_ip_pool = @import("create_dedicated_ip_pool.zig");
const create_deliverability_test_report = @import("create_deliverability_test_report.zig");
const create_email_identity = @import("create_email_identity.zig");
const delete_configuration_set = @import("delete_configuration_set.zig");
const delete_configuration_set_event_destination = @import("delete_configuration_set_event_destination.zig");
const delete_dedicated_ip_pool = @import("delete_dedicated_ip_pool.zig");
const delete_email_identity = @import("delete_email_identity.zig");
const get_account = @import("get_account.zig");
const get_blacklist_reports = @import("get_blacklist_reports.zig");
const get_configuration_set = @import("get_configuration_set.zig");
const get_configuration_set_event_destinations = @import("get_configuration_set_event_destinations.zig");
const get_dedicated_ip = @import("get_dedicated_ip.zig");
const get_dedicated_ips = @import("get_dedicated_ips.zig");
const get_deliverability_dashboard_options = @import("get_deliverability_dashboard_options.zig");
const get_deliverability_test_report = @import("get_deliverability_test_report.zig");
const get_domain_deliverability_campaign = @import("get_domain_deliverability_campaign.zig");
const get_domain_statistics_report = @import("get_domain_statistics_report.zig");
const get_email_identity = @import("get_email_identity.zig");
const list_configuration_sets = @import("list_configuration_sets.zig");
const list_dedicated_ip_pools = @import("list_dedicated_ip_pools.zig");
const list_deliverability_test_reports = @import("list_deliverability_test_reports.zig");
const list_domain_deliverability_campaigns = @import("list_domain_deliverability_campaigns.zig");
const list_email_identities = @import("list_email_identities.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_account_dedicated_ip_warmup_attributes = @import("put_account_dedicated_ip_warmup_attributes.zig");
const put_account_sending_attributes = @import("put_account_sending_attributes.zig");
const put_configuration_set_delivery_options = @import("put_configuration_set_delivery_options.zig");
const put_configuration_set_reputation_options = @import("put_configuration_set_reputation_options.zig");
const put_configuration_set_sending_options = @import("put_configuration_set_sending_options.zig");
const put_configuration_set_tracking_options = @import("put_configuration_set_tracking_options.zig");
const put_dedicated_ip_in_pool = @import("put_dedicated_ip_in_pool.zig");
const put_dedicated_ip_warmup_attributes = @import("put_dedicated_ip_warmup_attributes.zig");
const put_deliverability_dashboard_option = @import("put_deliverability_dashboard_option.zig");
const put_email_identity_dkim_attributes = @import("put_email_identity_dkim_attributes.zig");
const put_email_identity_feedback_attributes = @import("put_email_identity_feedback_attributes.zig");
const put_email_identity_mail_from_attributes = @import("put_email_identity_mail_from_attributes.zig");
const send_email = @import("send_email.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_configuration_set_event_destination = @import("update_configuration_set_event_destination.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pinpoint Email";

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

    /// Create a configuration set. *Configuration sets* are groups of
    /// rules that you can apply to the emails you send using Amazon Pinpoint. You
    /// apply a configuration
    /// set to an email by including a reference to the configuration set in the
    /// headers of the
    /// email. When you apply a configuration set to an email, all of the rules in
    /// that
    /// configuration set are applied to the email.
    pub fn createConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set.CreateConfigurationSetInput, options: CallOptions) !create_configuration_set.CreateConfigurationSetOutput {
        return create_configuration_set.execute(self, allocator, input, options);
    }

    /// Create an event destination. In Amazon Pinpoint, *events* include message
    /// sends, deliveries, opens, clicks, bounces, and complaints. *Event
    /// destinations* are places that you can send information about these events
    /// to. For example, you can send event data to Amazon SNS to receive
    /// notifications when you
    /// receive bounces or complaints, or you can use Amazon Kinesis Data Firehose
    /// to stream data to Amazon S3 for long-term
    /// storage.
    ///
    /// A single configuration set can include more than one event destination.
    pub fn createConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set_event_destination.CreateConfigurationSetEventDestinationInput, options: CallOptions) !create_configuration_set_event_destination.CreateConfigurationSetEventDestinationOutput {
        return create_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Create a new pool of dedicated IP addresses. A pool can include one or more
    /// dedicated
    /// IP addresses that are associated with your Amazon Pinpoint account. You can
    /// associate a pool with
    /// a configuration set. When you send an email that uses that configuration
    /// set, Amazon Pinpoint
    /// sends it using only the IP addresses in the associated pool.
    pub fn createDedicatedIpPool(self: *Self, allocator: std.mem.Allocator, input: create_dedicated_ip_pool.CreateDedicatedIpPoolInput, options: CallOptions) !create_dedicated_ip_pool.CreateDedicatedIpPoolOutput {
        return create_dedicated_ip_pool.execute(self, allocator, input, options);
    }

    /// Create a new predictive inbox placement test. Predictive inbox placement
    /// tests can help you predict how your messages will be handled
    /// by various email providers around the world. When you perform a predictive
    /// inbox placement test, you provide a
    /// sample message that contains the content that you plan to send to your
    /// customers. Amazon Pinpoint
    /// then sends that message to special email addresses spread across several
    /// major email
    /// providers. After about 24 hours, the test is complete, and you can use the
    /// `GetDeliverabilityTestReport` operation to view the results of the
    /// test.
    pub fn createDeliverabilityTestReport(self: *Self, allocator: std.mem.Allocator, input: create_deliverability_test_report.CreateDeliverabilityTestReportInput, options: CallOptions) !create_deliverability_test_report.CreateDeliverabilityTestReportOutput {
        return create_deliverability_test_report.execute(self, allocator, input, options);
    }

    /// Verifies an email identity for use with Amazon Pinpoint. In Amazon Pinpoint,
    /// an identity is an email
    /// address or domain that you use when you send email. Before you can use an
    /// identity to
    /// send email with Amazon Pinpoint, you first have to verify it. By verifying
    /// an address, you
    /// demonstrate that you're the owner of the address, and that you've given
    /// Amazon Pinpoint permission
    /// to send email from the address.
    ///
    /// When you verify an email address, Amazon Pinpoint sends an email to the
    /// address. Your email
    /// address is verified as soon as you follow the link in the verification
    /// email.
    ///
    /// When you verify a domain, this operation provides a set of DKIM tokens,
    /// which you can
    /// convert into CNAME tokens. You add these CNAME tokens to the DNS
    /// configuration for your
    /// domain. Your domain is verified when Amazon Pinpoint detects these records
    /// in the DNS
    /// configuration for your domain. It usually takes around 72 hours to complete
    /// the domain
    /// verification process.
    pub fn createEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: create_email_identity.CreateEmailIdentityInput, options: CallOptions) !create_email_identity.CreateEmailIdentityOutput {
        return create_email_identity.execute(self, allocator, input, options);
    }

    /// Delete an existing configuration set.
    ///
    /// In Amazon Pinpoint, *configuration sets* are groups of rules that you can
    /// apply to the emails you send. You apply a configuration set to an email by
    /// including a
    /// reference to the configuration set in the headers of the email. When you
    /// apply a
    /// configuration set to an email, all of the rules in that configuration set
    /// are applied to
    /// the email.
    pub fn deleteConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set.DeleteConfigurationSetInput, options: CallOptions) !delete_configuration_set.DeleteConfigurationSetOutput {
        return delete_configuration_set.execute(self, allocator, input, options);
    }

    /// Delete an event destination.
    ///
    /// In Amazon Pinpoint, *events* include message sends, deliveries, opens,
    /// clicks, bounces, and complaints. *Event destinations* are places that
    /// you can send information about these events to. For example, you can send
    /// event data to
    /// Amazon SNS to receive notifications when you receive bounces or complaints,
    /// or you can use
    /// Amazon Kinesis Data Firehose to stream data to Amazon S3 for long-term
    /// storage.
    pub fn deleteConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationInput, options: CallOptions) !delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationOutput {
        return delete_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Delete a dedicated IP pool.
    pub fn deleteDedicatedIpPool(self: *Self, allocator: std.mem.Allocator, input: delete_dedicated_ip_pool.DeleteDedicatedIpPoolInput, options: CallOptions) !delete_dedicated_ip_pool.DeleteDedicatedIpPoolOutput {
        return delete_dedicated_ip_pool.execute(self, allocator, input, options);
    }

    /// Deletes an email identity that you previously verified for use with Amazon
    /// Pinpoint. An identity
    /// can be either an email address or a domain name.
    pub fn deleteEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_email_identity.DeleteEmailIdentityInput, options: CallOptions) !delete_email_identity.DeleteEmailIdentityOutput {
        return delete_email_identity.execute(self, allocator, input, options);
    }

    /// Obtain information about the email-sending status and capabilities of your
    /// Amazon Pinpoint
    /// account in the current AWS Region.
    pub fn getAccount(self: *Self, allocator: std.mem.Allocator, input: get_account.GetAccountInput, options: CallOptions) !get_account.GetAccountOutput {
        return get_account.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the blacklists that your dedicated IP addresses appear
    /// on.
    pub fn getBlacklistReports(self: *Self, allocator: std.mem.Allocator, input: get_blacklist_reports.GetBlacklistReportsInput, options: CallOptions) !get_blacklist_reports.GetBlacklistReportsOutput {
        return get_blacklist_reports.execute(self, allocator, input, options);
    }

    /// Get information about an existing configuration set, including the dedicated
    /// IP pool
    /// that it's associated with, whether or not it's enabled for sending email,
    /// and
    /// more.
    ///
    /// In Amazon Pinpoint, *configuration sets* are groups of rules that you can
    /// apply to the emails you send. You apply a configuration set to an email by
    /// including a
    /// reference to the configuration set in the headers of the email. When you
    /// apply a
    /// configuration set to an email, all of the rules in that configuration set
    /// are applied to
    /// the email.
    pub fn getConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: get_configuration_set.GetConfigurationSetInput, options: CallOptions) !get_configuration_set.GetConfigurationSetOutput {
        return get_configuration_set.execute(self, allocator, input, options);
    }

    /// Retrieve a list of event destinations that are associated with a
    /// configuration
    /// set.
    ///
    /// In Amazon Pinpoint, *events* include message sends, deliveries, opens,
    /// clicks, bounces, and complaints. *Event destinations* are places that
    /// you can send information about these events to. For example, you can send
    /// event data to
    /// Amazon SNS to receive notifications when you receive bounces or complaints,
    /// or you can use
    /// Amazon Kinesis Data Firehose to stream data to Amazon S3 for long-term
    /// storage.
    pub fn getConfigurationSetEventDestinations(self: *Self, allocator: std.mem.Allocator, input: get_configuration_set_event_destinations.GetConfigurationSetEventDestinationsInput, options: CallOptions) !get_configuration_set_event_destinations.GetConfigurationSetEventDestinationsOutput {
        return get_configuration_set_event_destinations.execute(self, allocator, input, options);
    }

    /// Get information about a dedicated IP address, including the name of the
    /// dedicated IP
    /// pool that it's associated with, as well information about the automatic
    /// warm-up process
    /// for the address.
    pub fn getDedicatedIp(self: *Self, allocator: std.mem.Allocator, input: get_dedicated_ip.GetDedicatedIpInput, options: CallOptions) !get_dedicated_ip.GetDedicatedIpOutput {
        return get_dedicated_ip.execute(self, allocator, input, options);
    }

    /// List the dedicated IP addresses that are associated with your Amazon
    /// Pinpoint
    /// account.
    pub fn getDedicatedIps(self: *Self, allocator: std.mem.Allocator, input: get_dedicated_ips.GetDedicatedIpsInput, options: CallOptions) !get_dedicated_ips.GetDedicatedIpsOutput {
        return get_dedicated_ips.execute(self, allocator, input, options);
    }

    /// Retrieve information about the status of the Deliverability dashboard for
    /// your Amazon Pinpoint account.
    /// When the Deliverability dashboard is enabled, you gain access to reputation,
    /// deliverability, and
    /// other metrics for the domains that you use to send email using Amazon
    /// Pinpoint. You also gain the
    /// ability to perform predictive inbox placement tests.
    ///
    /// When you use the Deliverability dashboard, you pay a monthly subscription
    /// charge, in addition
    /// to any other fees that you accrue by using Amazon Pinpoint. For more
    /// information about the
    /// features and cost of a Deliverability dashboard subscription, see [Amazon
    /// Pinpoint Pricing](http://aws.amazon.com/pinpoint/pricing/).
    pub fn getDeliverabilityDashboardOptions(self: *Self, allocator: std.mem.Allocator, input: get_deliverability_dashboard_options.GetDeliverabilityDashboardOptionsInput, options: CallOptions) !get_deliverability_dashboard_options.GetDeliverabilityDashboardOptionsOutput {
        return get_deliverability_dashboard_options.execute(self, allocator, input, options);
    }

    /// Retrieve the results of a predictive inbox placement test.
    pub fn getDeliverabilityTestReport(self: *Self, allocator: std.mem.Allocator, input: get_deliverability_test_report.GetDeliverabilityTestReportInput, options: CallOptions) !get_deliverability_test_report.GetDeliverabilityTestReportOutput {
        return get_deliverability_test_report.execute(self, allocator, input, options);
    }

    /// Retrieve all the deliverability data for a specific campaign. This data is
    /// available
    /// for a campaign only if the campaign sent email by using a domain that the
    /// Deliverability dashboard is enabled for (`PutDeliverabilityDashboardOption`
    /// operation).
    pub fn getDomainDeliverabilityCampaign(self: *Self, allocator: std.mem.Allocator, input: get_domain_deliverability_campaign.GetDomainDeliverabilityCampaignInput, options: CallOptions) !get_domain_deliverability_campaign.GetDomainDeliverabilityCampaignOutput {
        return get_domain_deliverability_campaign.execute(self, allocator, input, options);
    }

    /// Retrieve inbox placement and engagement rates for the domains that you use
    /// to send
    /// email.
    pub fn getDomainStatisticsReport(self: *Self, allocator: std.mem.Allocator, input: get_domain_statistics_report.GetDomainStatisticsReportInput, options: CallOptions) !get_domain_statistics_report.GetDomainStatisticsReportOutput {
        return get_domain_statistics_report.execute(self, allocator, input, options);
    }

    /// Provides information about a specific identity associated with your Amazon
    /// Pinpoint account,
    /// including the identity's verification status, its DKIM authentication
    /// status, and its
    /// custom Mail-From settings.
    pub fn getEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: get_email_identity.GetEmailIdentityInput, options: CallOptions) !get_email_identity.GetEmailIdentityOutput {
        return get_email_identity.execute(self, allocator, input, options);
    }

    /// List all of the configuration sets associated with your Amazon Pinpoint
    /// account in the current
    /// region.
    ///
    /// In Amazon Pinpoint, *configuration sets* are groups of rules that you can
    /// apply to the emails you send. You apply a configuration set to an email by
    /// including a
    /// reference to the configuration set in the headers of the email. When you
    /// apply a
    /// configuration set to an email, all of the rules in that configuration set
    /// are applied to
    /// the email.
    pub fn listConfigurationSets(self: *Self, allocator: std.mem.Allocator, input: list_configuration_sets.ListConfigurationSetsInput, options: CallOptions) !list_configuration_sets.ListConfigurationSetsOutput {
        return list_configuration_sets.execute(self, allocator, input, options);
    }

    /// List all of the dedicated IP pools that exist in your Amazon Pinpoint
    /// account in the current
    /// AWS Region.
    pub fn listDedicatedIpPools(self: *Self, allocator: std.mem.Allocator, input: list_dedicated_ip_pools.ListDedicatedIpPoolsInput, options: CallOptions) !list_dedicated_ip_pools.ListDedicatedIpPoolsOutput {
        return list_dedicated_ip_pools.execute(self, allocator, input, options);
    }

    /// Show a list of the predictive inbox placement tests that you've performed,
    /// regardless of their statuses. For
    /// predictive inbox placement tests that are complete, you can use the
    /// `GetDeliverabilityTestReport`
    /// operation to view the results.
    pub fn listDeliverabilityTestReports(self: *Self, allocator: std.mem.Allocator, input: list_deliverability_test_reports.ListDeliverabilityTestReportsInput, options: CallOptions) !list_deliverability_test_reports.ListDeliverabilityTestReportsOutput {
        return list_deliverability_test_reports.execute(self, allocator, input, options);
    }

    /// Retrieve deliverability data for all the campaigns that used a specific
    /// domain to send
    /// email during a specified time range. This data is available for a domain
    /// only if you
    /// enabled the Deliverability dashboard (`PutDeliverabilityDashboardOption`
    /// operation)
    /// for the domain.
    pub fn listDomainDeliverabilityCampaigns(self: *Self, allocator: std.mem.Allocator, input: list_domain_deliverability_campaigns.ListDomainDeliverabilityCampaignsInput, options: CallOptions) !list_domain_deliverability_campaigns.ListDomainDeliverabilityCampaignsOutput {
        return list_domain_deliverability_campaigns.execute(self, allocator, input, options);
    }

    /// Returns a list of all of the email identities that are associated with your
    /// Amazon Pinpoint
    /// account. An identity can be either an email address or a domain. This
    /// operation returns
    /// identities that are verified as well as those that aren't.
    pub fn listEmailIdentities(self: *Self, allocator: std.mem.Allocator, input: list_email_identities.ListEmailIdentitiesInput, options: CallOptions) !list_email_identities.ListEmailIdentitiesOutput {
        return list_email_identities.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the tags (keys and values) that are associated with a
    /// specified
    /// resource. A *tag* is a label that you optionally define and associate
    /// with a resource in Amazon Pinpoint. Each tag consists of a required *tag
    /// key* and an optional associated *tag value*. A tag key
    /// is a general label that acts as a category for more specific tag values. A
    /// tag value
    /// acts as a descriptor within a tag key.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Enable or disable the automatic warm-up feature for dedicated IP addresses.
    pub fn putAccountDedicatedIpWarmupAttributes(self: *Self, allocator: std.mem.Allocator, input: put_account_dedicated_ip_warmup_attributes.PutAccountDedicatedIpWarmupAttributesInput, options: CallOptions) !put_account_dedicated_ip_warmup_attributes.PutAccountDedicatedIpWarmupAttributesOutput {
        return put_account_dedicated_ip_warmup_attributes.execute(self, allocator, input, options);
    }

    /// Enable or disable the ability of your account to send email.
    pub fn putAccountSendingAttributes(self: *Self, allocator: std.mem.Allocator, input: put_account_sending_attributes.PutAccountSendingAttributesInput, options: CallOptions) !put_account_sending_attributes.PutAccountSendingAttributesOutput {
        return put_account_sending_attributes.execute(self, allocator, input, options);
    }

    /// Associate a configuration set with a dedicated IP pool. You can use
    /// dedicated IP pools
    /// to create groups of dedicated IP addresses for sending specific types of
    /// email.
    pub fn putConfigurationSetDeliveryOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_delivery_options.PutConfigurationSetDeliveryOptionsInput, options: CallOptions) !put_configuration_set_delivery_options.PutConfigurationSetDeliveryOptionsOutput {
        return put_configuration_set_delivery_options.execute(self, allocator, input, options);
    }

    /// Enable or disable collection of reputation metrics for emails that you send
    /// using a
    /// particular configuration set in a specific AWS Region.
    pub fn putConfigurationSetReputationOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_reputation_options.PutConfigurationSetReputationOptionsInput, options: CallOptions) !put_configuration_set_reputation_options.PutConfigurationSetReputationOptionsOutput {
        return put_configuration_set_reputation_options.execute(self, allocator, input, options);
    }

    /// Enable or disable email sending for messages that use a particular
    /// configuration set
    /// in a specific AWS Region.
    pub fn putConfigurationSetSendingOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_sending_options.PutConfigurationSetSendingOptionsInput, options: CallOptions) !put_configuration_set_sending_options.PutConfigurationSetSendingOptionsOutput {
        return put_configuration_set_sending_options.execute(self, allocator, input, options);
    }

    /// Specify a custom domain to use for open and click tracking elements in email
    /// that you
    /// send using Amazon Pinpoint.
    pub fn putConfigurationSetTrackingOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_tracking_options.PutConfigurationSetTrackingOptionsInput, options: CallOptions) !put_configuration_set_tracking_options.PutConfigurationSetTrackingOptionsOutput {
        return put_configuration_set_tracking_options.execute(self, allocator, input, options);
    }

    /// Move a dedicated IP address to an existing dedicated IP pool.
    ///
    /// The dedicated IP address that you specify must already exist, and must be
    /// associated with your Amazon Pinpoint account.
    ///
    /// The dedicated IP pool you specify must already exist. You can create a new
    /// pool by
    /// using the `CreateDedicatedIpPool` operation.
    pub fn putDedicatedIpInPool(self: *Self, allocator: std.mem.Allocator, input: put_dedicated_ip_in_pool.PutDedicatedIpInPoolInput, options: CallOptions) !put_dedicated_ip_in_pool.PutDedicatedIpInPoolOutput {
        return put_dedicated_ip_in_pool.execute(self, allocator, input, options);
    }

    pub fn putDedicatedIpWarmupAttributes(self: *Self, allocator: std.mem.Allocator, input: put_dedicated_ip_warmup_attributes.PutDedicatedIpWarmupAttributesInput, options: CallOptions) !put_dedicated_ip_warmup_attributes.PutDedicatedIpWarmupAttributesOutput {
        return put_dedicated_ip_warmup_attributes.execute(self, allocator, input, options);
    }

    /// Enable or disable the Deliverability dashboard for your Amazon Pinpoint
    /// account. When you enable the
    /// Deliverability dashboard, you gain access to reputation, deliverability, and
    /// other metrics for
    /// the domains that you use to send email using Amazon Pinpoint. You also gain
    /// the ability to perform
    /// predictive inbox placement tests.
    ///
    /// When you use the Deliverability dashboard, you pay a monthly subscription
    /// charge, in addition
    /// to any other fees that you accrue by using Amazon Pinpoint. For more
    /// information about the
    /// features and cost of a Deliverability dashboard subscription, see [Amazon
    /// Pinpoint Pricing](http://aws.amazon.com/pinpoint/pricing/).
    pub fn putDeliverabilityDashboardOption(self: *Self, allocator: std.mem.Allocator, input: put_deliverability_dashboard_option.PutDeliverabilityDashboardOptionInput, options: CallOptions) !put_deliverability_dashboard_option.PutDeliverabilityDashboardOptionOutput {
        return put_deliverability_dashboard_option.execute(self, allocator, input, options);
    }

    /// Used to enable or disable DKIM authentication for an email identity.
    pub fn putEmailIdentityDkimAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_dkim_attributes.PutEmailIdentityDkimAttributesInput, options: CallOptions) !put_email_identity_dkim_attributes.PutEmailIdentityDkimAttributesOutput {
        return put_email_identity_dkim_attributes.execute(self, allocator, input, options);
    }

    /// Used to enable or disable feedback forwarding for an identity. This setting
    /// determines
    /// what happens when an identity is used to send an email that results in a
    /// bounce or
    /// complaint event.
    ///
    /// When you enable feedback forwarding, Amazon Pinpoint sends you email
    /// notifications when bounce
    /// or complaint events occur. Amazon Pinpoint sends this notification to the
    /// address that you
    /// specified in the Return-Path header of the original email.
    ///
    /// When you disable feedback forwarding, Amazon Pinpoint sends notifications
    /// through other
    /// mechanisms, such as by notifying an Amazon SNS topic. You're required to
    /// have a method of
    /// tracking bounces and complaints. If you haven't set up another mechanism for
    /// receiving
    /// bounce or complaint notifications, Amazon Pinpoint sends an email
    /// notification when these events
    /// occur (even if this setting is disabled).
    pub fn putEmailIdentityFeedbackAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_feedback_attributes.PutEmailIdentityFeedbackAttributesInput, options: CallOptions) !put_email_identity_feedback_attributes.PutEmailIdentityFeedbackAttributesOutput {
        return put_email_identity_feedback_attributes.execute(self, allocator, input, options);
    }

    /// Used to enable or disable the custom Mail-From domain configuration for an
    /// email
    /// identity.
    pub fn putEmailIdentityMailFromAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_mail_from_attributes.PutEmailIdentityMailFromAttributesInput, options: CallOptions) !put_email_identity_mail_from_attributes.PutEmailIdentityMailFromAttributesOutput {
        return put_email_identity_mail_from_attributes.execute(self, allocator, input, options);
    }

    /// Sends an email message. You can use the Amazon Pinpoint Email API to send
    /// two types of
    /// messages:
    ///
    /// * **Simple** – A standard email message. When
    /// you create this type of message, you specify the sender, the recipient, and
    /// the
    /// message body, and Amazon Pinpoint assembles the message for you.
    ///
    /// * **Raw** – A raw, MIME-formatted email
    /// message. When you send this type of email, you have to specify all of the
    /// message headers, as well as the message body. You can use this message type
    /// to
    /// send messages that contain attachments. The message that you specify has to
    /// be a
    /// valid MIME message.
    pub fn sendEmail(self: *Self, allocator: std.mem.Allocator, input: send_email.SendEmailInput, options: CallOptions) !send_email.SendEmailOutput {
        return send_email.execute(self, allocator, input, options);
    }

    /// Add one or more tags (keys and values) to a specified resource. A
    /// *tag* is a label that you optionally define and associate with a
    /// resource in Amazon Pinpoint. Tags can help you categorize and manage
    /// resources in different ways,
    /// such as by purpose, owner, environment, or other criteria. A resource can
    /// have as many
    /// as 50 tags.
    ///
    /// Each tag consists of a required *tag key* and an
    /// associated *tag value*, both of which you define. A tag key is a
    /// general label that acts as a category for more specific tag values. A tag
    /// value acts as
    /// a descriptor within a tag key.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove one or more tags (keys and values) from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update the configuration of an event destination for a configuration set.
    ///
    /// In Amazon Pinpoint, *events* include message sends, deliveries, opens,
    /// clicks, bounces, and complaints. *Event destinations* are places that
    /// you can send information about these events to. For example, you can send
    /// event data to
    /// Amazon SNS to receive notifications when you receive bounces or complaints,
    /// or you can use
    /// Amazon Kinesis Data Firehose to stream data to Amazon S3 for long-term
    /// storage.
    pub fn updateConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationInput, options: CallOptions) !update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationOutput {
        return update_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    pub fn getDedicatedIpsPaginator(self: *Self, params: get_dedicated_ips.GetDedicatedIpsInput) paginator.GetDedicatedIpsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationSetsPaginator(self: *Self, params: list_configuration_sets.ListConfigurationSetsInput) paginator.ListConfigurationSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDedicatedIpPoolsPaginator(self: *Self, params: list_dedicated_ip_pools.ListDedicatedIpPoolsInput) paginator.ListDedicatedIpPoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeliverabilityTestReportsPaginator(self: *Self, params: list_deliverability_test_reports.ListDeliverabilityTestReportsInput) paginator.ListDeliverabilityTestReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainDeliverabilityCampaignsPaginator(self: *Self, params: list_domain_deliverability_campaigns.ListDomainDeliverabilityCampaignsInput) paginator.ListDomainDeliverabilityCampaignsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEmailIdentitiesPaginator(self: *Self, params: list_email_identities.ListEmailIdentitiesInput) paginator.ListEmailIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
