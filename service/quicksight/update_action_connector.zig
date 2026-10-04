const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthConfig = @import("auth_config.zig").AuthConfig;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateActionConnectorInput = struct {
    /// The unique identifier of the action connector to update.
    action_connector_id: []const u8,

    /// The updated authentication configuration for connecting to the external
    /// service.
    authentication_config: AuthConfig,

    /// The Amazon Web Services account ID that contains the action connector to
    /// update.
    aws_account_id: []const u8,

    /// The updated description of the action connector.
    description: ?[]const u8 = null,

    /// The new name for the action connector.
    name: []const u8,

    /// The updated ARN of the VPC connection to use for secure connectivity.
    vpc_connection_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_connector_id = "ActionConnectorId",
        .authentication_config = "AuthenticationConfig",
        .aws_account_id = "AwsAccountId",
        .description = "Description",
        .name = "Name",
        .vpc_connection_arn = "VpcConnectionArn",
    };
};

pub const UpdateActionConnectorOutput = struct {
    /// The unique identifier of the updated action connector.
    action_connector_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the updated action connector.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status code of the request.
    status: ?i32 = null,

    /// The status of the update operation.
    update_status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .action_connector_id = "ActionConnectorId",
        .arn = "Arn",
        .request_id = "RequestId",
        .status = "Status",
        .update_status = "UpdateStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateActionConnectorInput, options: CallOptions) !UpdateActionConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateActionConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/action-connectors/");
    try path_buf.appendSlice(allocator, input.action_connector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthenticationConfig\":");
    try aws.json.writeValue(@TypeOf(input.authentication_config), input.authentication_config, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.vpc_connection_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcConnectionArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateActionConnectorOutput {
    var result: UpdateActionConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateActionConnectorOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
