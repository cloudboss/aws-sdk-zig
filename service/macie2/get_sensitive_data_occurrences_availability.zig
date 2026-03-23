const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityCode = @import("availability_code.zig").AvailabilityCode;
const UnavailabilityReasonCode = @import("unavailability_reason_code.zig").UnavailabilityReasonCode;

pub const GetSensitiveDataOccurrencesAvailabilityInput = struct {
    /// The unique identifier for the finding.
    finding_id: []const u8,

    pub const json_field_names = .{
        .finding_id = "findingId",
    };
};

pub const GetSensitiveDataOccurrencesAvailabilityOutput = struct {
    /// Specifies whether occurrences of sensitive data can be retrieved for the
    /// finding. Possible values are: AVAILABLE, the sensitive data can be
    /// retrieved; and, UNAVAILABLE, the sensitive data can't be retrieved. If this
    /// value is UNAVAILABLE, the reasons array indicates why the data can't be
    /// retrieved.
    code: ?AvailabilityCode = null,

    /// Specifies why occurrences of sensitive data can't be retrieved for the
    /// finding. Possible values are:
    ///
    /// * ACCOUNT_NOT_IN_ORGANIZATION - The affected account isn't currently part of
    ///   your organization. Or the account is part of your organization but Macie
    ///   isn't currently enabled for the account. You're not allowed to access the
    ///   affected S3 object by using Macie.
    /// * INVALID_CLASSIFICATION_RESULT - There isn't a corresponding sensitive data
    ///   discovery result for the finding. Or the corresponding sensitive data
    ///   discovery result isn't available in the current Amazon Web Services
    ///   Region, is malformed or corrupted, or uses an unsupported storage format.
    ///   Macie can't verify the location of the sensitive data to retrieve.
    /// * INVALID_RESULT_SIGNATURE - The corresponding sensitive data discovery
    ///   result is stored in an S3 object that wasn't signed by Macie. Macie can't
    ///   verify the integrity and authenticity of the sensitive data discovery
    ///   result. Therefore, Macie can't verify the location of the sensitive data
    ///   to retrieve.
    /// * MEMBER_ROLE_TOO_PERMISSIVE - The trust or permissions policy for the IAM
    ///   role in the affected member account doesn't meet Macie requirements for
    ///   restricting access to the role. Or the role's trust policy doesn't specify
    ///   the correct external ID for your organization. Macie can't assume the role
    ///   to retrieve the sensitive data.
    /// * MISSING_GET_MEMBER_PERMISSION - You're not allowed to retrieve information
    ///   about the association between your account and the affected account. Macie
    ///   can't determine whether you’re allowed to access the affected S3 object as
    ///   the delegated Macie administrator for the affected account.
    /// * OBJECT_EXCEEDS_SIZE_QUOTA - The storage size of the affected S3 object
    ///   exceeds the size quota for retrieving occurrences of sensitive data from
    ///   this type of file.
    /// * OBJECT_UNAVAILABLE - The affected S3 object isn't available. The object
    ///   was renamed, moved, deleted, or changed after Macie created the finding.
    ///   Or the object is encrypted with an KMS key that isn’t available. For
    ///   example, the key is disabled, is scheduled for deletion, or was deleted.
    /// * RESULT_NOT_SIGNED - The corresponding sensitive data discovery result is
    ///   stored in an S3 object that hasn't been signed. Macie can't verify the
    ///   integrity and authenticity of the sensitive data discovery result.
    ///   Therefore, Macie can't verify the location of the sensitive data to
    ///   retrieve.
    /// * ROLE_TOO_PERMISSIVE - Your account is configured to retrieve occurrences
    ///   of sensitive data by using an IAM role whose trust or permissions policy
    ///   doesn't meet Macie requirements for restricting access to the role. Macie
    ///   can’t assume the role to retrieve the sensitive data.
    /// * UNSUPPORTED_FINDING_TYPE - The specified finding isn't a sensitive data
    ///   finding.
    /// * UNSUPPORTED_OBJECT_TYPE - The affected S3 object uses a file or storage
    ///   format that Macie doesn't support for retrieving occurrences of sensitive
    ///   data.
    ///
    /// This value is null if sensitive data can be retrieved for the finding.
    reasons: ?[]const UnavailabilityReasonCode = null,

    pub const json_field_names = .{
        .code = "code",
        .reasons = "reasons",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSensitiveDataOccurrencesAvailabilityInput, options: CallOptions) !GetSensitiveDataOccurrencesAvailabilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "macie2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSensitiveDataOccurrencesAvailabilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/findings/");
    try path_buf.appendSlice(allocator, input.finding_id);
    try path_buf.appendSlice(allocator, "/reveal/availability");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSensitiveDataOccurrencesAvailabilityOutput {
    var result: GetSensitiveDataOccurrencesAvailabilityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSensitiveDataOccurrencesAvailabilityOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
