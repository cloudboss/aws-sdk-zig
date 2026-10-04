const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const DisassociateResourceInput = struct {
    /// The name or ID of the application.
    application: []const u8,

    /// The name or ID of the resource.
    resource: []const u8,

    /// The type of the resource that is being disassociated.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .application = "application",
        .resource = "resource",
        .resource_type = "resourceType",
    };
};

pub const DisassociateResourceOutput = struct {
    /// The Amazon resource name (ARN) that specifies the application.
    application_arn: ?[]const u8 = null,

    /// The Amazon resource name (ARN) that specifies the resource.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .resource_arn = "resourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateResourceInput, options: CallOptions) !DisassociateResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog-appregistry", "Service Catalog AppRegistry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.resource);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateResourceOutput {
    const result: DisassociateResourceOutput = try aws.json.parseJsonObject(
        DisassociateResourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
