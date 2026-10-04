const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryDestinationType = @import("delivery_destination_type.zig").DeliveryDestinationType;

pub const GetDestinationInput = struct {
    /// The name of the customer-managed destination.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetDestinationOutput = struct {
    /// The timestamp value of when the destination creation requset occurred.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the customer-managed destination.
    delivery_destination_arn: ?[]const u8 = null,

    /// The destination type for the customer-managed destination.
    delivery_destination_type: ?DeliveryDestinationType = null,

    /// The description of the customer-managed destination.
    description: ?[]const u8 = null,

    /// The name of the customer-managed destination.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the delivery destination role.
    role_arn: ?[]const u8 = null,

    /// A set of key/value pairs that are used to manage the customer-managed
    /// destination.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp value of when the destination update requset occurred.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .delivery_destination_arn = "DeliveryDestinationArn",
        .delivery_destination_type = "DeliveryDestinationType",
        .description = "Description",
        .name = "Name",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDestinationInput, options: CallOptions) !GetDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/destinations/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDestinationOutput {
    const result: GetDestinationOutput = try aws.json.parseJsonObject(
        GetDestinationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
