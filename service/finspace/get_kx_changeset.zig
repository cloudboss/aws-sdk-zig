const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeRequest = @import("change_request.zig").ChangeRequest;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const ChangesetStatus = @import("changeset_status.zig").ChangesetStatus;

pub const GetKxChangesetInput = struct {
    /// A unique identifier of the changeset for which you want to retrieve data.
    changeset_id: []const u8,

    /// The name of the kdb database.
    database_name: []const u8,

    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .database_name = "databaseName",
        .environment_id = "environmentId",
    };
};

pub const GetKxChangesetOutput = struct {
    /// Beginning time from which the changeset is active. The value is determined
    /// as epoch time in
    /// milliseconds. For example, the value for Monday, November 1, 2021 12:00:00
    /// PM UTC is specified as
    /// 1635768000000.
    active_from_timestamp: ?i64 = null,

    /// A list of change request objects that are run in order.
    change_requests: ?[]const ChangeRequest = null,

    /// A unique identifier for the changeset.
    changeset_id: ?[]const u8 = null,

    /// The timestamp at which the changeset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// The name of the kdb database.
    database_name: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// Provides details in the event of a failed flow, including the error type and
    /// the related error message.
    error_info: ?ErrorInfo = null,

    /// The timestamp at which the changeset was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// Status of the changeset creation process.
    ///
    /// * Pending – Changeset creation is pending.
    ///
    /// * Processing – Changeset creation is running.
    ///
    /// * Failed – Changeset creation has failed.
    ///
    /// * Complete – Changeset creation has succeeded.
    status: ?ChangesetStatus = null,

    pub const json_field_names = .{
        .active_from_timestamp = "activeFromTimestamp",
        .change_requests = "changeRequests",
        .changeset_id = "changesetId",
        .created_timestamp = "createdTimestamp",
        .database_name = "databaseName",
        .environment_id = "environmentId",
        .error_info = "errorInfo",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKxChangesetInput, options: CallOptions) !GetKxChangesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKxChangesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/databases/");
    try path_buf.appendSlice(allocator, input.database_name);
    try path_buf.appendSlice(allocator, "/changesets/");
    try path_buf.appendSlice(allocator, input.changeset_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKxChangesetOutput {
    const result: GetKxChangesetOutput = try aws.json.parseJsonObject(
        GetKxChangesetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
