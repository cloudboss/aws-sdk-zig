const aws = @import("aws");
const std = @import("std");

const associate_phone_numbers_with_voice_connector = @import("associate_phone_numbers_with_voice_connector.zig");
const associate_phone_numbers_with_voice_connector_group = @import("associate_phone_numbers_with_voice_connector_group.zig");
const batch_delete_phone_number = @import("batch_delete_phone_number.zig");
const batch_update_phone_number = @import("batch_update_phone_number.zig");
const create_phone_number_order = @import("create_phone_number_order.zig");
const create_proxy_session = @import("create_proxy_session.zig");
const create_sip_media_application = @import("create_sip_media_application.zig");
const create_sip_media_application_call = @import("create_sip_media_application_call.zig");
const create_sip_rule = @import("create_sip_rule.zig");
const create_voice_connector = @import("create_voice_connector.zig");
const create_voice_connector_group = @import("create_voice_connector_group.zig");
const create_voice_profile = @import("create_voice_profile.zig");
const create_voice_profile_domain = @import("create_voice_profile_domain.zig");
const delete_phone_number = @import("delete_phone_number.zig");
const delete_proxy_session = @import("delete_proxy_session.zig");
const delete_sip_media_application = @import("delete_sip_media_application.zig");
const delete_sip_rule = @import("delete_sip_rule.zig");
const delete_voice_connector = @import("delete_voice_connector.zig");
const delete_voice_connector_emergency_calling_configuration = @import("delete_voice_connector_emergency_calling_configuration.zig");
const delete_voice_connector_external_systems_configuration = @import("delete_voice_connector_external_systems_configuration.zig");
const delete_voice_connector_group = @import("delete_voice_connector_group.zig");
const delete_voice_connector_origination = @import("delete_voice_connector_origination.zig");
const delete_voice_connector_proxy = @import("delete_voice_connector_proxy.zig");
const delete_voice_connector_streaming_configuration = @import("delete_voice_connector_streaming_configuration.zig");
const delete_voice_connector_termination = @import("delete_voice_connector_termination.zig");
const delete_voice_connector_termination_credentials = @import("delete_voice_connector_termination_credentials.zig");
const delete_voice_profile = @import("delete_voice_profile.zig");
const delete_voice_profile_domain = @import("delete_voice_profile_domain.zig");
const disassociate_phone_numbers_from_voice_connector = @import("disassociate_phone_numbers_from_voice_connector.zig");
const disassociate_phone_numbers_from_voice_connector_group = @import("disassociate_phone_numbers_from_voice_connector_group.zig");
const get_global_settings = @import("get_global_settings.zig");
const get_phone_number = @import("get_phone_number.zig");
const get_phone_number_order = @import("get_phone_number_order.zig");
const get_phone_number_settings = @import("get_phone_number_settings.zig");
const get_proxy_session = @import("get_proxy_session.zig");
const get_sip_media_application = @import("get_sip_media_application.zig");
const get_sip_media_application_alexa_skill_configuration = @import("get_sip_media_application_alexa_skill_configuration.zig");
const get_sip_media_application_logging_configuration = @import("get_sip_media_application_logging_configuration.zig");
const get_sip_rule = @import("get_sip_rule.zig");
const get_speaker_search_task = @import("get_speaker_search_task.zig");
const get_voice_connector = @import("get_voice_connector.zig");
const get_voice_connector_emergency_calling_configuration = @import("get_voice_connector_emergency_calling_configuration.zig");
const get_voice_connector_external_systems_configuration = @import("get_voice_connector_external_systems_configuration.zig");
const get_voice_connector_group = @import("get_voice_connector_group.zig");
const get_voice_connector_logging_configuration = @import("get_voice_connector_logging_configuration.zig");
const get_voice_connector_origination = @import("get_voice_connector_origination.zig");
const get_voice_connector_proxy = @import("get_voice_connector_proxy.zig");
const get_voice_connector_streaming_configuration = @import("get_voice_connector_streaming_configuration.zig");
const get_voice_connector_termination = @import("get_voice_connector_termination.zig");
const get_voice_connector_termination_health = @import("get_voice_connector_termination_health.zig");
const get_voice_profile = @import("get_voice_profile.zig");
const get_voice_profile_domain = @import("get_voice_profile_domain.zig");
const get_voice_tone_analysis_task = @import("get_voice_tone_analysis_task.zig");
const list_available_voice_connector_regions = @import("list_available_voice_connector_regions.zig");
const list_phone_number_orders = @import("list_phone_number_orders.zig");
const list_phone_numbers = @import("list_phone_numbers.zig");
const list_proxy_sessions = @import("list_proxy_sessions.zig");
const list_sip_media_applications = @import("list_sip_media_applications.zig");
const list_sip_rules = @import("list_sip_rules.zig");
const list_supported_phone_number_countries = @import("list_supported_phone_number_countries.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_voice_connector_groups = @import("list_voice_connector_groups.zig");
const list_voice_connector_termination_credentials = @import("list_voice_connector_termination_credentials.zig");
const list_voice_connectors = @import("list_voice_connectors.zig");
const list_voice_profile_domains = @import("list_voice_profile_domains.zig");
const list_voice_profiles = @import("list_voice_profiles.zig");
const put_sip_media_application_alexa_skill_configuration = @import("put_sip_media_application_alexa_skill_configuration.zig");
const put_sip_media_application_logging_configuration = @import("put_sip_media_application_logging_configuration.zig");
const put_voice_connector_emergency_calling_configuration = @import("put_voice_connector_emergency_calling_configuration.zig");
const put_voice_connector_external_systems_configuration = @import("put_voice_connector_external_systems_configuration.zig");
const put_voice_connector_logging_configuration = @import("put_voice_connector_logging_configuration.zig");
const put_voice_connector_origination = @import("put_voice_connector_origination.zig");
const put_voice_connector_proxy = @import("put_voice_connector_proxy.zig");
const put_voice_connector_streaming_configuration = @import("put_voice_connector_streaming_configuration.zig");
const put_voice_connector_termination = @import("put_voice_connector_termination.zig");
const put_voice_connector_termination_credentials = @import("put_voice_connector_termination_credentials.zig");
const restore_phone_number = @import("restore_phone_number.zig");
const search_available_phone_numbers = @import("search_available_phone_numbers.zig");
const start_speaker_search_task = @import("start_speaker_search_task.zig");
const start_voice_tone_analysis_task = @import("start_voice_tone_analysis_task.zig");
const stop_speaker_search_task = @import("stop_speaker_search_task.zig");
const stop_voice_tone_analysis_task = @import("stop_voice_tone_analysis_task.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_global_settings = @import("update_global_settings.zig");
const update_phone_number = @import("update_phone_number.zig");
const update_phone_number_settings = @import("update_phone_number_settings.zig");
const update_proxy_session = @import("update_proxy_session.zig");
const update_sip_media_application = @import("update_sip_media_application.zig");
const update_sip_media_application_call = @import("update_sip_media_application_call.zig");
const update_sip_rule = @import("update_sip_rule.zig");
const update_voice_connector = @import("update_voice_connector.zig");
const update_voice_connector_group = @import("update_voice_connector_group.zig");
const update_voice_profile = @import("update_voice_profile.zig");
const update_voice_profile_domain = @import("update_voice_profile_domain.zig");
const validate_e911_address = @import("validate_e911_address.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Chime SDK Voice";

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

    /// Associates phone numbers with the specified Amazon Chime SDK Voice
    /// Connector.
    pub fn associatePhoneNumbersWithVoiceConnector(self: *Self, allocator: std.mem.Allocator, input: associate_phone_numbers_with_voice_connector.AssociatePhoneNumbersWithVoiceConnectorInput, options: associate_phone_numbers_with_voice_connector.Options) !associate_phone_numbers_with_voice_connector.AssociatePhoneNumbersWithVoiceConnectorOutput {
        return associate_phone_numbers_with_voice_connector.execute(self, allocator, input, options);
    }

    /// Associates phone numbers with the specified Amazon Chime SDK Voice Connector
    /// group.
    pub fn associatePhoneNumbersWithVoiceConnectorGroup(self: *Self, allocator: std.mem.Allocator, input: associate_phone_numbers_with_voice_connector_group.AssociatePhoneNumbersWithVoiceConnectorGroupInput, options: associate_phone_numbers_with_voice_connector_group.Options) !associate_phone_numbers_with_voice_connector_group.AssociatePhoneNumbersWithVoiceConnectorGroupOutput {
        return associate_phone_numbers_with_voice_connector_group.execute(self, allocator, input, options);
    }

    /// Moves phone numbers into the
    /// **Deletion queue**. Phone numbers must be disassociated from any users or
    /// Amazon Chime SDK Voice Connectors before they can be deleted.
    ///
    /// Phone numbers remain in the
    /// **Deletion queue** for 7 days before they are deleted permanently.
    pub fn batchDeletePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: batch_delete_phone_number.BatchDeletePhoneNumberInput, options: batch_delete_phone_number.Options) !batch_delete_phone_number.BatchDeletePhoneNumberOutput {
        return batch_delete_phone_number.execute(self, allocator, input, options);
    }

    /// Updates phone number product types, calling names, or phone number names.
    /// You can update one attribute at a time for each
    /// `UpdatePhoneNumberRequestItem`. For example, you can update the product
    /// type, the calling name, or phone name.
    ///
    /// You cannot have a duplicate `phoneNumberId` in a request.
    pub fn batchUpdatePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: batch_update_phone_number.BatchUpdatePhoneNumberInput, options: batch_update_phone_number.Options) !batch_update_phone_number.BatchUpdatePhoneNumberOutput {
        return batch_update_phone_number.execute(self, allocator, input, options);
    }

    /// Creates an order for phone numbers to be provisioned. For numbers outside
    /// the U.S., you must use the Amazon Chime SDK SIP media application dial-in
    /// product type.
    pub fn createPhoneNumberOrder(self: *Self, allocator: std.mem.Allocator, input: create_phone_number_order.CreatePhoneNumberOrderInput, options: create_phone_number_order.Options) !create_phone_number_order.CreatePhoneNumberOrderOutput {
        return create_phone_number_order.execute(self, allocator, input, options);
    }

    /// Creates a proxy session for the specified Amazon Chime SDK Voice Connector
    /// for
    /// the specified participant phone numbers.
    pub fn createProxySession(self: *Self, allocator: std.mem.Allocator, input: create_proxy_session.CreateProxySessionInput, options: create_proxy_session.Options) !create_proxy_session.CreateProxySessionOutput {
        return create_proxy_session.execute(self, allocator, input, options);
    }

    /// Creates a SIP media application. For more information about SIP media
    /// applications, see [Managing SIP media applications
    /// and
    /// rules](https://docs.aws.amazon.com/chime-sdk/latest/ag/manage-sip-applications.html) in the *Amazon Chime SDK Administrator Guide*.
    pub fn createSipMediaApplication(self: *Self, allocator: std.mem.Allocator, input: create_sip_media_application.CreateSipMediaApplicationInput, options: create_sip_media_application.Options) !create_sip_media_application.CreateSipMediaApplicationOutput {
        return create_sip_media_application.execute(self, allocator, input, options);
    }

    /// Creates an outbound call to a phone number from the phone number specified
    /// in the request, and it invokes the endpoint of the specified
    /// `sipMediaApplicationId`.
    pub fn createSipMediaApplicationCall(self: *Self, allocator: std.mem.Allocator, input: create_sip_media_application_call.CreateSipMediaApplicationCallInput, options: create_sip_media_application_call.Options) !create_sip_media_application_call.CreateSipMediaApplicationCallOutput {
        return create_sip_media_application_call.execute(self, allocator, input, options);
    }

    /// Creates a SIP rule, which can be used to run a SIP media application as a
    /// target for a specific trigger type. For more information about SIP rules,
    /// see [Managing SIP media applications
    /// and
    /// rules](https://docs.aws.amazon.com/chime-sdk/latest/ag/manage-sip-applications.html) in the *Amazon Chime SDK Administrator Guide*.
    pub fn createSipRule(self: *Self, allocator: std.mem.Allocator, input: create_sip_rule.CreateSipRuleInput, options: create_sip_rule.Options) !create_sip_rule.CreateSipRuleOutput {
        return create_sip_rule.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Chime SDK Voice Connector. For more information about
    /// Voice Connectors,
    /// see [Managing Amazon Chime SDK Voice Connector
    /// groups](https://docs.aws.amazon.com/chime-sdk/latest/ag/voice-connector-groups.html) in the *Amazon Chime SDK
    /// Administrator Guide*.
    pub fn createVoiceConnector(self: *Self, allocator: std.mem.Allocator, input: create_voice_connector.CreateVoiceConnectorInput, options: create_voice_connector.Options) !create_voice_connector.CreateVoiceConnectorOutput {
        return create_voice_connector.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Chime SDK Voice Connector group under the administrator's
    /// AWS account. You can associate Amazon Chime SDK Voice Connectors with the
    /// Voice Connector group by including `VoiceConnectorItems` in the
    /// request.
    ///
    /// You can include Voice Connectors from different AWS Regions in your group.
    /// This creates a fault tolerant mechanism for fallback in case of availability
    /// events.
    pub fn createVoiceConnectorGroup(self: *Self, allocator: std.mem.Allocator, input: create_voice_connector_group.CreateVoiceConnectorGroupInput, options: create_voice_connector_group.Options) !create_voice_connector_group.CreateVoiceConnectorGroupOutput {
        return create_voice_connector_group.execute(self, allocator, input, options);
    }

    /// Creates a voice profile, which consists of an enrolled user and their latest
    /// voice print.
    ///
    /// Before creating any voice profiles, you must provide all notices and obtain
    /// all consents from the speaker as required under applicable privacy and
    /// biometrics laws, and as required under the
    /// [AWS service terms](https://aws.amazon.com/service-terms/) for the Amazon
    /// Chime SDK.
    ///
    /// For more information about voice profiles and voice analytics, see [Using
    /// Amazon Chime SDK Voice
    /// Analytics](https://docs.aws.amazon.com/chime-sdk/latest/dg/pstn-voice-analytics.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    pub fn createVoiceProfile(self: *Self, allocator: std.mem.Allocator, input: create_voice_profile.CreateVoiceProfileInput, options: create_voice_profile.Options) !create_voice_profile.CreateVoiceProfileOutput {
        return create_voice_profile.execute(self, allocator, input, options);
    }

    /// Creates a voice profile domain, a collection of voice profiles, their voice
    /// prints, and encrypted enrollment audio.
    ///
    /// Before creating any voice profiles, you must provide all notices and obtain
    /// all consents from the speaker as required under applicable privacy and
    /// biometrics laws, and as required under the
    /// [AWS service terms](https://aws.amazon.com/service-terms/) for the Amazon
    /// Chime SDK.
    ///
    /// For more information about voice profile domains, see [Using Amazon Chime
    /// SDK Voice
    /// Analytics](https://docs.aws.amazon.com/chime-sdk/latest/dg/pstn-voice-analytics.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    pub fn createVoiceProfileDomain(self: *Self, allocator: std.mem.Allocator, input: create_voice_profile_domain.CreateVoiceProfileDomainInput, options: create_voice_profile_domain.Options) !create_voice_profile_domain.CreateVoiceProfileDomainOutput {
        return create_voice_profile_domain.execute(self, allocator, input, options);
    }

    /// Moves the specified phone number into the
    /// **Deletion queue**. A phone number must
    /// be disassociated from any users or Amazon Chime SDK Voice Connectors before
    /// it can be
    /// deleted.
    ///
    /// Deleted phone numbers remain in the
    /// **Deletion queue** queue for 7 days before
    /// they are deleted permanently.
    pub fn deletePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: delete_phone_number.DeletePhoneNumberInput, options: delete_phone_number.Options) !delete_phone_number.DeletePhoneNumberOutput {
        return delete_phone_number.execute(self, allocator, input, options);
    }

    /// Deletes the specified proxy session from the specified Amazon Chime SDK
    /// Voice
    /// Connector.
    pub fn deleteProxySession(self: *Self, allocator: std.mem.Allocator, input: delete_proxy_session.DeleteProxySessionInput, options: delete_proxy_session.Options) !delete_proxy_session.DeleteProxySessionOutput {
        return delete_proxy_session.execute(self, allocator, input, options);
    }

    /// Deletes a SIP media application.
    pub fn deleteSipMediaApplication(self: *Self, allocator: std.mem.Allocator, input: delete_sip_media_application.DeleteSipMediaApplicationInput, options: delete_sip_media_application.Options) !delete_sip_media_application.DeleteSipMediaApplicationOutput {
        return delete_sip_media_application.execute(self, allocator, input, options);
    }

    /// Deletes a SIP rule.
    pub fn deleteSipRule(self: *Self, allocator: std.mem.Allocator, input: delete_sip_rule.DeleteSipRuleInput, options: delete_sip_rule.Options) !delete_sip_rule.DeleteSipRuleOutput {
        return delete_sip_rule.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Chime SDK Voice Connector. Any phone numbers associated
    /// with the Amazon Chime SDK Voice Connector must be disassociated from it
    /// before it
    /// can be deleted.
    pub fn deleteVoiceConnector(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector.DeleteVoiceConnectorInput, options: delete_voice_connector.Options) !delete_voice_connector.DeleteVoiceConnectorOutput {
        return delete_voice_connector.execute(self, allocator, input, options);
    }

    /// Deletes the emergency calling details from the specified Amazon Chime SDK
    /// Voice
    /// Connector.
    pub fn deleteVoiceConnectorEmergencyCallingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_emergency_calling_configuration.DeleteVoiceConnectorEmergencyCallingConfigurationInput, options: delete_voice_connector_emergency_calling_configuration.Options) !delete_voice_connector_emergency_calling_configuration.DeleteVoiceConnectorEmergencyCallingConfigurationOutput {
        return delete_voice_connector_emergency_calling_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the external systems configuration for a Voice Connector.
    pub fn deleteVoiceConnectorExternalSystemsConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_external_systems_configuration.DeleteVoiceConnectorExternalSystemsConfigurationInput, options: delete_voice_connector_external_systems_configuration.Options) !delete_voice_connector_external_systems_configuration.DeleteVoiceConnectorExternalSystemsConfigurationOutput {
        return delete_voice_connector_external_systems_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Chime SDK Voice Connector group. Any `VoiceConnectorItems`
    /// and phone numbers associated with the group must be removed before it can be
    /// deleted.
    pub fn deleteVoiceConnectorGroup(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_group.DeleteVoiceConnectorGroupInput, options: delete_voice_connector_group.Options) !delete_voice_connector_group.DeleteVoiceConnectorGroupOutput {
        return delete_voice_connector_group.execute(self, allocator, input, options);
    }

    /// Deletes the origination settings for the specified Amazon Chime SDK Voice
    /// Connector.
    ///
    /// If emergency calling is configured for the Voice Connector, it must be
    /// deleted prior to deleting the origination settings.
    pub fn deleteVoiceConnectorOrigination(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_origination.DeleteVoiceConnectorOriginationInput, options: delete_voice_connector_origination.Options) !delete_voice_connector_origination.DeleteVoiceConnectorOriginationOutput {
        return delete_voice_connector_origination.execute(self, allocator, input, options);
    }

    /// Deletes the proxy configuration from the specified Amazon Chime SDK Voice
    /// Connector.
    pub fn deleteVoiceConnectorProxy(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_proxy.DeleteVoiceConnectorProxyInput, options: delete_voice_connector_proxy.Options) !delete_voice_connector_proxy.DeleteVoiceConnectorProxyOutput {
        return delete_voice_connector_proxy.execute(self, allocator, input, options);
    }

    /// Deletes a Voice Connector's streaming configuration.
    pub fn deleteVoiceConnectorStreamingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_streaming_configuration.DeleteVoiceConnectorStreamingConfigurationInput, options: delete_voice_connector_streaming_configuration.Options) !delete_voice_connector_streaming_configuration.DeleteVoiceConnectorStreamingConfigurationOutput {
        return delete_voice_connector_streaming_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the termination settings for the specified Amazon Chime SDK Voice
    /// Connector.
    ///
    /// If emergency calling is configured for the Voice Connector, it must be
    /// deleted prior to deleting the termination settings.
    pub fn deleteVoiceConnectorTermination(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_termination.DeleteVoiceConnectorTerminationInput, options: delete_voice_connector_termination.Options) !delete_voice_connector_termination.DeleteVoiceConnectorTerminationOutput {
        return delete_voice_connector_termination.execute(self, allocator, input, options);
    }

    /// Deletes the specified SIP credentials used by your equipment to
    /// authenticate during call termination.
    pub fn deleteVoiceConnectorTerminationCredentials(self: *Self, allocator: std.mem.Allocator, input: delete_voice_connector_termination_credentials.DeleteVoiceConnectorTerminationCredentialsInput, options: delete_voice_connector_termination_credentials.Options) !delete_voice_connector_termination_credentials.DeleteVoiceConnectorTerminationCredentialsOutput {
        return delete_voice_connector_termination_credentials.execute(self, allocator, input, options);
    }

    /// Deletes a voice profile, including its voice print and enrollment data.
    /// WARNING: This action is not reversible.
    pub fn deleteVoiceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_voice_profile.DeleteVoiceProfileInput, options: delete_voice_profile.Options) !delete_voice_profile.DeleteVoiceProfileOutput {
        return delete_voice_profile.execute(self, allocator, input, options);
    }

    /// Deletes all voice profiles in the domain. WARNING: This action is not
    /// reversible.
    pub fn deleteVoiceProfileDomain(self: *Self, allocator: std.mem.Allocator, input: delete_voice_profile_domain.DeleteVoiceProfileDomainInput, options: delete_voice_profile_domain.Options) !delete_voice_profile_domain.DeleteVoiceProfileDomainOutput {
        return delete_voice_profile_domain.execute(self, allocator, input, options);
    }

    /// Disassociates the specified phone numbers from the specified
    /// Amazon Chime SDK Voice Connector.
    pub fn disassociatePhoneNumbersFromVoiceConnector(self: *Self, allocator: std.mem.Allocator, input: disassociate_phone_numbers_from_voice_connector.DisassociatePhoneNumbersFromVoiceConnectorInput, options: disassociate_phone_numbers_from_voice_connector.Options) !disassociate_phone_numbers_from_voice_connector.DisassociatePhoneNumbersFromVoiceConnectorOutput {
        return disassociate_phone_numbers_from_voice_connector.execute(self, allocator, input, options);
    }

    /// Disassociates the specified phone numbers from the specified Amazon Chime
    /// SDK Voice
    /// Connector group.
    pub fn disassociatePhoneNumbersFromVoiceConnectorGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_phone_numbers_from_voice_connector_group.DisassociatePhoneNumbersFromVoiceConnectorGroupInput, options: disassociate_phone_numbers_from_voice_connector_group.Options) !disassociate_phone_numbers_from_voice_connector_group.DisassociatePhoneNumbersFromVoiceConnectorGroupOutput {
        return disassociate_phone_numbers_from_voice_connector_group.execute(self, allocator, input, options);
    }

    /// Retrieves the global settings for the Amazon Chime SDK Voice Connectors in
    /// an AWS account.
    pub fn getGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: get_global_settings.GetGlobalSettingsInput, options: get_global_settings.Options) !get_global_settings.GetGlobalSettingsOutput {
        return get_global_settings.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified phone number ID, such as associations,
    /// capabilities, and product type.
    pub fn getPhoneNumber(self: *Self, allocator: std.mem.Allocator, input: get_phone_number.GetPhoneNumberInput, options: get_phone_number.Options) !get_phone_number.GetPhoneNumberOutput {
        return get_phone_number.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified phone number order, such as the order
    /// creation timestamp, phone numbers in E.164 format, product type, and
    /// order status.
    pub fn getPhoneNumberOrder(self: *Self, allocator: std.mem.Allocator, input: get_phone_number_order.GetPhoneNumberOrderInput, options: get_phone_number_order.Options) !get_phone_number_order.GetPhoneNumberOrderOutput {
        return get_phone_number_order.execute(self, allocator, input, options);
    }

    /// Retrieves the phone number settings for the administrator's AWS account,
    /// such as the default outbound calling name.
    pub fn getPhoneNumberSettings(self: *Self, allocator: std.mem.Allocator, input: get_phone_number_settings.GetPhoneNumberSettingsInput, options: get_phone_number_settings.Options) !get_phone_number_settings.GetPhoneNumberSettingsOutput {
        return get_phone_number_settings.execute(self, allocator, input, options);
    }

    /// Retrieves the specified proxy session details for the specified Amazon Chime
    /// SDK Voice Connector.
    pub fn getProxySession(self: *Self, allocator: std.mem.Allocator, input: get_proxy_session.GetProxySessionInput, options: get_proxy_session.Options) !get_proxy_session.GetProxySessionOutput {
        return get_proxy_session.execute(self, allocator, input, options);
    }

    /// Retrieves the information for a SIP media application, including name,
    /// AWS Region, and endpoints.
    pub fn getSipMediaApplication(self: *Self, allocator: std.mem.Allocator, input: get_sip_media_application.GetSipMediaApplicationInput, options: get_sip_media_application.Options) !get_sip_media_application.GetSipMediaApplicationOutput {
        return get_sip_media_application.execute(self, allocator, input, options);
    }

    /// Gets the Alexa Skill configuration for the SIP media application.
    ///
    /// Due to changes made by the Amazon Alexa service, this API is no longer
    /// available for use. For more information, refer to
    /// the [Alexa Smart
    /// Properties](https://developer.amazon.com/en-US/alexa/alexasmartproperties)
    /// page.
    pub fn getSipMediaApplicationAlexaSkillConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_sip_media_application_alexa_skill_configuration.GetSipMediaApplicationAlexaSkillConfigurationInput, options: get_sip_media_application_alexa_skill_configuration.Options) !get_sip_media_application_alexa_skill_configuration.GetSipMediaApplicationAlexaSkillConfigurationOutput {
        return get_sip_media_application_alexa_skill_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the logging configuration for the specified SIP media application.
    pub fn getSipMediaApplicationLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_sip_media_application_logging_configuration.GetSipMediaApplicationLoggingConfigurationInput, options: get_sip_media_application_logging_configuration.Options) !get_sip_media_application_logging_configuration.GetSipMediaApplicationLoggingConfigurationOutput {
        return get_sip_media_application_logging_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a SIP rule, such as the rule ID, name, triggers,
    /// and
    /// target endpoints.
    pub fn getSipRule(self: *Self, allocator: std.mem.Allocator, input: get_sip_rule.GetSipRuleInput, options: get_sip_rule.Options) !get_sip_rule.GetSipRuleOutput {
        return get_sip_rule.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified speaker search task.
    pub fn getSpeakerSearchTask(self: *Self, allocator: std.mem.Allocator, input: get_speaker_search_task.GetSpeakerSearchTaskInput, options: get_speaker_search_task.Options) !get_speaker_search_task.GetSpeakerSearchTaskOutput {
        return get_speaker_search_task.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified Amazon Chime SDK Voice Connector, such
    /// as
    /// timestamps,name, outbound host, and encryption requirements.
    pub fn getVoiceConnector(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector.GetVoiceConnectorInput, options: get_voice_connector.Options) !get_voice_connector.GetVoiceConnectorOutput {
        return get_voice_connector.execute(self, allocator, input, options);
    }

    /// Retrieves the emergency calling configuration details for the specified
    /// Voice Connector.
    pub fn getVoiceConnectorEmergencyCallingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_emergency_calling_configuration.GetVoiceConnectorEmergencyCallingConfigurationInput, options: get_voice_connector_emergency_calling_configuration.Options) !get_voice_connector_emergency_calling_configuration.GetVoiceConnectorEmergencyCallingConfigurationOutput {
        return get_voice_connector_emergency_calling_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about an external systems configuration for a Voice
    /// Connector.
    pub fn getVoiceConnectorExternalSystemsConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_external_systems_configuration.GetVoiceConnectorExternalSystemsConfigurationInput, options: get_voice_connector_external_systems_configuration.Options) !get_voice_connector_external_systems_configuration.GetVoiceConnectorExternalSystemsConfigurationOutput {
        return get_voice_connector_external_systems_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified Amazon Chime SDK Voice Connector group,
    /// such as timestamps,name, and associated `VoiceConnectorItems`.
    pub fn getVoiceConnectorGroup(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_group.GetVoiceConnectorGroupInput, options: get_voice_connector_group.Options) !get_voice_connector_group.GetVoiceConnectorGroupOutput {
        return get_voice_connector_group.execute(self, allocator, input, options);
    }

    /// Retrieves the logging configuration settings for the specified Voice
    /// Connector.
    /// Shows whether SIP message logs are enabled for sending to Amazon CloudWatch
    /// Logs.
    pub fn getVoiceConnectorLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_logging_configuration.GetVoiceConnectorLoggingConfigurationInput, options: get_voice_connector_logging_configuration.Options) !get_voice_connector_logging_configuration.GetVoiceConnectorLoggingConfigurationOutput {
        return get_voice_connector_logging_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the origination settings for the specified Voice Connector.
    pub fn getVoiceConnectorOrigination(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_origination.GetVoiceConnectorOriginationInput, options: get_voice_connector_origination.Options) !get_voice_connector_origination.GetVoiceConnectorOriginationOutput {
        return get_voice_connector_origination.execute(self, allocator, input, options);
    }

    /// Retrieves the proxy configuration details for the specified Amazon Chime SDK
    /// Voice
    /// Connector.
    pub fn getVoiceConnectorProxy(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_proxy.GetVoiceConnectorProxyInput, options: get_voice_connector_proxy.Options) !get_voice_connector_proxy.GetVoiceConnectorProxyOutput {
        return get_voice_connector_proxy.execute(self, allocator, input, options);
    }

    /// Retrieves the streaming configuration details for the specified Amazon Chime
    /// SDK
    /// Voice Connector. Shows whether media streaming is enabled for sending to
    /// Amazon
    /// Kinesis. It also shows the retention period, in hours, for the Amazon
    /// Kinesis data.
    pub fn getVoiceConnectorStreamingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_streaming_configuration.GetVoiceConnectorStreamingConfigurationInput, options: get_voice_connector_streaming_configuration.Options) !get_voice_connector_streaming_configuration.GetVoiceConnectorStreamingConfigurationOutput {
        return get_voice_connector_streaming_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the termination setting details for the specified Voice Connector.
    pub fn getVoiceConnectorTermination(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_termination.GetVoiceConnectorTerminationInput, options: get_voice_connector_termination.Options) !get_voice_connector_termination.GetVoiceConnectorTerminationOutput {
        return get_voice_connector_termination.execute(self, allocator, input, options);
    }

    /// Retrieves information about the last time a `SIP OPTIONS` ping
    /// was received from your SIP infrastructure for the specified Amazon Chime SDK
    /// Voice
    /// Connector.
    pub fn getVoiceConnectorTerminationHealth(self: *Self, allocator: std.mem.Allocator, input: get_voice_connector_termination_health.GetVoiceConnectorTerminationHealthInput, options: get_voice_connector_termination_health.Options) !get_voice_connector_termination_health.GetVoiceConnectorTerminationHealthOutput {
        return get_voice_connector_termination_health.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified voice profile.
    pub fn getVoiceProfile(self: *Self, allocator: std.mem.Allocator, input: get_voice_profile.GetVoiceProfileInput, options: get_voice_profile.Options) !get_voice_profile.GetVoiceProfileOutput {
        return get_voice_profile.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified voice profile domain.
    pub fn getVoiceProfileDomain(self: *Self, allocator: std.mem.Allocator, input: get_voice_profile_domain.GetVoiceProfileDomainInput, options: get_voice_profile_domain.Options) !get_voice_profile_domain.GetVoiceProfileDomainOutput {
        return get_voice_profile_domain.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a voice tone analysis task.
    pub fn getVoiceToneAnalysisTask(self: *Self, allocator: std.mem.Allocator, input: get_voice_tone_analysis_task.GetVoiceToneAnalysisTaskInput, options: get_voice_tone_analysis_task.Options) !get_voice_tone_analysis_task.GetVoiceToneAnalysisTaskOutput {
        return get_voice_tone_analysis_task.execute(self, allocator, input, options);
    }

    /// Lists the available AWS Regions in which you can create an Amazon Chime SDK
    /// Voice Connector.
    pub fn listAvailableVoiceConnectorRegions(self: *Self, allocator: std.mem.Allocator, input: list_available_voice_connector_regions.ListAvailableVoiceConnectorRegionsInput, options: list_available_voice_connector_regions.Options) !list_available_voice_connector_regions.ListAvailableVoiceConnectorRegionsOutput {
        return list_available_voice_connector_regions.execute(self, allocator, input, options);
    }

    /// Lists the phone numbers for an administrator's Amazon Chime SDK account.
    pub fn listPhoneNumberOrders(self: *Self, allocator: std.mem.Allocator, input: list_phone_number_orders.ListPhoneNumberOrdersInput, options: list_phone_number_orders.Options) !list_phone_number_orders.ListPhoneNumberOrdersOutput {
        return list_phone_number_orders.execute(self, allocator, input, options);
    }

    /// Lists the phone numbers for the specified Amazon Chime SDK account,
    /// Amazon Chime SDK user, Amazon Chime SDK Voice Connector, or Amazon Chime SDK
    /// Voice
    /// Connector group.
    pub fn listPhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: list_phone_numbers.ListPhoneNumbersInput, options: list_phone_numbers.Options) !list_phone_numbers.ListPhoneNumbersOutput {
        return list_phone_numbers.execute(self, allocator, input, options);
    }

    /// Lists the proxy sessions for the specified Amazon Chime SDK Voice Connector.
    pub fn listProxySessions(self: *Self, allocator: std.mem.Allocator, input: list_proxy_sessions.ListProxySessionsInput, options: list_proxy_sessions.Options) !list_proxy_sessions.ListProxySessionsOutput {
        return list_proxy_sessions.execute(self, allocator, input, options);
    }

    /// Lists the SIP media applications under the administrator's AWS account.
    pub fn listSipMediaApplications(self: *Self, allocator: std.mem.Allocator, input: list_sip_media_applications.ListSipMediaApplicationsInput, options: list_sip_media_applications.Options) !list_sip_media_applications.ListSipMediaApplicationsOutput {
        return list_sip_media_applications.execute(self, allocator, input, options);
    }

    /// Lists the SIP rules under the administrator's AWS account.
    pub fn listSipRules(self: *Self, allocator: std.mem.Allocator, input: list_sip_rules.ListSipRulesInput, options: list_sip_rules.Options) !list_sip_rules.ListSipRulesOutput {
        return list_sip_rules.execute(self, allocator, input, options);
    }

    /// Lists the countries that you can order phone numbers from.
    pub fn listSupportedPhoneNumberCountries(self: *Self, allocator: std.mem.Allocator, input: list_supported_phone_number_countries.ListSupportedPhoneNumberCountriesInput, options: list_supported_phone_number_countries.Options) !list_supported_phone_number_countries.ListSupportedPhoneNumberCountriesOutput {
        return list_supported_phone_number_countries.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags in a given resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Chime SDK Voice Connector groups in the administrator's AWS
    /// account.
    pub fn listVoiceConnectorGroups(self: *Self, allocator: std.mem.Allocator, input: list_voice_connector_groups.ListVoiceConnectorGroupsInput, options: list_voice_connector_groups.Options) !list_voice_connector_groups.ListVoiceConnectorGroupsOutput {
        return list_voice_connector_groups.execute(self, allocator, input, options);
    }

    /// Lists the SIP credentials for the specified Amazon Chime SDK Voice
    /// Connector.
    pub fn listVoiceConnectorTerminationCredentials(self: *Self, allocator: std.mem.Allocator, input: list_voice_connector_termination_credentials.ListVoiceConnectorTerminationCredentialsInput, options: list_voice_connector_termination_credentials.Options) !list_voice_connector_termination_credentials.ListVoiceConnectorTerminationCredentialsOutput {
        return list_voice_connector_termination_credentials.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Chime SDK Voice Connectors in the administrators
    /// AWS account.
    pub fn listVoiceConnectors(self: *Self, allocator: std.mem.Allocator, input: list_voice_connectors.ListVoiceConnectorsInput, options: list_voice_connectors.Options) !list_voice_connectors.ListVoiceConnectorsOutput {
        return list_voice_connectors.execute(self, allocator, input, options);
    }

    /// Lists the specified voice profile domains in the administrator's AWS
    /// account.
    pub fn listVoiceProfileDomains(self: *Self, allocator: std.mem.Allocator, input: list_voice_profile_domains.ListVoiceProfileDomainsInput, options: list_voice_profile_domains.Options) !list_voice_profile_domains.ListVoiceProfileDomainsOutput {
        return list_voice_profile_domains.execute(self, allocator, input, options);
    }

    /// Lists the voice profiles in a voice profile domain.
    pub fn listVoiceProfiles(self: *Self, allocator: std.mem.Allocator, input: list_voice_profiles.ListVoiceProfilesInput, options: list_voice_profiles.Options) !list_voice_profiles.ListVoiceProfilesOutput {
        return list_voice_profiles.execute(self, allocator, input, options);
    }

    /// Updates the Alexa Skill configuration for the SIP media application.
    ///
    /// Due to changes made by the Amazon Alexa service, this API is no longer
    /// available for use. For more information, refer to
    /// the [Alexa Smart
    /// Properties](https://developer.amazon.com/en-US/alexa/alexasmartproperties)
    /// page.
    pub fn putSipMediaApplicationAlexaSkillConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_sip_media_application_alexa_skill_configuration.PutSipMediaApplicationAlexaSkillConfigurationInput, options: put_sip_media_application_alexa_skill_configuration.Options) !put_sip_media_application_alexa_skill_configuration.PutSipMediaApplicationAlexaSkillConfigurationOutput {
        return put_sip_media_application_alexa_skill_configuration.execute(self, allocator, input, options);
    }

    /// Updates the logging configuration for the specified SIP media application.
    pub fn putSipMediaApplicationLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_sip_media_application_logging_configuration.PutSipMediaApplicationLoggingConfigurationInput, options: put_sip_media_application_logging_configuration.Options) !put_sip_media_application_logging_configuration.PutSipMediaApplicationLoggingConfigurationOutput {
        return put_sip_media_application_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates a Voice Connector's emergency calling configuration.
    pub fn putVoiceConnectorEmergencyCallingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_emergency_calling_configuration.PutVoiceConnectorEmergencyCallingConfigurationInput, options: put_voice_connector_emergency_calling_configuration.Options) !put_voice_connector_emergency_calling_configuration.PutVoiceConnectorEmergencyCallingConfigurationOutput {
        return put_voice_connector_emergency_calling_configuration.execute(self, allocator, input, options);
    }

    /// Adds an external systems configuration to a Voice Connector.
    pub fn putVoiceConnectorExternalSystemsConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_external_systems_configuration.PutVoiceConnectorExternalSystemsConfigurationInput, options: put_voice_connector_external_systems_configuration.Options) !put_voice_connector_external_systems_configuration.PutVoiceConnectorExternalSystemsConfigurationOutput {
        return put_voice_connector_external_systems_configuration.execute(self, allocator, input, options);
    }

    /// Updates a Voice Connector's logging configuration.
    pub fn putVoiceConnectorLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_logging_configuration.PutVoiceConnectorLoggingConfigurationInput, options: put_voice_connector_logging_configuration.Options) !put_voice_connector_logging_configuration.PutVoiceConnectorLoggingConfigurationOutput {
        return put_voice_connector_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates a Voice Connector's origination settings.
    pub fn putVoiceConnectorOrigination(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_origination.PutVoiceConnectorOriginationInput, options: put_voice_connector_origination.Options) !put_voice_connector_origination.PutVoiceConnectorOriginationOutput {
        return put_voice_connector_origination.execute(self, allocator, input, options);
    }

    /// Puts the specified proxy configuration to the specified Amazon Chime SDK
    /// Voice Connector.
    pub fn putVoiceConnectorProxy(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_proxy.PutVoiceConnectorProxyInput, options: put_voice_connector_proxy.Options) !put_voice_connector_proxy.PutVoiceConnectorProxyOutput {
        return put_voice_connector_proxy.execute(self, allocator, input, options);
    }

    /// Updates a Voice Connector's streaming configuration settings.
    pub fn putVoiceConnectorStreamingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_streaming_configuration.PutVoiceConnectorStreamingConfigurationInput, options: put_voice_connector_streaming_configuration.Options) !put_voice_connector_streaming_configuration.PutVoiceConnectorStreamingConfigurationOutput {
        return put_voice_connector_streaming_configuration.execute(self, allocator, input, options);
    }

    /// Updates a Voice Connector's termination settings.
    pub fn putVoiceConnectorTermination(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_termination.PutVoiceConnectorTerminationInput, options: put_voice_connector_termination.Options) !put_voice_connector_termination.PutVoiceConnectorTerminationOutput {
        return put_voice_connector_termination.execute(self, allocator, input, options);
    }

    /// Updates a Voice Connector's termination credentials.
    pub fn putVoiceConnectorTerminationCredentials(self: *Self, allocator: std.mem.Allocator, input: put_voice_connector_termination_credentials.PutVoiceConnectorTerminationCredentialsInput, options: put_voice_connector_termination_credentials.Options) !put_voice_connector_termination_credentials.PutVoiceConnectorTerminationCredentialsOutput {
        return put_voice_connector_termination_credentials.execute(self, allocator, input, options);
    }

    /// Restores a deleted phone number.
    pub fn restorePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: restore_phone_number.RestorePhoneNumberInput, options: restore_phone_number.Options) !restore_phone_number.RestorePhoneNumberOutput {
        return restore_phone_number.execute(self, allocator, input, options);
    }

    /// Searches the provisioned phone numbers in an organization.
    pub fn searchAvailablePhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: search_available_phone_numbers.SearchAvailablePhoneNumbersInput, options: search_available_phone_numbers.Options) !search_available_phone_numbers.SearchAvailablePhoneNumbersOutput {
        return search_available_phone_numbers.execute(self, allocator, input, options);
    }

    /// Starts a speaker search task.
    ///
    /// Before starting any speaker search tasks, you must provide all notices and
    /// obtain all consents from the speaker as required under applicable privacy
    /// and biometrics laws, and as required under the
    /// [AWS service terms](https://aws.amazon.com/service-terms/) for the Amazon
    /// Chime SDK.
    pub fn startSpeakerSearchTask(self: *Self, allocator: std.mem.Allocator, input: start_speaker_search_task.StartSpeakerSearchTaskInput, options: start_speaker_search_task.Options) !start_speaker_search_task.StartSpeakerSearchTaskOutput {
        return start_speaker_search_task.execute(self, allocator, input, options);
    }

    /// Starts a voice tone analysis task. For more information about voice tone
    /// analysis, see
    /// [Using Amazon Chime SDK voice
    /// analytics](https://docs.aws.amazon.com/chime-sdk/latest/dg/pstn-voice-analytics.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    ///
    /// Before starting any voice tone analysis tasks, you must provide all notices
    /// and obtain all consents from the speaker as required under applicable
    /// privacy and biometrics laws, and as required under the
    /// [AWS service terms](https://aws.amazon.com/service-terms/) for the Amazon
    /// Chime SDK.
    pub fn startVoiceToneAnalysisTask(self: *Self, allocator: std.mem.Allocator, input: start_voice_tone_analysis_task.StartVoiceToneAnalysisTaskInput, options: start_voice_tone_analysis_task.Options) !start_voice_tone_analysis_task.StartVoiceToneAnalysisTaskOutput {
        return start_voice_tone_analysis_task.execute(self, allocator, input, options);
    }

    /// Stops a speaker search task.
    pub fn stopSpeakerSearchTask(self: *Self, allocator: std.mem.Allocator, input: stop_speaker_search_task.StopSpeakerSearchTaskInput, options: stop_speaker_search_task.Options) !stop_speaker_search_task.StopSpeakerSearchTaskOutput {
        return stop_speaker_search_task.execute(self, allocator, input, options);
    }

    /// Stops a voice tone analysis task.
    pub fn stopVoiceToneAnalysisTask(self: *Self, allocator: std.mem.Allocator, input: stop_voice_tone_analysis_task.StopVoiceToneAnalysisTaskInput, options: stop_voice_tone_analysis_task.Options) !stop_voice_tone_analysis_task.StopVoiceToneAnalysisTaskOutput {
        return stop_voice_tone_analysis_task.execute(self, allocator, input, options);
    }

    /// Adds a tag to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates global settings for the Amazon Chime SDK Voice Connectors in an AWS
    /// account.
    pub fn updateGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: update_global_settings.UpdateGlobalSettingsInput, options: update_global_settings.Options) !update_global_settings.UpdateGlobalSettingsOutput {
        return update_global_settings.execute(self, allocator, input, options);
    }

    /// Updates phone number details, such as product type, calling name, or phone
    /// number name for the
    /// specified phone number ID. You can update one phone number detail at a time.
    /// For
    /// example, you can update either the product type, calling name, or phone
    /// number name in one action.
    ///
    /// For numbers outside the U.S., you must use the Amazon Chime SDK SIP Media
    /// Application Dial-In product type.
    ///
    /// Updates to outbound calling names can take 72 hours to complete. Pending
    /// updates to outbound calling names must be complete before you can request
    /// another
    /// update.
    pub fn updatePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: update_phone_number.UpdatePhoneNumberInput, options: update_phone_number.Options) !update_phone_number.UpdatePhoneNumberOutput {
        return update_phone_number.execute(self, allocator, input, options);
    }

    /// Updates the phone number settings for the administrator's AWS account, such
    /// as the default outbound calling name. You can update the default outbound
    /// calling
    /// name once every seven days. Outbound calling names can take up to 72 hours
    /// to
    /// update.
    pub fn updatePhoneNumberSettings(self: *Self, allocator: std.mem.Allocator, input: update_phone_number_settings.UpdatePhoneNumberSettingsInput, options: update_phone_number_settings.Options) !update_phone_number_settings.UpdatePhoneNumberSettingsOutput {
        return update_phone_number_settings.execute(self, allocator, input, options);
    }

    /// Updates the specified proxy session details, such as voice or SMS
    /// capabilities.
    pub fn updateProxySession(self: *Self, allocator: std.mem.Allocator, input: update_proxy_session.UpdateProxySessionInput, options: update_proxy_session.Options) !update_proxy_session.UpdateProxySessionOutput {
        return update_proxy_session.execute(self, allocator, input, options);
    }

    /// Updates the details of the specified SIP media application.
    pub fn updateSipMediaApplication(self: *Self, allocator: std.mem.Allocator, input: update_sip_media_application.UpdateSipMediaApplicationInput, options: update_sip_media_application.Options) !update_sip_media_application.UpdateSipMediaApplicationOutput {
        return update_sip_media_application.execute(self, allocator, input, options);
    }

    /// Invokes the AWS Lambda function associated with the SIP media application
    /// and
    /// transaction ID in an update request. The Lambda function can then return a
    /// new set
    /// of actions.
    pub fn updateSipMediaApplicationCall(self: *Self, allocator: std.mem.Allocator, input: update_sip_media_application_call.UpdateSipMediaApplicationCallInput, options: update_sip_media_application_call.Options) !update_sip_media_application_call.UpdateSipMediaApplicationCallOutput {
        return update_sip_media_application_call.execute(self, allocator, input, options);
    }

    /// Updates the details of the specified SIP rule.
    pub fn updateSipRule(self: *Self, allocator: std.mem.Allocator, input: update_sip_rule.UpdateSipRuleInput, options: update_sip_rule.Options) !update_sip_rule.UpdateSipRuleOutput {
        return update_sip_rule.execute(self, allocator, input, options);
    }

    /// Updates the details for the specified Amazon Chime SDK Voice Connector.
    pub fn updateVoiceConnector(self: *Self, allocator: std.mem.Allocator, input: update_voice_connector.UpdateVoiceConnectorInput, options: update_voice_connector.Options) !update_voice_connector.UpdateVoiceConnectorOutput {
        return update_voice_connector.execute(self, allocator, input, options);
    }

    /// Updates the settings for the specified Amazon Chime SDK Voice Connector
    /// group.
    pub fn updateVoiceConnectorGroup(self: *Self, allocator: std.mem.Allocator, input: update_voice_connector_group.UpdateVoiceConnectorGroupInput, options: update_voice_connector_group.Options) !update_voice_connector_group.UpdateVoiceConnectorGroupOutput {
        return update_voice_connector_group.execute(self, allocator, input, options);
    }

    /// Updates the specified voice profile’s voice print and refreshes its
    /// expiration timestamp.
    ///
    /// As a condition of using this feature, you acknowledge that the collection,
    /// use, storage, and retention of
    /// your caller’s biometric identifiers and biometric information (“biometric
    /// data”) in the form of a digital voiceprint
    /// requires the caller’s informed consent via a written release. Such consent
    /// is required under various state laws,
    /// including biometrics laws in Illinois, Texas, Washington and other state
    /// privacy laws.
    ///
    /// You must provide a written release to each caller through a process that
    /// clearly reflects each caller’s informed
    /// consent before using Amazon Chime SDK Voice Insights service, as required
    /// under the terms of your agreement
    /// with AWS governing your use of the service.
    pub fn updateVoiceProfile(self: *Self, allocator: std.mem.Allocator, input: update_voice_profile.UpdateVoiceProfileInput, options: update_voice_profile.Options) !update_voice_profile.UpdateVoiceProfileOutput {
        return update_voice_profile.execute(self, allocator, input, options);
    }

    /// Updates the settings for the specified voice profile domain.
    pub fn updateVoiceProfileDomain(self: *Self, allocator: std.mem.Allocator, input: update_voice_profile_domain.UpdateVoiceProfileDomainInput, options: update_voice_profile_domain.Options) !update_voice_profile_domain.UpdateVoiceProfileDomainOutput {
        return update_voice_profile_domain.execute(self, allocator, input, options);
    }

    /// Validates an address to be used for 911 calls made with Amazon Chime SDK
    /// Voice
    /// Connectors. You can use validated addresses in a Presence Information Data
    /// Format
    /// Location Object file that you include in SIP requests. That helps ensure
    /// that addresses
    /// are routed to the appropriate Public Safety Answering Point.
    pub fn validateE911Address(self: *Self, allocator: std.mem.Allocator, input: validate_e911_address.ValidateE911AddressInput, options: validate_e911_address.Options) !validate_e911_address.ValidateE911AddressOutput {
        return validate_e911_address.execute(self, allocator, input, options);
    }

    pub fn listPhoneNumberOrdersPaginator(self: *Self, params: list_phone_number_orders.ListPhoneNumberOrdersInput) paginator.ListPhoneNumberOrdersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPhoneNumbersPaginator(self: *Self, params: list_phone_numbers.ListPhoneNumbersInput) paginator.ListPhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProxySessionsPaginator(self: *Self, params: list_proxy_sessions.ListProxySessionsInput) paginator.ListProxySessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSipMediaApplicationsPaginator(self: *Self, params: list_sip_media_applications.ListSipMediaApplicationsInput) paginator.ListSipMediaApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSipRulesPaginator(self: *Self, params: list_sip_rules.ListSipRulesInput) paginator.ListSipRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVoiceConnectorGroupsPaginator(self: *Self, params: list_voice_connector_groups.ListVoiceConnectorGroupsInput) paginator.ListVoiceConnectorGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVoiceConnectorsPaginator(self: *Self, params: list_voice_connectors.ListVoiceConnectorsInput) paginator.ListVoiceConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVoiceProfileDomainsPaginator(self: *Self, params: list_voice_profile_domains.ListVoiceProfileDomainsInput) paginator.ListVoiceProfileDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVoiceProfilesPaginator(self: *Self, params: list_voice_profiles.ListVoiceProfilesInput) paginator.ListVoiceProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchAvailablePhoneNumbersPaginator(self: *Self, params: search_available_phone_numbers.SearchAvailablePhoneNumbersInput) paginator.SearchAvailablePhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
