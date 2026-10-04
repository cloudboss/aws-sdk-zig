const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TeamsChannelConfiguration = @import("teams_channel_configuration.zig").TeamsChannelConfiguration;

pub const ListMicrosoftTeamsChannelConfigurationsInput = struct {
    /// The maximum number of results to include in the response. If more results
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional token returned from a prior request. Use this token for
    /// pagination of results from this action. If this parameter is specified, the
    /// response includes only results beyond the token, up to the value specified
    /// by MaxResults.
    next_token: ?[]const u8 = null,

    /// The ID of the Microsoft Teams authorized with AWS Chatbot.
    ///
    /// To get the team ID, you must perform the initial authorization flow with
    /// Microsoft Teams in the AWS Chatbot console. Then you can copy and paste the
    /// team ID from the console. For more information, see [Step 1: Configure a
    /// Microsoft Teams
    /// client](https://docs.aws.amazon.com/chatbot/latest/adminguide/teams-setup.html#teams-client-setup) in the * AWS Chatbot Administrator Guide*.
    team_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .team_id = "TeamId",
    };
};

pub const ListMicrosoftTeamsChannelConfigurationsOutput = struct {
    /// An optional token returned from a prior request. Use this token for
    /// pagination of results from this action. If this parameter is specified, the
    /// response includes only results beyond the token, up to the value specified
    /// by MaxResults.
    next_token: ?[]const u8 = null,

    /// A list of AWS Chatbot channel configurations for Microsoft Teams.
    team_channel_configurations: ?[]const TeamsChannelConfiguration = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .team_channel_configurations = "TeamChannelConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMicrosoftTeamsChannelConfigurationsInput, options: CallOptions) !ListMicrosoftTeamsChannelConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chatbot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMicrosoftTeamsChannelConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-ms-teams-channel-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.team_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TeamId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMicrosoftTeamsChannelConfigurationsOutput {
    const result: ListMicrosoftTeamsChannelConfigurationsOutput = try aws.json.parseJsonObject(
        ListMicrosoftTeamsChannelConfigurationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
