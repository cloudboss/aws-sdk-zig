const aws = @import("aws");
const std = @import("std");

const associate_origination_identity = @import("associate_origination_identity.zig");
const associate_protect_configuration = @import("associate_protect_configuration.zig");
const carrier_lookup = @import("carrier_lookup.zig");
const create_configuration_set = @import("create_configuration_set.zig");
const create_event_destination = @import("create_event_destination.zig");
const create_opt_out_list = @import("create_opt_out_list.zig");
const create_pool = @import("create_pool.zig");
const create_protect_configuration = @import("create_protect_configuration.zig");
const create_registration = @import("create_registration.zig");
const create_registration_association = @import("create_registration_association.zig");
const create_registration_attachment = @import("create_registration_attachment.zig");
const create_registration_version = @import("create_registration_version.zig");
const create_verified_destination_number = @import("create_verified_destination_number.zig");
const delete_account_default_protect_configuration = @import("delete_account_default_protect_configuration.zig");
const delete_configuration_set = @import("delete_configuration_set.zig");
const delete_default_message_type = @import("delete_default_message_type.zig");
const delete_default_sender_id = @import("delete_default_sender_id.zig");
const delete_event_destination = @import("delete_event_destination.zig");
const delete_keyword = @import("delete_keyword.zig");
const delete_media_message_spend_limit_override = @import("delete_media_message_spend_limit_override.zig");
const delete_opt_out_list = @import("delete_opt_out_list.zig");
const delete_opted_out_number = @import("delete_opted_out_number.zig");
const delete_pool = @import("delete_pool.zig");
const delete_protect_configuration = @import("delete_protect_configuration.zig");
const delete_protect_configuration_rule_set_number_override = @import("delete_protect_configuration_rule_set_number_override.zig");
const delete_registration = @import("delete_registration.zig");
const delete_registration_attachment = @import("delete_registration_attachment.zig");
const delete_registration_field_value = @import("delete_registration_field_value.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_text_message_spend_limit_override = @import("delete_text_message_spend_limit_override.zig");
const delete_verified_destination_number = @import("delete_verified_destination_number.zig");
const delete_voice_message_spend_limit_override = @import("delete_voice_message_spend_limit_override.zig");
const describe_account_attributes = @import("describe_account_attributes.zig");
const describe_account_limits = @import("describe_account_limits.zig");
const describe_configuration_sets = @import("describe_configuration_sets.zig");
const describe_keywords = @import("describe_keywords.zig");
const describe_opt_out_lists = @import("describe_opt_out_lists.zig");
const describe_opted_out_numbers = @import("describe_opted_out_numbers.zig");
const describe_phone_numbers = @import("describe_phone_numbers.zig");
const describe_pools = @import("describe_pools.zig");
const describe_protect_configurations = @import("describe_protect_configurations.zig");
const describe_registration_attachments = @import("describe_registration_attachments.zig");
const describe_registration_field_definitions = @import("describe_registration_field_definitions.zig");
const describe_registration_field_values = @import("describe_registration_field_values.zig");
const describe_registration_section_definitions = @import("describe_registration_section_definitions.zig");
const describe_registration_type_definitions = @import("describe_registration_type_definitions.zig");
const describe_registration_versions = @import("describe_registration_versions.zig");
const describe_registrations = @import("describe_registrations.zig");
const describe_sender_ids = @import("describe_sender_ids.zig");
const describe_spend_limits = @import("describe_spend_limits.zig");
const describe_verified_destination_numbers = @import("describe_verified_destination_numbers.zig");
const disassociate_origination_identity = @import("disassociate_origination_identity.zig");
const disassociate_protect_configuration = @import("disassociate_protect_configuration.zig");
const discard_registration_version = @import("discard_registration_version.zig");
const get_protect_configuration_country_rule_set = @import("get_protect_configuration_country_rule_set.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_pool_origination_identities = @import("list_pool_origination_identities.zig");
const list_protect_configuration_rule_set_number_overrides = @import("list_protect_configuration_rule_set_number_overrides.zig");
const list_registration_associations = @import("list_registration_associations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_keyword = @import("put_keyword.zig");
const put_message_feedback = @import("put_message_feedback.zig");
const put_opted_out_number = @import("put_opted_out_number.zig");
const put_protect_configuration_rule_set_number_override = @import("put_protect_configuration_rule_set_number_override.zig");
const put_registration_field_value = @import("put_registration_field_value.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const release_phone_number = @import("release_phone_number.zig");
const release_sender_id = @import("release_sender_id.zig");
const request_phone_number = @import("request_phone_number.zig");
const request_sender_id = @import("request_sender_id.zig");
const send_destination_number_verification_code = @import("send_destination_number_verification_code.zig");
const send_media_message = @import("send_media_message.zig");
const send_text_message = @import("send_text_message.zig");
const send_voice_message = @import("send_voice_message.zig");
const set_account_default_protect_configuration = @import("set_account_default_protect_configuration.zig");
const set_default_message_feedback_enabled = @import("set_default_message_feedback_enabled.zig");
const set_default_message_type = @import("set_default_message_type.zig");
const set_default_sender_id = @import("set_default_sender_id.zig");
const set_media_message_spend_limit_override = @import("set_media_message_spend_limit_override.zig");
const set_text_message_spend_limit_override = @import("set_text_message_spend_limit_override.zig");
const set_voice_message_spend_limit_override = @import("set_voice_message_spend_limit_override.zig");
const submit_registration_version = @import("submit_registration_version.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_event_destination = @import("update_event_destination.zig");
const update_phone_number = @import("update_phone_number.zig");
const update_pool = @import("update_pool.zig");
const update_protect_configuration = @import("update_protect_configuration.zig");
const update_protect_configuration_country_rule_set = @import("update_protect_configuration_country_rule_set.zig");
const update_sender_id = @import("update_sender_id.zig");
const verify_destination_number = @import("verify_destination_number.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pinpoint SMS Voice V2";

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

    /// Associates the specified origination identity with a pool.
    ///
    /// If the origination identity is a phone number and is already associated with
    /// another pool, an error is returned. A sender ID can be associated with
    /// multiple pools.
    ///
    /// If the origination identity configuration doesn't match the pool's
    /// configuration, an error is returned.
    pub fn associateOriginationIdentity(self: *Self, allocator: std.mem.Allocator, input: associate_origination_identity.AssociateOriginationIdentityInput, options: CallOptions) !associate_origination_identity.AssociateOriginationIdentityOutput {
        return associate_origination_identity.execute(self, allocator, input, options);
    }

    /// Associate a protect configuration with a configuration set. This replaces
    /// the configuration sets current protect configuration. A configuration set
    /// can only be associated with one protect configuration at a time. A protect
    /// configuration can be associated with multiple configuration sets.
    pub fn associateProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: associate_protect_configuration.AssociateProtectConfigurationInput, options: CallOptions) !associate_protect_configuration.AssociateProtectConfigurationOutput {
        return associate_protect_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about a destination phone number, including whether the
    /// number type and whether it is valid, the carrier, and more.
    pub fn carrierLookup(self: *Self, allocator: std.mem.Allocator, input: carrier_lookup.CarrierLookupInput, options: CallOptions) !carrier_lookup.CarrierLookupOutput {
        return carrier_lookup.execute(self, allocator, input, options);
    }

    /// Creates a new configuration set. After you create the configuration set, you
    /// can add one or more event destinations to it.
    ///
    /// A configuration set is a set of rules that you apply to the SMS and voice
    /// messages that you send.
    ///
    /// When you send a message, you can optionally specify a single configuration
    /// set.
    pub fn createConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set.CreateConfigurationSetInput, options: CallOptions) !create_configuration_set.CreateConfigurationSetOutput {
        return create_configuration_set.execute(self, allocator, input, options);
    }

    /// Creates a new event destination in a configuration set.
    ///
    /// An event destination is a location where you send message events. The event
    /// options are Amazon CloudWatch, Amazon Data Firehose, or Amazon SNS. For
    /// example, when a message is delivered successfully, you can send information
    /// about that event to an event destination, or send notifications to endpoints
    /// that are subscribed to an Amazon SNS topic.
    ///
    /// You can only create one event destination at a time. You must provide a
    /// value for a single event destination using either
    /// `CloudWatchLogsDestination`, `KinesisFirehoseDestination` or
    /// `SnsDestination`. If an event destination isn't provided then an exception
    /// is returned.
    ///
    /// Each configuration set can contain between 0 and 5 event destinations. Each
    /// event destination can contain a reference to a single destination, such as a
    /// CloudWatch or Firehose destination.
    pub fn createEventDestination(self: *Self, allocator: std.mem.Allocator, input: create_event_destination.CreateEventDestinationInput, options: CallOptions) !create_event_destination.CreateEventDestinationOutput {
        return create_event_destination.execute(self, allocator, input, options);
    }

    /// Creates a new opt-out list.
    ///
    /// If the opt-out list name already exists, an error is returned.
    ///
    /// An opt-out list is a list of phone numbers that are opted out, meaning you
    /// can't send SMS or voice messages to them. If end user replies with the
    /// keyword "STOP," an entry for the phone number is added to the opt-out list.
    /// In addition to STOP, your recipients can use any supported opt-out keyword,
    /// such as CANCEL or OPTOUT. For a list of supported opt-out keywords, see [
    /// SMS opt out
    /// ](https://docs.aws.amazon.com/pinpoint/latest/userguide/channels-sms-manage.html#channels-sms-manage-optout) in the End User Messaging SMS User Guide.
    pub fn createOptOutList(self: *Self, allocator: std.mem.Allocator, input: create_opt_out_list.CreateOptOutListInput, options: CallOptions) !create_opt_out_list.CreateOptOutListOutput {
        return create_opt_out_list.execute(self, allocator, input, options);
    }

    /// Creates a new pool and associates the specified origination identity to the
    /// pool. A pool can include one or more phone numbers and SenderIds that are
    /// associated with your Amazon Web Services account.
    ///
    /// The new pool inherits its configuration from the specified origination
    /// identity. This includes keywords, message type, opt-out list, two-way
    /// configuration, and self-managed opt-out configuration. Deletion protection
    /// isn't inherited from the origination identity and defaults to false.
    ///
    /// If the origination identity is a phone number and is already associated with
    /// another pool, an error is returned. A sender ID can be associated with
    /// multiple pools.
    pub fn createPool(self: *Self, allocator: std.mem.Allocator, input: create_pool.CreatePoolInput, options: CallOptions) !create_pool.CreatePoolOutput {
        return create_pool.execute(self, allocator, input, options);
    }

    /// Create a new protect configuration. By default all country rule sets for
    /// each capability are set to `ALLOW`. Update the country rule sets using
    /// `UpdateProtectConfigurationCountryRuleSet`. A protect configurations name is
    /// stored as a Tag with the key set to `Name` and value as the name of the
    /// protect configuration.
    pub fn createProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_protect_configuration.CreateProtectConfigurationInput, options: CallOptions) !create_protect_configuration.CreateProtectConfigurationOutput {
        return create_protect_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new registration based on the **RegistrationType** field.
    pub fn createRegistration(self: *Self, allocator: std.mem.Allocator, input: create_registration.CreateRegistrationInput, options: CallOptions) !create_registration.CreateRegistrationOutput {
        return create_registration.execute(self, allocator, input, options);
    }

    /// Associate the registration with an origination identity such as a phone
    /// number or sender ID.
    pub fn createRegistrationAssociation(self: *Self, allocator: std.mem.Allocator, input: create_registration_association.CreateRegistrationAssociationInput, options: CallOptions) !create_registration_association.CreateRegistrationAssociationOutput {
        return create_registration_association.execute(self, allocator, input, options);
    }

    /// Create a new registration attachment to use for uploading a file or a URL to
    /// a file. The maximum file size is 500KB and valid file extensions are PDF,
    /// JPEG and PNG. For example, many sender ID registrations require a signed
    /// “letter of authorization” (LOA) to be submitted.
    ///
    /// Use either `AttachmentUrl` or `AttachmentBody` to upload your attachment. If
    /// both are specified then an exception is returned.
    pub fn createRegistrationAttachment(self: *Self, allocator: std.mem.Allocator, input: create_registration_attachment.CreateRegistrationAttachmentInput, options: CallOptions) !create_registration_attachment.CreateRegistrationAttachmentOutput {
        return create_registration_attachment.execute(self, allocator, input, options);
    }

    /// Create a new version of the registration and increase the **VersionNumber**.
    /// The previous version of the registration becomes read-only.
    pub fn createRegistrationVersion(self: *Self, allocator: std.mem.Allocator, input: create_registration_version.CreateRegistrationVersionInput, options: CallOptions) !create_registration_version.CreateRegistrationVersionOutput {
        return create_registration_version.execute(self, allocator, input, options);
    }

    /// You can only send messages to verified destination numbers when your account
    /// is in the sandbox. You can add up to 10 verified destination numbers.
    pub fn createVerifiedDestinationNumber(self: *Self, allocator: std.mem.Allocator, input: create_verified_destination_number.CreateVerifiedDestinationNumberInput, options: CallOptions) !create_verified_destination_number.CreateVerifiedDestinationNumberOutput {
        return create_verified_destination_number.execute(self, allocator, input, options);
    }

    /// Removes the current account default protect configuration.
    pub fn deleteAccountDefaultProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_account_default_protect_configuration.DeleteAccountDefaultProtectConfigurationInput, options: CallOptions) !delete_account_default_protect_configuration.DeleteAccountDefaultProtectConfigurationOutput {
        return delete_account_default_protect_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an existing configuration set.
    ///
    /// A configuration set is a set of rules that you apply to voice and SMS
    /// messages that you send. In a configuration set, you can specify a
    /// destination for specific types of events related to voice and SMS messages.
    pub fn deleteConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set.DeleteConfigurationSetInput, options: CallOptions) !delete_configuration_set.DeleteConfigurationSetOutput {
        return delete_configuration_set.execute(self, allocator, input, options);
    }

    /// Deletes an existing default message type on a configuration set.
    ///
    /// A message type is a type of messages that you plan to send. If you send
    /// account-related messages or time-sensitive messages such as one-time
    /// passcodes, choose **Transactional**. If you plan to send messages that
    /// contain marketing material or other promotional content, choose
    /// **Promotional**. This setting applies to your entire Amazon Web Services
    /// account.
    pub fn deleteDefaultMessageType(self: *Self, allocator: std.mem.Allocator, input: delete_default_message_type.DeleteDefaultMessageTypeInput, options: CallOptions) !delete_default_message_type.DeleteDefaultMessageTypeOutput {
        return delete_default_message_type.execute(self, allocator, input, options);
    }

    /// Deletes an existing default sender ID on a configuration set.
    ///
    /// A default sender ID is the identity that appears on recipients' devices when
    /// they receive SMS messages. Support for sender ID capabilities varies by
    /// country or region.
    pub fn deleteDefaultSenderId(self: *Self, allocator: std.mem.Allocator, input: delete_default_sender_id.DeleteDefaultSenderIdInput, options: CallOptions) !delete_default_sender_id.DeleteDefaultSenderIdOutput {
        return delete_default_sender_id.execute(self, allocator, input, options);
    }

    /// Deletes an existing event destination.
    ///
    /// An event destination is a location where you send response information about
    /// the messages that you send. For example, when a message is delivered
    /// successfully, you can send information about that event to an Amazon
    /// CloudWatch destination, or send notifications to endpoints that are
    /// subscribed to an Amazon SNS topic.
    pub fn deleteEventDestination(self: *Self, allocator: std.mem.Allocator, input: delete_event_destination.DeleteEventDestinationInput, options: CallOptions) !delete_event_destination.DeleteEventDestinationOutput {
        return delete_event_destination.execute(self, allocator, input, options);
    }

    /// Deletes an existing keyword from an origination phone number or pool.
    ///
    /// A keyword is a word that you can search for on a particular phone number or
    /// pool. It is also a specific word or phrase that an end user can send to your
    /// number to elicit a response, such as an informational message or a special
    /// offer. When your number receives a message that begins with a keyword, End
    /// User Messaging SMS responds with a customizable message.
    ///
    /// Keywords "HELP" and "STOP" can't be deleted or modified.
    pub fn deleteKeyword(self: *Self, allocator: std.mem.Allocator, input: delete_keyword.DeleteKeywordInput, options: CallOptions) !delete_keyword.DeleteKeywordOutput {
        return delete_keyword.execute(self, allocator, input, options);
    }

    /// Deletes an account-level monthly spending limit override for sending
    /// multimedia messages (MMS). Deleting a spend limit override will set the
    /// `EnforcedLimit` to equal the `MaxLimit`, which is controlled by Amazon Web
    /// Services. For more information on spend limits (quotas) see [Quotas for
    /// Server Migration
    /// Service](https://docs.aws.amazon.com/sms-voice/latest/userguide/quotas.html)
    /// in the *Server Migration Service User Guide*.
    pub fn deleteMediaMessageSpendLimitOverride(self: *Self, allocator: std.mem.Allocator, input: delete_media_message_spend_limit_override.DeleteMediaMessageSpendLimitOverrideInput, options: CallOptions) !delete_media_message_spend_limit_override.DeleteMediaMessageSpendLimitOverrideOutput {
        return delete_media_message_spend_limit_override.execute(self, allocator, input, options);
    }

    /// Deletes an existing opt-out list. All opted out phone numbers in the opt-out
    /// list are deleted.
    ///
    /// If the specified opt-out list name doesn't exist or is in-use by an
    /// origination phone number or pool, an error is returned.
    pub fn deleteOptOutList(self: *Self, allocator: std.mem.Allocator, input: delete_opt_out_list.DeleteOptOutListInput, options: CallOptions) !delete_opt_out_list.DeleteOptOutListOutput {
        return delete_opt_out_list.execute(self, allocator, input, options);
    }

    /// Deletes an existing opted out destination phone number from the specified
    /// opt-out list.
    ///
    /// Each destination phone number can only be deleted once every 30 days.
    ///
    /// If the specified destination phone number doesn't exist or if the opt-out
    /// list doesn't exist, an error is returned.
    pub fn deleteOptedOutNumber(self: *Self, allocator: std.mem.Allocator, input: delete_opted_out_number.DeleteOptedOutNumberInput, options: CallOptions) !delete_opted_out_number.DeleteOptedOutNumberOutput {
        return delete_opted_out_number.execute(self, allocator, input, options);
    }

    /// Deletes an existing pool. Deleting a pool disassociates all origination
    /// identities from that pool.
    ///
    /// If the pool status isn't active or if deletion protection is enabled, an
    /// error is returned.
    ///
    /// A pool is a collection of phone numbers and SenderIds. A pool can include
    /// one or more phone numbers and SenderIds that are associated with your Amazon
    /// Web Services account.
    pub fn deletePool(self: *Self, allocator: std.mem.Allocator, input: delete_pool.DeletePoolInput, options: CallOptions) !delete_pool.DeletePoolOutput {
        return delete_pool.execute(self, allocator, input, options);
    }

    /// Permanently delete the protect configuration. The protect configuration must
    /// have deletion protection disabled and must not be associated as the account
    /// default protect configuration or associated with a configuration set.
    pub fn deleteProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_protect_configuration.DeleteProtectConfigurationInput, options: CallOptions) !delete_protect_configuration.DeleteProtectConfigurationOutput {
        return delete_protect_configuration.execute(self, allocator, input, options);
    }

    /// Permanently delete the protect configuration rule set number override.
    pub fn deleteProtectConfigurationRuleSetNumberOverride(self: *Self, allocator: std.mem.Allocator, input: delete_protect_configuration_rule_set_number_override.DeleteProtectConfigurationRuleSetNumberOverrideInput, options: CallOptions) !delete_protect_configuration_rule_set_number_override.DeleteProtectConfigurationRuleSetNumberOverrideOutput {
        return delete_protect_configuration_rule_set_number_override.execute(self, allocator, input, options);
    }

    /// Permanently delete an existing registration from your account.
    pub fn deleteRegistration(self: *Self, allocator: std.mem.Allocator, input: delete_registration.DeleteRegistrationInput, options: CallOptions) !delete_registration.DeleteRegistrationOutput {
        return delete_registration.execute(self, allocator, input, options);
    }

    /// Permanently delete the specified registration attachment.
    pub fn deleteRegistrationAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_registration_attachment.DeleteRegistrationAttachmentInput, options: CallOptions) !delete_registration_attachment.DeleteRegistrationAttachmentOutput {
        return delete_registration_attachment.execute(self, allocator, input, options);
    }

    /// Delete the value in a registration form field.
    pub fn deleteRegistrationFieldValue(self: *Self, allocator: std.mem.Allocator, input: delete_registration_field_value.DeleteRegistrationFieldValueInput, options: CallOptions) !delete_registration_field_value.DeleteRegistrationFieldValueOutput {
        return delete_registration_field_value.execute(self, allocator, input, options);
    }

    /// Deletes the resource-based policy document attached to the End User
    /// Messaging SMS resource. A shared resource can be a Pool, Opt-out list,
    /// Sender Id, or Phone number.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes an account-level monthly spending limit override for sending text
    /// messages. Deleting a spend limit override will set the `EnforcedLimit` to
    /// equal the `MaxLimit`, which is controlled by Amazon Web Services. For more
    /// information on spend limits (quotas) see [Quotas
    /// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/quotas.html) in the
    /// *End User Messaging SMS User Guide*.
    pub fn deleteTextMessageSpendLimitOverride(self: *Self, allocator: std.mem.Allocator, input: delete_text_message_spend_limit_override.DeleteTextMessageSpendLimitOverrideInput, options: CallOptions) !delete_text_message_spend_limit_override.DeleteTextMessageSpendLimitOverrideOutput {
        return delete_text_message_spend_limit_override.execute(self, allocator, input, options);
    }

    /// Delete a verified destination phone number.
    pub fn deleteVerifiedDestinationNumber(self: *Self, allocator: std.mem.Allocator, input: delete_verified_destination_number.DeleteVerifiedDestinationNumberInput, options: CallOptions) !delete_verified_destination_number.DeleteVerifiedDestinationNumberOutput {
        return delete_verified_destination_number.execute(self, allocator, input, options);
    }

    /// Deletes an account level monthly spend limit override for sending voice
    /// messages. Deleting a spend limit override sets the `EnforcedLimit` equal to
    /// the `MaxLimit`, which is controlled by Amazon Web Services. For more
    /// information on spending limits (quotas) see [Quotas
    /// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/quotas.html) in the
    /// *End User Messaging SMS User Guide*.
    pub fn deleteVoiceMessageSpendLimitOverride(self: *Self, allocator: std.mem.Allocator, input: delete_voice_message_spend_limit_override.DeleteVoiceMessageSpendLimitOverrideInput, options: CallOptions) !delete_voice_message_spend_limit_override.DeleteVoiceMessageSpendLimitOverrideOutput {
        return delete_voice_message_spend_limit_override.execute(self, allocator, input, options);
    }

    /// Describes attributes of your Amazon Web Services account. The supported
    /// account attributes include account tier, which indicates whether your
    /// account is in the sandbox or production environment. When you're ready to
    /// move your account out of the sandbox, create an Amazon Web Services Support
    /// case for a service limit increase request.
    ///
    /// New accounts are placed into an SMS or voice sandbox. The sandbox protects
    /// both Amazon Web Services end recipients and SMS or voice recipients from
    /// fraud and abuse.
    pub fn describeAccountAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_account_attributes.DescribeAccountAttributesInput, options: CallOptions) !describe_account_attributes.DescribeAccountAttributesOutput {
        return describe_account_attributes.execute(self, allocator, input, options);
    }

    /// Describes the current End User Messaging SMS SMS Voice V2 resource quotas
    /// for your account. The description for a quota includes the quota name,
    /// current usage toward that quota, and the quota's maximum value.
    ///
    /// When you establish an Amazon Web Services account, the account has initial
    /// quotas on the maximum number of configuration sets, opt-out lists, phone
    /// numbers, and pools that you can create in a given Region. For more
    /// information see [Quotas
    /// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/quotas.html) in the
    /// *End User Messaging SMS User Guide*.
    pub fn describeAccountLimits(self: *Self, allocator: std.mem.Allocator, input: describe_account_limits.DescribeAccountLimitsInput, options: CallOptions) !describe_account_limits.DescribeAccountLimitsOutput {
        return describe_account_limits.execute(self, allocator, input, options);
    }

    /// Describes the specified configuration sets or all in your account.
    ///
    /// If you specify configuration set names, the output includes information for
    /// only the specified configuration sets. If you specify filters, the output
    /// includes information for only those configuration sets that meet the filter
    /// criteria. If you don't specify configuration set names or filters, the
    /// output includes information for all configuration sets.
    ///
    /// If you specify a configuration set name that isn't valid, an error is
    /// returned.
    pub fn describeConfigurationSets(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_sets.DescribeConfigurationSetsInput, options: CallOptions) !describe_configuration_sets.DescribeConfigurationSetsOutput {
        return describe_configuration_sets.execute(self, allocator, input, options);
    }

    /// Describes the specified keywords or all keywords on your origination phone
    /// number or pool.
    ///
    /// A keyword is a word that you can search for on a particular phone number or
    /// pool. It is also a specific word or phrase that an end user can send to your
    /// number to elicit a response, such as an informational message or a special
    /// offer. When your number receives a message that begins with a keyword, End
    /// User Messaging SMS responds with a customizable message.
    ///
    /// If you specify a keyword that isn't valid, an error is returned.
    pub fn describeKeywords(self: *Self, allocator: std.mem.Allocator, input: describe_keywords.DescribeKeywordsInput, options: CallOptions) !describe_keywords.DescribeKeywordsOutput {
        return describe_keywords.execute(self, allocator, input, options);
    }

    /// Describes the specified opt-out list or all opt-out lists in your account.
    ///
    /// If you specify opt-out list names, the output includes information for only
    /// the specified opt-out lists. Opt-out lists include only those that meet the
    /// filter criteria. If you don't specify opt-out list names or filters, the
    /// output includes information for all opt-out lists.
    ///
    /// If you specify an opt-out list name that isn't valid, an error is returned.
    pub fn describeOptOutLists(self: *Self, allocator: std.mem.Allocator, input: describe_opt_out_lists.DescribeOptOutListsInput, options: CallOptions) !describe_opt_out_lists.DescribeOptOutListsOutput {
        return describe_opt_out_lists.execute(self, allocator, input, options);
    }

    /// Describes the specified opted out destination numbers or all opted out
    /// destination numbers in an opt-out list.
    ///
    /// If you specify opted out numbers, the output includes information for only
    /// the specified opted out numbers. If you specify filters, the output includes
    /// information for only those opted out numbers that meet the filter criteria.
    /// If you don't specify opted out numbers or filters, the output includes
    /// information for all opted out destination numbers in your opt-out list.
    ///
    /// If you specify an opted out number that isn't valid, an exception is
    /// returned.
    pub fn describeOptedOutNumbers(self: *Self, allocator: std.mem.Allocator, input: describe_opted_out_numbers.DescribeOptedOutNumbersInput, options: CallOptions) !describe_opted_out_numbers.DescribeOptedOutNumbersOutput {
        return describe_opted_out_numbers.execute(self, allocator, input, options);
    }

    /// Describes the specified origination phone number, or all the phone numbers
    /// in your account.
    ///
    /// If you specify phone number IDs, the output includes information for only
    /// the specified phone numbers. If you specify filters, the output includes
    /// information for only those phone numbers that meet the filter criteria. If
    /// you don't specify phone number IDs or filters, the output includes
    /// information for all phone numbers.
    ///
    /// If you specify a phone number ID that isn't valid, an error is returned.
    pub fn describePhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: describe_phone_numbers.DescribePhoneNumbersInput, options: CallOptions) !describe_phone_numbers.DescribePhoneNumbersOutput {
        return describe_phone_numbers.execute(self, allocator, input, options);
    }

    /// Retrieves the specified pools or all pools associated with your Amazon Web
    /// Services account.
    ///
    /// If you specify pool IDs, the output includes information for only the
    /// specified pools. If you specify filters, the output includes information for
    /// only those pools that meet the filter criteria. If you don't specify pool
    /// IDs or filters, the output includes information for all pools.
    ///
    /// If you specify a pool ID that isn't valid, an error is returned.
    ///
    /// A pool is a collection of phone numbers and SenderIds. A pool can include
    /// one or more phone numbers and SenderIds that are associated with your Amazon
    /// Web Services account.
    pub fn describePools(self: *Self, allocator: std.mem.Allocator, input: describe_pools.DescribePoolsInput, options: CallOptions) !describe_pools.DescribePoolsOutput {
        return describe_pools.execute(self, allocator, input, options);
    }

    /// Retrieves the protect configurations that match any of filters. If a filter
    /// isn’t provided then all protect configurations are returned.
    pub fn describeProtectConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_protect_configurations.DescribeProtectConfigurationsInput, options: CallOptions) !describe_protect_configurations.DescribeProtectConfigurationsOutput {
        return describe_protect_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registration attachments or all registration
    /// attachments associated with your Amazon Web Services account.
    pub fn describeRegistrationAttachments(self: *Self, allocator: std.mem.Allocator, input: describe_registration_attachments.DescribeRegistrationAttachmentsInput, options: CallOptions) !describe_registration_attachments.DescribeRegistrationAttachmentsOutput {
        return describe_registration_attachments.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registration type field definitions. You can use
    /// DescribeRegistrationFieldDefinitions to view the requirements for creating,
    /// filling out, and submitting each registration type.
    pub fn describeRegistrationFieldDefinitions(self: *Self, allocator: std.mem.Allocator, input: describe_registration_field_definitions.DescribeRegistrationFieldDefinitionsInput, options: CallOptions) !describe_registration_field_definitions.DescribeRegistrationFieldDefinitionsOutput {
        return describe_registration_field_definitions.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registration field values.
    pub fn describeRegistrationFieldValues(self: *Self, allocator: std.mem.Allocator, input: describe_registration_field_values.DescribeRegistrationFieldValuesInput, options: CallOptions) !describe_registration_field_values.DescribeRegistrationFieldValuesOutput {
        return describe_registration_field_values.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registration section definitions. You can use
    /// DescribeRegistrationSectionDefinitions to view the requirements for
    /// creating, filling out, and submitting each registration type.
    pub fn describeRegistrationSectionDefinitions(self: *Self, allocator: std.mem.Allocator, input: describe_registration_section_definitions.DescribeRegistrationSectionDefinitionsInput, options: CallOptions) !describe_registration_section_definitions.DescribeRegistrationSectionDefinitionsOutput {
        return describe_registration_section_definitions.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registration type definitions. You can use
    /// DescribeRegistrationTypeDefinitions to view the requirements for creating,
    /// filling out, and submitting each registration type.
    pub fn describeRegistrationTypeDefinitions(self: *Self, allocator: std.mem.Allocator, input: describe_registration_type_definitions.DescribeRegistrationTypeDefinitionsInput, options: CallOptions) !describe_registration_type_definitions.DescribeRegistrationTypeDefinitionsOutput {
        return describe_registration_type_definitions.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registration version.
    pub fn describeRegistrationVersions(self: *Self, allocator: std.mem.Allocator, input: describe_registration_versions.DescribeRegistrationVersionsInput, options: CallOptions) !describe_registration_versions.DescribeRegistrationVersionsOutput {
        return describe_registration_versions.execute(self, allocator, input, options);
    }

    /// Retrieves the specified registrations.
    pub fn describeRegistrations(self: *Self, allocator: std.mem.Allocator, input: describe_registrations.DescribeRegistrationsInput, options: CallOptions) !describe_registrations.DescribeRegistrationsOutput {
        return describe_registrations.execute(self, allocator, input, options);
    }

    /// Describes the specified SenderIds or all SenderIds associated with your
    /// Amazon Web Services account.
    ///
    /// If you specify SenderIds, the output includes information for only the
    /// specified SenderIds. If you specify filters, the output includes information
    /// for only those SenderIds that meet the filter criteria. If you don't specify
    /// SenderIds or filters, the output includes information for all SenderIds.
    ///
    /// f you specify a sender ID that isn't valid, an error is returned.
    pub fn describeSenderIds(self: *Self, allocator: std.mem.Allocator, input: describe_sender_ids.DescribeSenderIdsInput, options: CallOptions) !describe_sender_ids.DescribeSenderIdsOutput {
        return describe_sender_ids.execute(self, allocator, input, options);
    }

    /// Describes the current monthly spend limits for sending voice and text
    /// messages.
    ///
    /// When you establish an Amazon Web Services account, the account has initial
    /// monthly spend limit in a given Region. For more information on increasing
    /// your monthly spend limit, see [ Requesting increases to your monthly SMS,
    /// MMS, or Voice spending quota
    /// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/awssupport-spend-threshold.html) in the *End User Messaging SMS User Guide*.
    pub fn describeSpendLimits(self: *Self, allocator: std.mem.Allocator, input: describe_spend_limits.DescribeSpendLimitsInput, options: CallOptions) !describe_spend_limits.DescribeSpendLimitsOutput {
        return describe_spend_limits.execute(self, allocator, input, options);
    }

    /// Retrieves the specified verified destination numbers.
    pub fn describeVerifiedDestinationNumbers(self: *Self, allocator: std.mem.Allocator, input: describe_verified_destination_numbers.DescribeVerifiedDestinationNumbersInput, options: CallOptions) !describe_verified_destination_numbers.DescribeVerifiedDestinationNumbersOutput {
        return describe_verified_destination_numbers.execute(self, allocator, input, options);
    }

    /// Removes the specified origination identity from an existing pool.
    ///
    /// If the origination identity isn't associated with the specified pool, an
    /// error is returned.
    pub fn disassociateOriginationIdentity(self: *Self, allocator: std.mem.Allocator, input: disassociate_origination_identity.DisassociateOriginationIdentityInput, options: CallOptions) !disassociate_origination_identity.DisassociateOriginationIdentityOutput {
        return disassociate_origination_identity.execute(self, allocator, input, options);
    }

    /// Disassociate a protect configuration from a configuration set.
    pub fn disassociateProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: disassociate_protect_configuration.DisassociateProtectConfigurationInput, options: CallOptions) !disassociate_protect_configuration.DisassociateProtectConfigurationOutput {
        return disassociate_protect_configuration.execute(self, allocator, input, options);
    }

    /// Discard the current version of the registration.
    pub fn discardRegistrationVersion(self: *Self, allocator: std.mem.Allocator, input: discard_registration_version.DiscardRegistrationVersionInput, options: CallOptions) !discard_registration_version.DiscardRegistrationVersionOutput {
        return discard_registration_version.execute(self, allocator, input, options);
    }

    /// Retrieve the CountryRuleSet for the specified NumberCapability from a
    /// protect configuration.
    pub fn getProtectConfigurationCountryRuleSet(self: *Self, allocator: std.mem.Allocator, input: get_protect_configuration_country_rule_set.GetProtectConfigurationCountryRuleSetInput, options: CallOptions) !get_protect_configuration_country_rule_set.GetProtectConfigurationCountryRuleSetOutput {
        return get_protect_configuration_country_rule_set.execute(self, allocator, input, options);
    }

    /// Retrieves the JSON text of the resource-based policy document attached to
    /// the End User Messaging SMS resource. A shared resource can be a Pool,
    /// Opt-out list, Sender Id, or Phone number.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Lists all associated origination identities in your pool.
    ///
    /// If you specify filters, the output includes information for only those
    /// origination identities that meet the filter criteria.
    pub fn listPoolOriginationIdentities(self: *Self, allocator: std.mem.Allocator, input: list_pool_origination_identities.ListPoolOriginationIdentitiesInput, options: CallOptions) !list_pool_origination_identities.ListPoolOriginationIdentitiesOutput {
        return list_pool_origination_identities.execute(self, allocator, input, options);
    }

    /// Retrieve all of the protect configuration rule set number overrides that
    /// match the filters.
    pub fn listProtectConfigurationRuleSetNumberOverrides(self: *Self, allocator: std.mem.Allocator, input: list_protect_configuration_rule_set_number_overrides.ListProtectConfigurationRuleSetNumberOverridesInput, options: CallOptions) !list_protect_configuration_rule_set_number_overrides.ListProtectConfigurationRuleSetNumberOverridesOutput {
        return list_protect_configuration_rule_set_number_overrides.execute(self, allocator, input, options);
    }

    /// Retrieve all of the origination identities that are associated with a
    /// registration.
    pub fn listRegistrationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_registration_associations.ListRegistrationAssociationsInput, options: CallOptions) !list_registration_associations.ListRegistrationAssociationsOutput {
        return list_registration_associations.execute(self, allocator, input, options);
    }

    /// List all tags associated with a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates a keyword configuration on an origination phone number or
    /// pool.
    ///
    /// A keyword is a word that you can search for on a particular phone number or
    /// pool. It is also a specific word or phrase that an end user can send to your
    /// number to elicit a response, such as an informational message or a special
    /// offer. When your number receives a message that begins with a keyword, End
    /// User Messaging SMS responds with a customizable message.
    ///
    /// If you specify a keyword that isn't valid, an error is returned.
    pub fn putKeyword(self: *Self, allocator: std.mem.Allocator, input: put_keyword.PutKeywordInput, options: CallOptions) !put_keyword.PutKeywordOutput {
        return put_keyword.execute(self, allocator, input, options);
    }

    /// Set the MessageFeedbackStatus as `RECEIVED` or `FAILED` for the passed in
    /// MessageId.
    ///
    /// If you use message feedback then you must update message feedback record.
    /// When you receive a signal that a user has received the message you must use
    /// `PutMessageFeedback` to set the message feedback record as `RECEIVED`;
    /// Otherwise, an hour after the message feedback record is set to `FAILED`.
    pub fn putMessageFeedback(self: *Self, allocator: std.mem.Allocator, input: put_message_feedback.PutMessageFeedbackInput, options: CallOptions) !put_message_feedback.PutMessageFeedbackOutput {
        return put_message_feedback.execute(self, allocator, input, options);
    }

    /// Creates an opted out destination phone number in the opt-out list.
    ///
    /// If the destination phone number isn't valid or if the specified opt-out list
    /// doesn't exist, an error is returned.
    pub fn putOptedOutNumber(self: *Self, allocator: std.mem.Allocator, input: put_opted_out_number.PutOptedOutNumberInput, options: CallOptions) !put_opted_out_number.PutOptedOutNumberOutput {
        return put_opted_out_number.execute(self, allocator, input, options);
    }

    /// Create or update a phone number rule override and associate it with a
    /// protect configuration.
    pub fn putProtectConfigurationRuleSetNumberOverride(self: *Self, allocator: std.mem.Allocator, input: put_protect_configuration_rule_set_number_override.PutProtectConfigurationRuleSetNumberOverrideInput, options: CallOptions) !put_protect_configuration_rule_set_number_override.PutProtectConfigurationRuleSetNumberOverrideOutput {
        return put_protect_configuration_rule_set_number_override.execute(self, allocator, input, options);
    }

    /// Creates or updates a field value for a registration.
    pub fn putRegistrationFieldValue(self: *Self, allocator: std.mem.Allocator, input: put_registration_field_value.PutRegistrationFieldValueInput, options: CallOptions) !put_registration_field_value.PutRegistrationFieldValueOutput {
        return put_registration_field_value.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to a End User Messaging SMS resource(phone
    /// number, sender Id, phone poll, or opt-out list) that is used for sharing the
    /// resource. A shared resource can be a Pool, Opt-out list, Sender Id, or Phone
    /// number. For more information about resource-based policies, see [Working
    /// with shared
    /// resources](https://docs.aws.amazon.com/sms-voice/latest/userguide/shared-resources.html) in the *End User Messaging SMS User Guide*.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Releases an existing origination phone number in your account. Once
    /// released, a phone number is no longer available for sending messages.
    ///
    /// If the origination phone number has deletion protection enabled or is
    /// associated with a pool, an error is returned.
    pub fn releasePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: release_phone_number.ReleasePhoneNumberInput, options: CallOptions) !release_phone_number.ReleasePhoneNumberOutput {
        return release_phone_number.execute(self, allocator, input, options);
    }

    /// Releases an existing sender ID in your account.
    pub fn releaseSenderId(self: *Self, allocator: std.mem.Allocator, input: release_sender_id.ReleaseSenderIdInput, options: CallOptions) !release_sender_id.ReleaseSenderIdOutput {
        return release_sender_id.execute(self, allocator, input, options);
    }

    /// Request an origination phone number for use in your account. For more
    /// information on phone number request see [Request a phone
    /// number](https://docs.aws.amazon.com/sms-voice/latest/userguide/phone-numbers-request.html) in the *End User Messaging SMS User Guide*.
    pub fn requestPhoneNumber(self: *Self, allocator: std.mem.Allocator, input: request_phone_number.RequestPhoneNumberInput, options: CallOptions) !request_phone_number.RequestPhoneNumberOutput {
        return request_phone_number.execute(self, allocator, input, options);
    }

    /// Request a new sender ID that doesn't require registration.
    pub fn requestSenderId(self: *Self, allocator: std.mem.Allocator, input: request_sender_id.RequestSenderIdInput, options: CallOptions) !request_sender_id.RequestSenderIdOutput {
        return request_sender_id.execute(self, allocator, input, options);
    }

    /// Before you can send test messages to a verified destination phone number you
    /// need to opt-in the verified destination phone number. Creates a new text
    /// message with a verification code and send it to a verified destination phone
    /// number. Once you have the verification code use VerifyDestinationNumber to
    /// opt-in the verified destination phone number to receive messages.
    pub fn sendDestinationNumberVerificationCode(self: *Self, allocator: std.mem.Allocator, input: send_destination_number_verification_code.SendDestinationNumberVerificationCodeInput, options: CallOptions) !send_destination_number_verification_code.SendDestinationNumberVerificationCodeOutput {
        return send_destination_number_verification_code.execute(self, allocator, input, options);
    }

    /// Creates a new multimedia message (MMS) and sends it to a recipient's phone
    /// number.
    pub fn sendMediaMessage(self: *Self, allocator: std.mem.Allocator, input: send_media_message.SendMediaMessageInput, options: CallOptions) !send_media_message.SendMediaMessageOutput {
        return send_media_message.execute(self, allocator, input, options);
    }

    /// Creates a new text message and sends it to a recipient's phone number.
    /// SendTextMessage only sends an SMS message to one recipient each time it is
    /// invoked.
    ///
    /// SMS throughput limits are measured in Message Parts per Second (MPS). Your
    /// MPS limit depends on the destination country of your messages, as well as
    /// the type of phone number (origination number) that you use to send the
    /// message. For more information about MPS, see [Message Parts per Second (MPS)
    /// limits](https://docs.aws.amazon.com/sms-voice/latest/userguide/sms-limitations-mps.html) in the *End User Messaging SMS User Guide*.
    pub fn sendTextMessage(self: *Self, allocator: std.mem.Allocator, input: send_text_message.SendTextMessageInput, options: CallOptions) !send_text_message.SendTextMessageOutput {
        return send_text_message.execute(self, allocator, input, options);
    }

    /// Allows you to send a request that sends a voice message. This operation uses
    /// [Amazon Polly](http://aws.amazon.com/polly/) to convert a text script into a
    /// voice message.
    pub fn sendVoiceMessage(self: *Self, allocator: std.mem.Allocator, input: send_voice_message.SendVoiceMessageInput, options: CallOptions) !send_voice_message.SendVoiceMessageOutput {
        return send_voice_message.execute(self, allocator, input, options);
    }

    /// Set a protect configuration as your account default. You can only have one
    /// account default protect configuration at a time. The current account default
    /// protect configuration is replaced with the provided protect configuration.
    pub fn setAccountDefaultProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: set_account_default_protect_configuration.SetAccountDefaultProtectConfigurationInput, options: CallOptions) !set_account_default_protect_configuration.SetAccountDefaultProtectConfigurationOutput {
        return set_account_default_protect_configuration.execute(self, allocator, input, options);
    }

    /// Sets a configuration set's default for message feedback.
    pub fn setDefaultMessageFeedbackEnabled(self: *Self, allocator: std.mem.Allocator, input: set_default_message_feedback_enabled.SetDefaultMessageFeedbackEnabledInput, options: CallOptions) !set_default_message_feedback_enabled.SetDefaultMessageFeedbackEnabledOutput {
        return set_default_message_feedback_enabled.execute(self, allocator, input, options);
    }

    /// Sets the default message type on a configuration set.
    ///
    /// Choose the category of SMS messages that you plan to send from this account.
    /// If you send account-related messages or time-sensitive messages such as
    /// one-time passcodes, choose **Transactional**. If you plan to send messages
    /// that contain marketing material or other promotional content, choose
    /// **Promotional**. This setting applies to your entire Amazon Web Services
    /// account.
    pub fn setDefaultMessageType(self: *Self, allocator: std.mem.Allocator, input: set_default_message_type.SetDefaultMessageTypeInput, options: CallOptions) !set_default_message_type.SetDefaultMessageTypeOutput {
        return set_default_message_type.execute(self, allocator, input, options);
    }

    /// Sets default sender ID on a configuration set.
    ///
    /// When sending a text message to a destination country that supports sender
    /// IDs, the default sender ID on the configuration set specified will be used
    /// if no dedicated origination phone numbers or registered sender IDs are
    /// available in your account.
    pub fn setDefaultSenderId(self: *Self, allocator: std.mem.Allocator, input: set_default_sender_id.SetDefaultSenderIdInput, options: CallOptions) !set_default_sender_id.SetDefaultSenderIdOutput {
        return set_default_sender_id.execute(self, allocator, input, options);
    }

    /// Sets an account level monthly spend limit override for sending MMS messages.
    /// The requested spend limit must be less than or equal to the `MaxLimit`,
    /// which is set by Amazon Web Services.
    pub fn setMediaMessageSpendLimitOverride(self: *Self, allocator: std.mem.Allocator, input: set_media_message_spend_limit_override.SetMediaMessageSpendLimitOverrideInput, options: CallOptions) !set_media_message_spend_limit_override.SetMediaMessageSpendLimitOverrideOutput {
        return set_media_message_spend_limit_override.execute(self, allocator, input, options);
    }

    /// Sets an account level monthly spend limit override for sending text
    /// messages. The requested spend limit must be less than or equal to the
    /// `MaxLimit`, which is set by Amazon Web Services.
    pub fn setTextMessageSpendLimitOverride(self: *Self, allocator: std.mem.Allocator, input: set_text_message_spend_limit_override.SetTextMessageSpendLimitOverrideInput, options: CallOptions) !set_text_message_spend_limit_override.SetTextMessageSpendLimitOverrideOutput {
        return set_text_message_spend_limit_override.execute(self, allocator, input, options);
    }

    /// Sets an account level monthly spend limit override for sending voice
    /// messages. The requested spend limit must be less than or equal to the
    /// `MaxLimit`, which is set by Amazon Web Services.
    pub fn setVoiceMessageSpendLimitOverride(self: *Self, allocator: std.mem.Allocator, input: set_voice_message_spend_limit_override.SetVoiceMessageSpendLimitOverrideInput, options: CallOptions) !set_voice_message_spend_limit_override.SetVoiceMessageSpendLimitOverrideOutput {
        return set_voice_message_spend_limit_override.execute(self, allocator, input, options);
    }

    /// Submit the specified registration for review and approval.
    pub fn submitRegistrationVersion(self: *Self, allocator: std.mem.Allocator, input: submit_registration_version.SubmitRegistrationVersionInput, options: CallOptions) !submit_registration_version.SubmitRegistrationVersionOutput {
        return submit_registration_version.execute(self, allocator, input, options);
    }

    /// Adds or overwrites only the specified tags for the specified resource. When
    /// you specify an existing tag key, the value is overwritten with the new
    /// value. Each tag consists of a key and an optional value. Tag keys must be
    /// unique per resource. For more information about tags, see [Tags
    /// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/phone-numbers-tags.html) in the *End User Messaging SMS User Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the association of the specified tags from a resource. For more
    /// information on tags see [Tags
    /// ](https://docs.aws.amazon.com/sms-voice/latest/userguide/phone-numbers-tags.html) in the *End User Messaging SMS User Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing event destination in a configuration set. You can update
    /// the IAM role ARN for CloudWatch Logs and Firehose. You can also enable or
    /// disable the event destination.
    ///
    /// You may want to update an event destination to change its matching event
    /// types or updating the destination resource ARN. You can't change an event
    /// destination's type between CloudWatch Logs, Firehose, and Amazon SNS.
    pub fn updateEventDestination(self: *Self, allocator: std.mem.Allocator, input: update_event_destination.UpdateEventDestinationInput, options: CallOptions) !update_event_destination.UpdateEventDestinationOutput {
        return update_event_destination.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing origination phone number. You can
    /// update the opt-out list, enable or disable two-way messaging, change the
    /// TwoWayChannelArn, enable or disable self-managed opt-outs, and enable or
    /// disable deletion protection.
    ///
    /// If the origination phone number is associated with a pool, an error is
    /// returned.
    pub fn updatePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: update_phone_number.UpdatePhoneNumberInput, options: CallOptions) !update_phone_number.UpdatePhoneNumberOutput {
        return update_phone_number.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing pool. You can update the opt-out
    /// list, enable or disable two-way messaging, change the `TwoWayChannelArn`,
    /// enable or disable self-managed opt-outs, enable or disable deletion
    /// protection, and enable or disable shared routes.
    pub fn updatePool(self: *Self, allocator: std.mem.Allocator, input: update_pool.UpdatePoolInput, options: CallOptions) !update_pool.UpdatePoolOutput {
        return update_pool.execute(self, allocator, input, options);
    }

    /// Update the setting for an existing protect configuration.
    pub fn updateProtectConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_protect_configuration.UpdateProtectConfigurationInput, options: CallOptions) !update_protect_configuration.UpdateProtectConfigurationOutput {
        return update_protect_configuration.execute(self, allocator, input, options);
    }

    /// Update a country rule set to `ALLOW`, `BLOCK`, `MONITOR`, or `FILTER`
    /// messages to be sent to the specified destination counties. You can update
    /// one or multiple countries at a time. The updates are only applied to the
    /// specified NumberCapability type.
    pub fn updateProtectConfigurationCountryRuleSet(self: *Self, allocator: std.mem.Allocator, input: update_protect_configuration_country_rule_set.UpdateProtectConfigurationCountryRuleSetInput, options: CallOptions) !update_protect_configuration_country_rule_set.UpdateProtectConfigurationCountryRuleSetOutput {
        return update_protect_configuration_country_rule_set.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing sender ID.
    pub fn updateSenderId(self: *Self, allocator: std.mem.Allocator, input: update_sender_id.UpdateSenderIdInput, options: CallOptions) !update_sender_id.UpdateSenderIdOutput {
        return update_sender_id.execute(self, allocator, input, options);
    }

    /// Use the verification code that was received by the verified destination
    /// phone number to opt-in the verified destination phone number to receive more
    /// messages.
    pub fn verifyDestinationNumber(self: *Self, allocator: std.mem.Allocator, input: verify_destination_number.VerifyDestinationNumberInput, options: CallOptions) !verify_destination_number.VerifyDestinationNumberOutput {
        return verify_destination_number.execute(self, allocator, input, options);
    }

    pub fn describeAccountAttributesPaginator(self: *Self, params: describe_account_attributes.DescribeAccountAttributesInput) paginator.DescribeAccountAttributesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAccountLimitsPaginator(self: *Self, params: describe_account_limits.DescribeAccountLimitsInput) paginator.DescribeAccountLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeConfigurationSetsPaginator(self: *Self, params: describe_configuration_sets.DescribeConfigurationSetsInput) paginator.DescribeConfigurationSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeKeywordsPaginator(self: *Self, params: describe_keywords.DescribeKeywordsInput) paginator.DescribeKeywordsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOptOutListsPaginator(self: *Self, params: describe_opt_out_lists.DescribeOptOutListsInput) paginator.DescribeOptOutListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOptedOutNumbersPaginator(self: *Self, params: describe_opted_out_numbers.DescribeOptedOutNumbersInput) paginator.DescribeOptedOutNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePhoneNumbersPaginator(self: *Self, params: describe_phone_numbers.DescribePhoneNumbersInput) paginator.DescribePhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePoolsPaginator(self: *Self, params: describe_pools.DescribePoolsInput) paginator.DescribePoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeProtectConfigurationsPaginator(self: *Self, params: describe_protect_configurations.DescribeProtectConfigurationsInput) paginator.DescribeProtectConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationAttachmentsPaginator(self: *Self, params: describe_registration_attachments.DescribeRegistrationAttachmentsInput) paginator.DescribeRegistrationAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationFieldDefinitionsPaginator(self: *Self, params: describe_registration_field_definitions.DescribeRegistrationFieldDefinitionsInput) paginator.DescribeRegistrationFieldDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationFieldValuesPaginator(self: *Self, params: describe_registration_field_values.DescribeRegistrationFieldValuesInput) paginator.DescribeRegistrationFieldValuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationSectionDefinitionsPaginator(self: *Self, params: describe_registration_section_definitions.DescribeRegistrationSectionDefinitionsInput) paginator.DescribeRegistrationSectionDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationTypeDefinitionsPaginator(self: *Self, params: describe_registration_type_definitions.DescribeRegistrationTypeDefinitionsInput) paginator.DescribeRegistrationTypeDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationVersionsPaginator(self: *Self, params: describe_registration_versions.DescribeRegistrationVersionsInput) paginator.DescribeRegistrationVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRegistrationsPaginator(self: *Self, params: describe_registrations.DescribeRegistrationsInput) paginator.DescribeRegistrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSenderIdsPaginator(self: *Self, params: describe_sender_ids.DescribeSenderIdsInput) paginator.DescribeSenderIdsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSpendLimitsPaginator(self: *Self, params: describe_spend_limits.DescribeSpendLimitsInput) paginator.DescribeSpendLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVerifiedDestinationNumbersPaginator(self: *Self, params: describe_verified_destination_numbers.DescribeVerifiedDestinationNumbersInput) paginator.DescribeVerifiedDestinationNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPoolOriginationIdentitiesPaginator(self: *Self, params: list_pool_origination_identities.ListPoolOriginationIdentitiesInput) paginator.ListPoolOriginationIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProtectConfigurationRuleSetNumberOverridesPaginator(self: *Self, params: list_protect_configuration_rule_set_number_overrides.ListProtectConfigurationRuleSetNumberOverridesInput) paginator.ListProtectConfigurationRuleSetNumberOverridesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegistrationAssociationsPaginator(self: *Self, params: list_registration_associations.ListRegistrationAssociationsInput) paginator.ListRegistrationAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
