const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoMerging = @import("auto_merging.zig").AutoMerging;
const ExportingLocation = @import("exporting_location.zig").ExportingLocation;
const JobStats = @import("job_stats.zig").JobStats;
const IdentityResolutionJobStatus = @import("identity_resolution_job_status.zig").IdentityResolutionJobStatus;

pub const GetIdentityResolutionJobInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The unique identifier of the Identity Resolution Job.
    job_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .job_id = "JobId",
    };
};

pub const GetIdentityResolutionJobOutput = struct {
    /// Configuration settings for how to perform the auto-merging of profiles.
    auto_merging: ?AutoMerging = null,

    /// The unique name of the domain.
    domain_name: ?[]const u8 = null,

    /// The S3 location where the Identity Resolution Job writes result files.
    exporting_location: ?ExportingLocation = null,

    /// The timestamp of when the Identity Resolution Job was completed.
    job_end_time: ?i64 = null,

    /// The timestamp of when the Identity Resolution Job will expire.
    job_expiration_time: ?i64 = null,

    /// The unique identifier of the Identity Resolution Job.
    job_id: ?[]const u8 = null,

    /// The timestamp of when the Identity Resolution Job was started or will be
    /// started.
    job_start_time: ?i64 = null,

    /// Statistics about the Identity Resolution Job.
    job_stats: ?JobStats = null,

    /// The timestamp of when the Identity Resolution Job was most recently edited.
    last_updated_at: ?i64 = null,

    /// The error messages that are generated when the Identity Resolution Job runs.
    message: ?[]const u8 = null,

    /// The status of the Identity Resolution Job.
    ///
    /// * `PENDING`: The Identity Resolution Job is scheduled but has not started
    ///   yet. If you turn
    /// off the Identity Resolution feature in your domain, jobs in the `PENDING`
    /// state are
    /// deleted.
    ///
    /// * `PREPROCESSING`: The Identity Resolution Job is loading your data.
    ///
    /// * `FIND_MATCHING`: The Identity Resolution Job is using the machine learning
    ///   model to
    /// identify profiles that belong to the same matching group.
    ///
    /// * `MERGING`: The Identity Resolution Job is merging duplicate profiles.
    ///
    /// * `COMPLETED`: The Identity Resolution Job completed successfully.
    ///
    /// * `PARTIAL_SUCCESS`: There's a system error and not all of the data is
    /// merged. The Identity Resolution Job writes a message indicating the source
    /// of the problem.
    ///
    /// * `FAILED`: The Identity Resolution Job did not merge any data. It writes a
    ///   message
    /// indicating the source of the problem.
    status: ?IdentityResolutionJobStatus = null,

    pub const json_field_names = .{
        .auto_merging = "AutoMerging",
        .domain_name = "DomainName",
        .exporting_location = "ExportingLocation",
        .job_end_time = "JobEndTime",
        .job_expiration_time = "JobExpirationTime",
        .job_id = "JobId",
        .job_start_time = "JobStartTime",
        .job_stats = "JobStats",
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityResolutionJobInput, options: CallOptions) !GetIdentityResolutionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "profile");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityResolutionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/identity-resolution-jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityResolutionJobOutput {
    var result: GetIdentityResolutionJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIdentityResolutionJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

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
