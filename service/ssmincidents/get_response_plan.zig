const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const ChatChannel = @import("chat_channel.zig").ChatChannel;
const IncidentTemplate = @import("incident_template.zig").IncidentTemplate;
const Integration = @import("integration.zig").Integration;

pub const GetResponsePlanInput = struct {
    /// The Amazon Resource Name (ARN) of the response plan.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const GetResponsePlanOutput = struct {
    /// The actions that this response plan takes at the beginning of the incident.
    actions: ?[]const Action = null,

    /// The ARN of the response plan.
    arn: []const u8,

    /// The Chatbot chat channel used for collaboration during an incident.
    chat_channel: ?ChatChannel = null,

    /// The long format name of the response plan. Can contain spaces.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the contacts and escalation plans that
    /// the response
    /// plan engages during an incident.
    engagements: ?[]const []const u8 = null,

    /// Details used to create the incident when using this response plan.
    incident_template: ?IncidentTemplate = null,

    /// Information about third-party services integrated into the Incident Manager
    /// response
    /// plan.
    integrations: ?[]const Integration = null,

    /// The short format name of the response plan. The name can't contain spaces.
    name: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .arn = "arn",
        .chat_channel = "chatChannel",
        .display_name = "displayName",
        .engagements = "engagements",
        .incident_template = "incidentTemplate",
        .integrations = "integrations",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResponsePlanInput, options: CallOptions) !GetResponsePlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-incidents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResponsePlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getResponsePlan";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResponsePlanOutput {
    const result: GetResponsePlanOutput = try aws.json.parseJsonObject(
        GetResponsePlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
