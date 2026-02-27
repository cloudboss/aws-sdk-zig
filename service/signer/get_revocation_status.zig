const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetRevocationStatusInput = struct {
    /// A list of composite signed hashes that identify certificates.
    ///
    /// A certificate identifier consists of a subject certificate TBS hash (signed
    /// by the
    /// parent CA) combined with a parent CA TBS hash (signed by the parent CA’s
    /// CA). Root
    /// certificates are defined as their own CA.
    ///
    /// The following example shows how to calculate a hash for this parameter using
    /// OpenSSL
    /// commands:
    ///
    /// `openssl asn1parse -in childCert.pem -strparse 4 -out childCert.tbs`
    ///
    /// `openssl sha384 childCertTbsHash`
    ///
    /// `openssl asn1parse -in parentCert.pem -strparse 4 -out parentCert.tbs`
    ///
    /// `openssl sha384 parentCertTbsHash xxd -p
    /// childCertTbsHash > certificateHash.hex xxd -p parentCertTbsHash >>
    /// certificateHash.hex`
    ///
    /// `cat certificateHash.hex | tr -d '\n'`
    certificate_hashes: []const []const u8,

    /// The ARN of a signing job.
    job_arn: []const u8,

    /// The ID of a signing platform.
    platform_id: []const u8,

    /// The version of a signing profile.
    profile_version_arn: []const u8,

    /// The timestamp of the signature that validates the profile or job.
    signature_timestamp: i64,

    pub const json_field_names = .{
        .certificate_hashes = "certificateHashes",
        .job_arn = "jobArn",
        .platform_id = "platformId",
        .profile_version_arn = "profileVersionArn",
        .signature_timestamp = "signatureTimestamp",
    };
};

pub const GetRevocationStatusOutput = struct {
    /// A list of revoked entities (including zero or more of the signing profile
    /// ARN, signing job
    /// ARN, and certificate hashes) supplied as input to the API.
    revoked_entities: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .revoked_entities = "revokedEntities",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRevocationStatusInput, options: Options) !GetRevocationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "signer");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetRevocationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/revocations";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "certificateHashes=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.certificate_hashes);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "jobArn=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.job_arn);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "platformId=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.platform_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "profileVersionArn=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.profile_version_arn);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "signatureTimestamp=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.signature_timestamp}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetRevocationStatusOutput {
    var result: GetRevocationStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRevocationStatusOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
