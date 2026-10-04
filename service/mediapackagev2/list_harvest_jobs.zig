const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HarvestJobStatus = @import("harvest_job_status.zig").HarvestJobStatus;
const HarvestJob = @import("harvest_job.zig").HarvestJob;

pub const ListHarvestJobsInput = struct {
    /// The name of the channel group to filter the harvest jobs by. If specified,
    /// only harvest jobs associated with channels in this group will be returned.
    channel_group_name: []const u8,

    /// The name of the channel to filter the harvest jobs by. If specified, only
    /// harvest jobs associated with this channel will be returned.
    channel_name: ?[]const u8 = null,

    /// The maximum number of harvest jobs to return in a single request. If not
    /// specified, a default value will be used.
    max_results: ?i32 = null,

    /// A token used for pagination. Provide this value in subsequent requests to
    /// retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the origin endpoint to filter the harvest jobs by. If specified,
    /// only harvest jobs associated with this origin endpoint will be returned.
    origin_endpoint_name: ?[]const u8 = null,

    /// The status to filter the harvest jobs by. If specified, only harvest jobs
    /// with this status will be returned.
    status: ?HarvestJobStatus = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .origin_endpoint_name = "OriginEndpointName",
        .status = "Status",
    };
};

pub const ListHarvestJobsOutput = struct {
    /// An array of harvest job objects that match the specified criteria.
    items: ?[]const HarvestJob = null,

    /// A token used for pagination. Include this value in subsequent requests to
    /// retrieve the next set of results. If null, there are no more results to
    /// retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHarvestJobsInput, options: CallOptions) !ListHarvestJobsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHarvestJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/harvestJob");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.channel_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "channelName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.origin_endpoint_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "originEndpointName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHarvestJobsOutput {
    const result: ListHarvestJobsOutput = try aws.json.parseJsonObject(
        ListHarvestJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
