const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PropertyValueEntry = @import("property_value_entry.zig").PropertyValueEntry;
const BatchPutPropertyErrorEntry = @import("batch_put_property_error_entry.zig").BatchPutPropertyErrorEntry;

pub const BatchPutPropertyValuesInput = struct {
    /// An object that maps strings to the property value entries to set. Each
    /// string in the
    /// mapping must be unique to this object.
    entries: []const PropertyValueEntry,

    /// The ID of the workspace that contains the properties to set.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .entries = "entries",
        .workspace_id = "workspaceId",
    };
};

pub const BatchPutPropertyValuesOutput = struct {
    /// Entries that caused errors in the batch put operation.
    error_entries: ?[]const BatchPutPropertyErrorEntry = null,

    pub const json_field_names = .{
        .error_entries = "errorEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutPropertyValuesInput, options: CallOptions) !BatchPutPropertyValuesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutPropertyValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/entity-properties");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entries\":");
    try aws.json.writeValue(@TypeOf(input.entries), input.entries, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutPropertyValuesOutput {
    const result: BatchPutPropertyValuesOutput = try aws.json.parseJsonObject(
        BatchPutPropertyValuesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
