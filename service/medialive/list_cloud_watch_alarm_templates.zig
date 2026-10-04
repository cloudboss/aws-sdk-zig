const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudWatchAlarmTemplateSummary = @import("cloud_watch_alarm_template_summary.zig").CloudWatchAlarmTemplateSummary;

pub const ListCloudWatchAlarmTemplatesInput = struct {
    /// A cloudwatch alarm template group's identifier. Can be either be its id or
    /// current name.
    group_identifier: ?[]const u8 = null,

    max_results: ?i32 = null,

    /// A token used to retrieve the next set of results in paginated list
    /// responses.
    next_token: ?[]const u8 = null,

    /// Represents the scope of a resource, with options for all scopes, AWS
    /// provided resources, or local resources.
    scope: ?[]const u8 = null,

    /// A signal map's identifier. Can be either be its id or current name.
    signal_map_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_identifier = "GroupIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .scope = "Scope",
        .signal_map_identifier = "SignalMapIdentifier",
    };
};

pub const ListCloudWatchAlarmTemplatesOutput = struct {
    cloud_watch_alarm_templates: ?[]const CloudWatchAlarmTemplateSummary = null,

    /// A token used to retrieve the next set of results in paginated list
    /// responses.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_alarm_templates = "CloudWatchAlarmTemplates",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCloudWatchAlarmTemplatesInput, options: CallOptions) !ListCloudWatchAlarmTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCloudWatchAlarmTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prod/cloudwatch-alarm-templates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.group_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "groupIdentifier=");
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
    if (input.scope) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "scope=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.signal_map_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "signalMapIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCloudWatchAlarmTemplatesOutput {
    const result: ListCloudWatchAlarmTemplatesOutput = try aws.json.parseJsonObject(
        ListCloudWatchAlarmTemplatesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
