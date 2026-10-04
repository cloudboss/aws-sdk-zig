const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionInput = @import("connection_input.zig").ConnectionInput;
const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

pub const CreateConnectionInput = struct {
    /// The ID of the Data Catalog in which to create the connection. If none is
    /// provided, the Amazon Web Services
    /// account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// A `ConnectionInput` object defining the connection
    /// to create.
    connection_input: ConnectionInput,

    /// The tags you assign to the connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .connection_input = "ConnectionInput",
        .tags = "Tags",
    };
};

pub const CreateConnectionOutput = struct {
    /// The status of the connection creation request. The request can take some
    /// time for certain authentication types, for example when creating an OAuth
    /// connection with token exchange over VPC.
    create_connection_status: ?ConnectionStatus = null,

    pub const json_field_names = .{
        .create_connection_status = "CreateConnectionStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
}
