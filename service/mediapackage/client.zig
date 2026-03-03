const aws = @import("aws");
const std = @import("std");

const configure_logs = @import("configure_logs.zig");
const create_channel = @import("create_channel.zig");
const create_harvest_job = @import("create_harvest_job.zig");
const create_origin_endpoint = @import("create_origin_endpoint.zig");
const delete_channel = @import("delete_channel.zig");
const delete_origin_endpoint = @import("delete_origin_endpoint.zig");
const describe_channel = @import("describe_channel.zig");
const describe_harvest_job = @import("describe_harvest_job.zig");
const describe_origin_endpoint = @import("describe_origin_endpoint.zig");
const list_channels = @import("list_channels.zig");
const list_harvest_jobs = @import("list_harvest_jobs.zig");
const list_origin_endpoints = @import("list_origin_endpoints.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const rotate_channel_credentials = @import("rotate_channel_credentials.zig");
const rotate_ingest_endpoint_credentials = @import("rotate_ingest_endpoint_credentials.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_origin_endpoint = @import("update_origin_endpoint.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaPackage";

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

    /// Changes the Channel's properities to configure log subscription
    pub fn configureLogs(self: *Self, allocator: std.mem.Allocator, input: configure_logs.ConfigureLogsInput, options: CallOptions) !configure_logs.ConfigureLogsOutput {
        return configure_logs.execute(self, allocator, input, options);
    }

    /// Creates a new Channel.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: CallOptions) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Creates a new HarvestJob record.
    pub fn createHarvestJob(self: *Self, allocator: std.mem.Allocator, input: create_harvest_job.CreateHarvestJobInput, options: CallOptions) !create_harvest_job.CreateHarvestJobOutput {
        return create_harvest_job.execute(self, allocator, input, options);
    }

    /// Creates a new OriginEndpoint record.
    pub fn createOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_origin_endpoint.CreateOriginEndpointInput, options: CallOptions) !create_origin_endpoint.CreateOriginEndpointOutput {
        return create_origin_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an existing Channel.
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: CallOptions) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// Deletes an existing OriginEndpoint.
    pub fn deleteOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_origin_endpoint.DeleteOriginEndpointInput, options: CallOptions) !delete_origin_endpoint.DeleteOriginEndpointOutput {
        return delete_origin_endpoint.execute(self, allocator, input, options);
    }

    /// Gets details about a Channel.
    pub fn describeChannel(self: *Self, allocator: std.mem.Allocator, input: describe_channel.DescribeChannelInput, options: CallOptions) !describe_channel.DescribeChannelOutput {
        return describe_channel.execute(self, allocator, input, options);
    }

    /// Gets details about an existing HarvestJob.
    pub fn describeHarvestJob(self: *Self, allocator: std.mem.Allocator, input: describe_harvest_job.DescribeHarvestJobInput, options: CallOptions) !describe_harvest_job.DescribeHarvestJobOutput {
        return describe_harvest_job.execute(self, allocator, input, options);
    }

    /// Gets details about an existing OriginEndpoint.
    pub fn describeOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_origin_endpoint.DescribeOriginEndpointInput, options: CallOptions) !describe_origin_endpoint.DescribeOriginEndpointOutput {
        return describe_origin_endpoint.execute(self, allocator, input, options);
    }

    /// Returns a collection of Channels.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: CallOptions) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Returns a collection of HarvestJob records.
    pub fn listHarvestJobs(self: *Self, allocator: std.mem.Allocator, input: list_harvest_jobs.ListHarvestJobsInput, options: CallOptions) !list_harvest_jobs.ListHarvestJobsOutput {
        return list_harvest_jobs.execute(self, allocator, input, options);
    }

    /// Returns a collection of OriginEndpoint records.
    pub fn listOriginEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_origin_endpoints.ListOriginEndpointsInput, options: CallOptions) !list_origin_endpoints.ListOriginEndpointsOutput {
        return list_origin_endpoints.execute(self, allocator, input, options);
    }

    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Changes the Channel's first IngestEndpoint's username and password. WARNING
    /// - This API is deprecated. Please use RotateIngestEndpointCredentials instead
    pub fn rotateChannelCredentials(self: *Self, allocator: std.mem.Allocator, input: rotate_channel_credentials.RotateChannelCredentialsInput, options: CallOptions) !rotate_channel_credentials.RotateChannelCredentialsOutput {
        return rotate_channel_credentials.execute(self, allocator, input, options);
    }

    /// Rotate the IngestEndpoint's username and password, as specified by the
    /// IngestEndpoint's id.
    pub fn rotateIngestEndpointCredentials(self: *Self, allocator: std.mem.Allocator, input: rotate_ingest_endpoint_credentials.RotateIngestEndpointCredentialsInput, options: CallOptions) !rotate_ingest_endpoint_credentials.RotateIngestEndpointCredentialsOutput {
        return rotate_ingest_endpoint_credentials.execute(self, allocator, input, options);
    }

    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Channel.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: CallOptions) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Updates an existing OriginEndpoint.
    pub fn updateOriginEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_origin_endpoint.UpdateOriginEndpointInput, options: CallOptions) !update_origin_endpoint.UpdateOriginEndpointOutput {
        return update_origin_endpoint.execute(self, allocator, input, options);
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
};
