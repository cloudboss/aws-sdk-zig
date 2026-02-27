const aws = @import("aws");
const std = @import("std");

const create_app = @import("create_app.zig");
const create_campaign = @import("create_campaign.zig");
const create_email_template = @import("create_email_template.zig");
const create_export_job = @import("create_export_job.zig");
const create_import_job = @import("create_import_job.zig");
const create_in_app_template = @import("create_in_app_template.zig");
const create_journey = @import("create_journey.zig");
const create_push_template = @import("create_push_template.zig");
const create_recommender_configuration = @import("create_recommender_configuration.zig");
const create_segment = @import("create_segment.zig");
const create_sms_template = @import("create_sms_template.zig");
const create_voice_template = @import("create_voice_template.zig");
const delete_adm_channel = @import("delete_adm_channel.zig");
const delete_apns_channel = @import("delete_apns_channel.zig");
const delete_apns_sandbox_channel = @import("delete_apns_sandbox_channel.zig");
const delete_apns_voip_channel = @import("delete_apns_voip_channel.zig");
const delete_apns_voip_sandbox_channel = @import("delete_apns_voip_sandbox_channel.zig");
const delete_app = @import("delete_app.zig");
const delete_baidu_channel = @import("delete_baidu_channel.zig");
const delete_campaign = @import("delete_campaign.zig");
const delete_email_channel = @import("delete_email_channel.zig");
const delete_email_template = @import("delete_email_template.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const delete_event_stream = @import("delete_event_stream.zig");
const delete_gcm_channel = @import("delete_gcm_channel.zig");
const delete_in_app_template = @import("delete_in_app_template.zig");
const delete_journey = @import("delete_journey.zig");
const delete_push_template = @import("delete_push_template.zig");
const delete_recommender_configuration = @import("delete_recommender_configuration.zig");
const delete_segment = @import("delete_segment.zig");
const delete_sms_channel = @import("delete_sms_channel.zig");
const delete_sms_template = @import("delete_sms_template.zig");
const delete_user_endpoints = @import("delete_user_endpoints.zig");
const delete_voice_channel = @import("delete_voice_channel.zig");
const delete_voice_template = @import("delete_voice_template.zig");
const get_adm_channel = @import("get_adm_channel.zig");
const get_apns_channel = @import("get_apns_channel.zig");
const get_apns_sandbox_channel = @import("get_apns_sandbox_channel.zig");
const get_apns_voip_channel = @import("get_apns_voip_channel.zig");
const get_apns_voip_sandbox_channel = @import("get_apns_voip_sandbox_channel.zig");
const get_app = @import("get_app.zig");
const get_application_date_range_kpi = @import("get_application_date_range_kpi.zig");
const get_application_settings = @import("get_application_settings.zig");
const get_apps = @import("get_apps.zig");
const get_baidu_channel = @import("get_baidu_channel.zig");
const get_campaign = @import("get_campaign.zig");
const get_campaign_activities = @import("get_campaign_activities.zig");
const get_campaign_date_range_kpi = @import("get_campaign_date_range_kpi.zig");
const get_campaign_version = @import("get_campaign_version.zig");
const get_campaign_versions = @import("get_campaign_versions.zig");
const get_campaigns = @import("get_campaigns.zig");
const get_channels = @import("get_channels.zig");
const get_email_channel = @import("get_email_channel.zig");
const get_email_template = @import("get_email_template.zig");
const get_endpoint = @import("get_endpoint.zig");
const get_event_stream = @import("get_event_stream.zig");
const get_export_job = @import("get_export_job.zig");
const get_export_jobs = @import("get_export_jobs.zig");
const get_gcm_channel = @import("get_gcm_channel.zig");
const get_import_job = @import("get_import_job.zig");
const get_import_jobs = @import("get_import_jobs.zig");
const get_in_app_messages = @import("get_in_app_messages.zig");
const get_in_app_template = @import("get_in_app_template.zig");
const get_journey = @import("get_journey.zig");
const get_journey_date_range_kpi = @import("get_journey_date_range_kpi.zig");
const get_journey_execution_activity_metrics = @import("get_journey_execution_activity_metrics.zig");
const get_journey_execution_metrics = @import("get_journey_execution_metrics.zig");
const get_journey_run_execution_activity_metrics = @import("get_journey_run_execution_activity_metrics.zig");
const get_journey_run_execution_metrics = @import("get_journey_run_execution_metrics.zig");
const get_journey_runs = @import("get_journey_runs.zig");
const get_push_template = @import("get_push_template.zig");
const get_recommender_configuration = @import("get_recommender_configuration.zig");
const get_recommender_configurations = @import("get_recommender_configurations.zig");
const get_segment = @import("get_segment.zig");
const get_segment_export_jobs = @import("get_segment_export_jobs.zig");
const get_segment_import_jobs = @import("get_segment_import_jobs.zig");
const get_segment_version = @import("get_segment_version.zig");
const get_segment_versions = @import("get_segment_versions.zig");
const get_segments = @import("get_segments.zig");
const get_sms_channel = @import("get_sms_channel.zig");
const get_sms_template = @import("get_sms_template.zig");
const get_user_endpoints = @import("get_user_endpoints.zig");
const get_voice_channel = @import("get_voice_channel.zig");
const get_voice_template = @import("get_voice_template.zig");
const list_journeys = @import("list_journeys.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_versions = @import("list_template_versions.zig");
const list_templates = @import("list_templates.zig");
const phone_number_validate = @import("phone_number_validate.zig");
const put_event_stream = @import("put_event_stream.zig");
const put_events = @import("put_events.zig");
const remove_attributes = @import("remove_attributes.zig");
const send_messages = @import("send_messages.zig");
const send_otp_message = @import("send_otp_message.zig");
const send_users_messages = @import("send_users_messages.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_adm_channel = @import("update_adm_channel.zig");
const update_apns_channel = @import("update_apns_channel.zig");
const update_apns_sandbox_channel = @import("update_apns_sandbox_channel.zig");
const update_apns_voip_channel = @import("update_apns_voip_channel.zig");
const update_apns_voip_sandbox_channel = @import("update_apns_voip_sandbox_channel.zig");
const update_application_settings = @import("update_application_settings.zig");
const update_baidu_channel = @import("update_baidu_channel.zig");
const update_campaign = @import("update_campaign.zig");
const update_email_channel = @import("update_email_channel.zig");
const update_email_template = @import("update_email_template.zig");
const update_endpoint = @import("update_endpoint.zig");
const update_endpoints_batch = @import("update_endpoints_batch.zig");
const update_gcm_channel = @import("update_gcm_channel.zig");
const update_in_app_template = @import("update_in_app_template.zig");
const update_journey = @import("update_journey.zig");
const update_journey_state = @import("update_journey_state.zig");
const update_push_template = @import("update_push_template.zig");
const update_recommender_configuration = @import("update_recommender_configuration.zig");
const update_segment = @import("update_segment.zig");
const update_sms_channel = @import("update_sms_channel.zig");
const update_sms_template = @import("update_sms_template.zig");
const update_template_active_version = @import("update_template_active_version.zig");
const update_voice_channel = @import("update_voice_channel.zig");
const update_voice_template = @import("update_voice_template.zig");
const verify_otp_message = @import("verify_otp_message.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pinpoint";

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

    /// Creates an application.
    pub fn createApp(self: *Self, allocator: std.mem.Allocator, input: create_app.CreateAppInput, options: create_app.Options) !create_app.CreateAppOutput {
        return create_app.execute(self, allocator, input, options);
    }

    /// Creates a new campaign for an application or updates the settings of an
    /// existing campaign for an application.
    pub fn createCampaign(self: *Self, allocator: std.mem.Allocator, input: create_campaign.CreateCampaignInput, options: create_campaign.Options) !create_campaign.CreateCampaignOutput {
        return create_campaign.execute(self, allocator, input, options);
    }

    /// Creates a message template for messages that are sent through the email
    /// channel.
    pub fn createEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: create_email_template.CreateEmailTemplateInput, options: create_email_template.Options) !create_email_template.CreateEmailTemplateOutput {
        return create_email_template.execute(self, allocator, input, options);
    }

    /// Creates an export job for an application.
    pub fn createExportJob(self: *Self, allocator: std.mem.Allocator, input: create_export_job.CreateExportJobInput, options: create_export_job.Options) !create_export_job.CreateExportJobOutput {
        return create_export_job.execute(self, allocator, input, options);
    }

    /// Creates an import job for an application.
    pub fn createImportJob(self: *Self, allocator: std.mem.Allocator, input: create_import_job.CreateImportJobInput, options: create_import_job.Options) !create_import_job.CreateImportJobOutput {
        return create_import_job.execute(self, allocator, input, options);
    }

    /// Creates a new message template for messages using the in-app message
    /// channel.
    pub fn createInAppTemplate(self: *Self, allocator: std.mem.Allocator, input: create_in_app_template.CreateInAppTemplateInput, options: create_in_app_template.Options) !create_in_app_template.CreateInAppTemplateOutput {
        return create_in_app_template.execute(self, allocator, input, options);
    }

    /// Creates a journey for an application.
    pub fn createJourney(self: *Self, allocator: std.mem.Allocator, input: create_journey.CreateJourneyInput, options: create_journey.Options) !create_journey.CreateJourneyOutput {
        return create_journey.execute(self, allocator, input, options);
    }

    /// Creates a message template for messages that are sent through a push
    /// notification channel.
    pub fn createPushTemplate(self: *Self, allocator: std.mem.Allocator, input: create_push_template.CreatePushTemplateInput, options: create_push_template.Options) !create_push_template.CreatePushTemplateOutput {
        return create_push_template.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Pinpoint configuration for a recommender model.
    pub fn createRecommenderConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_recommender_configuration.CreateRecommenderConfigurationInput, options: create_recommender_configuration.Options) !create_recommender_configuration.CreateRecommenderConfigurationOutput {
        return create_recommender_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new segment for an application or updates the configuration,
    /// dimension, and other settings for an existing segment that's associated with
    /// an application.
    pub fn createSegment(self: *Self, allocator: std.mem.Allocator, input: create_segment.CreateSegmentInput, options: create_segment.Options) !create_segment.CreateSegmentOutput {
        return create_segment.execute(self, allocator, input, options);
    }

    /// Creates a message template for messages that are sent through the SMS
    /// channel.
    pub fn createSmsTemplate(self: *Self, allocator: std.mem.Allocator, input: create_sms_template.CreateSmsTemplateInput, options: create_sms_template.Options) !create_sms_template.CreateSmsTemplateOutput {
        return create_sms_template.execute(self, allocator, input, options);
    }

    /// Creates a message template for messages that are sent through the voice
    /// channel.
    pub fn createVoiceTemplate(self: *Self, allocator: std.mem.Allocator, input: create_voice_template.CreateVoiceTemplateInput, options: create_voice_template.Options) !create_voice_template.CreateVoiceTemplateOutput {
        return create_voice_template.execute(self, allocator, input, options);
    }

    /// Disables the ADM channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteAdmChannel(self: *Self, allocator: std.mem.Allocator, input: delete_adm_channel.DeleteAdmChannelInput, options: delete_adm_channel.Options) !delete_adm_channel.DeleteAdmChannelOutput {
        return delete_adm_channel.execute(self, allocator, input, options);
    }

    /// Disables the APNs channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteApnsChannel(self: *Self, allocator: std.mem.Allocator, input: delete_apns_channel.DeleteApnsChannelInput, options: delete_apns_channel.Options) !delete_apns_channel.DeleteApnsChannelOutput {
        return delete_apns_channel.execute(self, allocator, input, options);
    }

    /// Disables the APNs sandbox channel for an application and deletes any
    /// existing settings for the channel.
    pub fn deleteApnsSandboxChannel(self: *Self, allocator: std.mem.Allocator, input: delete_apns_sandbox_channel.DeleteApnsSandboxChannelInput, options: delete_apns_sandbox_channel.Options) !delete_apns_sandbox_channel.DeleteApnsSandboxChannelOutput {
        return delete_apns_sandbox_channel.execute(self, allocator, input, options);
    }

    /// Disables the APNs VoIP channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteApnsVoipChannel(self: *Self, allocator: std.mem.Allocator, input: delete_apns_voip_channel.DeleteApnsVoipChannelInput, options: delete_apns_voip_channel.Options) !delete_apns_voip_channel.DeleteApnsVoipChannelOutput {
        return delete_apns_voip_channel.execute(self, allocator, input, options);
    }

    /// Disables the APNs VoIP sandbox channel for an application and deletes any
    /// existing settings for the channel.
    pub fn deleteApnsVoipSandboxChannel(self: *Self, allocator: std.mem.Allocator, input: delete_apns_voip_sandbox_channel.DeleteApnsVoipSandboxChannelInput, options: delete_apns_voip_sandbox_channel.Options) !delete_apns_voip_sandbox_channel.DeleteApnsVoipSandboxChannelOutput {
        return delete_apns_voip_sandbox_channel.execute(self, allocator, input, options);
    }

    /// Deletes an application.
    pub fn deleteApp(self: *Self, allocator: std.mem.Allocator, input: delete_app.DeleteAppInput, options: delete_app.Options) !delete_app.DeleteAppOutput {
        return delete_app.execute(self, allocator, input, options);
    }

    /// Disables the Baidu channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteBaiduChannel(self: *Self, allocator: std.mem.Allocator, input: delete_baidu_channel.DeleteBaiduChannelInput, options: delete_baidu_channel.Options) !delete_baidu_channel.DeleteBaiduChannelOutput {
        return delete_baidu_channel.execute(self, allocator, input, options);
    }

    /// Deletes a campaign from an application.
    pub fn deleteCampaign(self: *Self, allocator: std.mem.Allocator, input: delete_campaign.DeleteCampaignInput, options: delete_campaign.Options) !delete_campaign.DeleteCampaignOutput {
        return delete_campaign.execute(self, allocator, input, options);
    }

    /// Disables the email channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteEmailChannel(self: *Self, allocator: std.mem.Allocator, input: delete_email_channel.DeleteEmailChannelInput, options: delete_email_channel.Options) !delete_email_channel.DeleteEmailChannelOutput {
        return delete_email_channel.execute(self, allocator, input, options);
    }

    /// Deletes a message template for messages that were sent through the email
    /// channel.
    pub fn deleteEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_email_template.DeleteEmailTemplateInput, options: delete_email_template.Options) !delete_email_template.DeleteEmailTemplateOutput {
        return delete_email_template.execute(self, allocator, input, options);
    }

    /// Deletes an endpoint from an application.
    pub fn deleteEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint.DeleteEndpointInput, options: delete_endpoint.Options) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the event stream for an application.
    pub fn deleteEventStream(self: *Self, allocator: std.mem.Allocator, input: delete_event_stream.DeleteEventStreamInput, options: delete_event_stream.Options) !delete_event_stream.DeleteEventStreamOutput {
        return delete_event_stream.execute(self, allocator, input, options);
    }

    /// Disables the GCM channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteGcmChannel(self: *Self, allocator: std.mem.Allocator, input: delete_gcm_channel.DeleteGcmChannelInput, options: delete_gcm_channel.Options) !delete_gcm_channel.DeleteGcmChannelOutput {
        return delete_gcm_channel.execute(self, allocator, input, options);
    }

    /// Deletes a message template for messages sent using the in-app message
    /// channel.
    pub fn deleteInAppTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_in_app_template.DeleteInAppTemplateInput, options: delete_in_app_template.Options) !delete_in_app_template.DeleteInAppTemplateOutput {
        return delete_in_app_template.execute(self, allocator, input, options);
    }

    /// Deletes a journey from an application.
    pub fn deleteJourney(self: *Self, allocator: std.mem.Allocator, input: delete_journey.DeleteJourneyInput, options: delete_journey.Options) !delete_journey.DeleteJourneyOutput {
        return delete_journey.execute(self, allocator, input, options);
    }

    /// Deletes a message template for messages that were sent through a push
    /// notification channel.
    pub fn deletePushTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_push_template.DeletePushTemplateInput, options: delete_push_template.Options) !delete_push_template.DeletePushTemplateOutput {
        return delete_push_template.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Pinpoint configuration for a recommender model.
    pub fn deleteRecommenderConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_recommender_configuration.DeleteRecommenderConfigurationInput, options: delete_recommender_configuration.Options) !delete_recommender_configuration.DeleteRecommenderConfigurationOutput {
        return delete_recommender_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a segment from an application.
    pub fn deleteSegment(self: *Self, allocator: std.mem.Allocator, input: delete_segment.DeleteSegmentInput, options: delete_segment.Options) !delete_segment.DeleteSegmentOutput {
        return delete_segment.execute(self, allocator, input, options);
    }

    /// Disables the SMS channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteSmsChannel(self: *Self, allocator: std.mem.Allocator, input: delete_sms_channel.DeleteSmsChannelInput, options: delete_sms_channel.Options) !delete_sms_channel.DeleteSmsChannelOutput {
        return delete_sms_channel.execute(self, allocator, input, options);
    }

    /// Deletes a message template for messages that were sent through the SMS
    /// channel.
    pub fn deleteSmsTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_sms_template.DeleteSmsTemplateInput, options: delete_sms_template.Options) !delete_sms_template.DeleteSmsTemplateOutput {
        return delete_sms_template.execute(self, allocator, input, options);
    }

    /// Deletes all the endpoints that are associated with a specific user ID.
    pub fn deleteUserEndpoints(self: *Self, allocator: std.mem.Allocator, input: delete_user_endpoints.DeleteUserEndpointsInput, options: delete_user_endpoints.Options) !delete_user_endpoints.DeleteUserEndpointsOutput {
        return delete_user_endpoints.execute(self, allocator, input, options);
    }

    /// Disables the voice channel for an application and deletes any existing
    /// settings for the channel.
    pub fn deleteVoiceChannel(self: *Self, allocator: std.mem.Allocator, input: delete_voice_channel.DeleteVoiceChannelInput, options: delete_voice_channel.Options) !delete_voice_channel.DeleteVoiceChannelOutput {
        return delete_voice_channel.execute(self, allocator, input, options);
    }

    /// Deletes a message template for messages that were sent through the voice
    /// channel.
    pub fn deleteVoiceTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_voice_template.DeleteVoiceTemplateInput, options: delete_voice_template.Options) !delete_voice_template.DeleteVoiceTemplateOutput {
        return delete_voice_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the ADM channel for
    /// an application.
    pub fn getAdmChannel(self: *Self, allocator: std.mem.Allocator, input: get_adm_channel.GetAdmChannelInput, options: get_adm_channel.Options) !get_adm_channel.GetAdmChannelOutput {
        return get_adm_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the APNs channel for
    /// an application.
    pub fn getApnsChannel(self: *Self, allocator: std.mem.Allocator, input: get_apns_channel.GetApnsChannelInput, options: get_apns_channel.Options) !get_apns_channel.GetApnsChannelOutput {
        return get_apns_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the APNs sandbox
    /// channel for an application.
    pub fn getApnsSandboxChannel(self: *Self, allocator: std.mem.Allocator, input: get_apns_sandbox_channel.GetApnsSandboxChannelInput, options: get_apns_sandbox_channel.Options) !get_apns_sandbox_channel.GetApnsSandboxChannelOutput {
        return get_apns_sandbox_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the APNs VoIP channel
    /// for an application.
    pub fn getApnsVoipChannel(self: *Self, allocator: std.mem.Allocator, input: get_apns_voip_channel.GetApnsVoipChannelInput, options: get_apns_voip_channel.Options) !get_apns_voip_channel.GetApnsVoipChannelOutput {
        return get_apns_voip_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the APNs VoIP sandbox
    /// channel for an application.
    pub fn getApnsVoipSandboxChannel(self: *Self, allocator: std.mem.Allocator, input: get_apns_voip_sandbox_channel.GetApnsVoipSandboxChannelInput, options: get_apns_voip_sandbox_channel.Options) !get_apns_voip_sandbox_channel.GetApnsVoipSandboxChannelOutput {
        return get_apns_voip_sandbox_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about an application.
    pub fn getApp(self: *Self, allocator: std.mem.Allocator, input: get_app.GetAppInput, options: get_app.Options) !get_app.GetAppOutput {
        return get_app.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard metric that applies
    /// to an application.
    pub fn getApplicationDateRangeKpi(self: *Self, allocator: std.mem.Allocator, input: get_application_date_range_kpi.GetApplicationDateRangeKpiInput, options: get_application_date_range_kpi.Options) !get_application_date_range_kpi.GetApplicationDateRangeKpiOutput {
        return get_application_date_range_kpi.execute(self, allocator, input, options);
    }

    /// Retrieves information about the settings for an application.
    pub fn getApplicationSettings(self: *Self, allocator: std.mem.Allocator, input: get_application_settings.GetApplicationSettingsInput, options: get_application_settings.Options) !get_application_settings.GetApplicationSettingsOutput {
        return get_application_settings.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the applications that are associated with
    /// your Amazon Pinpoint account.
    pub fn getApps(self: *Self, allocator: std.mem.Allocator, input: get_apps.GetAppsInput, options: get_apps.Options) !get_apps.GetAppsOutput {
        return get_apps.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the Baidu channel for
    /// an application.
    pub fn getBaiduChannel(self: *Self, allocator: std.mem.Allocator, input: get_baidu_channel.GetBaiduChannelInput, options: get_baidu_channel.Options) !get_baidu_channel.GetBaiduChannelOutput {
        return get_baidu_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status, configuration, and other settings
    /// for a campaign.
    pub fn getCampaign(self: *Self, allocator: std.mem.Allocator, input: get_campaign.GetCampaignInput, options: get_campaign.Options) !get_campaign.GetCampaignOutput {
        return get_campaign.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the activities for a campaign.
    pub fn getCampaignActivities(self: *Self, allocator: std.mem.Allocator, input: get_campaign_activities.GetCampaignActivitiesInput, options: get_campaign_activities.Options) !get_campaign_activities.GetCampaignActivitiesOutput {
        return get_campaign_activities.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard metric that applies
    /// to a campaign.
    pub fn getCampaignDateRangeKpi(self: *Self, allocator: std.mem.Allocator, input: get_campaign_date_range_kpi.GetCampaignDateRangeKpiInput, options: get_campaign_date_range_kpi.Options) !get_campaign_date_range_kpi.GetCampaignDateRangeKpiOutput {
        return get_campaign_date_range_kpi.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status, configuration, and other settings
    /// for a specific version of a campaign.
    pub fn getCampaignVersion(self: *Self, allocator: std.mem.Allocator, input: get_campaign_version.GetCampaignVersionInput, options: get_campaign_version.Options) !get_campaign_version.GetCampaignVersionOutput {
        return get_campaign_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status, configuration, and other settings
    /// for all versions of a campaign.
    pub fn getCampaignVersions(self: *Self, allocator: std.mem.Allocator, input: get_campaign_versions.GetCampaignVersionsInput, options: get_campaign_versions.Options) !get_campaign_versions.GetCampaignVersionsOutput {
        return get_campaign_versions.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status, configuration, and other settings
    /// for all the campaigns that are associated with an application.
    pub fn getCampaigns(self: *Self, allocator: std.mem.Allocator, input: get_campaigns.GetCampaignsInput, options: get_campaigns.Options) !get_campaigns.GetCampaignsOutput {
        return get_campaigns.execute(self, allocator, input, options);
    }

    /// Retrieves information about the history and status of each channel for an
    /// application.
    pub fn getChannels(self: *Self, allocator: std.mem.Allocator, input: get_channels.GetChannelsInput, options: get_channels.Options) !get_channels.GetChannelsOutput {
        return get_channels.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the email channel for
    /// an application.
    pub fn getEmailChannel(self: *Self, allocator: std.mem.Allocator, input: get_email_channel.GetEmailChannelInput, options: get_email_channel.Options) !get_email_channel.GetEmailChannelOutput {
        return get_email_channel.execute(self, allocator, input, options);
    }

    /// Retrieves the content and settings of a message template for messages that
    /// are sent through the email channel.
    pub fn getEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: get_email_template.GetEmailTemplateInput, options: get_email_template.Options) !get_email_template.GetEmailTemplateOutput {
        return get_email_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about the settings and attributes of a specific
    /// endpoint for an application.
    pub fn getEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_endpoint.GetEndpointInput, options: get_endpoint.Options) !get_endpoint.GetEndpointOutput {
        return get_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves information about the event stream settings for an application.
    pub fn getEventStream(self: *Self, allocator: std.mem.Allocator, input: get_event_stream.GetEventStreamInput, options: get_event_stream.Options) !get_event_stream.GetEventStreamOutput {
        return get_event_stream.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of a specific export job
    /// for an application.
    pub fn getExportJob(self: *Self, allocator: std.mem.Allocator, input: get_export_job.GetExportJobInput, options: get_export_job.Options) !get_export_job.GetExportJobOutput {
        return get_export_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of all the export jobs
    /// for an application.
    pub fn getExportJobs(self: *Self, allocator: std.mem.Allocator, input: get_export_jobs.GetExportJobsInput, options: get_export_jobs.Options) !get_export_jobs.GetExportJobsOutput {
        return get_export_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the GCM channel for
    /// an application.
    pub fn getGcmChannel(self: *Self, allocator: std.mem.Allocator, input: get_gcm_channel.GetGcmChannelInput, options: get_gcm_channel.Options) !get_gcm_channel.GetGcmChannelOutput {
        return get_gcm_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of a specific import job
    /// for an application.
    pub fn getImportJob(self: *Self, allocator: std.mem.Allocator, input: get_import_job.GetImportJobInput, options: get_import_job.Options) !get_import_job.GetImportJobOutput {
        return get_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of all the import jobs
    /// for an application.
    pub fn getImportJobs(self: *Self, allocator: std.mem.Allocator, input: get_import_jobs.GetImportJobsInput, options: get_import_jobs.Options) !get_import_jobs.GetImportJobsOutput {
        return get_import_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves the in-app messages targeted for the provided endpoint ID.
    pub fn getInAppMessages(self: *Self, allocator: std.mem.Allocator, input: get_in_app_messages.GetInAppMessagesInput, options: get_in_app_messages.Options) !get_in_app_messages.GetInAppMessagesOutput {
        return get_in_app_messages.execute(self, allocator, input, options);
    }

    /// Retrieves the content and settings of a message template for messages sent
    /// through the in-app channel.
    pub fn getInAppTemplate(self: *Self, allocator: std.mem.Allocator, input: get_in_app_template.GetInAppTemplateInput, options: get_in_app_template.Options) !get_in_app_template.GetInAppTemplateOutput {
        return get_in_app_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status, configuration, and other settings
    /// for a journey.
    pub fn getJourney(self: *Self, allocator: std.mem.Allocator, input: get_journey.GetJourneyInput, options: get_journey.Options) !get_journey.GetJourneyOutput {
        return get_journey.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard engagement metric
    /// that applies to a journey.
    pub fn getJourneyDateRangeKpi(self: *Self, allocator: std.mem.Allocator, input: get_journey_date_range_kpi.GetJourneyDateRangeKpiInput, options: get_journey_date_range_kpi.Options) !get_journey_date_range_kpi.GetJourneyDateRangeKpiOutput {
        return get_journey_date_range_kpi.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard execution metric that
    /// applies to a journey activity.
    pub fn getJourneyExecutionActivityMetrics(self: *Self, allocator: std.mem.Allocator, input: get_journey_execution_activity_metrics.GetJourneyExecutionActivityMetricsInput, options: get_journey_execution_activity_metrics.Options) !get_journey_execution_activity_metrics.GetJourneyExecutionActivityMetricsOutput {
        return get_journey_execution_activity_metrics.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard execution metric that
    /// applies to a journey.
    pub fn getJourneyExecutionMetrics(self: *Self, allocator: std.mem.Allocator, input: get_journey_execution_metrics.GetJourneyExecutionMetricsInput, options: get_journey_execution_metrics.Options) !get_journey_execution_metrics.GetJourneyExecutionMetricsOutput {
        return get_journey_execution_metrics.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard run execution metric
    /// that applies to a journey activity.
    pub fn getJourneyRunExecutionActivityMetrics(self: *Self, allocator: std.mem.Allocator, input: get_journey_run_execution_activity_metrics.GetJourneyRunExecutionActivityMetricsInput, options: get_journey_run_execution_activity_metrics.Options) !get_journey_run_execution_activity_metrics.GetJourneyRunExecutionActivityMetricsOutput {
        return get_journey_run_execution_activity_metrics.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) pre-aggregated data for a standard run execution metric
    /// that applies to a journey.
    pub fn getJourneyRunExecutionMetrics(self: *Self, allocator: std.mem.Allocator, input: get_journey_run_execution_metrics.GetJourneyRunExecutionMetricsInput, options: get_journey_run_execution_metrics.Options) !get_journey_run_execution_metrics.GetJourneyRunExecutionMetricsOutput {
        return get_journey_run_execution_metrics.execute(self, allocator, input, options);
    }

    /// Provides information about the runs of a journey.
    pub fn getJourneyRuns(self: *Self, allocator: std.mem.Allocator, input: get_journey_runs.GetJourneyRunsInput, options: get_journey_runs.Options) !get_journey_runs.GetJourneyRunsOutput {
        return get_journey_runs.execute(self, allocator, input, options);
    }

    /// Retrieves the content and settings of a message template for messages that
    /// are sent through a push notification channel.
    pub fn getPushTemplate(self: *Self, allocator: std.mem.Allocator, input: get_push_template.GetPushTemplateInput, options: get_push_template.Options) !get_push_template.GetPushTemplateOutput {
        return get_push_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about an Amazon Pinpoint configuration for a
    /// recommender model.
    pub fn getRecommenderConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_recommender_configuration.GetRecommenderConfigurationInput, options: get_recommender_configuration.Options) !get_recommender_configuration.GetRecommenderConfigurationOutput {
        return get_recommender_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the recommender model configurations that
    /// are associated with your Amazon Pinpoint account.
    pub fn getRecommenderConfigurations(self: *Self, allocator: std.mem.Allocator, input: get_recommender_configurations.GetRecommenderConfigurationsInput, options: get_recommender_configurations.Options) !get_recommender_configurations.GetRecommenderConfigurationsOutput {
        return get_recommender_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves information about the configuration, dimension, and other settings
    /// for a specific segment that's associated with an application.
    pub fn getSegment(self: *Self, allocator: std.mem.Allocator, input: get_segment.GetSegmentInput, options: get_segment.Options) !get_segment.GetSegmentOutput {
        return get_segment.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the export jobs for a
    /// segment.
    pub fn getSegmentExportJobs(self: *Self, allocator: std.mem.Allocator, input: get_segment_export_jobs.GetSegmentExportJobsInput, options: get_segment_export_jobs.Options) !get_segment_export_jobs.GetSegmentExportJobsOutput {
        return get_segment_export_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the import jobs for a
    /// segment.
    pub fn getSegmentImportJobs(self: *Self, allocator: std.mem.Allocator, input: get_segment_import_jobs.GetSegmentImportJobsInput, options: get_segment_import_jobs.Options) !get_segment_import_jobs.GetSegmentImportJobsOutput {
        return get_segment_import_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves information about the configuration, dimension, and other settings
    /// for a specific version of a segment that's associated with an application.
    pub fn getSegmentVersion(self: *Self, allocator: std.mem.Allocator, input: get_segment_version.GetSegmentVersionInput, options: get_segment_version.Options) !get_segment_version.GetSegmentVersionOutput {
        return get_segment_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about the configuration, dimension, and other settings
    /// for all the versions of a specific segment that's associated with an
    /// application.
    pub fn getSegmentVersions(self: *Self, allocator: std.mem.Allocator, input: get_segment_versions.GetSegmentVersionsInput, options: get_segment_versions.Options) !get_segment_versions.GetSegmentVersionsOutput {
        return get_segment_versions.execute(self, allocator, input, options);
    }

    /// Retrieves information about the configuration, dimension, and other settings
    /// for all the segments that are associated with an application.
    pub fn getSegments(self: *Self, allocator: std.mem.Allocator, input: get_segments.GetSegmentsInput, options: get_segments.Options) !get_segments.GetSegmentsOutput {
        return get_segments.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the SMS channel for
    /// an application.
    pub fn getSmsChannel(self: *Self, allocator: std.mem.Allocator, input: get_sms_channel.GetSmsChannelInput, options: get_sms_channel.Options) !get_sms_channel.GetSmsChannelOutput {
        return get_sms_channel.execute(self, allocator, input, options);
    }

    /// Retrieves the content and settings of a message template for messages that
    /// are sent through the SMS channel.
    pub fn getSmsTemplate(self: *Self, allocator: std.mem.Allocator, input: get_sms_template.GetSmsTemplateInput, options: get_sms_template.Options) !get_sms_template.GetSmsTemplateOutput {
        return get_sms_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the endpoints that are associated with a
    /// specific user ID.
    pub fn getUserEndpoints(self: *Self, allocator: std.mem.Allocator, input: get_user_endpoints.GetUserEndpointsInput, options: get_user_endpoints.Options) !get_user_endpoints.GetUserEndpointsOutput {
        return get_user_endpoints.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status and settings of the voice channel for
    /// an application.
    pub fn getVoiceChannel(self: *Self, allocator: std.mem.Allocator, input: get_voice_channel.GetVoiceChannelInput, options: get_voice_channel.Options) !get_voice_channel.GetVoiceChannelOutput {
        return get_voice_channel.execute(self, allocator, input, options);
    }

    /// Retrieves the content and settings of a message template for messages that
    /// are sent through the voice channel.
    pub fn getVoiceTemplate(self: *Self, allocator: std.mem.Allocator, input: get_voice_template.GetVoiceTemplateInput, options: get_voice_template.Options) !get_voice_template.GetVoiceTemplateOutput {
        return get_voice_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status, configuration, and other settings
    /// for all the journeys that are associated with an application.
    pub fn listJourneys(self: *Self, allocator: std.mem.Allocator, input: list_journeys.ListJourneysInput, options: list_journeys.Options) !list_journeys.ListJourneysOutput {
        return list_journeys.execute(self, allocator, input, options);
    }

    /// Retrieves all the tags (keys and values) that are associated with an
    /// application, campaign, message template, or segment.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the versions of a specific message template.
    pub fn listTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: list_template_versions.ListTemplateVersionsInput, options: list_template_versions.Options) !list_template_versions.ListTemplateVersionsOutput {
        return list_template_versions.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the message templates that are associated
    /// with your Amazon Pinpoint account.
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: list_templates.Options) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// Retrieves information about a phone number.
    pub fn phoneNumberValidate(self: *Self, allocator: std.mem.Allocator, input: phone_number_validate.PhoneNumberValidateInput, options: phone_number_validate.Options) !phone_number_validate.PhoneNumberValidateOutput {
        return phone_number_validate.execute(self, allocator, input, options);
    }

    /// Creates a new event stream for an application or updates the settings of an
    /// existing event stream for an application.
    pub fn putEventStream(self: *Self, allocator: std.mem.Allocator, input: put_event_stream.PutEventStreamInput, options: put_event_stream.Options) !put_event_stream.PutEventStreamOutput {
        return put_event_stream.execute(self, allocator, input, options);
    }

    /// Creates a new event to record for endpoints, or creates or updates endpoint
    /// data that existing events are associated with.
    pub fn putEvents(self: *Self, allocator: std.mem.Allocator, input: put_events.PutEventsInput, options: put_events.Options) !put_events.PutEventsOutput {
        return put_events.execute(self, allocator, input, options);
    }

    /// Removes one or more custom attributes, of the same attribute type, from the
    /// application. Existing endpoints still have the attributes but Amazon
    /// Pinpoint will stop capturing new or changed values for these attributes.
    pub fn removeAttributes(self: *Self, allocator: std.mem.Allocator, input: remove_attributes.RemoveAttributesInput, options: remove_attributes.Options) !remove_attributes.RemoveAttributesOutput {
        return remove_attributes.execute(self, allocator, input, options);
    }

    /// Creates and sends a direct message.
    pub fn sendMessages(self: *Self, allocator: std.mem.Allocator, input: send_messages.SendMessagesInput, options: send_messages.Options) !send_messages.SendMessagesOutput {
        return send_messages.execute(self, allocator, input, options);
    }

    /// Send an OTP message
    pub fn sendOtpMessage(self: *Self, allocator: std.mem.Allocator, input: send_otp_message.SendOTPMessageInput, options: send_otp_message.Options) !send_otp_message.SendOTPMessageOutput {
        return send_otp_message.execute(self, allocator, input, options);
    }

    /// Creates and sends a message to a list of users.
    pub fn sendUsersMessages(self: *Self, allocator: std.mem.Allocator, input: send_users_messages.SendUsersMessagesInput, options: send_users_messages.Options) !send_users_messages.SendUsersMessagesOutput {
        return send_users_messages.execute(self, allocator, input, options);
    }

    /// Adds one or more tags (keys and values) to an application, campaign, message
    /// template, or segment.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags (keys and values) from an application, campaign,
    /// message template, or segment.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Enables the ADM channel for an application or updates the status and
    /// settings of the ADM channel for an application.
    pub fn updateAdmChannel(self: *Self, allocator: std.mem.Allocator, input: update_adm_channel.UpdateAdmChannelInput, options: update_adm_channel.Options) !update_adm_channel.UpdateAdmChannelOutput {
        return update_adm_channel.execute(self, allocator, input, options);
    }

    /// Enables the APNs channel for an application or updates the status and
    /// settings of the APNs channel for an application.
    pub fn updateApnsChannel(self: *Self, allocator: std.mem.Allocator, input: update_apns_channel.UpdateApnsChannelInput, options: update_apns_channel.Options) !update_apns_channel.UpdateApnsChannelOutput {
        return update_apns_channel.execute(self, allocator, input, options);
    }

    /// Enables the APNs sandbox channel for an application or updates the status
    /// and settings of the APNs sandbox channel for an application.
    pub fn updateApnsSandboxChannel(self: *Self, allocator: std.mem.Allocator, input: update_apns_sandbox_channel.UpdateApnsSandboxChannelInput, options: update_apns_sandbox_channel.Options) !update_apns_sandbox_channel.UpdateApnsSandboxChannelOutput {
        return update_apns_sandbox_channel.execute(self, allocator, input, options);
    }

    /// Enables the APNs VoIP channel for an application or updates the status and
    /// settings of the APNs VoIP channel for an application.
    pub fn updateApnsVoipChannel(self: *Self, allocator: std.mem.Allocator, input: update_apns_voip_channel.UpdateApnsVoipChannelInput, options: update_apns_voip_channel.Options) !update_apns_voip_channel.UpdateApnsVoipChannelOutput {
        return update_apns_voip_channel.execute(self, allocator, input, options);
    }

    /// Enables the APNs VoIP sandbox channel for an application or updates the
    /// status and settings of the APNs VoIP sandbox channel for an application.
    pub fn updateApnsVoipSandboxChannel(self: *Self, allocator: std.mem.Allocator, input: update_apns_voip_sandbox_channel.UpdateApnsVoipSandboxChannelInput, options: update_apns_voip_sandbox_channel.Options) !update_apns_voip_sandbox_channel.UpdateApnsVoipSandboxChannelOutput {
        return update_apns_voip_sandbox_channel.execute(self, allocator, input, options);
    }

    /// Updates the settings for an application.
    pub fn updateApplicationSettings(self: *Self, allocator: std.mem.Allocator, input: update_application_settings.UpdateApplicationSettingsInput, options: update_application_settings.Options) !update_application_settings.UpdateApplicationSettingsOutput {
        return update_application_settings.execute(self, allocator, input, options);
    }

    /// Enables the Baidu channel for an application or updates the status and
    /// settings of the Baidu channel for an application.
    pub fn updateBaiduChannel(self: *Self, allocator: std.mem.Allocator, input: update_baidu_channel.UpdateBaiduChannelInput, options: update_baidu_channel.Options) !update_baidu_channel.UpdateBaiduChannelOutput {
        return update_baidu_channel.execute(self, allocator, input, options);
    }

    /// Updates the configuration and other settings for a campaign.
    pub fn updateCampaign(self: *Self, allocator: std.mem.Allocator, input: update_campaign.UpdateCampaignInput, options: update_campaign.Options) !update_campaign.UpdateCampaignOutput {
        return update_campaign.execute(self, allocator, input, options);
    }

    /// Enables the email channel for an application or updates the status and
    /// settings of the email channel for an application.
    pub fn updateEmailChannel(self: *Self, allocator: std.mem.Allocator, input: update_email_channel.UpdateEmailChannelInput, options: update_email_channel.Options) !update_email_channel.UpdateEmailChannelOutput {
        return update_email_channel.execute(self, allocator, input, options);
    }

    /// Updates an existing message template for messages that are sent through the
    /// email channel.
    pub fn updateEmailTemplate(self: *Self, allocator: std.mem.Allocator, input: update_email_template.UpdateEmailTemplateInput, options: update_email_template.Options) !update_email_template.UpdateEmailTemplateOutput {
        return update_email_template.execute(self, allocator, input, options);
    }

    /// Creates a new endpoint for an application or updates the settings and
    /// attributes of an existing endpoint for an application. You can also use this
    /// operation to define custom attributes for an endpoint. If an update includes
    /// one or more values for a custom attribute, Amazon Pinpoint replaces
    /// (overwrites) any existing values with the new values.
    pub fn updateEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_endpoint.UpdateEndpointInput, options: update_endpoint.Options) !update_endpoint.UpdateEndpointOutput {
        return update_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new batch of endpoints for an application or updates the settings
    /// and attributes of a batch of existing endpoints for an application. You can
    /// also use this operation to define custom attributes for a batch of
    /// endpoints. If an update includes one or more values for a custom attribute,
    /// Amazon Pinpoint replaces (overwrites) any existing values with the new
    /// values.
    pub fn updateEndpointsBatch(self: *Self, allocator: std.mem.Allocator, input: update_endpoints_batch.UpdateEndpointsBatchInput, options: update_endpoints_batch.Options) !update_endpoints_batch.UpdateEndpointsBatchOutput {
        return update_endpoints_batch.execute(self, allocator, input, options);
    }

    /// Enables the GCM channel for an application or updates the status and
    /// settings of the GCM channel for an application.
    pub fn updateGcmChannel(self: *Self, allocator: std.mem.Allocator, input: update_gcm_channel.UpdateGcmChannelInput, options: update_gcm_channel.Options) !update_gcm_channel.UpdateGcmChannelOutput {
        return update_gcm_channel.execute(self, allocator, input, options);
    }

    /// Updates an existing message template for messages sent through the in-app
    /// message channel.
    pub fn updateInAppTemplate(self: *Self, allocator: std.mem.Allocator, input: update_in_app_template.UpdateInAppTemplateInput, options: update_in_app_template.Options) !update_in_app_template.UpdateInAppTemplateOutput {
        return update_in_app_template.execute(self, allocator, input, options);
    }

    /// Updates the configuration and other settings for a journey.
    pub fn updateJourney(self: *Self, allocator: std.mem.Allocator, input: update_journey.UpdateJourneyInput, options: update_journey.Options) !update_journey.UpdateJourneyOutput {
        return update_journey.execute(self, allocator, input, options);
    }

    /// Cancels (stops) an active journey.
    pub fn updateJourneyState(self: *Self, allocator: std.mem.Allocator, input: update_journey_state.UpdateJourneyStateInput, options: update_journey_state.Options) !update_journey_state.UpdateJourneyStateOutput {
        return update_journey_state.execute(self, allocator, input, options);
    }

    /// Updates an existing message template for messages that are sent through a
    /// push notification channel.
    pub fn updatePushTemplate(self: *Self, allocator: std.mem.Allocator, input: update_push_template.UpdatePushTemplateInput, options: update_push_template.Options) !update_push_template.UpdatePushTemplateOutput {
        return update_push_template.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Pinpoint configuration for a recommender model.
    pub fn updateRecommenderConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_recommender_configuration.UpdateRecommenderConfigurationInput, options: update_recommender_configuration.Options) !update_recommender_configuration.UpdateRecommenderConfigurationOutput {
        return update_recommender_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new segment for an application or updates the configuration,
    /// dimension, and other settings for an existing segment that's associated with
    /// an application.
    pub fn updateSegment(self: *Self, allocator: std.mem.Allocator, input: update_segment.UpdateSegmentInput, options: update_segment.Options) !update_segment.UpdateSegmentOutput {
        return update_segment.execute(self, allocator, input, options);
    }

    /// Enables the SMS channel for an application or updates the status and
    /// settings of the SMS channel for an application.
    pub fn updateSmsChannel(self: *Self, allocator: std.mem.Allocator, input: update_sms_channel.UpdateSmsChannelInput, options: update_sms_channel.Options) !update_sms_channel.UpdateSmsChannelOutput {
        return update_sms_channel.execute(self, allocator, input, options);
    }

    /// Updates an existing message template for messages that are sent through the
    /// SMS channel.
    pub fn updateSmsTemplate(self: *Self, allocator: std.mem.Allocator, input: update_sms_template.UpdateSmsTemplateInput, options: update_sms_template.Options) !update_sms_template.UpdateSmsTemplateOutput {
        return update_sms_template.execute(self, allocator, input, options);
    }

    /// Changes the status of a specific version of a message template to *active*.
    pub fn updateTemplateActiveVersion(self: *Self, allocator: std.mem.Allocator, input: update_template_active_version.UpdateTemplateActiveVersionInput, options: update_template_active_version.Options) !update_template_active_version.UpdateTemplateActiveVersionOutput {
        return update_template_active_version.execute(self, allocator, input, options);
    }

    /// Enables the voice channel for an application or updates the status and
    /// settings of the voice channel for an application.
    pub fn updateVoiceChannel(self: *Self, allocator: std.mem.Allocator, input: update_voice_channel.UpdateVoiceChannelInput, options: update_voice_channel.Options) !update_voice_channel.UpdateVoiceChannelOutput {
        return update_voice_channel.execute(self, allocator, input, options);
    }

    /// Updates an existing message template for messages that are sent through the
    /// voice channel.
    pub fn updateVoiceTemplate(self: *Self, allocator: std.mem.Allocator, input: update_voice_template.UpdateVoiceTemplateInput, options: update_voice_template.Options) !update_voice_template.UpdateVoiceTemplateOutput {
        return update_voice_template.execute(self, allocator, input, options);
    }

    /// Verify an OTP
    pub fn verifyOtpMessage(self: *Self, allocator: std.mem.Allocator, input: verify_otp_message.VerifyOTPMessageInput, options: verify_otp_message.Options) !verify_otp_message.VerifyOTPMessageOutput {
        return verify_otp_message.execute(self, allocator, input, options);
    }
};
