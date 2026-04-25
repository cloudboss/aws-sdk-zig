const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Permission = @import("permission.zig").Permission;
const Privilege = @import("privilege.zig").Privilege;
const S3PrefixType = @import("s3_prefix_type.zig").S3PrefixType;
const Credentials = @import("credentials.zig").Credentials;
const Grantee = @import("grantee.zig").Grantee;
const serde = @import("serde.zig");

pub const GetDataAccessInput = struct {
    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// The context to identify the job or query associated with the credential
    /// request. This information will be displayed in CloudTrail log in your
    /// account.
    audit_context: ?[]const u8 = null,

    /// The session duration, in seconds, of the temporary access credential that S3
    /// Access Grants vends to the grantee or client application. The default value
    /// is 1 hour, but the grantee can specify a range from 900 seconds (15 minutes)
    /// up to 43200 seconds (12 hours). If the grantee requests a value higher than
    /// this maximum, the operation fails.
    duration_seconds: ?i32 = null,

    /// The type of permission granted to your S3 data, which can be set to one of
    /// the following values:
    ///
    /// * `READ` – Grant read-only access to the S3 data.
    ///
    /// * `WRITE` – Grant write-only access to the S3 data.
    ///
    /// * `READWRITE` – Grant both read and write access to the S3 data.
    permission: Permission,

    /// The scope of the temporary access credential that S3 Access Grants vends to
    /// the grantee or client application.
    ///
    /// * `Default` – The scope of the returned temporary access token is the scope
    ///   of the grant that is closest to the target scope.
    ///
    /// * `Minimal` – The scope of the returned temporary access token is the same
    ///   as the requested target scope as long as the requested scope is the same
    ///   as or a subset of the grant scope.
    privilege: ?Privilege = null,

    /// The S3 URI path of the data to which you are requesting temporary access
    /// credentials. If the requesting account has an access grant for this data, S3
    /// Access Grants vends temporary access credentials in the response.
    target: []const u8,

    /// The type of `Target`. The only possible value is `Object`. Pass this value
    /// if the target data that you would like to access is a path to an object. Do
    /// not pass this value if the target data is a bucket or a bucket and a prefix.
    target_type: ?S3PrefixType = null,
};

pub const GetDataAccessOutput = struct {
    /// The temporary credential token that S3 Access Grants vends.
    credentials: ?Credentials = null,

    /// The user, group, or role that was granted access to the S3 location scope.
    /// For directory identities, this API also returns the grants of the IAM role
    /// used for the identity-aware request. For more information on identity-aware
    /// sessions, see [Granting permissions to use identity-aware console
    /// sessions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_sts-setcontext.html).
    grantee: ?Grantee = null,

    /// The S3 URI path of the data to which you are being granted temporary access
    /// credentials.
    matched_grant_target: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataAccessInput, options: CallOptions) !GetDataAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v20180820/accessgrantsinstance/dataaccess";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.audit_context) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "auditContext=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.duration_seconds) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "durationSeconds=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "permission=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.permission.wireName());
    query_has_prev = true;
    if (input.privilege) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "privilege=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "target=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target);
    query_has_prev = true;
    if (input.target_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "targetType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataAccessOutput {
    var result: GetDataAccessOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try serde.deserializeGrantee(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "MatchedGrantTarget")) {
                    result.matched_grant_target = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobStatusException")) {
        return .{ .arena = arena, .kind = .{ .job_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchPublicAccessBlockConfiguration")) {
        return .{ .arena = arena, .kind = .{ .no_such_public_access_block_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
