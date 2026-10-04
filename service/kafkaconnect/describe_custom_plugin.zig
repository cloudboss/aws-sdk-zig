const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomPluginState = @import("custom_plugin_state.zig").CustomPluginState;
const CustomPluginRevisionSummary = @import("custom_plugin_revision_summary.zig").CustomPluginRevisionSummary;
const StateDescription = @import("state_description.zig").StateDescription;

pub const DescribeCustomPluginInput = struct {
    /// Returns information about a custom plugin.
    custom_plugin_arn: []const u8,

    pub const json_field_names = .{
        .custom_plugin_arn = "customPluginArn",
    };
};

pub const DescribeCustomPluginOutput = struct {
    /// The time that the custom plugin was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the custom plugin.
    custom_plugin_arn: ?[]const u8 = null,

    /// The state of the custom plugin.
    custom_plugin_state: ?CustomPluginState = null,

    /// The description of the custom plugin.
    description: ?[]const u8 = null,

    /// The latest successfully created revision of the custom plugin. If there are
    /// no successfully created revisions, this field will be absent.
    latest_revision: ?CustomPluginRevisionSummary = null,

    /// The name of the custom plugin.
    name: ?[]const u8 = null,

    /// Details about the state of a custom plugin.
    state_description: ?StateDescription = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .custom_plugin_arn = "customPluginArn",
        .custom_plugin_state = "customPluginState",
        .description = "description",
        .latest_revision = "latestRevision",
        .name = "name",
        .state_description = "stateDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomPluginInput, options: CallOptions) !DescribeCustomPluginOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCustomPluginInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/custom-plugins/");
    try path_buf.appendSlice(allocator, input.custom_plugin_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCustomPluginOutput {
    var result: DescribeCustomPluginOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeCustomPluginOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
