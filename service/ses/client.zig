const aws = @import("aws");
const std = @import("std");

const clone_receipt_rule_set = @import("clone_receipt_rule_set.zig");
const create_configuration_set = @import("create_configuration_set.zig");
const create_configuration_set_event_destination = @import("create_configuration_set_event_destination.zig");
const create_configuration_set_tracking_options = @import("create_configuration_set_tracking_options.zig");
const create_custom_verification_email_template = @import("create_custom_verification_email_template.zig");
const create_receipt_filter = @import("create_receipt_filter.zig");
const create_receipt_rule = @import("create_receipt_rule.zig");
const create_receipt_rule_set = @import("create_receipt_rule_set.zig");
const create_template = @import("create_template.zig");
const delete_configuration_set = @import("delete_configuration_set.zig");
const delete_configuration_set_event_destination = @import("delete_configuration_set_event_destination.zig");
const delete_configuration_set_tracking_options = @import("delete_configuration_set_tracking_options.zig");
const delete_custom_verification_email_template = @import("delete_custom_verification_email_template.zig");
const delete_identity = @import("delete_identity.zig");
const delete_identity_policy = @import("delete_identity_policy.zig");
const delete_receipt_filter = @import("delete_receipt_filter.zig");
const delete_receipt_rule = @import("delete_receipt_rule.zig");
const delete_receipt_rule_set = @import("delete_receipt_rule_set.zig");
const delete_template = @import("delete_template.zig");
const delete_verified_email_address = @import("delete_verified_email_address.zig");
const describe_active_receipt_rule_set = @import("describe_active_receipt_rule_set.zig");
const describe_configuration_set = @import("describe_configuration_set.zig");
const describe_receipt_rule = @import("describe_receipt_rule.zig");
const describe_receipt_rule_set = @import("describe_receipt_rule_set.zig");
const get_account_sending_enabled = @import("get_account_sending_enabled.zig");
const get_custom_verification_email_template = @import("get_custom_verification_email_template.zig");
const get_identity_dkim_attributes = @import("get_identity_dkim_attributes.zig");
const get_identity_mail_from_domain_attributes = @import("get_identity_mail_from_domain_attributes.zig");
const get_identity_notification_attributes = @import("get_identity_notification_attributes.zig");
const get_identity_policies = @import("get_identity_policies.zig");
const get_identity_verification_attributes = @import("get_identity_verification_attributes.zig");
const get_send_quota = @import("get_send_quota.zig");
const get_send_statistics = @import("get_send_statistics.zig");
const get_template = @import("get_template.zig");
const list_configuration_sets = @import("list_configuration_sets.zig");
const list_custom_verification_email_templates = @import("list_custom_verification_email_templates.zig");
const list_identities = @import("list_identities.zig");
const list_identity_policies = @import("list_identity_policies.zig");
const list_receipt_filters = @import("list_receipt_filters.zig");
const list_receipt_rule_sets = @import("list_receipt_rule_sets.zig");
const list_templates = @import("list_templates.zig");
const list_verified_email_addresses = @import("list_verified_email_addresses.zig");
const put_configuration_set_delivery_options = @import("put_configuration_set_delivery_options.zig");
const put_identity_policy = @import("put_identity_policy.zig");
const reorder_receipt_rule_set = @import("reorder_receipt_rule_set.zig");
const send_bounce = @import("send_bounce.zig");
const send_bulk_templated_email = @import("send_bulk_templated_email.zig");
const send_custom_verification_email = @import("send_custom_verification_email.zig");
const send_email = @import("send_email.zig");
const send_raw_email = @import("send_raw_email.zig");
const send_templated_email = @import("send_templated_email.zig");
const set_active_receipt_rule_set = @import("set_active_receipt_rule_set.zig");
const set_identity_dkim_enabled = @import("set_identity_dkim_enabled.zig");
const set_identity_feedback_forwarding_enabled = @import("set_identity_feedback_forwarding_enabled.zig");
const set_identity_headers_in_notifications_enabled = @import("set_identity_headers_in_notifications_enabled.zig");
const set_identity_mail_from_domain = @import("set_identity_mail_from_domain.zig");
const set_identity_notification_topic = @import("set_identity_notification_topic.zig");
const set_receipt_rule_position = @import("set_receipt_rule_position.zig");
const test_render_template = @import("test_render_template.zig");
const update_account_sending_enabled = @import("update_account_sending_enabled.zig");
const update_configuration_set_event_destination = @import("update_configuration_set_event_destination.zig");
const update_configuration_set_reputation_metrics_enabled = @import("update_configuration_set_reputation_metrics_enabled.zig");
const update_configuration_set_sending_enabled = @import("update_configuration_set_sending_enabled.zig");
const update_configuration_set_tracking_options = @import("update_configuration_set_tracking_options.zig");
const update_custom_verification_email_template = @import("update_custom_verification_email_template.zig");
const update_receipt_rule = @import("update_receipt_rule.zig");
const update_template = @import("update_template.zig");
const verify_domain_dkim = @import("verify_domain_dkim.zig");
const verify_domain_identity = @import("verify_domain_identity.zig");
const verify_email_address = @import("verify_email_address.zig");
const verify_email_identity = @import("verify_email_identity.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SES";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a receipt rule set by cloning an existing one. All receipt rules and
    /// configurations are copied to the new receipt rule set and are completely
    /// independent of
    /// the source rule set.
    ///
    /// For information about setting up rule sets, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-concepts.html#receiving-email-concepts-rules).
    ///
    /// You can execute this operation no more than once per second.
    pub fn cloneReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: clone_receipt_rule_set.CloneReceiptRuleSetInput, options: clone_receipt_rule_set.Options) !clone_receipt_rule_set.CloneReceiptRuleSetOutput {
        return clone_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Creates a configuration set.
    ///
    /// Configuration sets enable you to publish email sending events. For
    /// information about
    /// using configuration sets, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set.CreateConfigurationSetInput, options: create_configuration_set.Options) !create_configuration_set.CreateConfigurationSetOutput {
        return create_configuration_set.execute(self, allocator, input, options);
    }

    /// Creates a configuration set event destination.
    ///
    /// When you create or update an event destination, you must provide one, and
    /// only
    /// one, destination. The destination can be CloudWatch, Amazon Kinesis
    /// Firehose, or Amazon Simple Notification Service (Amazon SNS).
    ///
    /// An event destination is the Amazon Web Services service to which Amazon SES
    /// publishes the email sending
    /// events associated with a configuration set. For information about using
    /// configuration
    /// sets, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set_event_destination.CreateConfigurationSetEventDestinationInput, options: create_configuration_set_event_destination.Options) !create_configuration_set_event_destination.CreateConfigurationSetEventDestinationOutput {
        return create_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Creates an association between a configuration set and a custom domain for
    /// open and
    /// click event tracking.
    ///
    /// By default, images and links used for tracking open and click events are
    /// hosted on
    /// domains operated by Amazon SES. You can configure a subdomain of your own to
    /// handle these
    /// events. For information about using custom domains, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/configure-custom-open-click-domains.html).
    pub fn createConfigurationSetTrackingOptions(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set_tracking_options.CreateConfigurationSetTrackingOptionsInput, options: create_configuration_set_tracking_options.Options) !create_configuration_set_tracking_options.CreateConfigurationSetTrackingOptionsOutput {
        return create_configuration_set_tracking_options.execute(self, allocator, input, options);
    }

    /// Creates a new custom verification email template.
    ///
    /// For more information about custom verification email templates, see [Using
    /// Custom Verification Email
    /// Templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn createCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: create_custom_verification_email_template.CreateCustomVerificationEmailTemplateInput, options: create_custom_verification_email_template.Options) !create_custom_verification_email_template.CreateCustomVerificationEmailTemplateOutput {
        return create_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Creates a new IP address filter.
    ///
    /// For information about setting up IP address filters, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-ip-filtering-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createReceiptFilter(self: *Self, allocator: std.mem.Allocator, input: create_receipt_filter.CreateReceiptFilterInput, options: create_receipt_filter.Options) !create_receipt_filter.CreateReceiptFilterOutput {
        return create_receipt_filter.execute(self, allocator, input, options);
    }

    /// Creates a receipt rule.
    ///
    /// For information about setting up receipt rules, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createReceiptRule(self: *Self, allocator: std.mem.Allocator, input: create_receipt_rule.CreateReceiptRuleInput, options: create_receipt_rule.Options) !create_receipt_rule.CreateReceiptRuleOutput {
        return create_receipt_rule.execute(self, allocator, input, options);
    }

    /// Creates an empty receipt rule set.
    ///
    /// For information about setting up receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-concepts.html#receiving-email-concepts-rules).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: create_receipt_rule_set.CreateReceiptRuleSetInput, options: create_receipt_rule_set.Options) !create_receipt_rule_set.CreateReceiptRuleSetOutput {
        return create_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Creates an email template. Email templates enable you to send personalized
    /// email to
    /// one or more destinations in a single operation. For more information, see
    /// the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/send-personalized-email-api.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createTemplate(self: *Self, allocator: std.mem.Allocator, input: create_template.CreateTemplateInput, options: create_template.Options) !create_template.CreateTemplateOutput {
        return create_template.execute(self, allocator, input, options);
    }

    /// Deletes a configuration set. Configuration sets enable you to publish email
    /// sending
    /// events. For information about using configuration sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set.DeleteConfigurationSetInput, options: delete_configuration_set.Options) !delete_configuration_set.DeleteConfigurationSetOutput {
        return delete_configuration_set.execute(self, allocator, input, options);
    }

    /// Deletes a configuration set event destination. Configuration set event
    /// destinations
    /// are associated with configuration sets, which enable you to publish email
    /// sending
    /// events. For information about using configuration sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationInput, options: delete_configuration_set_event_destination.Options) !delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationOutput {
        return delete_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Deletes an association between a configuration set and a custom domain for
    /// open and
    /// click event tracking.
    ///
    /// By default, images and links used for tracking open and click events are
    /// hosted on
    /// domains operated by Amazon SES. You can configure a subdomain of your own to
    /// handle these
    /// events. For information about using custom domains, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/configure-custom-open-click-domains.html).
    ///
    /// Deleting this kind of association results in emails sent using the specified
    /// configuration set to capture open and click events using the standard,
    /// Amazon SES-operated domains.
    pub fn deleteConfigurationSetTrackingOptions(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set_tracking_options.DeleteConfigurationSetTrackingOptionsInput, options: delete_configuration_set_tracking_options.Options) !delete_configuration_set_tracking_options.DeleteConfigurationSetTrackingOptionsOutput {
        return delete_configuration_set_tracking_options.execute(self, allocator, input, options);
    }

    /// Deletes an existing custom verification email template.
    ///
    /// For more information about custom verification email templates, see [Using
    /// Custom Verification Email
    /// Templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_custom_verification_email_template.DeleteCustomVerificationEmailTemplateInput, options: delete_custom_verification_email_template.Options) !delete_custom_verification_email_template.DeleteCustomVerificationEmailTemplateOutput {
        return delete_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Deletes the specified identity (an email address or a domain) from the list
    /// of
    /// verified identities.
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_identity.DeleteIdentityInput, options: delete_identity.Options) !delete_identity.DeleteIdentityOutput {
        return delete_identity.execute(self, allocator, input, options);
    }

    /// Deletes the specified sending authorization policy for the given identity
    /// (an email
    /// address or a domain). This operation returns successfully even if a policy
    /// with the
    /// specified name does not exist.
    ///
    /// This operation is for the identity owner only. If you have not verified the
    /// identity, it returns an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteIdentityPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_identity_policy.DeleteIdentityPolicyInput, options: delete_identity_policy.Options) !delete_identity_policy.DeleteIdentityPolicyOutput {
        return delete_identity_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified IP address filter.
    ///
    /// For information about managing IP address filters, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-ip-filtering-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteReceiptFilter(self: *Self, allocator: std.mem.Allocator, input: delete_receipt_filter.DeleteReceiptFilterInput, options: delete_receipt_filter.Options) !delete_receipt_filter.DeleteReceiptFilterOutput {
        return delete_receipt_filter.execute(self, allocator, input, options);
    }

    /// Deletes the specified receipt rule.
    ///
    /// For information about managing receipt rules, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteReceiptRule(self: *Self, allocator: std.mem.Allocator, input: delete_receipt_rule.DeleteReceiptRuleInput, options: delete_receipt_rule.Options) !delete_receipt_rule.DeleteReceiptRuleOutput {
        return delete_receipt_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified receipt rule set and all of the receipt rules it
    /// contains.
    ///
    /// The currently active rule set cannot be deleted.
    ///
    /// For information about managing receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: delete_receipt_rule_set.DeleteReceiptRuleSetInput, options: delete_receipt_rule_set.Options) !delete_receipt_rule_set.DeleteReceiptRuleSetOutput {
        return delete_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Deletes an email template.
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_template.DeleteTemplateInput, options: delete_template.Options) !delete_template.DeleteTemplateOutput {
        return delete_template.execute(self, allocator, input, options);
    }

    /// Deprecated. Use the `DeleteIdentity` operation to delete email addresses
    /// and domains.
    pub fn deleteVerifiedEmailAddress(self: *Self, allocator: std.mem.Allocator, input: delete_verified_email_address.DeleteVerifiedEmailAddressInput, options: delete_verified_email_address.Options) !delete_verified_email_address.DeleteVerifiedEmailAddressOutput {
        return delete_verified_email_address.execute(self, allocator, input, options);
    }

    /// Returns the metadata and receipt rules for the receipt rule set that is
    /// currently
    /// active.
    ///
    /// For information about setting up receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-concepts.html#receiving-email-concepts-rules).
    ///
    /// You can execute this operation no more than once per second.
    pub fn describeActiveReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: describe_active_receipt_rule_set.DescribeActiveReceiptRuleSetInput, options: describe_active_receipt_rule_set.Options) !describe_active_receipt_rule_set.DescribeActiveReceiptRuleSetOutput {
        return describe_active_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Returns the details of the specified configuration set. For information
    /// about using
    /// configuration sets, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn describeConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_set.DescribeConfigurationSetInput, options: describe_configuration_set.Options) !describe_configuration_set.DescribeConfigurationSetOutput {
        return describe_configuration_set.execute(self, allocator, input, options);
    }

    /// Returns the details of the specified receipt rule.
    ///
    /// For information about setting up receipt rules, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn describeReceiptRule(self: *Self, allocator: std.mem.Allocator, input: describe_receipt_rule.DescribeReceiptRuleInput, options: describe_receipt_rule.Options) !describe_receipt_rule.DescribeReceiptRuleOutput {
        return describe_receipt_rule.execute(self, allocator, input, options);
    }

    /// Returns the details of the specified receipt rule set.
    ///
    /// For information about managing receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn describeReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: describe_receipt_rule_set.DescribeReceiptRuleSetInput, options: describe_receipt_rule_set.Options) !describe_receipt_rule_set.DescribeReceiptRuleSetOutput {
        return describe_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Returns the email sending status of the Amazon SES account for the current
    /// Region.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getAccountSendingEnabled(self: *Self, allocator: std.mem.Allocator, input: get_account_sending_enabled.GetAccountSendingEnabledInput, options: get_account_sending_enabled.Options) !get_account_sending_enabled.GetAccountSendingEnabledOutput {
        return get_account_sending_enabled.execute(self, allocator, input, options);
    }

    /// Returns the custom email verification template for the template name you
    /// specify.
    ///
    /// For more information about custom verification email templates, see [Using
    /// Custom Verification Email
    /// Templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: get_custom_verification_email_template.GetCustomVerificationEmailTemplateInput, options: get_custom_verification_email_template.Options) !get_custom_verification_email_template.GetCustomVerificationEmailTemplateOutput {
        return get_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Returns the current status of Easy DKIM signing for an entity. For domain
    /// name
    /// identities, this operation also returns the DKIM tokens that are required
    /// for Easy DKIM
    /// signing, and whether Amazon SES has successfully verified that these tokens
    /// have been
    /// published.
    ///
    /// This operation takes a list of identities as input and returns the following
    /// information for each:
    ///
    /// * Whether Easy DKIM signing is enabled or disabled.
    ///
    /// * A set of DKIM tokens that represent the identity. If the identity is an
    ///   email
    /// address, the tokens represent the domain of that address.
    ///
    /// * Whether Amazon SES has successfully verified the DKIM tokens published in
    ///   the
    /// domain's DNS. This information is only returned for domain name identities,
    /// not
    /// for email addresses.
    ///
    /// This operation is throttled at one request per second and can only get DKIM
    /// attributes
    /// for up to 100 identities at a time.
    ///
    /// For more information about creating DNS records using DKIM tokens, go to the
    /// [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/send-email-authentication-dkim-easy-managing.html).
    pub fn getIdentityDkimAttributes(self: *Self, allocator: std.mem.Allocator, input: get_identity_dkim_attributes.GetIdentityDkimAttributesInput, options: get_identity_dkim_attributes.Options) !get_identity_dkim_attributes.GetIdentityDkimAttributesOutput {
        return get_identity_dkim_attributes.execute(self, allocator, input, options);
    }

    /// Returns the custom MAIL FROM attributes for a list of identities (email
    /// addresses :
    /// domains).
    ///
    /// This operation is throttled at one request per second and can only get
    /// custom MAIL
    /// FROM attributes for up to 100 identities at a time.
    pub fn getIdentityMailFromDomainAttributes(self: *Self, allocator: std.mem.Allocator, input: get_identity_mail_from_domain_attributes.GetIdentityMailFromDomainAttributesInput, options: get_identity_mail_from_domain_attributes.Options) !get_identity_mail_from_domain_attributes.GetIdentityMailFromDomainAttributesOutput {
        return get_identity_mail_from_domain_attributes.execute(self, allocator, input, options);
    }

    /// Given a list of verified identities (email addresses and/or domains),
    /// returns a
    /// structure describing identity notification attributes.
    ///
    /// This operation is throttled at one request per second and can only get
    /// notification
    /// attributes for up to 100 identities at a time.
    ///
    /// For more information about using notifications with Amazon SES, see the
    /// [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity-using-notifications.html).
    pub fn getIdentityNotificationAttributes(self: *Self, allocator: std.mem.Allocator, input: get_identity_notification_attributes.GetIdentityNotificationAttributesInput, options: get_identity_notification_attributes.Options) !get_identity_notification_attributes.GetIdentityNotificationAttributesOutput {
        return get_identity_notification_attributes.execute(self, allocator, input, options);
    }

    /// Returns the requested sending authorization policies for the given identity
    /// (an email
    /// address or a domain). The policies are returned as a map of policy names to
    /// policy
    /// contents. You can retrieve a maximum of 20 policies at a time.
    ///
    /// This operation is for the identity owner only. If you have not verified the
    /// identity, it returns an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn getIdentityPolicies(self: *Self, allocator: std.mem.Allocator, input: get_identity_policies.GetIdentityPoliciesInput, options: get_identity_policies.Options) !get_identity_policies.GetIdentityPoliciesOutput {
        return get_identity_policies.execute(self, allocator, input, options);
    }

    /// Given a list of identities (email addresses and/or domains), returns the
    /// verification
    /// status and (for domain identities) the verification token for each identity.
    ///
    /// The verification status of an email address is "Pending" until the email
    /// address owner
    /// clicks the link within the verification email that Amazon SES sent to that
    /// address. If the
    /// email address owner clicks the link within 24 hours, the verification status
    /// of the
    /// email address changes to "Success". If the link is not clicked within 24
    /// hours, the
    /// verification status changes to "Failed." In that case, to verify the email
    /// address, you
    /// must restart the verification process from the beginning.
    ///
    /// For domain identities, the domain's verification status is "Pending" as
    /// Amazon SES searches
    /// for the required TXT record in the DNS settings of the domain. When Amazon
    /// SES detects the
    /// record, the domain's verification status changes to "Success". If Amazon SES
    /// is unable to
    /// detect the record within 72 hours, the domain's verification status changes
    /// to "Failed."
    /// In that case, to verify the domain, you must restart the verification
    /// process from the
    /// beginning.
    ///
    /// This operation is throttled at one request per second and can only get
    /// verification
    /// attributes for up to 100 identities at a time.
    pub fn getIdentityVerificationAttributes(self: *Self, allocator: std.mem.Allocator, input: get_identity_verification_attributes.GetIdentityVerificationAttributesInput, options: get_identity_verification_attributes.Options) !get_identity_verification_attributes.GetIdentityVerificationAttributesOutput {
        return get_identity_verification_attributes.execute(self, allocator, input, options);
    }

    /// Provides the sending limits for the Amazon SES account.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getSendQuota(self: *Self, allocator: std.mem.Allocator, input: get_send_quota.GetSendQuotaInput, options: get_send_quota.Options) !get_send_quota.GetSendQuotaOutput {
        return get_send_quota.execute(self, allocator, input, options);
    }

    /// Provides sending statistics for the current Amazon Web Services Region. The
    /// result is a list of data
    /// points, representing the last two weeks of sending activity. Each data point
    /// in the list
    /// contains statistics for a 15-minute period of time.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getSendStatistics(self: *Self, allocator: std.mem.Allocator, input: get_send_statistics.GetSendStatisticsInput, options: get_send_statistics.Options) !get_send_statistics.GetSendStatisticsOutput {
        return get_send_statistics.execute(self, allocator, input, options);
    }

    /// Displays the template object (which includes the Subject line, HTML part and
    /// text
    /// part) for the template you specify.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getTemplate(self: *Self, allocator: std.mem.Allocator, input: get_template.GetTemplateInput, options: get_template.Options) !get_template.GetTemplateOutput {
        return get_template.execute(self, allocator, input, options);
    }

    /// Provides a list of the configuration sets associated with your Amazon SES
    /// account in the
    /// current Amazon Web Services Region. For information about using
    /// configuration sets, see [Monitoring
    /// Your Amazon SES Sending
    /// Activity](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html) in the *Amazon SES Developer
    /// Guide.*
    ///
    /// You can execute this operation no more than once per second. This operation
    /// returns up
    /// to 1,000 configuration sets each time it is run. If your Amazon SES account
    /// has more than
    /// 1,000 configuration sets, this operation also returns `NextToken`. You can
    /// then execute the `ListConfigurationSets` operation again, passing the
    /// `NextToken` parameter and the value of the NextToken element to retrieve
    /// additional results.
    pub fn listConfigurationSets(self: *Self, allocator: std.mem.Allocator, input: list_configuration_sets.ListConfigurationSetsInput, options: list_configuration_sets.Options) !list_configuration_sets.ListConfigurationSetsOutput {
        return list_configuration_sets.execute(self, allocator, input, options);
    }

    /// Lists the existing custom verification email templates for your account in
    /// the current
    /// Amazon Web Services Region.
    ///
    /// For more information about custom verification email templates, see [Using
    /// Custom Verification Email
    /// Templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn listCustomVerificationEmailTemplates(self: *Self, allocator: std.mem.Allocator, input: list_custom_verification_email_templates.ListCustomVerificationEmailTemplatesInput, options: list_custom_verification_email_templates.Options) !list_custom_verification_email_templates.ListCustomVerificationEmailTemplatesOutput {
        return list_custom_verification_email_templates.execute(self, allocator, input, options);
    }

    /// Returns a list containing all of the identities (email addresses and
    /// domains) for your
    /// Amazon Web Services account in the current Amazon Web Services Region,
    /// regardless of verification status.
    ///
    /// You can execute this operation no more than once per second.
    ///
    /// It's recommended that for successive pagination calls of this API, you
    /// continue to
    /// the use the same parameter/value pairs as used in the original call, e.g.,
    /// if you
    /// used `IdentityType=Domain` in the the original call and received a
    /// `NextToken` in the response, you should continue providing the
    /// `IdentityType=Domain` parameter for further `NextToken`
    /// calls; however, if you didn't provide the `IdentityType` parameter in the
    /// original call, then continue to not provide it for successive pagination
    /// calls.
    /// Using this protocol will ensure consistent results.
    pub fn listIdentities(self: *Self, allocator: std.mem.Allocator, input: list_identities.ListIdentitiesInput, options: list_identities.Options) !list_identities.ListIdentitiesOutput {
        return list_identities.execute(self, allocator, input, options);
    }

    /// Returns a list of sending authorization policies that are attached to the
    /// given
    /// identity (an email address or a domain). This operation returns only a list.
    /// To get the
    /// actual policy content, use `GetIdentityPolicies`.
    ///
    /// This operation is for the identity owner only. If you have not verified the
    /// identity, it returns an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn listIdentityPolicies(self: *Self, allocator: std.mem.Allocator, input: list_identity_policies.ListIdentityPoliciesInput, options: list_identity_policies.Options) !list_identity_policies.ListIdentityPoliciesOutput {
        return list_identity_policies.execute(self, allocator, input, options);
    }

    /// Lists the IP address filters associated with your Amazon Web Services
    /// account in the current
    /// Amazon Web Services Region.
    ///
    /// For information about managing IP address filters, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-ip-filtering-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn listReceiptFilters(self: *Self, allocator: std.mem.Allocator, input: list_receipt_filters.ListReceiptFiltersInput, options: list_receipt_filters.Options) !list_receipt_filters.ListReceiptFiltersOutput {
        return list_receipt_filters.execute(self, allocator, input, options);
    }

    /// Lists the receipt rule sets that exist under your Amazon Web Services
    /// account in the current
    /// Amazon Web Services Region. If there are additional receipt rule sets to be
    /// retrieved, you receive a
    /// `NextToken` that you can provide to the next call to
    /// `ListReceiptRuleSets` to retrieve the additional entries.
    ///
    /// For information about managing receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn listReceiptRuleSets(self: *Self, allocator: std.mem.Allocator, input: list_receipt_rule_sets.ListReceiptRuleSetsInput, options: list_receipt_rule_sets.Options) !list_receipt_rule_sets.ListReceiptRuleSetsOutput {
        return list_receipt_rule_sets.execute(self, allocator, input, options);
    }

    /// Lists the email templates present in your Amazon SES account in the current
    /// Amazon Web Services Region.
    ///
    /// You can execute this operation no more than once per second.
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: list_templates.Options) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// Deprecated. Use the `ListIdentities` operation to list the email addresses
    /// and domains associated with your account.
    pub fn listVerifiedEmailAddresses(self: *Self, allocator: std.mem.Allocator, input: list_verified_email_addresses.ListVerifiedEmailAddressesInput, options: list_verified_email_addresses.Options) !list_verified_email_addresses.ListVerifiedEmailAddressesOutput {
        return list_verified_email_addresses.execute(self, allocator, input, options);
    }

    /// Adds or updates the delivery options for a configuration set.
    pub fn putConfigurationSetDeliveryOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_delivery_options.PutConfigurationSetDeliveryOptionsInput, options: put_configuration_set_delivery_options.Options) !put_configuration_set_delivery_options.PutConfigurationSetDeliveryOptionsOutput {
        return put_configuration_set_delivery_options.execute(self, allocator, input, options);
    }

    /// Adds or updates a sending authorization policy for the specified identity
    /// (an email
    /// address or a domain).
    ///
    /// This operation is for the identity owner only. If you have not verified the
    /// identity, it returns an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn putIdentityPolicy(self: *Self, allocator: std.mem.Allocator, input: put_identity_policy.PutIdentityPolicyInput, options: put_identity_policy.Options) !put_identity_policy.PutIdentityPolicyOutput {
        return put_identity_policy.execute(self, allocator, input, options);
    }

    /// Reorders the receipt rules within a receipt rule set.
    ///
    /// All of the rules in the rule set must be represented in this request. That
    /// is, it
    /// is error if the reorder request doesn't explicitly position all of the
    /// rules.
    ///
    /// For information about managing receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn reorderReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: reorder_receipt_rule_set.ReorderReceiptRuleSetInput, options: reorder_receipt_rule_set.Options) !reorder_receipt_rule_set.ReorderReceiptRuleSetOutput {
        return reorder_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Generates and sends a bounce message to the sender of an email you received
    /// through
    /// Amazon SES. You can only use this operation on an email up to 24 hours after
    /// you receive
    /// it.
    ///
    /// You cannot use this operation to send generic bounces for mail that was not
    /// received by Amazon SES.
    ///
    /// For information about receiving email through Amazon SES, see the [Amazon
    /// SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn sendBounce(self: *Self, allocator: std.mem.Allocator, input: send_bounce.SendBounceInput, options: send_bounce.Options) !send_bounce.SendBounceOutput {
        return send_bounce.execute(self, allocator, input, options);
    }

    /// Composes an email message to multiple destinations. The message body is
    /// created using
    /// an email template.
    ///
    /// To send email using this operation, your call must meet the following
    /// requirements:
    ///
    /// * The call must refer to an existing email template. You can create email
    /// templates using CreateTemplate.
    ///
    /// * The message must be sent from a verified email address or domain.
    ///
    /// * If your account is still in the Amazon SES sandbox, you may send only to
    ///   verified
    /// addresses or domains, or to email addresses associated with the Amazon SES
    /// Mailbox
    /// Simulator. For more information, see [Verifying Email
    /// Addresses and
    /// Domains](https://docs.aws.amazon.com/ses/latest/dg/verify-addresses-and-domains.html) in the *Amazon SES Developer
    /// Guide.*
    ///
    /// * The maximum message size is 10 MB.
    ///
    /// * Each `Destination` parameter must include at least one recipient
    /// email address. The recipient address can be a To: address, a CC: address, or
    /// a
    /// BCC: address. If a recipient email address is invalid (that is, it is not in
    /// the
    /// format *UserName@[SubDomain.]Domain.TopLevelDomain*), the
    /// entire message is rejected, even if the message contains other recipients
    /// that
    /// are valid.
    ///
    /// * The message may not include more than 50 recipients, across the To:, CC:
    ///   and
    /// BCC: fields. If you need to send an email message to a larger audience, you
    /// can
    /// divide your recipient list into groups of 50 or fewer, and then call the
    /// `SendBulkTemplatedEmail` operation several times to send the
    /// message to each group.
    ///
    /// * The number of destinations you can contact in a single call can be limited
    ///   by
    /// your account's maximum sending rate.
    pub fn sendBulkTemplatedEmail(self: *Self, allocator: std.mem.Allocator, input: send_bulk_templated_email.SendBulkTemplatedEmailInput, options: send_bulk_templated_email.Options) !send_bulk_templated_email.SendBulkTemplatedEmailOutput {
        return send_bulk_templated_email.execute(self, allocator, input, options);
    }

    /// Adds an email address to the list of identities for your Amazon SES account
    /// in the current
    /// Amazon Web Services Region and attempts to verify it. As a result of
    /// executing this operation, a
    /// customized verification email is sent to the specified address.
    ///
    /// To use this operation, you must first create a custom verification email
    /// template. For
    /// more information about creating and using custom verification email
    /// templates, see
    /// [Using
    /// Custom Verification Email
    /// Templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn sendCustomVerificationEmail(self: *Self, allocator: std.mem.Allocator, input: send_custom_verification_email.SendCustomVerificationEmailInput, options: send_custom_verification_email.Options) !send_custom_verification_email.SendCustomVerificationEmailOutput {
        return send_custom_verification_email.execute(self, allocator, input, options);
    }

    /// Composes an email message and immediately queues it for sending. To send
    /// email using
    /// this operation, your message must meet the following requirements:
    ///
    /// * The message must be sent from a verified email address or domain. If you
    /// attempt to send email using a non-verified address or domain, the operation
    /// results in an "Email address not verified" error.
    ///
    /// * If your account is still in the Amazon SES sandbox, you may only send to
    ///   verified
    /// addresses or domains, or to email addresses associated with the Amazon SES
    /// Mailbox
    /// Simulator. For more information, see [Verifying Email
    /// Addresses and
    /// Domains](https://docs.aws.amazon.com/ses/latest/dg/verify-addresses-and-domains.html) in the *Amazon SES Developer
    /// Guide.*
    ///
    /// * The maximum message size is 10 MB.
    ///
    /// * The message must include at least one recipient email address. The
    ///   recipient
    /// address can be a To: address, a CC: address, or a BCC: address. If a
    /// recipient
    /// email address is invalid (that is, it is not in the format
    /// *UserName@[SubDomain.]Domain.TopLevelDomain*), the entire
    /// message is rejected, even if the message contains other recipients that are
    /// valid.
    ///
    /// * The message may not include more than 50 recipients, across the To:, CC:
    ///   and
    /// BCC: fields. If you need to send an email message to a larger audience, you
    /// can
    /// divide your recipient list into groups of 50 or fewer, and then call the
    /// `SendEmail` operation several times to send the message to each
    /// group.
    ///
    /// For every message that you send, the total number of recipients (including
    /// each
    /// recipient in the To:, CC: and BCC: fields) is counted against the maximum
    /// number of
    /// emails you can send in a 24-hour period (your *sending quota*).
    /// For more information about sending quotas in Amazon SES, see [Managing Your
    /// Amazon SES Sending
    /// Limits](https://docs.aws.amazon.com/ses/latest/dg/manage-sending-quotas.html) in the *Amazon SES Developer Guide.*
    pub fn sendEmail(self: *Self, allocator: std.mem.Allocator, input: send_email.SendEmailInput, options: send_email.Options) !send_email.SendEmailOutput {
        return send_email.execute(self, allocator, input, options);
    }

    /// Composes an email message and immediately queues it for sending.
    ///
    /// This operation is more flexible than the `SendEmail` operation. When you
    /// use the `SendRawEmail` operation, you can specify the headers of the message
    /// as well as its content. This flexibility is useful, for example, when you
    /// need to send a
    /// multipart MIME email (such a message that contains both a text and an HTML
    /// version). You
    /// can also use this operation to send messages that include attachments.
    ///
    /// The `SendRawEmail` operation has the following requirements:
    ///
    /// * You can only send email from [verified email addresses or
    ///   domains](https://docs.aws.amazon.com/ses/latest/dg/verify-addresses-and-domains.html). If you try to send email from
    /// an address that isn't verified, the operation results in an "Email address
    /// not
    /// verified" error.
    ///
    /// * If your account is still in the [Amazon SES
    ///   sandbox](https://docs.aws.amazon.com/ses/latest/dg/request-production-access.html), you can only send email to other verified addresses
    /// in your account, or to addresses that are associated with the [Amazon SES
    /// mailbox
    /// simulator](https://docs.aws.amazon.com/ses/latest/dg/send-an-email-from-console.html).
    ///
    /// * The maximum message size, including attachments, is 10 MB.
    ///
    /// * Each message has to include at least one recipient address. A recipient
    /// address includes any address on the To:, CC:, or BCC: lines.
    ///
    /// * If you send a single message to more than one recipient address, and one
    ///   of
    /// the recipient addresses isn't in a valid format (that is, it's not in the
    /// format
    /// *UserName@[SubDomain.]Domain.TopLevelDomain*), Amazon SES
    /// rejects the entire message, even if the other addresses are valid.
    ///
    /// * Each message can include up to 50 recipient addresses across the To:, CC:,
    ///   or
    /// BCC: lines. If you need to send a single message to more than 50 recipients,
    /// you
    /// have to split the list of recipient addresses into groups of less than 50
    /// recipients, and send separate messages to each group.
    ///
    /// * Amazon SES allows you to specify 8-bit Content-Transfer-Encoding for MIME
    ///   message
    /// parts. However, if Amazon SES has to modify the contents of your message
    /// (for
    /// example, if you use open and click tracking), 8-bit content isn't preserved.
    /// For
    /// this reason, we highly recommend that you encode all content that isn't
    /// 7-bit
    /// ASCII. For more information, see [MIME
    /// Encoding](https://docs.aws.amazon.com/ses/latest/dg/send-email-raw.html#send-email-mime-encoding) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// Additionally, keep the following considerations in mind when using the
    /// `SendRawEmail` operation:
    ///
    /// * Although you can customize the message headers when using the
    /// `SendRawEmail` operation, Amazon SES automatically applies its own
    /// `Message-ID` and `Date` headers; if you passed these
    /// headers when creating the message, they are overwritten by the values that
    /// Amazon SES
    /// provides.
    ///
    /// * If you are using sending authorization to send on behalf of another user,
    /// `SendRawEmail` enables you to specify the cross-account identity
    /// for the email's Source, From, and Return-Path parameters in one of two ways:
    /// you
    /// can pass optional parameters `SourceArn`, `FromArn`,
    /// and/or `ReturnPathArn`, or you can include the following X-headers in
    /// the header of your raw email:
    ///
    /// * `X-SES-SOURCE-ARN`
    ///
    /// * `X-SES-FROM-ARN`
    ///
    /// * `X-SES-RETURN-PATH-ARN`
    ///
    /// Don't include these X-headers in the DKIM signature. Amazon SES removes
    /// these
    /// before it sends the email.
    ///
    /// If you only specify the `SourceIdentityArn` parameter, Amazon SES sets
    /// the From and Return-Path addresses to the same identity that you
    /// specified.
    ///
    /// For more information about sending authorization, see the [Using
    /// Sending Authorization with Amazon
    /// SES](https://docs.aws.amazon.com/ses/latest/dg/sending-authorization.html)
    /// in the *Amazon SES Developer
    /// Guide.*
    ///
    /// * For every message that you send, the total number of recipients (including
    /// each recipient in the To:, CC: and BCC: fields) is counted against the
    /// maximum
    /// number of emails you can send in a 24-hour period (your *sending
    /// quota*). For more information about sending quotas in Amazon SES, see
    /// [Managing Your Amazon SES Sending
    /// Limits](https://docs.aws.amazon.com/ses/latest/dg/manage-sending-quotas.html) in the *Amazon SES Developer
    /// Guide.*
    pub fn sendRawEmail(self: *Self, allocator: std.mem.Allocator, input: send_raw_email.SendRawEmailInput, options: send_raw_email.Options) !send_raw_email.SendRawEmailOutput {
        return send_raw_email.execute(self, allocator, input, options);
    }

    /// Composes an email message using an email template and immediately queues it
    /// for
    /// sending.
    ///
    /// To send email using this operation, your call must meet the following
    /// requirements:
    ///
    /// * The call must refer to an existing email template. You can create email
    /// templates using the CreateTemplate operation.
    ///
    /// * The message must be sent from a verified email address or domain.
    ///
    /// * If your account is still in the Amazon SES sandbox, you may only send to
    ///   verified
    /// addresses or domains, or to email addresses associated with the Amazon SES
    /// Mailbox
    /// Simulator. For more information, see [Verifying Email
    /// Addresses and
    /// Domains](https://docs.aws.amazon.com/ses/latest/dg/verify-addresses-and-domains.html) in the *Amazon SES Developer
    /// Guide.*
    ///
    /// * The maximum message size is 10 MB.
    ///
    /// * Calls to the `SendTemplatedEmail` operation may only include one
    /// `Destination` parameter. A destination is a set of recipients
    /// that receives the same version of the email. The `Destination`
    /// parameter can include up to 50 recipients, across the To:, CC: and BCC:
    /// fields.
    ///
    /// * The `Destination` parameter must include at least one recipient
    /// email address. The recipient address can be a To: address, a CC: address, or
    /// a
    /// BCC: address. If a recipient email address is invalid (that is, it is not in
    /// the
    /// format *UserName@[SubDomain.]Domain.TopLevelDomain*), the
    /// entire message is rejected, even if the message contains other recipients
    /// that
    /// are valid.
    ///
    /// If your call to the `SendTemplatedEmail` operation includes all of the
    /// required parameters, Amazon SES accepts it and returns a Message ID.
    /// However, if Amazon SES
    /// can't render the email because the template contains errors, it doesn't send
    /// the
    /// email. Additionally, because it already accepted the message, Amazon SES
    /// doesn't return a
    /// message stating that it was unable to send the email.
    ///
    /// For these reasons, we highly recommend that you set up Amazon SES to send
    /// you
    /// notifications when Rendering Failure events occur. For more information, see
    /// [Sending Personalized Email Using the Amazon SES
    /// API](https://docs.aws.amazon.com/ses/latest/dg/send-personalized-email-api.html) in the
    /// *Amazon Simple Email Service Developer Guide*.
    pub fn sendTemplatedEmail(self: *Self, allocator: std.mem.Allocator, input: send_templated_email.SendTemplatedEmailInput, options: send_templated_email.Options) !send_templated_email.SendTemplatedEmailOutput {
        return send_templated_email.execute(self, allocator, input, options);
    }

    /// Sets the specified receipt rule set as the active receipt rule set.
    ///
    /// To disable your email-receiving through Amazon SES completely, you can call
    /// this
    /// operation with `RuleSetName` set to null.
    ///
    /// For information about managing receipt rule sets, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn setActiveReceiptRuleSet(self: *Self, allocator: std.mem.Allocator, input: set_active_receipt_rule_set.SetActiveReceiptRuleSetInput, options: set_active_receipt_rule_set.Options) !set_active_receipt_rule_set.SetActiveReceiptRuleSetOutput {
        return set_active_receipt_rule_set.execute(self, allocator, input, options);
    }

    /// Enables or disables Easy DKIM signing of email sent from an identity. If
    /// Easy DKIM
    /// signing is enabled for a domain, then Amazon SES uses DKIM to sign all email
    /// that it sends
    /// from addresses on that domain. If Easy DKIM signing is enabled for an email
    /// address,
    /// then Amazon SES uses DKIM to sign all email it sends from that address.
    ///
    /// For email addresses (for example, `user@example.com`), you can only
    /// enable DKIM signing if the corresponding domain (in this case,
    /// `example.com`) has been set up to use Easy DKIM.
    ///
    /// You can enable DKIM signing for an identity at any time after you start the
    /// verification process for the identity, even if the verification process
    /// isn't complete.
    ///
    /// You can execute this operation no more than once per second.
    ///
    /// For more information about Easy DKIM signing, go to the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/send-email-authentication-dkim-easy.html).
    pub fn setIdentityDkimEnabled(self: *Self, allocator: std.mem.Allocator, input: set_identity_dkim_enabled.SetIdentityDkimEnabledInput, options: set_identity_dkim_enabled.Options) !set_identity_dkim_enabled.SetIdentityDkimEnabledOutput {
        return set_identity_dkim_enabled.execute(self, allocator, input, options);
    }

    /// Given an identity (an email address or a domain), enables or disables
    /// whether Amazon SES
    /// forwards bounce and complaint notifications as email. Feedback forwarding
    /// can only be
    /// disabled when Amazon Simple Notification Service (Amazon SNS) topics are
    /// specified for both bounces and
    /// complaints.
    ///
    /// Feedback forwarding does not apply to delivery notifications. Delivery
    /// notifications are only available through Amazon SNS.
    ///
    /// You can execute this operation no more than once per second.
    ///
    /// For more information about using notifications with Amazon SES, see the
    /// [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity-using-notifications.html).
    pub fn setIdentityFeedbackForwardingEnabled(self: *Self, allocator: std.mem.Allocator, input: set_identity_feedback_forwarding_enabled.SetIdentityFeedbackForwardingEnabledInput, options: set_identity_feedback_forwarding_enabled.Options) !set_identity_feedback_forwarding_enabled.SetIdentityFeedbackForwardingEnabledOutput {
        return set_identity_feedback_forwarding_enabled.execute(self, allocator, input, options);
    }

    /// Given an identity (an email address or a domain), sets whether Amazon SES
    /// includes the
    /// original email headers in the Amazon Simple Notification Service (Amazon
    /// SNS) notifications of a specified
    /// type.
    ///
    /// You can execute this operation no more than once per second.
    ///
    /// For more information about using notifications with Amazon SES, see the
    /// [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity-using-notifications.html).
    pub fn setIdentityHeadersInNotificationsEnabled(self: *Self, allocator: std.mem.Allocator, input: set_identity_headers_in_notifications_enabled.SetIdentityHeadersInNotificationsEnabledInput, options: set_identity_headers_in_notifications_enabled.Options) !set_identity_headers_in_notifications_enabled.SetIdentityHeadersInNotificationsEnabledOutput {
        return set_identity_headers_in_notifications_enabled.execute(self, allocator, input, options);
    }

    /// Enables or disables the custom MAIL FROM domain setup for a verified
    /// identity (an
    /// email address or a domain).
    ///
    /// To send emails using the specified MAIL FROM domain, you must add an MX
    /// record to
    /// your MAIL FROM domain's DNS settings. To ensure that your emails pass Sender
    /// Policy
    /// Framework (SPF) checks, you must also add or update an SPF record. For more
    /// information, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/mail-from.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn setIdentityMailFromDomain(self: *Self, allocator: std.mem.Allocator, input: set_identity_mail_from_domain.SetIdentityMailFromDomainInput, options: set_identity_mail_from_domain.Options) !set_identity_mail_from_domain.SetIdentityMailFromDomainOutput {
        return set_identity_mail_from_domain.execute(self, allocator, input, options);
    }

    /// Sets an Amazon Simple Notification Service (Amazon SNS) topic to use when
    /// delivering notifications. When you use
    /// this operation, you specify a verified identity, such as an email address or
    /// domain.
    /// When you send an email that uses the chosen identity in the Source field,
    /// Amazon SES sends
    /// notifications to the topic you specified. You can send bounce, complaint, or
    /// delivery
    /// notifications (or any combination of the three) to the Amazon SNS topic that
    /// you
    /// specify.
    ///
    /// You can execute this operation no more than once per second.
    ///
    /// For more information about feedback notification, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity-using-notifications.html).
    pub fn setIdentityNotificationTopic(self: *Self, allocator: std.mem.Allocator, input: set_identity_notification_topic.SetIdentityNotificationTopicInput, options: set_identity_notification_topic.Options) !set_identity_notification_topic.SetIdentityNotificationTopicOutput {
        return set_identity_notification_topic.execute(self, allocator, input, options);
    }

    /// Sets the position of the specified receipt rule in the receipt rule set.
    ///
    /// For information about managing receipt rules, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn setReceiptRulePosition(self: *Self, allocator: std.mem.Allocator, input: set_receipt_rule_position.SetReceiptRulePositionInput, options: set_receipt_rule_position.Options) !set_receipt_rule_position.SetReceiptRulePositionOutput {
        return set_receipt_rule_position.execute(self, allocator, input, options);
    }

    /// Creates a preview of the MIME content of an email when provided with a
    /// template and a
    /// set of replacement data.
    ///
    /// You can execute this operation no more than once per second.
    pub fn testRenderTemplate(self: *Self, allocator: std.mem.Allocator, input: test_render_template.TestRenderTemplateInput, options: test_render_template.Options) !test_render_template.TestRenderTemplateOutput {
        return test_render_template.execute(self, allocator, input, options);
    }

    /// Enables or disables email sending across your entire Amazon SES account in
    /// the current
    /// Amazon Web Services Region. You can use this operation in conjunction with
    /// Amazon CloudWatch alarms to
    /// temporarily pause email sending across your Amazon SES account in a given
    /// Amazon Web Services Region when
    /// reputation metrics (such as your bounce or complaint rates) reach certain
    /// thresholds.
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateAccountSendingEnabled(self: *Self, allocator: std.mem.Allocator, input: update_account_sending_enabled.UpdateAccountSendingEnabledInput, options: update_account_sending_enabled.Options) !update_account_sending_enabled.UpdateAccountSendingEnabledOutput {
        return update_account_sending_enabled.execute(self, allocator, input, options);
    }

    /// Updates the event destination of a configuration set. Event destinations are
    /// associated with configuration sets, which enable you to publish email
    /// sending events to
    /// Amazon CloudWatch, Amazon Kinesis Firehose, or Amazon Simple Notification
    /// Service (Amazon SNS). For information about using configuration sets,
    /// see [Monitoring Your Amazon SES Sending
    /// Activity](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html) in the *Amazon SES Developer
    /// Guide.*
    ///
    /// When you create or update an event destination, you must provide one, and
    /// only
    /// one, destination. The destination can be Amazon CloudWatch, Amazon Kinesis
    /// Firehose, or Amazon Simple Notification Service
    /// (Amazon SNS).
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationInput, options: update_configuration_set_event_destination.Options) !update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationOutput {
        return update_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Enables or disables the publishing of reputation metrics for emails sent
    /// using a
    /// specific configuration set in a given Amazon Web Services Region. Reputation
    /// metrics include bounce
    /// and complaint rates. These metrics are published to Amazon CloudWatch. By
    /// using CloudWatch, you can
    /// create alarms when bounce or complaint rates exceed certain thresholds.
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateConfigurationSetReputationMetricsEnabled(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_reputation_metrics_enabled.UpdateConfigurationSetReputationMetricsEnabledInput, options: update_configuration_set_reputation_metrics_enabled.Options) !update_configuration_set_reputation_metrics_enabled.UpdateConfigurationSetReputationMetricsEnabledOutput {
        return update_configuration_set_reputation_metrics_enabled.execute(self, allocator, input, options);
    }

    /// Enables or disables email sending for messages sent using a specific
    /// configuration set
    /// in a given Amazon Web Services Region. You can use this operation in
    /// conjunction with Amazon CloudWatch alarms
    /// to temporarily pause email sending for a configuration set when the
    /// reputation metrics
    /// for that configuration set (such as your bounce on complaint rate) exceed
    /// certain
    /// thresholds.
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateConfigurationSetSendingEnabled(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_sending_enabled.UpdateConfigurationSetSendingEnabledInput, options: update_configuration_set_sending_enabled.Options) !update_configuration_set_sending_enabled.UpdateConfigurationSetSendingEnabledOutput {
        return update_configuration_set_sending_enabled.execute(self, allocator, input, options);
    }

    /// Modifies an association between a configuration set and a custom domain for
    /// open and
    /// click event tracking.
    ///
    /// By default, images and links used for tracking open and click events are
    /// hosted on
    /// domains operated by Amazon SES. You can configure a subdomain of your own to
    /// handle these
    /// events. For information about using custom domains, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/configure-custom-open-click-domains.html).
    pub fn updateConfigurationSetTrackingOptions(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_tracking_options.UpdateConfigurationSetTrackingOptionsInput, options: update_configuration_set_tracking_options.Options) !update_configuration_set_tracking_options.UpdateConfigurationSetTrackingOptionsOutput {
        return update_configuration_set_tracking_options.execute(self, allocator, input, options);
    }

    /// Updates an existing custom verification email template.
    ///
    /// For more information about custom verification email templates, see [Using
    /// Custom Verification Email
    /// Templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: update_custom_verification_email_template.UpdateCustomVerificationEmailTemplateInput, options: update_custom_verification_email_template.Options) !update_custom_verification_email_template.UpdateCustomVerificationEmailTemplateOutput {
        return update_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Updates a receipt rule.
    ///
    /// For information about managing receipt rules, see the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-receipt-rules-console-walkthrough.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateReceiptRule(self: *Self, allocator: std.mem.Allocator, input: update_receipt_rule.UpdateReceiptRuleInput, options: update_receipt_rule.Options) !update_receipt_rule.UpdateReceiptRuleOutput {
        return update_receipt_rule.execute(self, allocator, input, options);
    }

    /// Updates an email template. Email templates enable you to send personalized
    /// email to
    /// one or more destinations in a single operation. For more information, see
    /// the [Amazon SES
    /// Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/send-personalized-email-api.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_template.UpdateTemplateInput, options: update_template.Options) !update_template.UpdateTemplateOutput {
        return update_template.execute(self, allocator, input, options);
    }

    /// Returns a set of DKIM tokens for a domain identity.
    ///
    /// When you execute the `VerifyDomainDkim` operation, the domain that you
    /// specify is added to the list of identities that are associated with your
    /// account.
    /// This is true even if you haven't already associated the domain with your
    /// account by
    /// using the `VerifyDomainIdentity` operation. However, you can't send email
    /// from the domain until you either successfully [verify
    /// it](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#verify-domain-procedure) or you successfully [set up DKIM for
    /// it](https://docs.aws.amazon.com/ses/latest/dg/send-email-authentication-dkim-easy.html).
    ///
    /// You use the tokens that are generated by this operation to create CNAME
    /// records. When
    /// Amazon SES detects that you've added these records to the DNS configuration
    /// for a domain, you
    /// can start sending email from that domain. You can start sending email even
    /// if you
    /// haven't added the TXT record provided by the VerifyDomainIdentity operation
    /// to the DNS
    /// configuration for your domain. All email that you send from the domain is
    /// authenticated
    /// using DKIM.
    ///
    /// To create the CNAME records for DKIM authentication, use the following
    /// values:
    ///
    /// * **Name**:
    /// *token*._domainkey.*example.com*
    ///
    /// * **Type**: CNAME
    ///
    /// * **Value**:
    /// *token*.dkim.amazonses.com
    ///
    /// In the preceding example, replace *token* with one of the tokens
    /// that are generated when you execute this operation. Replace
    /// *example.com* with your domain. Repeat this process for each
    /// token that's generated by this operation.
    ///
    /// You can execute this operation no more than once per second.
    pub fn verifyDomainDkim(self: *Self, allocator: std.mem.Allocator, input: verify_domain_dkim.VerifyDomainDkimInput, options: verify_domain_dkim.Options) !verify_domain_dkim.VerifyDomainDkimOutput {
        return verify_domain_dkim.execute(self, allocator, input, options);
    }

    /// Adds a domain to the list of identities for your Amazon SES account in the
    /// current
    /// Amazon Web Services Region and attempts to verify it. For more information
    /// about verifying domains,
    /// see [Verifying Email Addresses and
    /// Domains](https://docs.aws.amazon.com/ses/latest/dg/verify-addresses-and-domains.html) in the *Amazon SES Developer
    /// Guide.*
    ///
    /// You can execute this operation no more than once per second.
    pub fn verifyDomainIdentity(self: *Self, allocator: std.mem.Allocator, input: verify_domain_identity.VerifyDomainIdentityInput, options: verify_domain_identity.Options) !verify_domain_identity.VerifyDomainIdentityOutput {
        return verify_domain_identity.execute(self, allocator, input, options);
    }

    /// Deprecated. Use the `VerifyEmailIdentity` operation to verify a new email
    /// address.
    pub fn verifyEmailAddress(self: *Self, allocator: std.mem.Allocator, input: verify_email_address.VerifyEmailAddressInput, options: verify_email_address.Options) !verify_email_address.VerifyEmailAddressOutput {
        return verify_email_address.execute(self, allocator, input, options);
    }

    /// Adds an email address to the list of identities for your Amazon SES account
    /// in the current
    /// Amazon Web Services Region and attempts to verify it. As a result of
    /// executing this operation, a
    /// verification email is sent to the specified address.
    ///
    /// You can execute this operation no more than once per second.
    pub fn verifyEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: verify_email_identity.VerifyEmailIdentityInput, options: verify_email_identity.Options) !verify_email_identity.VerifyEmailIdentityOutput {
        return verify_email_identity.execute(self, allocator, input, options);
    }

    pub fn listCustomVerificationEmailTemplatesPaginator(self: *Self, params: list_custom_verification_email_templates.ListCustomVerificationEmailTemplatesInput) paginator.ListCustomVerificationEmailTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIdentitiesPaginator(self: *Self, params: list_identities.ListIdentitiesInput) paginator.ListIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilIdentityExists(self: *Self, params: get_identity_verification_attributes.GetIdentityVerificationAttributesInput) aws.waiter.WaiterError!void {
        var w = waiters.IdentityExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
