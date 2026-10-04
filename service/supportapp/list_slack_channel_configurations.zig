const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SlackChannelConfiguration = @import("slack_channel_configuration.zig").SlackChannelConfiguration;

pub const ListSlackChannelConfigurationsInput = struct {
    /// If the results of a search are large, the API only returns a portion of the
    /// results and
    /// includes a `nextToken` pagination token in the response. To retrieve the
    /// next batch of results, reissue the search request and include the returned
    /// token.
    /// When the API returns the last set of results, the response doesn't include a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
    };
};

pub const ListSlackChannelConfigurationsOutput = struct {
    /// The point where pagination should resume when the response returns only
    /// partial
    /// results.
    next_token: ?[]const u8 = null,

    /// The configurations for a Slack channel.
    slack_channel_configurations: ?[]const SlackChannelConfiguration = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .slack_channel_configurations = "slackChannelConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSlackChannelConfigurationsInput, options: CallOptions) !ListSlackChannelConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "supportapp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSlackChannelConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportapp", "Support App", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/control/list-slack-channel-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSlackChannelConfigurationsOutput {
    var result: ListSlackChannelConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSlackChannelConfigurationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
