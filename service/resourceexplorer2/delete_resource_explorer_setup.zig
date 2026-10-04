const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteResourceExplorerSetupInput = struct {
    /// Specifies whether to delete Resource Explorer configuration from all Regions
    /// where it is currently enabled. If this parameter is set to `true`, a value
    /// for `RegionList` must not be provided. Otherwise, the operation fails with a
    /// `ValidationException` error.
    delete_in_all_regions: ?bool = null,

    /// A list of Amazon Web Services Regions from which to delete the Resource
    /// Explorer configuration. If not specified, the operation uses the
    /// `DeleteInAllRegions` parameter to determine scope.
    region_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .delete_in_all_regions = "DeleteInAllRegions",
        .region_list = "RegionList",
    };
};

pub const DeleteResourceExplorerSetupOutput = struct {
    /// The unique identifier for the deletion task. Use this ID with
    /// `GetResourceExplorerSetup` to monitor the progress of the deletion
    /// operation.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "TaskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteResourceExplorerSetupInput, options: CallOptions) !DeleteResourceExplorerSetupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-explorer-2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteResourceExplorerSetupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DeleteResourceExplorerSetup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.delete_in_all_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeleteInAllRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.region_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RegionList\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteResourceExplorerSetupOutput {
    var result: DeleteResourceExplorerSetupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteResourceExplorerSetupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
