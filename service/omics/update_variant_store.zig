const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReferenceItem = @import("reference_item.zig").ReferenceItem;
const StoreStatus = @import("store_status.zig").StoreStatus;

pub const UpdateVariantStoreInput = struct {
    /// A description for the store.
    description: ?[]const u8 = null,

    /// A name for the store.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
    };
};

pub const UpdateVariantStoreOutput = struct {
    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: []const u8,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: []const u8,

    /// The store's genome reference.
    reference: ?ReferenceItem = null,

    /// The store's status.
    status: StoreStatus,

    /// When the store was updated.
    update_time: i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .reference = "reference",
        .status = "status",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVariantStoreInput, options: CallOptions) !UpdateVariantStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVariantStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/variantStore/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVariantStoreOutput {
    var result: UpdateVariantStoreOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateVariantStoreOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
