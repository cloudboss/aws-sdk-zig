const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ItemError = @import("item_error.zig").ItemError;
const IterableFormItem = @import("iterable_form_item.zig").IterableFormItem;

pub const BatchGetIterableFormsInput = struct {
    /// The unique identifier of the asset.
    asset_identifier: []const u8,

    /// The list of item identifiers to retrieve. Each identifier can be an item ID
    /// or item name.
    item_identifiers: []const []const u8,

    /// The name of the iterable form to retrieve items from.
    iterable_form_name: []const u8,

    pub const json_field_names = .{
        .asset_identifier = "AssetIdentifier",
        .item_identifiers = "ItemIdentifiers",
        .iterable_form_name = "IterableFormName",
    };
};

pub const BatchGetIterableFormsOutput = struct {
    /// The list of errors for items that could not be retrieved.
    errors: ?[]const ItemError = null,

    /// The list of retrieved iterable form items.
    items: ?[]const IterableFormItem = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .items = "Items",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetIterableFormsInput, options: CallOptions) !BatchGetIterableFormsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetIterableFormsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchGetIterableForms");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetIterableFormsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetIterableFormsOutput, body, allocator);
}
