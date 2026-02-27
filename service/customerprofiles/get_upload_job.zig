const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectTypeField = @import("object_type_field.zig").ObjectTypeField;
const ResultsSummary = @import("results_summary.zig").ResultsSummary;
const UploadJobStatus = @import("upload_job_status.zig").UploadJobStatus;
const StatusReason = @import("status_reason.zig").StatusReason;

pub const GetUploadJobInput = struct {
    /// The unique name of the domain containing the upload job.
    domain_name: []const u8,

    /// The unique identifier of the upload job to retrieve.
    job_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .job_id = "JobId",
    };
};

pub const GetUploadJobOutput = struct {
    /// The timestamp when the upload job was completed.
    completed_at: ?i64 = null,

    /// The timestamp when the upload job was created.
    created_at: ?i64 = null,

    /// The expiry duration for the profiles ingested with the upload job.
    data_expiry: ?i32 = null,

    /// The unique name of the upload job. Could be a file name to identify the
    /// upload job.
    display_name: ?[]const u8 = null,

    /// The mapping between CSV Columns and Profile Object attributes for the upload
    /// job.
    fields: ?[]const aws.map.MapEntry(ObjectTypeField) = null,

    /// The unique identifier of the upload job.
    job_id: ?[]const u8 = null,

    /// The summary of results for the upload job, including the number of updated,
    /// created, and
    /// failed records.
    results_summary: ?ResultsSummary = null,

    /// The status describing the status for the upload job. The following are Valid
    /// Values:
    ///
    /// * **CREATED**: The upload job has been created, but has
    /// not started processing yet.
    ///
    /// * **IN_PROGRESS**: The upload job is currently in
    /// progress, ingesting and processing the profile data.
    ///
    /// * **PARTIALLY_SUCCEEDED**: The upload job has
    /// successfully completed the ingestion and processing of all profile data.
    ///
    /// * **SUCCEEDED**: The upload job has successfully
    /// completed the ingestion and processing of all profile data.
    ///
    /// * **FAILED**: The upload job has failed to complete.
    ///
    /// * **STOPPED**: The upload job has been manually stopped
    /// or terminated before completion.
    status: ?UploadJobStatus = null,

    /// The reason for the current status of the upload job. Possible reasons:
    ///
    /// * **VALIDATION_FAILURE**: The upload job has
    /// encountered an error or issue and was unable to complete the profile data
    /// ingestion.
    ///
    /// * **INTERNAL_FAILURE**: Failure caused from service
    /// side
    status_reason: ?StatusReason = null,

    /// The unique key columns used for de-duping the keys in the upload job.
    unique_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_at = "CompletedAt",
        .created_at = "CreatedAt",
        .data_expiry = "DataExpiry",
        .display_name = "DisplayName",
        .fields = "Fields",
        .job_id = "JobId",
        .results_summary = "ResultsSummary",
        .status = "Status",
        .status_reason = "StatusReason",
        .unique_key = "UniqueKey",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUploadJobInput, options: Options) !GetUploadJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "customerprofiles");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetUploadJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domains/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/upload-jobs/");
    try path_buf.appendSlice(alloc, input.job_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetUploadJobOutput {
    var result: GetUploadJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetUploadJobOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
