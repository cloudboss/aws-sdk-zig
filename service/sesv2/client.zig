const aws = @import("aws");
const std = @import("std");

const batch_get_metric_data = @import("batch_get_metric_data.zig");
const cancel_export_job = @import("cancel_export_job.zig");
const create_configuration_set = @import("create_configuration_set.zig");
const create_configuration_set_event_destination = @import("create_configuration_set_event_destination.zig");
const create_contact = @import("create_contact.zig");
const create_contact_list = @import("create_contact_list.zig");
const create_custom_verification_email_template = @import("create_custom_verification_email_template.zig");
const create_dedicated_ip_pool = @import("create_dedicated_ip_pool.zig");
const create_deliverability_test_report = @import("create_deliverability_test_report.zig");
const create_email_identity = @import("create_email_identity.zig");
const create_email_identity_policy = @import("create_email_identity_policy.zig");
const create_email_template = @import("create_email_template.zig");
const create_export_job = @import("create_export_job.zig");
const create_import_job = @import("create_import_job.zig");
const create_multi_region_endpoint = @import("create_multi_region_endpoint.zig");
const create_tenant = @import("create_tenant.zig");
const create_tenant_resource_association = @import("create_tenant_resource_association.zig");
const delete_configuration_set = @import("delete_configuration_set.zig");
const delete_configuration_set_event_destination = @import("delete_configuration_set_event_destination.zig");
const delete_contact = @import("delete_contact.zig");
const delete_contact_list = @import("delete_contact_list.zig");
const delete_custom_verification_email_template = @import("delete_custom_verification_email_template.zig");
const delete_dedicated_ip_pool = @import("delete_dedicated_ip_pool.zig");
const delete_email_identity = @import("delete_email_identity.zig");
const delete_email_identity_policy = @import("delete_email_identity_policy.zig");
const delete_email_template = @import("delete_email_template.zig");
const delete_multi_region_endpoint = @import("delete_multi_region_endpoint.zig");
const delete_suppressed_destination = @import("delete_suppressed_destination.zig");
const delete_tenant = @import("delete_tenant.zig");
const delete_tenant_resource_association = @import("delete_tenant_resource_association.zig");
const get_account = @import("get_account.zig");
const get_blacklist_reports = @import("get_blacklist_reports.zig");
const get_configuration_set = @import("get_configuration_set.zig");
const get_configuration_set_event_destinations = @import("get_configuration_set_event_destinations.zig");
const get_contact = @import("get_contact.zig");
const get_contact_list = @import("get_contact_list.zig");
const get_custom_verification_email_template = @import("get_custom_verification_email_template.zig");
const get_dedicated_ip = @import("get_dedicated_ip.zig");
const get_dedicated_ip_pool = @import("get_dedicated_ip_pool.zig");
const get_dedicated_ips = @import("get_dedicated_ips.zig");
const get_deliverability_dashboard_options = @import("get_deliverability_dashboard_options.zig");
const get_deliverability_test_report = @import("get_deliverability_test_report.zig");
const get_domain_deliverability_campaign = @import("get_domain_deliverability_campaign.zig");
const get_domain_statistics_report = @import("get_domain_statistics_report.zig");
const get_email_address_insights = @import("get_email_address_insights.zig");
const get_email_identity = @import("get_email_identity.zig");
const get_email_identity_policies = @import("get_email_identity_policies.zig");
const get_email_template = @import("get_email_template.zig");
const get_export_job = @import("get_export_job.zig");
const get_import_job = @import("get_import_job.zig");
const get_message_insights = @import("get_message_insights.zig");
const get_multi_region_endpoint = @import("get_multi_region_endpoint.zig");
const get_reputation_entity = @import("get_reputation_entity.zig");
const get_suppressed_destination = @import("get_suppressed_destination.zig");
const get_tenant = @import("get_tenant.zig");
const list_configuration_sets = @import("list_configuration_sets.zig");
const list_contact_lists = @import("list_contact_lists.zig");
const list_contacts = @import("list_contacts.zig");
const list_custom_verification_email_templates = @import("list_custom_verification_email_templates.zig");
const list_dedicated_ip_pools = @import("list_dedicated_ip_pools.zig");
const list_deliverability_test_reports = @import("list_deliverability_test_reports.zig");
const list_domain_deliverability_campaigns = @import("list_domain_deliverability_campaigns.zig");
const list_email_identities = @import("list_email_identities.zig");
const list_email_templates = @import("list_email_templates.zig");
const list_export_jobs = @import("list_export_jobs.zig");
const list_import_jobs = @import("list_import_jobs.zig");
const list_multi_region_endpoints = @import("list_multi_region_endpoints.zig");
const list_recommendations = @import("list_recommendations.zig");
const list_reputation_entities = @import("list_reputation_entities.zig");
const list_resource_tenants = @import("list_resource_tenants.zig");
const list_suppressed_destinations = @import("list_suppressed_destinations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tenant_resources = @import("list_tenant_resources.zig");
const list_tenants = @import("list_tenants.zig");
const put_account_dedicated_ip_warmup_attributes = @import("put_account_dedicated_ip_warmup_attributes.zig");
const put_account_details = @import("put_account_details.zig");
const put_account_sending_attributes = @import("put_account_sending_attributes.zig");
const put_account_suppression_attributes = @import("put_account_suppression_attributes.zig");
const put_account_vdm_attributes = @import("put_account_vdm_attributes.zig");
const put_configuration_set_archiving_options = @import("put_configuration_set_archiving_options.zig");
const put_configuration_set_delivery_options = @import("put_configuration_set_delivery_options.zig");
const put_configuration_set_reputation_options = @import("put_configuration_set_reputation_options.zig");
const put_configuration_set_sending_options = @import("put_configuration_set_sending_options.zig");
const put_configuration_set_suppression_options = @import("put_configuration_set_suppression_options.zig");
const put_configuration_set_tracking_options = @import("put_configuration_set_tracking_options.zig");
const put_configuration_set_vdm_options = @import("put_configuration_set_vdm_options.zig");
const put_dedicated_ip_in_pool = @import("put_dedicated_ip_in_pool.zig");
const put_dedicated_ip_pool_scaling_attributes = @import("put_dedicated_ip_pool_scaling_attributes.zig");
const put_dedicated_ip_warmup_attributes = @import("put_dedicated_ip_warmup_attributes.zig");
const put_deliverability_dashboard_option = @import("put_deliverability_dashboard_option.zig");
const put_email_identity_configuration_set_attributes = @import("put_email_identity_configuration_set_attributes.zig");
const put_email_identity_dkim_attributes = @import("put_email_identity_dkim_attributes.zig");
const put_email_identity_dkim_signing_attributes = @import("put_email_identity_dkim_signing_attributes.zig");
const put_email_identity_feedback_attributes = @import("put_email_identity_feedback_attributes.zig");
const put_email_identity_mail_from_attributes = @import("put_email_identity_mail_from_attributes.zig");
const put_suppressed_destination = @import("put_suppressed_destination.zig");
const send_bulk_email = @import("send_bulk_email.zig");
const send_custom_verification_email = @import("send_custom_verification_email.zig");
const send_email = @import("send_email.zig");
const tag_resource = @import("tag_resource.zig");
const test_render_email_template = @import("test_render_email_template.zig");
const untag_resource = @import("untag_resource.zig");
const update_configuration_set_event_destination = @import("update_configuration_set_event_destination.zig");
const update_contact = @import("update_contact.zig");
const update_contact_list = @import("update_contact_list.zig");
const update_custom_verification_email_template = @import("update_custom_verification_email_template.zig");
const update_email_identity_policy = @import("update_email_identity_policy.zig");
const update_email_template = @import("update_email_template.zig");
const update_reputation_entity_customer_managed_status = @import("update_reputation_entity_customer_managed_status.zig");
const update_reputation_entity_policy = @import("update_reputation_entity_policy.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SESv2";

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

    /// Retrieves batches of metric data collected based on your sending activity.
    ///
    /// You can execute this operation no more than 16 times per second,
    /// and with at most 160 queries from the batches per second (cumulative).
    pub fn batchGetMetricData(self: *Self, allocator: std.mem.Allocator, input: batch_get_metric_data.BatchGetMetricDataInput, options: batch_get_metric_data.Options) !batch_get_metric_data.BatchGetMetricDataOutput {
        return batch_get_metric_data.execute(self, allocator, input, options);
    }

    /// Cancels an export job.
    pub fn cancelExportJob(self: *Self, allocator: std.mem.Allocator, input: cancel_export_job.CancelExportJobInput, options: cancel_export_job.Options) !cancel_export_job.CancelExportJobOutput {
        return cancel_export_job.execute(self, allocator, input, options);
    }

    /// Create a configuration set. *Configuration sets* are groups of
    /// rules that you can apply to the emails that you send. You apply a
    /// configuration set to
    /// an email by specifying the name of the configuration set when you call the
    /// Amazon SES API v2. When
    /// you apply a configuration set to an email, all of the rules in that
    /// configuration set
    /// are applied to the email.
    pub fn createConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set.CreateConfigurationSetInput, options: create_configuration_set.Options) !create_configuration_set.CreateConfigurationSetOutput {
        return create_configuration_set.execute(self, allocator, input, options);
    }

    /// Create an event destination. *Events* include message sends,
    /// deliveries, opens, clicks, bounces, and complaints. *Event
    /// destinations* are places that you can send information about these events
    /// to. For example, you can send event data to Amazon EventBridge and associate
    /// a rule to send the event
    /// to the specified target.
    ///
    /// A single configuration set can include more than one event destination.
    pub fn createConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set_event_destination.CreateConfigurationSetEventDestinationInput, options: create_configuration_set_event_destination.Options) !create_configuration_set_event_destination.CreateConfigurationSetEventDestinationOutput {
        return create_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Creates a contact, which is an end-user who is receiving the email, and adds
    /// them to a
    /// contact list.
    pub fn createContact(self: *Self, allocator: std.mem.Allocator, input: create_contact.CreateContactInput, options: create_contact.Options) !create_contact.CreateContactOutput {
        return create_contact.execute(self, allocator, input, options);
    }

    /// Creates a contact list.
    pub fn createContactList(self: *Self, allocator: std.mem.Allocator, input: create_contact_list.CreateContactListInput, options: create_contact_list.Options) !create_contact_list.CreateContactListOutput {
        return create_contact_list.execute(self, allocator, input, options);
    }

    /// Creates a new custom verification email template.
    ///
    /// For more information about custom verification email templates, see [Using
    /// custom verification email
    /// templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn createCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: create_custom_verification_email_template.CreateCustomVerificationEmailTemplateInput, options: create_custom_verification_email_template.Options) !create_custom_verification_email_template.CreateCustomVerificationEmailTemplateOutput {
        return create_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Create a new pool of dedicated IP addresses. A pool can include one or more
    /// dedicated
    /// IP addresses that are associated with your Amazon Web Services account. You
    /// can associate a pool with
    /// a configuration set. When you send an email that uses that configuration
    /// set, the
    /// message is sent from one of the addresses in the associated pool.
    pub fn createDedicatedIpPool(self: *Self, allocator: std.mem.Allocator, input: create_dedicated_ip_pool.CreateDedicatedIpPoolInput, options: create_dedicated_ip_pool.Options) !create_dedicated_ip_pool.CreateDedicatedIpPoolOutput {
        return create_dedicated_ip_pool.execute(self, allocator, input, options);
    }

    /// Create a new predictive inbox placement test. Predictive inbox placement
    /// tests can help you predict how your messages will be handled
    /// by various email providers around the world. When you perform a predictive
    /// inbox placement test, you provide a
    /// sample message that contains the content that you plan to send to your
    /// customers. Amazon SES
    /// then sends that message to special email addresses spread across several
    /// major email
    /// providers. After about 24 hours, the test is complete, and you can use the
    /// `GetDeliverabilityTestReport` operation to view the results of the
    /// test.
    pub fn createDeliverabilityTestReport(self: *Self, allocator: std.mem.Allocator, input: create_deliverability_test_report.CreateDeliverabilityTestReportInput, options: create_deliverability_test_report.Options) !create_deliverability_test_report.CreateDeliverabilityTestReportOutput {
        return create_deliverability_test_report.execute(self, allocator, input, options);
    }

    /// Starts the process of verifying an email identity. An *identity* is
    /// an email address or domain that you use when you send email. Before you can
    /// use an
    /// identity to send email, you first have to verify it. By verifying an
    /// identity, you
    /// demonstrate that you're the owner of the identity, and that you've given
    /// Amazon SES API v2
    /// permission to send email from the identity.
    ///
    /// When you verify an email address, Amazon SES sends an email to the address.
    /// Your email
    /// address is verified as soon as you follow the link in the verification
    /// email.
    ///
    /// When you verify a domain without specifying the `DkimSigningAttributes`
    /// object, this operation provides a set of DKIM tokens. You can convert these
    /// tokens into
    /// CNAME records, which you then add to the DNS configuration for your domain.
    /// Your domain
    /// is verified when Amazon SES detects these records in the DNS configuration
    /// for your domain.
    /// This verification method is known as [Easy
    /// DKIM](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/easy-dkim.html).
    ///
    /// Alternatively, you can perform the verification process by providing your
    /// own
    /// public-private key pair. This verification method is known as Bring Your Own
    /// DKIM
    /// (BYODKIM). To use BYODKIM, your call to the `CreateEmailIdentity` operation
    /// has to include the `DkimSigningAttributes` object. When you specify this
    /// object, you provide a selector (a component of the DNS record name that
    /// identifies the
    /// public key to use for DKIM authentication) and a private key.
    ///
    /// When you verify a domain, this operation provides a set of DKIM tokens,
    /// which you can
    /// convert into CNAME tokens. You add these CNAME tokens to the DNS
    /// configuration for your
    /// domain. Your domain is verified when Amazon SES detects these records in the
    /// DNS
    /// configuration for your domain. For some DNS providers, it can take 72 hours
    /// or more to
    /// complete the domain verification process.
    ///
    /// Additionally, you can associate an existing configuration set with the email
    /// identity that you're verifying.
    pub fn createEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: create_email_identity.CreateEmailIdentityInput, options: create_email_identity.Options) !create_email_identity.CreateEmailIdentityOutput {
        return create_email_identity.execute(self, allocator, input, options);
    }

    /// Creates the specified sending authorization policy for the given identity
    /// (an email
    /// address or a domain).
    ///
    /// This API is for the identity owner only. If you have not verified the
    /// identity,
    /// this API will return an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createEmailIdentityPolicy(self: *Self, allocator: std.mem.Allocator, input: create_email_identity_policy.CreateEmailIdentityPolicyInput, options: create_email_identity_policy.Options) !create_email_identity_policy.CreateEmailIdentityPolicyOutput {
        return create_email_identity_policy.execute(self, allocator, input, options);
    }

    /// Creates an email template. Email templates enable you to send personalized
    /// email to
    /// one or more destinations in a single API operation. For more information,
    /// see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-personalized-email-api.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn createEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: create_email_template.CreateEmailTemplateInput, options: create_email_template.Options) !create_email_template.CreateEmailTemplateOutput {
        return create_email_template.execute(self, allocator, input, options);
    }

    /// Creates an export job for a data source and destination.
    ///
    /// You can execute this operation no more than once per second.
    pub fn createExportJob(self: *Self, allocator: std.mem.Allocator, input: create_export_job.CreateExportJobInput, options: create_export_job.Options) !create_export_job.CreateExportJobOutput {
        return create_export_job.execute(self, allocator, input, options);
    }

    /// Creates an import job for a data destination.
    pub fn createImportJob(self: *Self, allocator: std.mem.Allocator, input: create_import_job.CreateImportJobInput, options: create_import_job.Options) !create_import_job.CreateImportJobOutput {
        return create_import_job.execute(self, allocator, input, options);
    }

    /// Creates a multi-region endpoint (global-endpoint).
    ///
    /// The primary region is going to be the AWS-Region where the operation is
    /// executed.
    /// The secondary region has to be provided in request's parameters.
    /// From the data flow standpoint there is no difference between primary
    /// and secondary regions - sending traffic will be split equally between the
    /// two.
    /// The primary region is the region where the resource has been created and
    /// where it can be managed.
    pub fn createMultiRegionEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_multi_region_endpoint.CreateMultiRegionEndpointInput, options: create_multi_region_endpoint.Options) !create_multi_region_endpoint.CreateMultiRegionEndpointOutput {
        return create_multi_region_endpoint.execute(self, allocator, input, options);
    }

    /// Create a tenant.
    ///
    /// *Tenants* are logical containers that group related SES resources together.
    /// Each tenant can have its own set of resources like email identities,
    /// configuration sets,
    /// and templates, along with reputation metrics and sending status. This helps
    /// isolate and manage
    /// email sending for different customers or business units within your Amazon
    /// SES API v2 account.
    pub fn createTenant(self: *Self, allocator: std.mem.Allocator, input: create_tenant.CreateTenantInput, options: create_tenant.Options) !create_tenant.CreateTenantOutput {
        return create_tenant.execute(self, allocator, input, options);
    }

    /// Associate a resource with a tenant.
    ///
    /// *Resources* can be email identities, configuration sets, or email templates.
    /// When you associate a resource with a tenant, you can use that resource when
    /// sending emails
    /// on behalf of that tenant.
    ///
    /// A single resource can be associated with multiple tenants, allowing for
    /// resource sharing
    /// across different tenants while maintaining isolation in email sending
    /// operations.
    pub fn createTenantResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: create_tenant_resource_association.CreateTenantResourceAssociationInput, options: create_tenant_resource_association.Options) !create_tenant_resource_association.CreateTenantResourceAssociationOutput {
        return create_tenant_resource_association.execute(self, allocator, input, options);
    }

    /// Delete an existing configuration set.
    ///
    /// *Configuration sets* are groups of rules that you can apply to the
    /// emails you send. You apply a configuration set to an email by including a
    /// reference to
    /// the configuration set in the headers of the email. When you apply a
    /// configuration set to
    /// an email, all of the rules in that configuration set are applied to the
    /// email.
    pub fn deleteConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set.DeleteConfigurationSetInput, options: delete_configuration_set.Options) !delete_configuration_set.DeleteConfigurationSetOutput {
        return delete_configuration_set.execute(self, allocator, input, options);
    }

    /// Delete an event destination.
    ///
    /// *Events* include message sends, deliveries, opens, clicks, bounces,
    /// and complaints. *Event destinations* are places that you can send
    /// information about these events to. For example, you can send event data to
    /// Amazon EventBridge and
    /// associate a rule to send the event to the specified target.
    pub fn deleteConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationInput, options: delete_configuration_set_event_destination.Options) !delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationOutput {
        return delete_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Removes a contact from a contact list.
    pub fn deleteContact(self: *Self, allocator: std.mem.Allocator, input: delete_contact.DeleteContactInput, options: delete_contact.Options) !delete_contact.DeleteContactOutput {
        return delete_contact.execute(self, allocator, input, options);
    }

    /// Deletes a contact list and all of the contacts on that list.
    pub fn deleteContactList(self: *Self, allocator: std.mem.Allocator, input: delete_contact_list.DeleteContactListInput, options: delete_contact_list.Options) !delete_contact_list.DeleteContactListOutput {
        return delete_contact_list.execute(self, allocator, input, options);
    }

    /// Deletes an existing custom verification email template.
    ///
    /// For more information about custom verification email templates, see [Using
    /// custom verification email
    /// templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_custom_verification_email_template.DeleteCustomVerificationEmailTemplateInput, options: delete_custom_verification_email_template.Options) !delete_custom_verification_email_template.DeleteCustomVerificationEmailTemplateOutput {
        return delete_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Delete a dedicated IP pool.
    pub fn deleteDedicatedIpPool(self: *Self, allocator: std.mem.Allocator, input: delete_dedicated_ip_pool.DeleteDedicatedIpPoolInput, options: delete_dedicated_ip_pool.Options) !delete_dedicated_ip_pool.DeleteDedicatedIpPoolOutput {
        return delete_dedicated_ip_pool.execute(self, allocator, input, options);
    }

    /// Deletes an email identity. An identity can be either an email address or a
    /// domain
    /// name.
    pub fn deleteEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_email_identity.DeleteEmailIdentityInput, options: delete_email_identity.Options) !delete_email_identity.DeleteEmailIdentityOutput {
        return delete_email_identity.execute(self, allocator, input, options);
    }

    /// Deletes the specified sending authorization policy for the given identity
    /// (an email
    /// address or a domain). This API returns successfully even if a policy with
    /// the specified
    /// name does not exist.
    ///
    /// This API is for the identity owner only. If you have not verified the
    /// identity,
    /// this API will return an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteEmailIdentityPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_email_identity_policy.DeleteEmailIdentityPolicyInput, options: delete_email_identity_policy.Options) !delete_email_identity_policy.DeleteEmailIdentityPolicyOutput {
        return delete_email_identity_policy.execute(self, allocator, input, options);
    }

    /// Deletes an email template.
    ///
    /// You can execute this operation no more than once per second.
    pub fn deleteEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_email_template.DeleteEmailTemplateInput, options: delete_email_template.Options) !delete_email_template.DeleteEmailTemplateOutput {
        return delete_email_template.execute(self, allocator, input, options);
    }

    /// Deletes a multi-region endpoint (global-endpoint).
    ///
    /// Only multi-region endpoints (global-endpoints) whose primary region is the
    /// AWS-Region
    /// where operation is executed can be deleted.
    pub fn deleteMultiRegionEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_multi_region_endpoint.DeleteMultiRegionEndpointInput, options: delete_multi_region_endpoint.Options) !delete_multi_region_endpoint.DeleteMultiRegionEndpointOutput {
        return delete_multi_region_endpoint.execute(self, allocator, input, options);
    }

    /// Removes an email address from the suppression list for your account.
    pub fn deleteSuppressedDestination(self: *Self, allocator: std.mem.Allocator, input: delete_suppressed_destination.DeleteSuppressedDestinationInput, options: delete_suppressed_destination.Options) !delete_suppressed_destination.DeleteSuppressedDestinationOutput {
        return delete_suppressed_destination.execute(self, allocator, input, options);
    }

    /// Delete an existing tenant.
    ///
    /// When you delete a tenant, its associations with resources
    /// are removed, but the resources themselves are not deleted.
    pub fn deleteTenant(self: *Self, allocator: std.mem.Allocator, input: delete_tenant.DeleteTenantInput, options: delete_tenant.Options) !delete_tenant.DeleteTenantOutput {
        return delete_tenant.execute(self, allocator, input, options);
    }

    /// Delete an association between a tenant and a resource.
    ///
    /// When you delete a tenant-resource association, the resource itself is not
    /// deleted,
    /// only its association with the specific tenant is removed. After removal, the
    /// resource
    /// will no longer be available for use with that tenant's email sending
    /// operations.
    pub fn deleteTenantResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_tenant_resource_association.DeleteTenantResourceAssociationInput, options: delete_tenant_resource_association.Options) !delete_tenant_resource_association.DeleteTenantResourceAssociationOutput {
        return delete_tenant_resource_association.execute(self, allocator, input, options);
    }

    /// Obtain information about the email-sending status and capabilities of your
    /// Amazon SES
    /// account in the current Amazon Web Services Region.
    pub fn getAccount(self: *Self, allocator: std.mem.Allocator, input: get_account.GetAccountInput, options: get_account.Options) !get_account.GetAccountOutput {
        return get_account.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the blacklists that your dedicated IP addresses appear
    /// on.
    pub fn getBlacklistReports(self: *Self, allocator: std.mem.Allocator, input: get_blacklist_reports.GetBlacklistReportsInput, options: get_blacklist_reports.Options) !get_blacklist_reports.GetBlacklistReportsOutput {
        return get_blacklist_reports.execute(self, allocator, input, options);
    }

    /// Get information about an existing configuration set, including the dedicated
    /// IP pool
    /// that it's associated with, whether or not it's enabled for sending email,
    /// and
    /// more.
    ///
    /// *Configuration sets* are groups of rules that you can apply to the
    /// emails you send. You apply a configuration set to an email by including a
    /// reference to
    /// the configuration set in the headers of the email. When you apply a
    /// configuration set to
    /// an email, all of the rules in that configuration set are applied to the
    /// email.
    pub fn getConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: get_configuration_set.GetConfigurationSetInput, options: get_configuration_set.Options) !get_configuration_set.GetConfigurationSetOutput {
        return get_configuration_set.execute(self, allocator, input, options);
    }

    /// Retrieve a list of event destinations that are associated with a
    /// configuration
    /// set.
    ///
    /// *Events* include message sends, deliveries, opens, clicks, bounces,
    /// and complaints. *Event destinations* are places that you can send
    /// information about these events to. For example, you can send event data to
    /// Amazon EventBridge and
    /// associate a rule to send the event to the specified target.
    pub fn getConfigurationSetEventDestinations(self: *Self, allocator: std.mem.Allocator, input: get_configuration_set_event_destinations.GetConfigurationSetEventDestinationsInput, options: get_configuration_set_event_destinations.Options) !get_configuration_set_event_destinations.GetConfigurationSetEventDestinationsOutput {
        return get_configuration_set_event_destinations.execute(self, allocator, input, options);
    }

    /// Returns a contact from a contact list.
    pub fn getContact(self: *Self, allocator: std.mem.Allocator, input: get_contact.GetContactInput, options: get_contact.Options) !get_contact.GetContactOutput {
        return get_contact.execute(self, allocator, input, options);
    }

    /// Returns contact list metadata. It does not return any information about the
    /// contacts
    /// present in the list.
    pub fn getContactList(self: *Self, allocator: std.mem.Allocator, input: get_contact_list.GetContactListInput, options: get_contact_list.Options) !get_contact_list.GetContactListOutput {
        return get_contact_list.execute(self, allocator, input, options);
    }

    /// Returns the custom email verification template for the template name you
    /// specify.
    ///
    /// For more information about custom verification email templates, see [Using
    /// custom verification email
    /// templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: get_custom_verification_email_template.GetCustomVerificationEmailTemplateInput, options: get_custom_verification_email_template.Options) !get_custom_verification_email_template.GetCustomVerificationEmailTemplateOutput {
        return get_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Get information about a dedicated IP address, including the name of the
    /// dedicated IP
    /// pool that it's associated with, as well information about the automatic
    /// warm-up process
    /// for the address.
    pub fn getDedicatedIp(self: *Self, allocator: std.mem.Allocator, input: get_dedicated_ip.GetDedicatedIpInput, options: get_dedicated_ip.Options) !get_dedicated_ip.GetDedicatedIpOutput {
        return get_dedicated_ip.execute(self, allocator, input, options);
    }

    /// Retrieve information about the dedicated pool.
    pub fn getDedicatedIpPool(self: *Self, allocator: std.mem.Allocator, input: get_dedicated_ip_pool.GetDedicatedIpPoolInput, options: get_dedicated_ip_pool.Options) !get_dedicated_ip_pool.GetDedicatedIpPoolOutput {
        return get_dedicated_ip_pool.execute(self, allocator, input, options);
    }

    /// List the dedicated IP addresses that are associated with your Amazon Web
    /// Services
    /// account.
    pub fn getDedicatedIps(self: *Self, allocator: std.mem.Allocator, input: get_dedicated_ips.GetDedicatedIpsInput, options: get_dedicated_ips.Options) !get_dedicated_ips.GetDedicatedIpsOutput {
        return get_dedicated_ips.execute(self, allocator, input, options);
    }

    /// Retrieve information about the status of the Deliverability dashboard for
    /// your account. When
    /// the Deliverability dashboard is enabled, you gain access to reputation,
    /// deliverability, and other
    /// metrics for the domains that you use to send email. You also gain the
    /// ability to perform
    /// predictive inbox placement tests.
    ///
    /// When you use the Deliverability dashboard, you pay a monthly subscription
    /// charge, in addition
    /// to any other fees that you accrue by using Amazon SES and other Amazon Web
    /// Services services. For more
    /// information about the features and cost of a Deliverability dashboard
    /// subscription, see [Amazon SES Pricing](http://aws.amazon.com/ses/pricing/).
    pub fn getDeliverabilityDashboardOptions(self: *Self, allocator: std.mem.Allocator, input: get_deliverability_dashboard_options.GetDeliverabilityDashboardOptionsInput, options: get_deliverability_dashboard_options.Options) !get_deliverability_dashboard_options.GetDeliverabilityDashboardOptionsOutput {
        return get_deliverability_dashboard_options.execute(self, allocator, input, options);
    }

    /// Retrieve the results of a predictive inbox placement test.
    pub fn getDeliverabilityTestReport(self: *Self, allocator: std.mem.Allocator, input: get_deliverability_test_report.GetDeliverabilityTestReportInput, options: get_deliverability_test_report.Options) !get_deliverability_test_report.GetDeliverabilityTestReportOutput {
        return get_deliverability_test_report.execute(self, allocator, input, options);
    }

    /// Retrieve all the deliverability data for a specific campaign. This data is
    /// available
    /// for a campaign only if the campaign sent email by using a domain that the
    /// Deliverability dashboard is enabled for.
    pub fn getDomainDeliverabilityCampaign(self: *Self, allocator: std.mem.Allocator, input: get_domain_deliverability_campaign.GetDomainDeliverabilityCampaignInput, options: get_domain_deliverability_campaign.Options) !get_domain_deliverability_campaign.GetDomainDeliverabilityCampaignOutput {
        return get_domain_deliverability_campaign.execute(self, allocator, input, options);
    }

    /// Retrieve inbox placement and engagement rates for the domains that you use
    /// to send
    /// email.
    pub fn getDomainStatisticsReport(self: *Self, allocator: std.mem.Allocator, input: get_domain_statistics_report.GetDomainStatisticsReportInput, options: get_domain_statistics_report.Options) !get_domain_statistics_report.GetDomainStatisticsReportOutput {
        return get_domain_statistics_report.execute(self, allocator, input, options);
    }

    /// Provides validation insights about a specific email address, including
    /// syntax validation, DNS record checks, mailbox existence, and other
    /// deliverability factors.
    pub fn getEmailAddressInsights(self: *Self, allocator: std.mem.Allocator, input: get_email_address_insights.GetEmailAddressInsightsInput, options: get_email_address_insights.Options) !get_email_address_insights.GetEmailAddressInsightsOutput {
        return get_email_address_insights.execute(self, allocator, input, options);
    }

    /// Provides information about a specific identity, including the identity's
    /// verification
    /// status, sending authorization policies, its DKIM authentication status, and
    /// its custom
    /// Mail-From settings.
    pub fn getEmailIdentity(self: *Self, allocator: std.mem.Allocator, input: get_email_identity.GetEmailIdentityInput, options: get_email_identity.Options) !get_email_identity.GetEmailIdentityOutput {
        return get_email_identity.execute(self, allocator, input, options);
    }

    /// Returns the requested sending authorization policies for the given identity
    /// (an email
    /// address or a domain). The policies are returned as a map of policy names to
    /// policy
    /// contents. You can retrieve a maximum of 20 policies at a time.
    ///
    /// This API is for the identity owner only. If you have not verified the
    /// identity,
    /// this API will return an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn getEmailIdentityPolicies(self: *Self, allocator: std.mem.Allocator, input: get_email_identity_policies.GetEmailIdentityPoliciesInput, options: get_email_identity_policies.Options) !get_email_identity_policies.GetEmailIdentityPoliciesOutput {
        return get_email_identity_policies.execute(self, allocator, input, options);
    }

    /// Displays the template object (which includes the subject line, HTML part and
    /// text
    /// part) for the template you specify.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: get_email_template.GetEmailTemplateInput, options: get_email_template.Options) !get_email_template.GetEmailTemplateOutput {
        return get_email_template.execute(self, allocator, input, options);
    }

    /// Provides information about an export job.
    pub fn getExportJob(self: *Self, allocator: std.mem.Allocator, input: get_export_job.GetExportJobInput, options: get_export_job.Options) !get_export_job.GetExportJobOutput {
        return get_export_job.execute(self, allocator, input, options);
    }

    /// Provides information about an import job.
    pub fn getImportJob(self: *Self, allocator: std.mem.Allocator, input: get_import_job.GetImportJobInput, options: get_import_job.Options) !get_import_job.GetImportJobOutput {
        return get_import_job.execute(self, allocator, input, options);
    }

    /// Provides information about a specific message, including the from address,
    /// the
    /// subject, the recipient address, email tags, as well as events associated
    /// with the message.
    ///
    /// You can execute this operation no more than once per second.
    pub fn getMessageInsights(self: *Self, allocator: std.mem.Allocator, input: get_message_insights.GetMessageInsightsInput, options: get_message_insights.Options) !get_message_insights.GetMessageInsightsOutput {
        return get_message_insights.execute(self, allocator, input, options);
    }

    /// Displays the multi-region endpoint (global-endpoint) configuration.
    ///
    /// Only multi-region endpoints (global-endpoints) whose primary region is the
    /// AWS-Region
    /// where operation is executed can be displayed.
    pub fn getMultiRegionEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_multi_region_endpoint.GetMultiRegionEndpointInput, options: get_multi_region_endpoint.Options) !get_multi_region_endpoint.GetMultiRegionEndpointOutput {
        return get_multi_region_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieve information about a specific reputation entity, including its
    /// reputation
    /// management policy, customer-managed status, Amazon Web Services Amazon
    /// SES-managed status, and aggregate
    /// sending status.
    ///
    /// *Reputation entities* represent resources in your Amazon SES account that
    /// have reputation
    /// tracking and management capabilities. The reputation impact reflects the
    /// highest
    /// impact reputation finding for the entity. Reputation findings can be
    /// retrieved
    /// using the `ListRecommendations` operation.
    pub fn getReputationEntity(self: *Self, allocator: std.mem.Allocator, input: get_reputation_entity.GetReputationEntityInput, options: get_reputation_entity.Options) !get_reputation_entity.GetReputationEntityOutput {
        return get_reputation_entity.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific email address that's on the
    /// suppression list
    /// for your account.
    pub fn getSuppressedDestination(self: *Self, allocator: std.mem.Allocator, input: get_suppressed_destination.GetSuppressedDestinationInput, options: get_suppressed_destination.Options) !get_suppressed_destination.GetSuppressedDestinationOutput {
        return get_suppressed_destination.execute(self, allocator, input, options);
    }

    /// Get information about a specific tenant, including the tenant's name, ID,
    /// ARN,
    /// creation timestamp, tags, and sending status.
    pub fn getTenant(self: *Self, allocator: std.mem.Allocator, input: get_tenant.GetTenantInput, options: get_tenant.Options) !get_tenant.GetTenantOutput {
        return get_tenant.execute(self, allocator, input, options);
    }

    /// List all of the configuration sets associated with your account in the
    /// current
    /// region.
    ///
    /// *Configuration sets* are groups of rules that you can apply to the
    /// emails you send. You apply a configuration set to an email by including a
    /// reference to
    /// the configuration set in the headers of the email. When you apply a
    /// configuration set to
    /// an email, all of the rules in that configuration set are applied to the
    /// email.
    pub fn listConfigurationSets(self: *Self, allocator: std.mem.Allocator, input: list_configuration_sets.ListConfigurationSetsInput, options: list_configuration_sets.Options) !list_configuration_sets.ListConfigurationSetsOutput {
        return list_configuration_sets.execute(self, allocator, input, options);
    }

    /// Lists all of the contact lists available.
    ///
    /// If your output includes a "NextToken" field with a string value, this
    /// indicates there may be additional
    /// contacts on the filtered list - regardless of the number of contacts
    /// returned.
    pub fn listContactLists(self: *Self, allocator: std.mem.Allocator, input: list_contact_lists.ListContactListsInput, options: list_contact_lists.Options) !list_contact_lists.ListContactListsOutput {
        return list_contact_lists.execute(self, allocator, input, options);
    }

    /// Lists the contacts present in a specific contact list.
    pub fn listContacts(self: *Self, allocator: std.mem.Allocator, input: list_contacts.ListContactsInput, options: list_contacts.Options) !list_contacts.ListContactsOutput {
        return list_contacts.execute(self, allocator, input, options);
    }

    /// Lists the existing custom verification email templates for your account in
    /// the current
    /// Amazon Web Services Region.
    ///
    /// For more information about custom verification email templates, see [Using
    /// custom verification email
    /// templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn listCustomVerificationEmailTemplates(self: *Self, allocator: std.mem.Allocator, input: list_custom_verification_email_templates.ListCustomVerificationEmailTemplatesInput, options: list_custom_verification_email_templates.Options) !list_custom_verification_email_templates.ListCustomVerificationEmailTemplatesOutput {
        return list_custom_verification_email_templates.execute(self, allocator, input, options);
    }

    /// List all of the dedicated IP pools that exist in your Amazon Web Services
    /// account in the current
    /// Region.
    pub fn listDedicatedIpPools(self: *Self, allocator: std.mem.Allocator, input: list_dedicated_ip_pools.ListDedicatedIpPoolsInput, options: list_dedicated_ip_pools.Options) !list_dedicated_ip_pools.ListDedicatedIpPoolsOutput {
        return list_dedicated_ip_pools.execute(self, allocator, input, options);
    }

    /// Show a list of the predictive inbox placement tests that you've performed,
    /// regardless of their statuses. For
    /// predictive inbox placement tests that are complete, you can use the
    /// `GetDeliverabilityTestReport`
    /// operation to view the results.
    pub fn listDeliverabilityTestReports(self: *Self, allocator: std.mem.Allocator, input: list_deliverability_test_reports.ListDeliverabilityTestReportsInput, options: list_deliverability_test_reports.Options) !list_deliverability_test_reports.ListDeliverabilityTestReportsOutput {
        return list_deliverability_test_reports.execute(self, allocator, input, options);
    }

    /// Retrieve deliverability data for all the campaigns that used a specific
    /// domain to send
    /// email during a specified time range. This data is available for a domain
    /// only if you
    /// enabled the Deliverability dashboard for the domain.
    pub fn listDomainDeliverabilityCampaigns(self: *Self, allocator: std.mem.Allocator, input: list_domain_deliverability_campaigns.ListDomainDeliverabilityCampaignsInput, options: list_domain_deliverability_campaigns.Options) !list_domain_deliverability_campaigns.ListDomainDeliverabilityCampaignsOutput {
        return list_domain_deliverability_campaigns.execute(self, allocator, input, options);
    }

    /// Returns a list of all of the email identities that are associated with your
    /// Amazon Web Services
    /// account. An identity can be either an email address or a domain. This
    /// operation returns
    /// identities that are verified as well as those that aren't. This operation
    /// returns
    /// identities that are associated with Amazon SES and Amazon Pinpoint.
    pub fn listEmailIdentities(self: *Self, allocator: std.mem.Allocator, input: list_email_identities.ListEmailIdentitiesInput, options: list_email_identities.Options) !list_email_identities.ListEmailIdentitiesOutput {
        return list_email_identities.execute(self, allocator, input, options);
    }

    /// Lists the email templates present in your Amazon SES account in the current
    /// Amazon Web Services
    /// Region.
    ///
    /// You can execute this operation no more than once per second.
    pub fn listEmailTemplates(self: *Self, allocator: std.mem.Allocator, input: list_email_templates.ListEmailTemplatesInput, options: list_email_templates.Options) !list_email_templates.ListEmailTemplatesOutput {
        return list_email_templates.execute(self, allocator, input, options);
    }

    /// Lists all of the export jobs.
    pub fn listExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_export_jobs.ListExportJobsInput, options: list_export_jobs.Options) !list_export_jobs.ListExportJobsOutput {
        return list_export_jobs.execute(self, allocator, input, options);
    }

    /// Lists all of the import jobs.
    pub fn listImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_import_jobs.ListImportJobsInput, options: list_import_jobs.Options) !list_import_jobs.ListImportJobsOutput {
        return list_import_jobs.execute(self, allocator, input, options);
    }

    /// List the multi-region endpoints (global-endpoints).
    ///
    /// Only multi-region endpoints (global-endpoints) whose primary region is the
    /// AWS-Region
    /// where operation is executed will be listed.
    pub fn listMultiRegionEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_multi_region_endpoints.ListMultiRegionEndpointsInput, options: list_multi_region_endpoints.Options) !list_multi_region_endpoints.ListMultiRegionEndpointsOutput {
        return list_multi_region_endpoints.execute(self, allocator, input, options);
    }

    /// Lists the recommendations present in your Amazon SES account in the current
    /// Amazon Web Services Region.
    ///
    /// You can execute this operation no more than once per second.
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: list_recommendations.Options) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// List reputation entities in your Amazon SES account in the current Amazon
    /// Web Services Region.
    /// You can filter the results by entity type, reputation impact, sending
    /// status,
    /// or entity reference prefix.
    ///
    /// *Reputation entities* represent resources in your account that have
    /// reputation
    /// tracking and management capabilities. Use this operation to get an overview
    /// of
    /// all entities and their current reputation status.
    pub fn listReputationEntities(self: *Self, allocator: std.mem.Allocator, input: list_reputation_entities.ListReputationEntitiesInput, options: list_reputation_entities.Options) !list_reputation_entities.ListReputationEntitiesOutput {
        return list_reputation_entities.execute(self, allocator, input, options);
    }

    /// List all tenants associated with a specific resource.
    ///
    /// This operation returns a list of tenants that are associated with the
    /// specified
    /// resource. This is useful for understanding which tenants are currently using
    /// a particular
    /// resource such as an email identity, configuration set, or email template.
    pub fn listResourceTenants(self: *Self, allocator: std.mem.Allocator, input: list_resource_tenants.ListResourceTenantsInput, options: list_resource_tenants.Options) !list_resource_tenants.ListResourceTenantsOutput {
        return list_resource_tenants.execute(self, allocator, input, options);
    }

    /// Retrieves a list of email addresses that are on the suppression list for
    /// your
    /// account.
    pub fn listSuppressedDestinations(self: *Self, allocator: std.mem.Allocator, input: list_suppressed_destinations.ListSuppressedDestinationsInput, options: list_suppressed_destinations.Options) !list_suppressed_destinations.ListSuppressedDestinationsOutput {
        return list_suppressed_destinations.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the tags (keys and values) that are associated with a
    /// specified
    /// resource. A *tag* is a label that you optionally define and associate
    /// with a resource. Each tag consists of a required *tag key* and an
    /// optional associated *tag value*. A tag key is a general label that
    /// acts as a category for more specific tag values. A tag value acts as a
    /// descriptor within
    /// a tag key.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List all resources associated with a specific tenant.
    ///
    /// This operation returns a list of resources (email identities, configuration
    /// sets,
    /// or email templates) that are associated with the specified tenant. You can
    /// optionally
    /// filter the results by resource type.
    pub fn listTenantResources(self: *Self, allocator: std.mem.Allocator, input: list_tenant_resources.ListTenantResourcesInput, options: list_tenant_resources.Options) !list_tenant_resources.ListTenantResourcesOutput {
        return list_tenant_resources.execute(self, allocator, input, options);
    }

    /// List all tenants associated with your account in the current Amazon Web
    /// Services Region.
    ///
    /// This operation returns basic information about each tenant,
    /// such as tenant name, ID, ARN, and creation timestamp.
    pub fn listTenants(self: *Self, allocator: std.mem.Allocator, input: list_tenants.ListTenantsInput, options: list_tenants.Options) !list_tenants.ListTenantsOutput {
        return list_tenants.execute(self, allocator, input, options);
    }

    /// Enable or disable the automatic warm-up feature for dedicated IP addresses.
    pub fn putAccountDedicatedIpWarmupAttributes(self: *Self, allocator: std.mem.Allocator, input: put_account_dedicated_ip_warmup_attributes.PutAccountDedicatedIpWarmupAttributesInput, options: put_account_dedicated_ip_warmup_attributes.Options) !put_account_dedicated_ip_warmup_attributes.PutAccountDedicatedIpWarmupAttributesOutput {
        return put_account_dedicated_ip_warmup_attributes.execute(self, allocator, input, options);
    }

    /// Update your Amazon SES account details.
    pub fn putAccountDetails(self: *Self, allocator: std.mem.Allocator, input: put_account_details.PutAccountDetailsInput, options: put_account_details.Options) !put_account_details.PutAccountDetailsOutput {
        return put_account_details.execute(self, allocator, input, options);
    }

    /// Enable or disable the ability of your account to send email.
    pub fn putAccountSendingAttributes(self: *Self, allocator: std.mem.Allocator, input: put_account_sending_attributes.PutAccountSendingAttributesInput, options: put_account_sending_attributes.Options) !put_account_sending_attributes.PutAccountSendingAttributesOutput {
        return put_account_sending_attributes.execute(self, allocator, input, options);
    }

    /// Change the settings for the account-level suppression list.
    pub fn putAccountSuppressionAttributes(self: *Self, allocator: std.mem.Allocator, input: put_account_suppression_attributes.PutAccountSuppressionAttributesInput, options: put_account_suppression_attributes.Options) !put_account_suppression_attributes.PutAccountSuppressionAttributesOutput {
        return put_account_suppression_attributes.execute(self, allocator, input, options);
    }

    /// Update your Amazon SES account VDM attributes.
    ///
    /// You can execute this operation no more than once per second.
    pub fn putAccountVdmAttributes(self: *Self, allocator: std.mem.Allocator, input: put_account_vdm_attributes.PutAccountVdmAttributesInput, options: put_account_vdm_attributes.Options) !put_account_vdm_attributes.PutAccountVdmAttributesOutput {
        return put_account_vdm_attributes.execute(self, allocator, input, options);
    }

    /// Associate the configuration set with a MailManager archive. When you send
    /// email using the
    /// `SendEmail` or `SendBulkEmail` operations the message as it will be given
    /// to the receiving SMTP server will be archived, along with the recipient
    /// information.
    pub fn putConfigurationSetArchivingOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_archiving_options.PutConfigurationSetArchivingOptionsInput, options: put_configuration_set_archiving_options.Options) !put_configuration_set_archiving_options.PutConfigurationSetArchivingOptionsOutput {
        return put_configuration_set_archiving_options.execute(self, allocator, input, options);
    }

    /// Associate a configuration set with a dedicated IP pool. You can use
    /// dedicated IP pools
    /// to create groups of dedicated IP addresses for sending specific types of
    /// email.
    pub fn putConfigurationSetDeliveryOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_delivery_options.PutConfigurationSetDeliveryOptionsInput, options: put_configuration_set_delivery_options.Options) !put_configuration_set_delivery_options.PutConfigurationSetDeliveryOptionsOutput {
        return put_configuration_set_delivery_options.execute(self, allocator, input, options);
    }

    /// Enable or disable collection of reputation metrics for emails that you send
    /// using a
    /// particular configuration set in a specific Amazon Web Services Region.
    pub fn putConfigurationSetReputationOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_reputation_options.PutConfigurationSetReputationOptionsInput, options: put_configuration_set_reputation_options.Options) !put_configuration_set_reputation_options.PutConfigurationSetReputationOptionsOutput {
        return put_configuration_set_reputation_options.execute(self, allocator, input, options);
    }

    /// Enable or disable email sending for messages that use a particular
    /// configuration set
    /// in a specific Amazon Web Services Region.
    pub fn putConfigurationSetSendingOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_sending_options.PutConfigurationSetSendingOptionsInput, options: put_configuration_set_sending_options.Options) !put_configuration_set_sending_options.PutConfigurationSetSendingOptionsOutput {
        return put_configuration_set_sending_options.execute(self, allocator, input, options);
    }

    /// Specify the account suppression list preferences for a configuration set.
    pub fn putConfigurationSetSuppressionOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_suppression_options.PutConfigurationSetSuppressionOptionsInput, options: put_configuration_set_suppression_options.Options) !put_configuration_set_suppression_options.PutConfigurationSetSuppressionOptionsOutput {
        return put_configuration_set_suppression_options.execute(self, allocator, input, options);
    }

    /// Specify a custom domain to use for open and click tracking elements in email
    /// that you
    /// send.
    pub fn putConfigurationSetTrackingOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_tracking_options.PutConfigurationSetTrackingOptionsInput, options: put_configuration_set_tracking_options.Options) !put_configuration_set_tracking_options.PutConfigurationSetTrackingOptionsOutput {
        return put_configuration_set_tracking_options.execute(self, allocator, input, options);
    }

    /// Specify VDM preferences for email that you send using the configuration set.
    ///
    /// You can execute this operation no more than once per second.
    pub fn putConfigurationSetVdmOptions(self: *Self, allocator: std.mem.Allocator, input: put_configuration_set_vdm_options.PutConfigurationSetVdmOptionsInput, options: put_configuration_set_vdm_options.Options) !put_configuration_set_vdm_options.PutConfigurationSetVdmOptionsOutput {
        return put_configuration_set_vdm_options.execute(self, allocator, input, options);
    }

    /// Move a dedicated IP address to an existing dedicated IP pool.
    ///
    /// The dedicated IP address that you specify must already exist, and must be
    /// associated with your Amazon Web Services account.
    ///
    /// The dedicated IP pool you specify must already exist. You can create a new
    /// pool by
    /// using the `CreateDedicatedIpPool` operation.
    pub fn putDedicatedIpInPool(self: *Self, allocator: std.mem.Allocator, input: put_dedicated_ip_in_pool.PutDedicatedIpInPoolInput, options: put_dedicated_ip_in_pool.Options) !put_dedicated_ip_in_pool.PutDedicatedIpInPoolOutput {
        return put_dedicated_ip_in_pool.execute(self, allocator, input, options);
    }

    /// Used to convert a dedicated IP pool to a different scaling mode.
    ///
    /// `MANAGED` pools cannot be converted to `STANDARD` scaling mode.
    pub fn putDedicatedIpPoolScalingAttributes(self: *Self, allocator: std.mem.Allocator, input: put_dedicated_ip_pool_scaling_attributes.PutDedicatedIpPoolScalingAttributesInput, options: put_dedicated_ip_pool_scaling_attributes.Options) !put_dedicated_ip_pool_scaling_attributes.PutDedicatedIpPoolScalingAttributesOutput {
        return put_dedicated_ip_pool_scaling_attributes.execute(self, allocator, input, options);
    }

    pub fn putDedicatedIpWarmupAttributes(self: *Self, allocator: std.mem.Allocator, input: put_dedicated_ip_warmup_attributes.PutDedicatedIpWarmupAttributesInput, options: put_dedicated_ip_warmup_attributes.Options) !put_dedicated_ip_warmup_attributes.PutDedicatedIpWarmupAttributesOutput {
        return put_dedicated_ip_warmup_attributes.execute(self, allocator, input, options);
    }

    /// Enable or disable the Deliverability dashboard. When you enable the
    /// Deliverability dashboard, you gain
    /// access to reputation, deliverability, and other metrics for the domains that
    /// you use to
    /// send email. You also gain the ability to perform predictive inbox placement
    /// tests.
    ///
    /// When you use the Deliverability dashboard, you pay a monthly subscription
    /// charge, in addition
    /// to any other fees that you accrue by using Amazon SES and other Amazon Web
    /// Services services. For more
    /// information about the features and cost of a Deliverability dashboard
    /// subscription, see [Amazon SES Pricing](http://aws.amazon.com/ses/pricing/).
    pub fn putDeliverabilityDashboardOption(self: *Self, allocator: std.mem.Allocator, input: put_deliverability_dashboard_option.PutDeliverabilityDashboardOptionInput, options: put_deliverability_dashboard_option.Options) !put_deliverability_dashboard_option.PutDeliverabilityDashboardOptionOutput {
        return put_deliverability_dashboard_option.execute(self, allocator, input, options);
    }

    /// Used to associate a configuration set with an email identity.
    pub fn putEmailIdentityConfigurationSetAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_configuration_set_attributes.PutEmailIdentityConfigurationSetAttributesInput, options: put_email_identity_configuration_set_attributes.Options) !put_email_identity_configuration_set_attributes.PutEmailIdentityConfigurationSetAttributesOutput {
        return put_email_identity_configuration_set_attributes.execute(self, allocator, input, options);
    }

    /// Used to enable or disable DKIM authentication for an email identity.
    pub fn putEmailIdentityDkimAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_dkim_attributes.PutEmailIdentityDkimAttributesInput, options: put_email_identity_dkim_attributes.Options) !put_email_identity_dkim_attributes.PutEmailIdentityDkimAttributesOutput {
        return put_email_identity_dkim_attributes.execute(self, allocator, input, options);
    }

    /// Used to configure or change the DKIM authentication settings for an email
    /// domain
    /// identity. You can use this operation to do any of the following:
    ///
    /// * Update the signing attributes for an identity that uses Bring Your Own
    ///   DKIM
    /// (BYODKIM).
    ///
    /// * Update the key length that should be used for Easy DKIM.
    ///
    /// * Change from using no DKIM authentication to using Easy DKIM.
    ///
    /// * Change from using no DKIM authentication to using BYODKIM.
    ///
    /// * Change from using Easy DKIM to using BYODKIM.
    ///
    /// * Change from using BYODKIM to using Easy DKIM.
    pub fn putEmailIdentityDkimSigningAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_dkim_signing_attributes.PutEmailIdentityDkimSigningAttributesInput, options: put_email_identity_dkim_signing_attributes.Options) !put_email_identity_dkim_signing_attributes.PutEmailIdentityDkimSigningAttributesOutput {
        return put_email_identity_dkim_signing_attributes.execute(self, allocator, input, options);
    }

    /// Used to enable or disable feedback forwarding for an identity. This setting
    /// determines
    /// what happens when an identity is used to send an email that results in a
    /// bounce or
    /// complaint event.
    ///
    /// If the value is `true`, you receive email notifications when bounce or
    /// complaint events occur. These notifications are sent to the address that you
    /// specified
    /// in the `Return-Path` header of the original email.
    ///
    /// You're required to have a method of tracking bounces and complaints. If you
    /// haven't
    /// set up another mechanism for receiving bounce or complaint notifications
    /// (for example,
    /// by setting up an event destination), you receive an email notification when
    /// these events
    /// occur (even if this setting is disabled).
    pub fn putEmailIdentityFeedbackAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_feedback_attributes.PutEmailIdentityFeedbackAttributesInput, options: put_email_identity_feedback_attributes.Options) !put_email_identity_feedback_attributes.PutEmailIdentityFeedbackAttributesOutput {
        return put_email_identity_feedback_attributes.execute(self, allocator, input, options);
    }

    /// Used to enable or disable the custom Mail-From domain configuration for an
    /// email
    /// identity.
    pub fn putEmailIdentityMailFromAttributes(self: *Self, allocator: std.mem.Allocator, input: put_email_identity_mail_from_attributes.PutEmailIdentityMailFromAttributesInput, options: put_email_identity_mail_from_attributes.Options) !put_email_identity_mail_from_attributes.PutEmailIdentityMailFromAttributesOutput {
        return put_email_identity_mail_from_attributes.execute(self, allocator, input, options);
    }

    /// Adds an email address to the suppression list for your account.
    pub fn putSuppressedDestination(self: *Self, allocator: std.mem.Allocator, input: put_suppressed_destination.PutSuppressedDestinationInput, options: put_suppressed_destination.Options) !put_suppressed_destination.PutSuppressedDestinationOutput {
        return put_suppressed_destination.execute(self, allocator, input, options);
    }

    /// Composes an email message to multiple destinations.
    pub fn sendBulkEmail(self: *Self, allocator: std.mem.Allocator, input: send_bulk_email.SendBulkEmailInput, options: send_bulk_email.Options) !send_bulk_email.SendBulkEmailOutput {
        return send_bulk_email.execute(self, allocator, input, options);
    }

    /// Adds an email address to the list of identities for your Amazon SES account
    /// in the current
    /// Amazon Web Services Region and attempts to verify it. As a result of
    /// executing this
    /// operation, a customized verification email is sent to the specified address.
    ///
    /// To use this operation, you must first create a custom verification email
    /// template. For
    /// more information about creating and using custom verification email
    /// templates, see
    /// [Using
    /// custom verification email
    /// templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn sendCustomVerificationEmail(self: *Self, allocator: std.mem.Allocator, input: send_custom_verification_email.SendCustomVerificationEmailInput, options: send_custom_verification_email.Options) !send_custom_verification_email.SendCustomVerificationEmailOutput {
        return send_custom_verification_email.execute(self, allocator, input, options);
    }

    /// Sends an email message. You can use the Amazon SES API v2 to send the
    /// following types of
    /// messages:
    ///
    /// * **Simple** – A standard email message. When
    /// you create this type of message, you specify the sender, the recipient, and
    /// the
    /// message body, and Amazon SES assembles the message for you.
    ///
    /// * **Raw** – A raw, MIME-formatted email
    /// message. When you send this type of email, you have to specify all of the
    /// message headers, as well as the message body. You can use this message type
    /// to
    /// send messages that contain attachments. The message that you specify has to
    /// be a
    /// valid MIME message.
    ///
    /// * **Templated** – A message that contains
    /// personalization tags. When you send this type of email, Amazon SES API v2
    /// automatically
    /// replaces the tags with values that you specify.
    pub fn sendEmail(self: *Self, allocator: std.mem.Allocator, input: send_email.SendEmailInput, options: send_email.Options) !send_email.SendEmailOutput {
        return send_email.execute(self, allocator, input, options);
    }

    /// Add one or more tags (keys and values) to a specified resource. A
    /// *tag* is a label that you optionally define and associate with a
    /// resource. Tags can help you categorize and manage resources in different
    /// ways, such as
    /// by purpose, owner, environment, or other criteria. A resource can have as
    /// many as 50
    /// tags.
    ///
    /// Each tag consists of a required *tag key* and an
    /// associated *tag value*, both of which you define. A tag key is a
    /// general label that acts as a category for more specific tag values. A tag
    /// value acts as
    /// a descriptor within a tag key.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Creates a preview of the MIME content of an email when provided with a
    /// template and a
    /// set of replacement data.
    ///
    /// You can execute this operation no more than once per second.
    pub fn testRenderEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: test_render_email_template.TestRenderEmailTemplateInput, options: test_render_email_template.Options) !test_render_email_template.TestRenderEmailTemplateOutput {
        return test_render_email_template.execute(self, allocator, input, options);
    }

    /// Remove one or more tags (keys and values) from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update the configuration of an event destination for a configuration set.
    ///
    /// *Events* include message sends, deliveries, opens, clicks, bounces,
    /// and complaints. *Event destinations* are places that you can send
    /// information about these events to. For example, you can send event data to
    /// Amazon EventBridge and
    /// associate a rule to send the event to the specified target.
    pub fn updateConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationInput, options: update_configuration_set_event_destination.Options) !update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationOutput {
        return update_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Updates a contact's preferences for a list.
    ///
    /// You must specify all existing topic preferences in the
    /// `TopicPreferences` object, not just the ones that need updating;
    /// otherwise, all your existing preferences will be removed.
    pub fn updateContact(self: *Self, allocator: std.mem.Allocator, input: update_contact.UpdateContactInput, options: update_contact.Options) !update_contact.UpdateContactOutput {
        return update_contact.execute(self, allocator, input, options);
    }

    /// Updates contact list metadata. This operation does a complete replacement.
    pub fn updateContactList(self: *Self, allocator: std.mem.Allocator, input: update_contact_list.UpdateContactListInput, options: update_contact_list.Options) !update_contact_list.UpdateContactListOutput {
        return update_contact_list.execute(self, allocator, input, options);
    }

    /// Updates an existing custom verification email template.
    ///
    /// For more information about custom verification email templates, see [Using
    /// custom verification email
    /// templates](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES Developer
    /// Guide*.
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateCustomVerificationEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: update_custom_verification_email_template.UpdateCustomVerificationEmailTemplateInput, options: update_custom_verification_email_template.Options) !update_custom_verification_email_template.UpdateCustomVerificationEmailTemplateOutput {
        return update_custom_verification_email_template.execute(self, allocator, input, options);
    }

    /// Updates the specified sending authorization policy for the given identity
    /// (an email
    /// address or a domain). This API returns successfully even if a policy with
    /// the specified
    /// name does not exist.
    ///
    /// This API is for the identity owner only. If you have not verified the
    /// identity,
    /// this API will return an error.
    ///
    /// Sending authorization is a feature that enables an identity owner to
    /// authorize other
    /// senders to use its identities. For information about using sending
    /// authorization, see
    /// the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/sending-authorization.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateEmailIdentityPolicy(self: *Self, allocator: std.mem.Allocator, input: update_email_identity_policy.UpdateEmailIdentityPolicyInput, options: update_email_identity_policy.Options) !update_email_identity_policy.UpdateEmailIdentityPolicyOutput {
        return update_email_identity_policy.execute(self, allocator, input, options);
    }

    /// Updates an email template. Email templates enable you to send personalized
    /// email to
    /// one or more destinations in a single API operation. For more information,
    /// see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-personalized-email-api.html).
    ///
    /// You can execute this operation no more than once per second.
    pub fn updateEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: update_email_template.UpdateEmailTemplateInput, options: update_email_template.Options) !update_email_template.UpdateEmailTemplateOutput {
        return update_email_template.execute(self, allocator, input, options);
    }

    /// Update the customer-managed sending status for a reputation entity. This
    /// allows
    /// you to enable, disable, or reinstate sending for the entity.
    ///
    /// The customer-managed status works in conjunction with the Amazon Web
    /// Services Amazon SES-managed status
    /// to determine the overall sending capability. When you update the
    /// customer-managed status,
    /// the Amazon Web Services Amazon SES-managed status remains unchanged. If
    /// Amazon Web Services Amazon SES has disabled the entity,
    /// it will not be allowed to send regardless of the customer-managed status
    /// setting. When you
    /// reinstate an entity through the customer-managed status, it can continue
    /// sending only if
    /// the Amazon Web Services Amazon SES-managed status also permits sending, even
    /// if there are active reputation
    /// findings, until the findings are resolved or new violations occur.
    pub fn updateReputationEntityCustomerManagedStatus(self: *Self, allocator: std.mem.Allocator, input: update_reputation_entity_customer_managed_status.UpdateReputationEntityCustomerManagedStatusInput, options: update_reputation_entity_customer_managed_status.Options) !update_reputation_entity_customer_managed_status.UpdateReputationEntityCustomerManagedStatusOutput {
        return update_reputation_entity_customer_managed_status.execute(self, allocator, input, options);
    }

    /// Update the reputation management policy for a reputation entity. The policy
    /// determines how the entity responds to reputation findings, such as
    /// automatically
    /// pausing sending when certain thresholds are exceeded.
    ///
    /// Reputation management policies are Amazon Web Services Amazon SES-managed
    /// (predefined policies).
    /// You can select from none, standard, and strict policies.
    pub fn updateReputationEntityPolicy(self: *Self, allocator: std.mem.Allocator, input: update_reputation_entity_policy.UpdateReputationEntityPolicyInput, options: update_reputation_entity_policy.Options) !update_reputation_entity_policy.UpdateReputationEntityPolicyOutput {
        return update_reputation_entity_policy.execute(self, allocator, input, options);
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

    pub fn listContactListsPaginator(self: *Self, params: list_contact_lists.ListContactListsInput) paginator.ListContactListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactsPaginator(self: *Self, params: list_contacts.ListContactsInput) paginator.ListContactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomVerificationEmailTemplatesPaginator(self: *Self, params: list_custom_verification_email_templates.ListCustomVerificationEmailTemplatesInput) paginator.ListCustomVerificationEmailTemplatesPaginator {
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

    pub fn listEmailTemplatesPaginator(self: *Self, params: list_email_templates.ListEmailTemplatesInput) paginator.ListEmailTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExportJobsPaginator(self: *Self, params: list_export_jobs.ListExportJobsInput) paginator.ListExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImportJobsPaginator(self: *Self, params: list_import_jobs.ListImportJobsInput) paginator.ListImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMultiRegionEndpointsPaginator(self: *Self, params: list_multi_region_endpoints.ListMultiRegionEndpointsInput) paginator.ListMultiRegionEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationsPaginator(self: *Self, params: list_recommendations.ListRecommendationsInput) paginator.ListRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReputationEntitiesPaginator(self: *Self, params: list_reputation_entities.ListReputationEntitiesInput) paginator.ListReputationEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceTenantsPaginator(self: *Self, params: list_resource_tenants.ListResourceTenantsInput) paginator.ListResourceTenantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSuppressedDestinationsPaginator(self: *Self, params: list_suppressed_destinations.ListSuppressedDestinationsInput) paginator.ListSuppressedDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTenantResourcesPaginator(self: *Self, params: list_tenant_resources.ListTenantResourcesInput) paginator.ListTenantResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTenantsPaginator(self: *Self, params: list_tenants.ListTenantsInput) paginator.ListTenantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
