const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const HarvestedManifests = @import("harvested_manifests.zig").HarvestedManifests;
const HarvesterScheduleConfiguration = @import("harvester_schedule_configuration.zig").HarvesterScheduleConfiguration;
const HarvestJobStatus = @import("harvest_job_status.zig").HarvestJobStatus;

pub const GetHarvestJobInput = struct {
    /// The name of the channel group containing the channel associated with the
    /// harvest job.
    channel_group_name: []const u8,

    /// The name of the channel associated with the harvest job.
    channel_name: []const u8,

    /// The name of the harvest job to retrieve.
    harvest_job_name: []const u8,

    /// The name of the origin endpoint associated with the harvest job.
    origin_endpoint_name: []const u8,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .harvest_job_name = "HarvestJobName",
        .origin_endpoint_name = "OriginEndpointName",
    };
};

pub const GetHarvestJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the harvest job.
    arn: []const u8,

    /// The name of the channel group containing the channel associated with the
    /// harvest job.
    channel_group_name: []const u8,

    /// The name of the channel associated with the harvest job.
    channel_name: []const u8,

    /// The date and time when the harvest job was created.
    created_at: i64,

    /// The description of the harvest job, if provided.
    description: ?[]const u8 = null,

    /// The S3 destination where the harvested content is being placed.
    destination: ?Destination = null,

    /// An error message if the harvest job encountered any issues.
    error_message: ?[]const u8 = null,

    /// The current version of the harvest job. Used for concurrency control.
    e_tag: ?[]const u8 = null,

    /// A list of manifests that are being or have been harvested.
    harvested_manifests: ?HarvestedManifests = null,

    /// The name of the harvest job.
    harvest_job_name: []const u8,

    /// The date and time when the harvest job was last modified.
    modified_at: i64,

    /// The name of the origin endpoint associated with the harvest job.
    origin_endpoint_name: []const u8,

    /// The configuration for when the harvest job is scheduled to run, including
    /// start and end times.
    schedule_configuration: ?HarvesterScheduleConfiguration = null,

    /// The current status of the harvest job (e.g., QUEUED, IN_PROGRESS, CANCELLED,
    /// COMPLETED, FAILED).
    status: HarvestJobStatus,

    /// A collection of tags associated with the harvest job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .destination = "Destination",
        .error_message = "ErrorMessage",
        .e_tag = "ETag",
        .harvested_manifests = "HarvestedManifests",
        .harvest_job_name = "HarvestJobName",
        .modified_at = "ModifiedAt",
        .origin_endpoint_name = "OriginEndpointName",
        .schedule_configuration = "ScheduleConfiguration",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHarvestJobInput, options: CallOptions) !GetHarvestJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackagev2", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetHarvestJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/originEndpoint/");
    try path_buf.appendSlice(allocator, input.origin_endpoint_name);
    try path_buf.appendSlice(allocator, "/harvestJob/");
    try path_buf.appendSlice(allocator, input.harvest_job_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetHarvestJobOutput {
    var result: GetHarvestJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetHarvestJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
