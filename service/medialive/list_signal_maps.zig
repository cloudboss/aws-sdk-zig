const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SignalMapSummary = @import("signal_map_summary.zig").SignalMapSummary;

pub const ListSignalMapsInput = struct {
    /// A cloudwatch alarm template group's identifier. Can be either be its id or
    /// current name.
    cloud_watch_alarm_template_group_identifier: ?[]const u8 = null,

    /// An eventbridge rule template group's identifier. Can be either be its id or
    /// current name.
    event_bridge_rule_template_group_identifier: ?[]const u8 = null,

    max_results: ?i32 = null,

    /// A token used to retrieve the next set of results in paginated list
    /// responses.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_alarm_template_group_identifier = "CloudWatchAlarmTemplateGroupIdentifier",
        .event_bridge_rule_template_group_identifier = "EventBridgeRuleTemplateGroupIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSignalMapsOutput = struct {
    /// A token used to retrieve the next set of results in paginated list
    /// responses.
    next_token: ?[]const u8 = null,

    signal_maps: ?[]const SignalMapSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .signal_maps = "SignalMaps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSignalMapsInput, options: CallOptions) !ListSignalMapsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSignalMapsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prod/signal-maps";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cloud_watch_alarm_template_group_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "cloudWatchAlarmTemplateGroupIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.event_bridge_rule_template_group_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "eventBridgeRuleTemplateGroupIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSignalMapsOutput {
    const result: ListSignalMapsOutput = try aws.json.parseJsonObject(
        ListSignalMapsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
