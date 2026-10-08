const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Integrations = @import("integrations.zig").Integrations;

pub const GetApplicationInput = struct {
    /// The name, ID, or ARN
    /// of the application.
    application: []const u8,

    pub const json_field_names = .{
        .application = "application",
    };
};

pub const GetApplicationOutput = struct {
    /// A key-value pair that identifies an associated resource.
    application_tag: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon resource name (ARN) that specifies the application across
    /// services.
    arn: ?[]const u8 = null,

    /// The number of top-level resources that were registered as part of this
    /// application.
    associated_resource_count: ?i32 = null,

    /// The ISO-8601 formatted timestamp of the moment when the application was
    /// created.
    creation_time: ?i64 = null,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// The identifier of the application.
    id: ?[]const u8 = null,

    /// The information
    /// about the integration
    /// of the application
    /// with other services,
    /// such as
    /// Resource Groups.
    integrations: ?Integrations = null,

    /// The ISO-8601 formatted timestamp of the moment when the application was last
    /// updated.
    last_update_time: ?i64 = null,

    /// The name of the application. The name must be unique in the region in which
    /// you are creating the application.
    name: ?[]const u8 = null,

    /// Key-value pairs associated with the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_tag = "applicationTag",
        .arn = "arn",
        .associated_resource_count = "associatedResourceCount",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .integrations = "integrations",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog-appregistry", "Service Catalog AppRegistry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
