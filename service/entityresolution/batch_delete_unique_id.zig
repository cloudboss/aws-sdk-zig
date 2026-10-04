const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletedUniqueId = @import("deleted_unique_id.zig").DeletedUniqueId;
const DeleteUniqueIdError = @import("delete_unique_id_error.zig").DeleteUniqueIdError;
const DeleteUniqueIdStatus = @import("delete_unique_id_status.zig").DeleteUniqueIdStatus;

pub const BatchDeleteUniqueIdInput = struct {
    /// The input source for the batch delete unique ID operation.
    input_source: ?[]const u8 = null,

    /// The unique IDs to delete.
    unique_ids: []const []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .input_source = "inputSource",
        .unique_ids = "uniqueIds",
        .workflow_name = "workflowName",
    };
};

pub const BatchDeleteUniqueIdOutput = struct {
    /// The unique IDs that were deleted.
    deleted: ?[]const DeletedUniqueId = null,

    /// The unique IDs that were disconnected.
    disconnected_unique_ids: ?[]const []const u8 = null,

    /// The errors from deleting multiple unique IDs.
    errors: ?[]const DeleteUniqueIdError = null,

    /// The status of the batch delete unique ID operation.
    status: DeleteUniqueIdStatus,

    pub const json_field_names = .{
        .deleted = "deleted",
        .disconnected_unique_ids = "disconnectedUniqueIds",
        .errors = "errors",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteUniqueIdInput, options: CallOptions) !BatchDeleteUniqueIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteUniqueIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/matchingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    try path_buf.appendSlice(allocator, "/uniqueids");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.input_source) |v| {
        try request.headers.put(allocator, "inputSource", v);
    }
    {
        var header_buf: std.ArrayList(u8) = .empty;
        for (input.unique_ids) |item| {
            if (header_buf.items.len > 0) try header_buf.appendSlice(allocator, ", ");
            try header_buf.appendSlice(allocator, item);
        }
        try request.headers.put(allocator, "uniqueIds", header_buf.items);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteUniqueIdOutput {
    const result: BatchDeleteUniqueIdOutput = try aws.json.parseJsonObject(
        BatchDeleteUniqueIdOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
