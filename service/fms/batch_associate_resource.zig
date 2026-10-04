const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailedItem = @import("failed_item.zig").FailedItem;

pub const BatchAssociateResourceInput = struct {
    /// The uniform resource identifiers (URIs) of resources that should be
    /// associated to the resource set. The URIs must be Amazon Resource Names
    /// (ARNs).
    items: []const []const u8,

    /// A unique identifier for the resource set, used in a request to refer to the
    /// resource set.
    resource_set_identifier: []const u8,

    pub const json_field_names = .{
        .items = "Items",
        .resource_set_identifier = "ResourceSetIdentifier",
    };
};

pub const BatchAssociateResourceOutput = struct {
    /// The resources that failed to associate to the resource set.
    failed_items: ?[]const FailedItem = null,

    /// A unique identifier for the resource set, used in a request to refer to the
    /// resource set.
    resource_set_identifier: []const u8,

    pub const json_field_names = .{
        .failed_items = "FailedItems",
        .resource_set_identifier = "ResourceSetIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchAssociateResourceInput, options: CallOptions) !BatchAssociateResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchAssociateResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.BatchAssociateResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchAssociateResourceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchAssociateResourceOutput, body, allocator);
}
