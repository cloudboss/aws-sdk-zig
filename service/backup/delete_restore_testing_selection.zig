const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteRestoreTestingSelectionInput = struct {
    /// Required unique name of the restore testing plan that contains the
    /// restore testing selection you wish to delete.
    restore_testing_plan_name: []const u8,

    /// Required unique name of the restore testing selection you
    /// wish to delete.
    restore_testing_selection_name: []const u8,

    pub const json_field_names = .{
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
    };
};

pub const DeleteRestoreTestingSelectionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRestoreTestingSelectionInput, options: CallOptions) !DeleteRestoreTestingSelectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRestoreTestingSelectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restore-testing/plans/");
    try path_buf.appendSlice(allocator, input.restore_testing_plan_name);
    try path_buf.appendSlice(allocator, "/selections/");
    try path_buf.appendSlice(allocator, input.restore_testing_selection_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRestoreTestingSelectionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteRestoreTestingSelectionOutput = .{};

    return result;
}
