const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingConfiguration = @import("billing_configuration.zig").BillingConfiguration;
const ManagedInstanceRequest = @import("managed_instance_request.zig").ManagedInstanceRequest;
const Tag = @import("tag.zig").Tag;

pub const CreateWorkspaceInstanceInput = struct {
    /// Optional billing configuration for the WorkSpace Instance. Allows customers
    /// to specify their preferred billing mode when creating a new instance.
    /// Defaults to hourly billing if not specified.
    billing_configuration: ?BillingConfiguration = null,

    /// Unique token to ensure idempotent instance creation, preventing duplicate
    /// workspace launches.
    client_token: ?[]const u8 = null,

    /// Comprehensive configuration settings for the WorkSpaces Instance, including
    /// network, compute, and storage parameters.
    managed_instance: ManagedInstanceRequest,

    /// Optional metadata tags for categorizing and managing WorkSpaces Instances.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .billing_configuration = "BillingConfiguration",
        .client_token = "ClientToken",
        .managed_instance = "ManagedInstance",
        .tags = "Tags",
    };
};

pub const CreateWorkspaceInstanceOutput = struct {
    /// Unique identifier assigned to the newly created WorkSpaces Instance.
    workspace_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .workspace_instance_id = "WorkspaceInstanceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceInstanceInput, options: CallOptions) !CreateWorkspaceInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-instances", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-instances", "Workspaces Instances", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "EUCMIFrontendAPIService.CreateWorkspaceInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWorkspaceInstanceOutput, body, allocator);
}
