const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetJobOutputInput = struct {
    /// The `AccountId` value is the AWS account ID of the account that owns the
    /// vault. You can either specify an AWS account ID or optionally a single '`-`'
    /// (hyphen), in which case Amazon Glacier uses the AWS account ID associated
    /// with the
    /// credentials used to sign the request. If you use an account ID, do not
    /// include any hyphens
    /// ('-') in the ID.
    account_id: []const u8,

    /// The job ID whose data is downloaded.
    job_id: []const u8,

    /// The range of bytes to retrieve from the output. For example, if you want to
    /// download
    /// the first 1,048,576 bytes, specify the range as `bytes=0-1048575`. By
    /// default, this operation
    /// downloads the entire output.
    ///
    /// If the job output is large, then you can use a range to
    /// retrieve a portion of the output. This allows you to download the entire
    /// output in smaller
    /// chunks of bytes. For example, suppose you have 1 GB of job output you want
    /// to download and
    /// you decide to download 128 MB chunks of data at a time, which is a total of
    /// eight Get Job
    /// Output requests. You use the following process to download the job output:
    ///
    /// * Download a 128 MB chunk of output by specifying the appropriate byte
    ///   range.
    /// Verify that all 128 MB of data was received.
    ///
    /// * Along with the data, the response includes a SHA256 tree hash of the
    ///   payload.
    /// You compute the checksum of the payload on the client and compare it with
    /// the
    /// checksum you received in the response to ensure you received all the
    /// expected
    /// data.
    ///
    /// * Repeat steps 1 and 2 for all the eight 128 MB chunks of output data, each
    ///   time
    /// specifying the appropriate byte range.
    ///
    /// * After downloading all the parts of the job output, you have a list of
    ///   eight
    /// checksum values. Compute the tree hash of these values to find the checksum
    /// of the
    /// entire output. Using the DescribeJob API, obtain job information of
    /// the job that provided you the output. The response includes the checksum of
    /// the
    /// entire archive stored in Amazon Glacier. You compare this value with the
    /// checksum you
    /// computed to ensure you have downloaded the entire archive content with no
    /// errors.
    range: ?[]const u8 = null,

    /// The name of the vault.
    vault_name: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .job_id = "jobId",
        .range = "range",
        .vault_name = "vaultName",
    };
};

pub const GetJobOutputOutput = struct {
    /// Indicates the range units accepted. For more information, see
    /// [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html).
    accept_ranges: ?[]const u8 = null,

    /// The description of an archive.
    archive_description: ?[]const u8 = null,

    /// The job data, either archive data or inventory data.
    body: ?aws.http.StreamingBody = null,

    /// The checksum of the data in the response. This header is returned only when
    /// retrieving the output for an archive retrieval job. Furthermore, this header
    /// appears only
    /// under the following conditions:
    ///
    /// * You get the entire range of the archive.
    ///
    /// * You request a range to return of the archive that starts and ends on a
    ///   multiple
    /// of 1 MB. For example, if you have an 3.1 MB archive and you specify a range
    /// to return
    /// that starts at 1 MB and ends at 2 MB, then the x-amz-sha256-tree-hash is
    /// returned as
    /// a response header.
    ///
    /// * You request a range of the archive to return that starts on a multiple of
    ///   1 MB
    /// and goes to the end of the archive. For example, if you have a 3.1 MB
    /// archive and you
    /// specify a range that starts at 2 MB and ends at 3.1 MB (the end of the
    /// archive), then
    /// the x-amz-sha256-tree-hash is returned as a response header.
    checksum: ?[]const u8 = null,

    /// The range of bytes returned by Amazon Glacier. If only partial output is
    /// downloaded,
    /// the response provides the range of bytes Amazon Glacier returned. For
    /// example, bytes
    /// 0-1048575/8388608 returns the first 1 MB from 8 MB.
    content_range: ?[]const u8 = null,

    /// The Content-Type depends on whether the job output is an archive or a vault
    /// inventory. For archive data, the Content-Type is application/octet-stream.
    /// For vault
    /// inventory, if you requested CSV format when you initiated the job, the
    /// Content-Type is
    /// text/csv. Otherwise, by default, vault inventory is returned as JSON, and
    /// the Content-Type
    /// is application/json.
    content_type: ?[]const u8 = null,

    /// The HTTP response code for a job output request. The value depends on
    /// whether a range
    /// was specified in the request.
    status: ?i32 = null,

    pub fn deinit(self: *GetJobOutputOutput) void {
        if (self.body) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .accept_ranges = "acceptRanges",
        .archive_description = "archiveDescription",
        .body = "body",
        .checksum = "checksum",
        .content_range = "contentRange",
        .content_type = "contentType",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobOutputInput, options: CallOptions) !GetJobOutputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "glacier");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobOutputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/vaults/");
    try path_buf.appendSlice(allocator, input.vault_name);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/output");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.range) |v| {
        try request.headers.put(allocator, "Range", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetJobOutputOutput {
    var result: GetJobOutputOutput = .{};
    result.body = stream_resp.body;
    result.status = @intCast(stream_resp.status);
    if (stream_resp.headers.get("accept-ranges")) |value| {
        result.accept_ranges = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-archive-description")) |value| {
        result.archive_description = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-sha256-tree-hash")) |value| {
        result.checksum = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-range")) |value| {
        result.content_range = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        return .{ .arena = arena, .kind = .{ .no_longer_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyEnforcedException")) {
        return .{ .arena = arena, .kind = .{ .policy_enforced_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
