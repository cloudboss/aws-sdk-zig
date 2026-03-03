const aws = @import("aws");
const std = @import("std");

const create_campaign = @import("create_campaign.zig");
const delete_campaign = @import("delete_campaign.zig");
const delete_connect_instance_config = @import("delete_connect_instance_config.zig");
const delete_instance_onboarding_job = @import("delete_instance_onboarding_job.zig");
const describe_campaign = @import("describe_campaign.zig");
const get_campaign_state = @import("get_campaign_state.zig");
const get_campaign_state_batch = @import("get_campaign_state_batch.zig");
const get_connect_instance_config = @import("get_connect_instance_config.zig");
const get_instance_onboarding_job_status = @import("get_instance_onboarding_job_status.zig");
const list_campaigns = @import("list_campaigns.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const pause_campaign = @import("pause_campaign.zig");
const put_dial_request_batch = @import("put_dial_request_batch.zig");
const resume_campaign = @import("resume_campaign.zig");
const start_campaign = @import("start_campaign.zig");
const start_instance_onboarding_job = @import("start_instance_onboarding_job.zig");
const stop_campaign = @import("stop_campaign.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_campaign_dialer_config = @import("update_campaign_dialer_config.zig");
const update_campaign_name = @import("update_campaign_name.zig");
const update_campaign_outbound_call_config = @import("update_campaign_outbound_call_config.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ConnectCampaigns";

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
    pub fn createCampaign(self: *Self, allocator: std.mem.Allocator, input: create_campaign.CreateCampaignInput, options: create_campaign.Options) !create_campaign.CreateCampaignOutput {
        return create_campaign.execute(self, allocator, input, options);
    }

    /// Deletes a campaign from the specified Amazon Connect account.
    pub fn deleteCampaign(self: *Self, allocator: std.mem.Allocator, input: delete_campaign.DeleteCampaignInput, options: delete_campaign.Options) !delete_campaign.DeleteCampaignOutput {
        return delete_campaign.execute(self, allocator, input, options);
    }

    /// Deletes a connect instance config from the specified AWS account.
    pub fn deleteConnectInstanceConfig(self: *Self, allocator: std.mem.Allocator, input: delete_connect_instance_config.DeleteConnectInstanceConfigInput, options: delete_connect_instance_config.Options) !delete_connect_instance_config.DeleteConnectInstanceConfigOutput {
        return delete_connect_instance_config.execute(self, allocator, input, options);
    }

    /// Delete the Connect Campaigns onboarding job for the specified Amazon Connect
    /// instance.
    pub fn deleteInstanceOnboardingJob(self: *Self, allocator: std.mem.Allocator, input: delete_instance_onboarding_job.DeleteInstanceOnboardingJobInput, options: delete_instance_onboarding_job.Options) !delete_instance_onboarding_job.DeleteInstanceOnboardingJobOutput {
        return delete_instance_onboarding_job.execute(self, allocator, input, options);
    }

    /// Describes the specific campaign.
    pub fn describeCampaign(self: *Self, allocator: std.mem.Allocator, input: describe_campaign.DescribeCampaignInput, options: describe_campaign.Options) !describe_campaign.DescribeCampaignOutput {
        return describe_campaign.execute(self, allocator, input, options);
    }

    /// Get state of a campaign for the specified Amazon Connect account.
    pub fn getCampaignState(self: *Self, allocator: std.mem.Allocator, input: get_campaign_state.GetCampaignStateInput, options: get_campaign_state.Options) !get_campaign_state.GetCampaignStateOutput {
        return get_campaign_state.execute(self, allocator, input, options);
    }

    /// Get state of campaigns for the specified Amazon Connect account.
    pub fn getCampaignStateBatch(self: *Self, allocator: std.mem.Allocator, input: get_campaign_state_batch.GetCampaignStateBatchInput, options: get_campaign_state_batch.Options) !get_campaign_state_batch.GetCampaignStateBatchOutput {
        return get_campaign_state_batch.execute(self, allocator, input, options);
    }

    /// Get the specific Connect instance config.
    pub fn getConnectInstanceConfig(self: *Self, allocator: std.mem.Allocator, input: get_connect_instance_config.GetConnectInstanceConfigInput, options: get_connect_instance_config.Options) !get_connect_instance_config.GetConnectInstanceConfigOutput {
        return get_connect_instance_config.execute(self, allocator, input, options);
    }

    /// Get the specific instance onboarding job status.
    pub fn getInstanceOnboardingJobStatus(self: *Self, allocator: std.mem.Allocator, input: get_instance_onboarding_job_status.GetInstanceOnboardingJobStatusInput, options: get_instance_onboarding_job_status.Options) !get_instance_onboarding_job_status.GetInstanceOnboardingJobStatusOutput {
        return get_instance_onboarding_job_status.execute(self, allocator, input, options);
    }

    /// Provides summary information about the campaigns under the specified Amazon
    /// Connect account.
    pub fn listCampaigns(self: *Self, allocator: std.mem.Allocator, input: list_campaigns.ListCampaignsInput, options: list_campaigns.Options) !list_campaigns.ListCampaignsOutput {
        return list_campaigns.execute(self, allocator, input, options);
    }

    /// List tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Pauses a campaign for the specified Amazon Connect account.
    pub fn pauseCampaign(self: *Self, allocator: std.mem.Allocator, input: pause_campaign.PauseCampaignInput, options: pause_campaign.Options) !pause_campaign.PauseCampaignOutput {
        return pause_campaign.execute(self, allocator, input, options);
    }

    /// Creates dials requests for the specified campaign Amazon Connect account.
    /// This API is idempotent.
    pub fn putDialRequestBatch(self: *Self, allocator: std.mem.Allocator, input: put_dial_request_batch.PutDialRequestBatchInput, options: put_dial_request_batch.Options) !put_dial_request_batch.PutDialRequestBatchOutput {
        return put_dial_request_batch.execute(self, allocator, input, options);
    }

    /// Stops a campaign for the specified Amazon Connect account.
    pub fn resumeCampaign(self: *Self, allocator: std.mem.Allocator, input: resume_campaign.ResumeCampaignInput, options: resume_campaign.Options) !resume_campaign.ResumeCampaignOutput {
        return resume_campaign.execute(self, allocator, input, options);
    }

    /// Starts a campaign for the specified Amazon Connect account.
    pub fn startCampaign(self: *Self, allocator: std.mem.Allocator, input: start_campaign.StartCampaignInput, options: start_campaign.Options) !start_campaign.StartCampaignOutput {
        return start_campaign.execute(self, allocator, input, options);
    }

    /// Onboard the specific Amazon Connect instance to Connect Campaigns.
    pub fn startInstanceOnboardingJob(self: *Self, allocator: std.mem.Allocator, input: start_instance_onboarding_job.StartInstanceOnboardingJobInput, options: start_instance_onboarding_job.Options) !start_instance_onboarding_job.StartInstanceOnboardingJobOutput {
        return start_instance_onboarding_job.execute(self, allocator, input, options);
    }

    /// Stops a campaign for the specified Amazon Connect account.
    pub fn stopCampaign(self: *Self, allocator: std.mem.Allocator, input: stop_campaign.StopCampaignInput, options: stop_campaign.Options) !stop_campaign.StopCampaignOutput {
        return stop_campaign.execute(self, allocator, input, options);
    }

    /// Tag a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untag a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the dialer config of a campaign. This API is idempotent.
    pub fn updateCampaignDialerConfig(self: *Self, allocator: std.mem.Allocator, input: update_campaign_dialer_config.UpdateCampaignDialerConfigInput, options: update_campaign_dialer_config.Options) !update_campaign_dialer_config.UpdateCampaignDialerConfigOutput {
        return update_campaign_dialer_config.execute(self, allocator, input, options);
    }

    /// Updates the name of a campaign. This API is idempotent.
    pub fn updateCampaignName(self: *Self, allocator: std.mem.Allocator, input: update_campaign_name.UpdateCampaignNameInput, options: update_campaign_name.Options) !update_campaign_name.UpdateCampaignNameOutput {
        return update_campaign_name.execute(self, allocator, input, options);
    }

    /// Updates the outbound call config of a campaign. This API is idempotent.
    pub fn updateCampaignOutboundCallConfig(self: *Self, allocator: std.mem.Allocator, input: update_campaign_outbound_call_config.UpdateCampaignOutboundCallConfigInput, options: update_campaign_outbound_call_config.Options) !update_campaign_outbound_call_config.UpdateCampaignOutboundCallConfigOutput {
        return update_campaign_outbound_call_config.execute(self, allocator, input, options);
    }

    pub fn listCampaignsPaginator(self: *Self, params: list_campaigns.ListCampaignsInput) paginator.ListCampaignsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
