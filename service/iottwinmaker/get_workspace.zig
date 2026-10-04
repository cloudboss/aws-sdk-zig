const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetWorkspaceInput = struct {
    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .workspace_id = "workspaceId",
    };
};

pub const GetWorkspaceOutput = struct {
    /// The ARN of the workspace.
    arn: []const u8,

    /// The date and time when the workspace was created.
    creation_date_time: i64,

    /// The description of the workspace.
    description: ?[]const u8 = null,

    /// A list of services that are linked to the workspace.
    linked_services: ?[]const []const u8 = null,

    /// The ARN of the execution role associated with the workspace.
    role: ?[]const u8 = null,

    /// The ARN of the S3 bucket where resources associated with the workspace are
    /// stored.
    s_3_location: ?[]const u8 = null,

    /// The date and time when the workspace was last updated.
    update_date_time: i64,

    /// The ID of the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .linked_services = "linkedServices",
        .role = "role",
        .s_3_location = "s3Location",
        .update_date_time = "updateDateTime",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkspaceInput, options: CallOptions) !GetWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkspaceOutput {
    var result: GetWorkspaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkspaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
