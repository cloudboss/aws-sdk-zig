const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeRequest = @import("change_request.zig").ChangeRequest;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const ChangesetStatus = @import("changeset_status.zig").ChangesetStatus;

pub const CreateKxChangesetInput = struct {
    /// A list of change request objects that are run in order. A change request
    /// object consists of `changeType` , `s3Path`, and `dbPath`.
    /// A changeType can have the following values:
    ///
    /// * PUT – Adds or updates files in a database.
    ///
    /// * DELETE – Deletes files in a database.
    ///
    /// All the change requests require a mandatory `dbPath` attribute that defines
    /// the
    /// path within the database directory. All database paths must start with a
    /// leading / and end
    /// with a trailing /. The `s3Path` attribute defines the s3 source file path
    /// and is
    /// required for a PUT change type. The `s3path` must end with a trailing / if
    /// it is
    /// a directory and must end without a trailing / if it is a file.
    ///
    /// Here are few examples of how you can use the change request object:
    ///
    /// * This request adds a single sym file at database root location.
    ///
    /// `{ "changeType": "PUT", "s3Path":"s3://bucket/db/sym",
    /// "dbPath":"/"}`
    ///
    /// * This request adds files in the given `s3Path` under the 2020.01.02
    /// partition of the database.
    ///
    /// `{ "changeType": "PUT", "s3Path":"s3://bucket/db/2020.01.02/",
    /// "dbPath":"/2020.01.02/"}`
    ///
    /// * This request adds files in the given `s3Path` under the
    /// *taq* table partition of the database.
    ///
    /// `[ { "changeType": "PUT", "s3Path":"s3://bucket/db/2020.01.02/taq/",
    /// "dbPath":"/2020.01.02/taq/"}]`
    ///
    /// * This request deletes the 2020.01.02 partition of the database.
    ///
    /// `[{ "changeType": "DELETE", "dbPath": "/2020.01.02/"} ]`
    ///
    /// * The *DELETE* request allows you to delete the existing files under the
    /// 2020.01.02 partition of the database, and the *PUT* request adds a
    /// new taq table under it.
    ///
    /// `[ {"changeType": "DELETE", "dbPath":"/2020.01.02/"}, {"changeType": "PUT",
    /// "s3Path":"s3://bucket/db/2020.01.02/taq/",
    /// "dbPath":"/2020.01.02/taq/"}]`
    change_requests: []const ChangeRequest,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: []const u8,

    /// The name of the kdb database.
    database_name: []const u8,

    /// A unique identifier of the kdb environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .change_requests = "changeRequests",
        .client_token = "clientToken",
        .database_name = "databaseName",
        .environment_id = "environmentId",
    };
};

pub const CreateKxChangesetOutput = struct {
    /// A list of change requests.
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

    /// The details of the error that you receive when creating a changeset. It
    /// consists of the type of error and the error message.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKxChangesetInput, options: CallOptions) !CreateKxChangesetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKxChangesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/databases/");
    try path_buf.appendSlice(allocator, input.database_name);
    try path_buf.appendSlice(allocator, "/changesets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"changeRequests\":");
    try aws.json.writeValue(@TypeOf(input.change_requests), input.change_requests, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKxChangesetOutput {
    const result: CreateKxChangesetOutput = try aws.json.parseJsonObject(
        CreateKxChangesetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
