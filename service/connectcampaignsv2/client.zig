const aws = @import("aws");
const std = @import("std");

const create_campaign = @import("create_campaign.zig");
const delete_campaign = @import("delete_campaign.zig");
const delete_campaign_channel_subtype_config = @import("delete_campaign_channel_subtype_config.zig");
const delete_campaign_communication_limits = @import("delete_campaign_communication_limits.zig");
const delete_campaign_communication_time = @import("delete_campaign_communication_time.zig");
const delete_campaign_entry_limits = @import("delete_campaign_entry_limits.zig");
const delete_connect_instance_config = @import("delete_connect_instance_config.zig");
const delete_connect_instance_integration = @import("delete_connect_instance_integration.zig");
const delete_instance_onboarding_job = @import("delete_instance_onboarding_job.zig");
const describe_campaign = @import("describe_campaign.zig");
const get_campaign_state = @import("get_campaign_state.zig");
const get_campaign_state_batch = @import("get_campaign_state_batch.zig");
const get_connect_instance_config = @import("get_connect_instance_config.zig");
const get_instance_communication_limits = @import("get_instance_communication_limits.zig");
const get_instance_onboarding_job_status = @import("get_instance_onboarding_job_status.zig");
const list_campaigns = @import("list_campaigns.zig");
const list_connect_instance_integrations = @import("list_connect_instance_integrations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const pause_campaign = @import("pause_campaign.zig");
const put_connect_instance_integration = @import("put_connect_instance_integration.zig");
const put_instance_communication_limits = @import("put_instance_communication_limits.zig");
const put_outbound_request_batch = @import("put_outbound_request_batch.zig");
const put_profile_outbound_request_batch = @import("put_profile_outbound_request_batch.zig");
const resume_campaign = @import("resume_campaign.zig");
const start_campaign = @import("start_campaign.zig");
const start_instance_onboarding_job = @import("start_instance_onboarding_job.zig");
const stop_campaign = @import("stop_campaign.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_campaign_channel_subtype_config = @import("update_campaign_channel_subtype_config.zig");
const update_campaign_communication_limits = @import("update_campaign_communication_limits.zig");
const update_campaign_communication_time = @import("update_campaign_communication_time.zig");
const update_campaign_entry_limits = @import("update_campaign_entry_limits.zig");
const update_campaign_flow_association = @import("update_campaign_flow_association.zig");
const update_campaign_name = @import("update_campaign_name.zig");
const update_campaign_schedule = @import("update_campaign_schedule.zig");
const update_campaign_source = @import("update_campaign_source.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ConnectCampaignsV2";

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

    /// Creates a campaign for the specified Amazon Connect account. This API is
    /// idempotent.
    pub fn createCampaign(self: *Self, allocator: std.mem.Allocator, input: create_campaign.CreateCampaignInput, options: CallOptions) !create_campaign.CreateCampaignOutput {
        return create_campaign.execute(self, allocator, input, options);
    }

    /// Deletes a campaign from the specified Amazon Connect account.
    pub fn deleteCampaign(self: *Self, allocator: std.mem.Allocator, input: delete_campaign.DeleteCampaignInput, options: CallOptions) !delete_campaign.DeleteCampaignOutput {
        return delete_campaign.execute(self, allocator, input, options);
    }

    /// Deletes the channel subtype config of a campaign. This API is idempotent.
    pub fn deleteCampaignChannelSubtypeConfig(self: *Self, allocator: std.mem.Allocator, input: delete_campaign_channel_subtype_config.DeleteCampaignChannelSubtypeConfigInput, options: CallOptions) !delete_campaign_channel_subtype_config.DeleteCampaignChannelSubtypeConfigOutput {
        return delete_campaign_channel_subtype_config.execute(self, allocator, input, options);
    }

    /// Deletes the communication limits config for a campaign. This API is
    /// idempotent.
    pub fn deleteCampaignCommunicationLimits(self: *Self, allocator: std.mem.Allocator, input: delete_campaign_communication_limits.DeleteCampaignCommunicationLimitsInput, options: CallOptions) !delete_campaign_communication_limits.DeleteCampaignCommunicationLimitsOutput {
        return delete_campaign_communication_limits.execute(self, allocator, input, options);
    }

    /// Deletes the communication time config for a campaign. This API is
    /// idempotent.
    pub fn deleteCampaignCommunicationTime(self: *Self, allocator: std.mem.Allocator, input: delete_campaign_communication_time.DeleteCampaignCommunicationTimeInput, options: CallOptions) !delete_campaign_communication_time.DeleteCampaignCommunicationTimeOutput {
        return delete_campaign_communication_time.execute(self, allocator, input, options);
    }

    /// Deletes the entry limits config for a campaign. This API is idempotent.
    pub fn deleteCampaignEntryLimits(self: *Self, allocator: std.mem.Allocator, input: delete_campaign_entry_limits.DeleteCampaignEntryLimitsInput, options: CallOptions) !delete_campaign_entry_limits.DeleteCampaignEntryLimitsOutput {
        return delete_campaign_entry_limits.execute(self, allocator, input, options);
    }

    /// Deletes a connect instance config from the specified AWS account.
    pub fn deleteConnectInstanceConfig(self: *Self, allocator: std.mem.Allocator, input: delete_connect_instance_config.DeleteConnectInstanceConfigInput, options: CallOptions) !delete_connect_instance_config.DeleteConnectInstanceConfigOutput {
        return delete_connect_instance_config.execute(self, allocator, input, options);
    }

    /// Delete the integration for the specified Amazon Connect instance.
    pub fn deleteConnectInstanceIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_connect_instance_integration.DeleteConnectInstanceIntegrationInput, options: CallOptions) !delete_connect_instance_integration.DeleteConnectInstanceIntegrationOutput {
        return delete_connect_instance_integration.execute(self, allocator, input, options);
    }

    /// Delete the Connect Campaigns onboarding job for the specified Amazon Connect
    /// instance.
    pub fn deleteInstanceOnboardingJob(self: *Self, allocator: std.mem.Allocator, input: delete_instance_onboarding_job.DeleteInstanceOnboardingJobInput, options: CallOptions) !delete_instance_onboarding_job.DeleteInstanceOnboardingJobOutput {
        return delete_instance_onboarding_job.execute(self, allocator, input, options);
    }

    /// Describes the specific campaign.
    pub fn describeCampaign(self: *Self, allocator: std.mem.Allocator, input: describe_campaign.DescribeCampaignInput, options: CallOptions) !describe_campaign.DescribeCampaignOutput {
        return describe_campaign.execute(self, allocator, input, options);
    }

    /// Get state of a campaign for the specified Amazon Connect account.
    pub fn getCampaignState(self: *Self, allocator: std.mem.Allocator, input: get_campaign_state.GetCampaignStateInput, options: CallOptions) !get_campaign_state.GetCampaignStateOutput {
        return get_campaign_state.execute(self, allocator, input, options);
    }

    /// Get state of campaigns for the specified Amazon Connect account.
    pub fn getCampaignStateBatch(self: *Self, allocator: std.mem.Allocator, input: get_campaign_state_batch.GetCampaignStateBatchInput, options: CallOptions) !get_campaign_state_batch.GetCampaignStateBatchOutput {
        return get_campaign_state_batch.execute(self, allocator, input, options);
    }

    /// Get the specific Connect instance config.
    pub fn getConnectInstanceConfig(self: *Self, allocator: std.mem.Allocator, input: get_connect_instance_config.GetConnectInstanceConfigInput, options: CallOptions) !get_connect_instance_config.GetConnectInstanceConfigOutput {
        return get_connect_instance_config.execute(self, allocator, input, options);
    }

    /// Get the instance communication limits.
    pub fn getInstanceCommunicationLimits(self: *Self, allocator: std.mem.Allocator, input: get_instance_communication_limits.GetInstanceCommunicationLimitsInput, options: CallOptions) !get_instance_communication_limits.GetInstanceCommunicationLimitsOutput {
        return get_instance_communication_limits.execute(self, allocator, input, options);
    }

    /// Get the specific instance onboarding job status.
    pub fn getInstanceOnboardingJobStatus(self: *Self, allocator: std.mem.Allocator, input: get_instance_onboarding_job_status.GetInstanceOnboardingJobStatusInput, options: CallOptions) !get_instance_onboarding_job_status.GetInstanceOnboardingJobStatusOutput {
        return get_instance_onboarding_job_status.execute(self, allocator, input, options);
    }

    /// Provides summary information about the campaigns under the specified Amazon
    /// Connect account.
    pub fn listCampaigns(self: *Self, allocator: std.mem.Allocator, input: list_campaigns.ListCampaignsInput, options: CallOptions) !list_campaigns.ListCampaignsOutput {
        return list_campaigns.execute(self, allocator, input, options);
    }

    /// Provides summary information about the integration under the specified
    /// Connect instance.
    pub fn listConnectInstanceIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_connect_instance_integrations.ListConnectInstanceIntegrationsInput, options: CallOptions) !list_connect_instance_integrations.ListConnectInstanceIntegrationsOutput {
        return list_connect_instance_integrations.execute(self, allocator, input, options);
    }

    /// List tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Pauses a campaign for the specified Amazon Connect account.
    pub fn pauseCampaign(self: *Self, allocator: std.mem.Allocator, input: pause_campaign.PauseCampaignInput, options: CallOptions) !pause_campaign.PauseCampaignOutput {
        return pause_campaign.execute(self, allocator, input, options);
    }

    /// Put or update the integration for the specified Amazon Connect instance.
    pub fn putConnectInstanceIntegration(self: *Self, allocator: std.mem.Allocator, input: put_connect_instance_integration.PutConnectInstanceIntegrationInput, options: CallOptions) !put_connect_instance_integration.PutConnectInstanceIntegrationOutput {
        return put_connect_instance_integration.execute(self, allocator, input, options);
    }

    /// Put the instance communication limits. This API is idempotent.
    pub fn putInstanceCommunicationLimits(self: *Self, allocator: std.mem.Allocator, input: put_instance_communication_limits.PutInstanceCommunicationLimitsInput, options: CallOptions) !put_instance_communication_limits.PutInstanceCommunicationLimitsOutput {
        return put_instance_communication_limits.execute(self, allocator, input, options);
    }

    /// Creates outbound requests for the specified campaign Amazon Connect account.
    /// This API is idempotent.
    pub fn putOutboundRequestBatch(self: *Self, allocator: std.mem.Allocator, input: put_outbound_request_batch.PutOutboundRequestBatchInput, options: CallOptions) !put_outbound_request_batch.PutOutboundRequestBatchOutput {
        return put_outbound_request_batch.execute(self, allocator, input, options);
    }

    /// Takes in a list of profile outbound requests to be placed as part of an
    /// outbound campaign. This API is idempotent.
    pub fn putProfileOutboundRequestBatch(self: *Self, allocator: std.mem.Allocator, input: put_profile_outbound_request_batch.PutProfileOutboundRequestBatchInput, options: CallOptions) !put_profile_outbound_request_batch.PutProfileOutboundRequestBatchOutput {
        return put_profile_outbound_request_batch.execute(self, allocator, input, options);
    }

    /// Stops a campaign for the specified Amazon Connect account.
    pub fn resumeCampaign(self: *Self, allocator: std.mem.Allocator, input: resume_campaign.ResumeCampaignInput, options: CallOptions) !resume_campaign.ResumeCampaignOutput {
        return resume_campaign.execute(self, allocator, input, options);
    }

    /// Starts a campaign for the specified Amazon Connect account.
    pub fn startCampaign(self: *Self, allocator: std.mem.Allocator, input: start_campaign.StartCampaignInput, options: CallOptions) !start_campaign.StartCampaignOutput {
        return start_campaign.execute(self, allocator, input, options);
    }

    /// Onboard the specific Amazon Connect instance to Connect Campaigns.
    pub fn startInstanceOnboardingJob(self: *Self, allocator: std.mem.Allocator, input: start_instance_onboarding_job.StartInstanceOnboardingJobInput, options: CallOptions) !start_instance_onboarding_job.StartInstanceOnboardingJobOutput {
        return start_instance_onboarding_job.execute(self, allocator, input, options);
    }

    /// Stops a campaign for the specified Amazon Connect account.
    pub fn stopCampaign(self: *Self, allocator: std.mem.Allocator, input: stop_campaign.StopCampaignInput, options: CallOptions) !stop_campaign.StopCampaignOutput {
        return stop_campaign.execute(self, allocator, input, options);
    }

    /// Tag a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untag a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the channel subtype config of a campaign. This API is idempotent.
    pub fn updateCampaignChannelSubtypeConfig(self: *Self, allocator: std.mem.Allocator, input: update_campaign_channel_subtype_config.UpdateCampaignChannelSubtypeConfigInput, options: CallOptions) !update_campaign_channel_subtype_config.UpdateCampaignChannelSubtypeConfigOutput {
        return update_campaign_channel_subtype_config.execute(self, allocator, input, options);
    }

    /// Updates the communication limits config for a campaign. This API is
    /// idempotent.
    pub fn updateCampaignCommunicationLimits(self: *Self, allocator: std.mem.Allocator, input: update_campaign_communication_limits.UpdateCampaignCommunicationLimitsInput, options: CallOptions) !update_campaign_communication_limits.UpdateCampaignCommunicationLimitsOutput {
        return update_campaign_communication_limits.execute(self, allocator, input, options);
    }

    /// Updates the communication time config for a campaign. This API is
    /// idempotent.
    pub fn updateCampaignCommunicationTime(self: *Self, allocator: std.mem.Allocator, input: update_campaign_communication_time.UpdateCampaignCommunicationTimeInput, options: CallOptions) !update_campaign_communication_time.UpdateCampaignCommunicationTimeOutput {
        return update_campaign_communication_time.execute(self, allocator, input, options);
    }

    /// Updates the entry limits config for a campaign. This API is idempotent.
    pub fn updateCampaignEntryLimits(self: *Self, allocator: std.mem.Allocator, input: update_campaign_entry_limits.UpdateCampaignEntryLimitsInput, options: CallOptions) !update_campaign_entry_limits.UpdateCampaignEntryLimitsOutput {
        return update_campaign_entry_limits.execute(self, allocator, input, options);
    }

    /// Updates the campaign flow associated with a campaign. This API is
    /// idempotent.
    pub fn updateCampaignFlowAssociation(self: *Self, allocator: std.mem.Allocator, input: update_campaign_flow_association.UpdateCampaignFlowAssociationInput, options: CallOptions) !update_campaign_flow_association.UpdateCampaignFlowAssociationOutput {
        return update_campaign_flow_association.execute(self, allocator, input, options);
    }

    /// Updates the name of a campaign. This API is idempotent.
    pub fn updateCampaignName(self: *Self, allocator: std.mem.Allocator, input: update_campaign_name.UpdateCampaignNameInput, options: CallOptions) !update_campaign_name.UpdateCampaignNameOutput {
        return update_campaign_name.execute(self, allocator, input, options);
    }

    /// Updates the schedule for a campaign. This API is idempotent.
    pub fn updateCampaignSchedule(self: *Self, allocator: std.mem.Allocator, input: update_campaign_schedule.UpdateCampaignScheduleInput, options: CallOptions) !update_campaign_schedule.UpdateCampaignScheduleOutput {
        return update_campaign_schedule.execute(self, allocator, input, options);
    }

    /// Updates the campaign source with a campaign. This API is idempotent.
    pub fn updateCampaignSource(self: *Self, allocator: std.mem.Allocator, input: update_campaign_source.UpdateCampaignSourceInput, options: CallOptions) !update_campaign_source.UpdateCampaignSourceOutput {
        return update_campaign_source.execute(self, allocator, input, options);
    }

    pub fn listCampaignsPaginator(self: *Self, params: list_campaigns.ListCampaignsInput) paginator.ListCampaignsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConnectInstanceIntegrationsPaginator(self: *Self, params: list_connect_instance_integrations.ListConnectInstanceIntegrationsInput) paginator.ListConnectInstanceIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
