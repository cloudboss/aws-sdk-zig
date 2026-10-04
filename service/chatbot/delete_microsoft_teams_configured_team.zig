const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteMicrosoftTeamsConfiguredTeamInput = struct {
    /// The ID of the Microsoft Teams team authorized with AWS Chatbot.
    ///
    /// To get the team ID, you must perform the initial authorization flow with
    /// Microsoft Teams in the AWS Chatbot console. Then you can copy and paste the
    /// team ID from the console. For more information, see [Step 1: Configure a
    /// Microsoft Teams
    /// client](https://docs.aws.amazon.com/chatbot/latest/adminguide/teams-setup.html#teams-client-setup) in the * AWS Chatbot Administrator Guide*.
    team_id: []const u8,

    pub const json_field_names = .{
        .team_id = "TeamId",
    };
};

pub const DeleteMicrosoftTeamsConfiguredTeamOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteMicrosoftTeamsConfiguredTeamInput, options: CallOptions) !DeleteMicrosoftTeamsConfiguredTeamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteMicrosoftTeamsConfiguredTeamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delete-ms-teams-configured-teams";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TeamId\":");
    try aws.json.writeValue(@TypeOf(input.team_id), input.team_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteMicrosoftTeamsConfiguredTeamOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteMicrosoftTeamsConfiguredTeamOutput = .{};

    return result;
}
