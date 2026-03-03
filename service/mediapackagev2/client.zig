const aws = @import("aws");
const std = @import("std");

const cancel_harvest_job = @import("cancel_harvest_job.zig");
const create_channel = @import("create_channel.zig");
const create_channel_group = @import("create_channel_group.zig");
const create_harvest_job = @import("create_harvest_job.zig");
const create_origin_endpoint = @import("create_origin_endpoint.zig");
const delete_channel = @import("delete_channel.zig");
const delete_channel_group = @import("delete_channel_group.zig");
const delete_channel_policy = @import("delete_channel_policy.zig");
const delete_origin_endpoint = @import("delete_origin_endpoint.zig");
const delete_origin_endpoint_policy = @import("delete_origin_endpoint_policy.zig");
const get_channel = @import("get_channel.zig");
const get_channel_group = @import("get_channel_group.zig");
const get_channel_policy = @import("get_channel_policy.zig");
const get_harvest_job = @import("get_harvest_job.zig");
const get_origin_endpoint = @import("get_origin_endpoint.zig");
const get_origin_endpoint_policy = @import("get_origin_endpoint_policy.zig");
const list_channel_groups = @import("list_channel_groups.zig");
const list_channels = @import("list_channels.zig");
const list_harvest_jobs = @import("list_harvest_jobs.zig");
const list_origin_endpoints = @import("list_origin_endpoints.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_channel_policy = @import("put_channel_policy.zig");
const put_origin_endpoint_policy = @import("put_origin_endpoint_policy.zig");
const reset_channel_state = @import("reset_channel_state.zig");
const reset_origin_endpoint_state = @import("reset_origin_endpoint_state.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_channel_group = @import("update_channel_group.zig");
const update_origin_endpoint = @import("update_origin_endpoint.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaPackageV2";

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

    /// Cancels an in-progress harvest job.
    pub fn cancelHarvestJob(self: *Self, allocator: std.mem.Allocator, input: cancel_harvest_job.CancelHarvestJobInput, options: cancel_harvest_job.Options) !cancel_harvest_job.CancelHarvestJobOutput {
        return cancel_harvest_job.execute(self, allocator, input, options);
    }

    /// Create a channel to start receiving content streams. The channel represents
    /// the input to MediaPackage for incoming live content from an encoder such as
    /// AWS Elemental MediaLive. The channel receives content, and after packaging
    /// it, outputs it through an origin endpoint to downstream devices (such as
    /// video players or CDNs) that request the content. You can create only one
    /// channel with each request. We recommend that you spread out channels between
    /// channel groups, such as putting redundant channels in the same AWS Region in
    /// different channel groups.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: create_channel.Options) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Create a channel group to group your channels and origin endpoints. A
    /// channel group is the top-level resource that consists of channels and origin
    /// endpoints that are associated with it and that provides predictable URLs for
    /// stream delivery. All channels and origin endpoints within the channel group
    /// are guaranteed to share the DNS. You can create only one channel group with
    /// each request.
    pub fn createChannelGroup(self: *Self, allocator: std.mem.Allocator, input: create_channel_group.CreateChannelGroupInput, options: create_channel_group.Options) !create_channel_group.CreateChannelGroupOutput {
        return create_channel_group.execute(self, allocator, input, options);
    }

    /// Creates a new harvest job to export content from a MediaPackage v2 channel
    /// to an S3 bucket.
    pub fn createHarvestJob(self: *Self, allocator: std.mem.Allocator, input: create_harvest_job.CreateHarvestJobInput, options: create_harvest_job.Options) !create_harvest_job.CreateHarvestJobOutput {
        return create_harvest_job.execute(self, allocator, input, options);
    }

    /// The endpoint is attached to a channel, and represents the output of the live
    /// content. You can associate multiple endpoints to a single channel. Each
    /// endpoint gives players and downstream CDNs (such as Amazon CloudFront)
    /// access to the content for playback. Content can't be served from a channel
    /// until it has an endpoint. You can create only one endpoint with each
    /// request.
    pub fn createOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_origin_endpoint.CreateOriginEndpointInput, options: create_origin_endpoint.Options) !create_origin_endpoint.CreateOriginEndpointOutput {
        return create_origin_endpoint.execute(self, allocator, input, options);
    }

    /// Delete a channel to stop AWS Elemental MediaPackage from receiving further
    /// content. You must delete the channel's origin endpoints before you can
    /// delete the channel.
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: delete_channel.Options) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// Delete a channel group. You must delete the channel group's channels and
    /// origin endpoints before you can delete the channel group. If you delete a
    /// channel group, you'll lose access to the egress domain and will have to
    /// create a new channel group to replace it.
    pub fn deleteChannelGroup(self: *Self, allocator: std.mem.Allocator, input: delete_channel_group.DeleteChannelGroupInput, options: delete_channel_group.Options) !delete_channel_group.DeleteChannelGroupOutput {
        return delete_channel_group.execute(self, allocator, input, options);
    }

    /// Delete a channel policy.
    pub fn deleteChannelPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_channel_policy.DeleteChannelPolicyInput, options: delete_channel_policy.Options) !delete_channel_policy.DeleteChannelPolicyOutput {
        return delete_channel_policy.execute(self, allocator, input, options);
    }

    /// Origin endpoints can serve content until they're deleted. Delete the
    /// endpoint if it should no longer respond to playback requests. You must
    /// delete all endpoints from a channel before you can delete the channel.
    pub fn deleteOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_origin_endpoint.DeleteOriginEndpointInput, options: delete_origin_endpoint.Options) !delete_origin_endpoint.DeleteOriginEndpointOutput {
        return delete_origin_endpoint.execute(self, allocator, input, options);
    }

    /// Delete an origin endpoint policy.
    pub fn deleteOriginEndpointPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_origin_endpoint_policy.DeleteOriginEndpointPolicyInput, options: delete_origin_endpoint_policy.Options) !delete_origin_endpoint_policy.DeleteOriginEndpointPolicyOutput {
        return delete_origin_endpoint_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the specified channel that's configured in AWS Elemental
    /// MediaPackage.
    pub fn getChannel(self: *Self, allocator: std.mem.Allocator, input: get_channel.GetChannelInput, options: get_channel.Options) !get_channel.GetChannelOutput {
        return get_channel.execute(self, allocator, input, options);
    }

    /// Retrieves the specified channel group that's configured in AWS Elemental
    /// MediaPackage.
    pub fn getChannelGroup(self: *Self, allocator: std.mem.Allocator, input: get_channel_group.GetChannelGroupInput, options: get_channel_group.Options) !get_channel_group.GetChannelGroupOutput {
        return get_channel_group.execute(self, allocator, input, options);
    }

    /// Retrieves the specified channel policy that's configured in AWS Elemental
    /// MediaPackage. With policies, you can specify who has access to AWS resources
    /// and what actions they can perform on those resources.
    pub fn getChannelPolicy(self: *Self, allocator: std.mem.Allocator, input: get_channel_policy.GetChannelPolicyInput, options: get_channel_policy.Options) !get_channel_policy.GetChannelPolicyOutput {
        return get_channel_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific harvest job.
    pub fn getHarvestJob(self: *Self, allocator: std.mem.Allocator, input: get_harvest_job.GetHarvestJobInput, options: get_harvest_job.Options) !get_harvest_job.GetHarvestJobOutput {
        return get_harvest_job.execute(self, allocator, input, options);
    }

    /// Retrieves the specified origin endpoint that's configured in AWS Elemental
    /// MediaPackage to obtain its playback URL and to view the packaging settings
    /// that it's currently using.
    pub fn getOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_origin_endpoint.GetOriginEndpointInput, options: get_origin_endpoint.Options) !get_origin_endpoint.GetOriginEndpointOutput {
        return get_origin_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves the specified origin endpoint policy that's configured in AWS
    /// Elemental MediaPackage.
    pub fn getOriginEndpointPolicy(self: *Self, allocator: std.mem.Allocator, input: get_origin_endpoint_policy.GetOriginEndpointPolicyInput, options: get_origin_endpoint_policy.Options) !get_origin_endpoint_policy.GetOriginEndpointPolicyOutput {
        return get_origin_endpoint_policy.execute(self, allocator, input, options);
    }

    /// Retrieves all channel groups that are configured in Elemental MediaPackage.
    pub fn listChannelGroups(self: *Self, allocator: std.mem.Allocator, input: list_channel_groups.ListChannelGroupsInput, options: list_channel_groups.Options) !list_channel_groups.ListChannelGroupsOutput {
        return list_channel_groups.execute(self, allocator, input, options);
    }

    /// Retrieves all channels in a specific channel group that are configured in
    /// AWS Elemental MediaPackage.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Retrieves a list of harvest jobs that match the specified criteria.
    pub fn listHarvestJobs(self: *Self, allocator: std.mem.Allocator, input: list_harvest_jobs.ListHarvestJobsInput, options: list_harvest_jobs.Options) !list_harvest_jobs.ListHarvestJobsOutput {
        return list_harvest_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves all origin endpoints in a specific channel that are configured in
    /// AWS Elemental MediaPackage.
    pub fn listOriginEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_origin_endpoints.ListOriginEndpointsInput, options: list_origin_endpoints.Options) !list_origin_endpoints.ListOriginEndpointsOutput {
        return list_origin_endpoints.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches an IAM policy to the specified channel. With policies, you can
    /// specify who has access to AWS resources and what actions they can perform on
    /// those resources. You can attach only one policy with each request.
    pub fn putChannelPolicy(self: *Self, allocator: std.mem.Allocator, input: put_channel_policy.PutChannelPolicyInput, options: put_channel_policy.Options) !put_channel_policy.PutChannelPolicyOutput {
        return put_channel_policy.execute(self, allocator, input, options);
    }

    /// Attaches an IAM policy to the specified origin endpoint. You can attach only
    /// one policy with each request.
    pub fn putOriginEndpointPolicy(self: *Self, allocator: std.mem.Allocator, input: put_origin_endpoint_policy.PutOriginEndpointPolicyInput, options: put_origin_endpoint_policy.Options) !put_origin_endpoint_policy.PutOriginEndpointPolicyOutput {
        return put_origin_endpoint_policy.execute(self, allocator, input, options);
    }

    /// Resetting the channel can help to clear errors from misconfigurations in the
    /// encoder. A reset refreshes the ingest stream and removes previous content.
    ///
    /// Be sure to stop the encoder before you reset the channel, and wait at least
    /// 30 seconds before you restart the encoder.
    pub fn resetChannelState(self: *Self, allocator: std.mem.Allocator, input: reset_channel_state.ResetChannelStateInput, options: reset_channel_state.Options) !reset_channel_state.ResetChannelStateOutput {
        return reset_channel_state.execute(self, allocator, input, options);
    }

    /// Resetting the origin endpoint can help to resolve unexpected behavior and
    /// other content packaging issues. It also helps to preserve special events
    /// when you don't want the previous content to be available for viewing. A
    /// reset clears out all previous content from the origin endpoint.
    ///
    /// MediaPackage might return old content from this endpoint in the first 30
    /// seconds after the endpoint reset. For best results, when possible, wait 30
    /// seconds from endpoint reset to send playback requests to this endpoint.
    pub fn resetOriginEndpointState(self: *Self, allocator: std.mem.Allocator, input: reset_origin_endpoint_state.ResetOriginEndpointStateInput, options: reset_origin_endpoint_state.Options) !reset_origin_endpoint_state.ResetOriginEndpointStateOutput {
        return reset_origin_endpoint_state.execute(self, allocator, input, options);
    }

    /// Assigns one of more tags (key-value pairs) to the specified MediaPackage
    /// resource.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions, by granting a user permission to access or
    /// change only resources with certain tag values. You can use the TagResource
    /// operation with a resource that already has tags. If you specify a new tag
    /// key for the resource, this tag is appended to the list of tags associated
    /// with the resource. If you specify a tag key that is already associated with
    /// the resource, the new tag value that you specify replaces the previous value
    /// for that tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update the specified channel. You can edit if MediaPackage sends ingest or
    /// egress access logs to the CloudWatch log group, if content will be
    /// encrypted, the description on a channel, and your channel's policy settings.
    /// You can't edit the name of the channel or CloudFront distribution details.
    ///
    /// Any edits you make that impact the video output may not be reflected for a
    /// few minutes.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: update_channel.Options) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Update the specified channel group. You can edit the description on a
    /// channel group for easier identification later from the AWS Elemental
    /// MediaPackage console. You can't edit the name of the channel group.
    ///
    /// Any edits you make that impact the video output may not be reflected for a
    /// few minutes.
    pub fn updateChannelGroup(self: *Self, allocator: std.mem.Allocator, input: update_channel_group.UpdateChannelGroupInput, options: update_channel_group.Options) !update_channel_group.UpdateChannelGroupOutput {
        return update_channel_group.execute(self, allocator, input, options);
    }

    /// Update the specified origin endpoint. Edit the packaging preferences on an
    /// endpoint to optimize the viewing experience. You can't edit the name of the
    /// endpoint.
    ///
    /// Any edits you make that impact the video output may not be reflected for a
    /// few minutes.
    pub fn updateOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_origin_endpoint.UpdateOriginEndpointInput, options: update_origin_endpoint.Options) !update_origin_endpoint.UpdateOriginEndpointOutput {
        return update_origin_endpoint.execute(self, allocator, input, options);
    }

    pub fn listChannelGroupsPaginator(self: *Self, params: list_channel_groups.ListChannelGroupsInput) paginator.ListChannelGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHarvestJobsPaginator(self: *Self, params: list_harvest_jobs.ListHarvestJobsInput) paginator.ListHarvestJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOriginEndpointsPaginator(self: *Self, params: list_origin_endpoints.ListOriginEndpointsInput) paginator.ListOriginEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilHarvestJobFinished(self: *Self, params: get_harvest_job.GetHarvestJobInput) aws.waiter.WaiterError!void {
        var w = waiters.HarvestJobFinishedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
