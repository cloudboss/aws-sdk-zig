const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppDefinition = @import("app_definition.zig").AppDefinition;
const AppRequiredCapability = @import("app_required_capability.zig").AppRequiredCapability;
const AppStatus = @import("app_status.zig").AppStatus;

pub const GetQAppInput = struct {
    /// The unique identifier of the Q App to retrieve.
    app_id: []const u8,

    /// The version of the Q App.
    app_version: ?i32 = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_version = "appVersion",
        .instance_id = "instanceId",
    };
};

pub const GetQAppOutput = struct {
    /// The Amazon Resource Name (ARN) of the Q App.
    app_arn: []const u8,

    /// The full definition of the Q App, specifying the cards and flow.
    app_definition: ?AppDefinition = null,

    /// The unique identifier of the Q App.
    app_id: []const u8,

    /// The version of the Q App.
    app_version: i32,

    /// The date and time the Q App was created.
    created_at: i64,

    /// The user who created the Q App.
    created_by: []const u8,

    /// The description of the Q App.
    description: ?[]const u8 = null,

    /// The initial prompt displayed when the Q App is started.
    initial_prompt: ?[]const u8 = null,

    /// The capabilities required to run the Q App, such as file upload or
    /// third-party integrations.
    required_capabilities: ?[]const AppRequiredCapability = null,

    /// The status of the Q App.
    status: AppStatus,

    /// The title of the Q App.
    title: []const u8,

    /// The date and time the Q App was last updated.
    updated_at: i64,

    /// The user who last updated the Q App.
    updated_by: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_definition = "appDefinition",
        .app_id = "appId",
        .app_version = "appVersion",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .initial_prompt = "initialPrompt",
        .required_capabilities = "requiredCapabilities",
        .status = "status",
        .title = "title",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQAppInput, options: CallOptions) !GetQAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apps.get";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "appId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.app_id);
    query_has_prev = true;
    if (input.app_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "appVersion=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQAppOutput {
    const result: GetQAppOutput = try aws.json.parseJsonObject(
        GetQAppOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
