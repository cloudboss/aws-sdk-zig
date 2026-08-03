const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const DescribeSnapshotsInput = struct {
    /// The identifier of the directory for which to retrieve snapshot information.
    directory_id: ?[]const u8 = null,

    /// The maximum number of objects to return.
    limit: ?i32 = null,

    /// The *DescribeSnapshotsResult.NextToken* value from a previous call to
    /// DescribeSnapshots. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    /// A list of identifiers of the snapshots to obtain the information for. If
    /// this member is
    /// null or empty, all snapshots are returned using the *Limit* and *NextToken*
    /// members.
    snapshot_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .limit = "Limit",
        .next_token = "NextToken",
        .snapshot_ids = "SnapshotIds",
    };
};

pub const DescribeSnapshotsOutput = struct {
    /// If not null, more results are available. Pass this value in the *NextToken*
    /// member of
    /// a subsequent call to DescribeSnapshots.
    next_token: ?[]const u8 = null,

    /// The list of Snapshot objects that were retrieved.
    ///
    /// It is possible that this list contains less than the number of items
    /// specified in the
    /// *Limit* member of the request. This occurs if there are less than the
    /// requested
    /// number of items left to retrieve, or if the limitations of the operation
    /// have been
    /// exceeded.
    snapshots: ?[]const Snapshot = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .snapshots = "Snapshots",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSnapshotsInput, options: CallOptions) !DescribeSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeSnapshots");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSnapshotsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSnapshotsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ADAssessmentLimitExceededException")) {
        const parsed_error: ?errors.ADAssessmentLimitExceededException = aws.json.parseJsonObject(errors.ADAssessmentLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ad_assessment_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AuthenticationFailedException")) {
        const parsed_error: ?errors.AuthenticationFailedException = aws.json.parseJsonObject(errors.AuthenticationFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .authentication_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CertificateAlreadyExistsException")) {
        const parsed_error: ?errors.CertificateAlreadyExistsException = aws.json.parseJsonObject(errors.CertificateAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .certificate_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CertificateDoesNotExistException")) {
        const parsed_error: ?errors.CertificateDoesNotExistException = aws.json.parseJsonObject(errors.CertificateDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .certificate_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CertificateInUseException")) {
        const parsed_error: ?errors.CertificateInUseException = aws.json.parseJsonObject(errors.CertificateInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .certificate_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CertificateLimitExceededException")) {
        const parsed_error: ?errors.CertificateLimitExceededException = aws.json.parseJsonObject(errors.CertificateLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .certificate_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        const parsed_error: ?errors.ClientException = aws.json.parseJsonObject(errors.ClientException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .client_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryAlreadyInRegionException")) {
        const parsed_error: ?errors.DirectoryAlreadyInRegionException = aws.json.parseJsonObject(errors.DirectoryAlreadyInRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_already_in_region_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryAlreadySharedException")) {
        const parsed_error: ?errors.DirectoryAlreadySharedException = aws.json.parseJsonObject(errors.DirectoryAlreadySharedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_already_shared_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryDoesNotExistException")) {
        const parsed_error: ?errors.DirectoryDoesNotExistException = aws.json.parseJsonObject(errors.DirectoryDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryInDesiredStateException")) {
        const parsed_error: ?errors.DirectoryInDesiredStateException = aws.json.parseJsonObject(errors.DirectoryInDesiredStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_in_desired_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryLimitExceededException")) {
        const parsed_error: ?errors.DirectoryLimitExceededException = aws.json.parseJsonObject(errors.DirectoryLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryNotSharedException")) {
        const parsed_error: ?errors.DirectoryNotSharedException = aws.json.parseJsonObject(errors.DirectoryNotSharedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_not_shared_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryUnavailableException")) {
        const parsed_error: ?errors.DirectoryUnavailableException = aws.json.parseJsonObject(errors.DirectoryUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DisableAlreadyInProgressException")) {
        const parsed_error: ?errors.DisableAlreadyInProgressException = aws.json.parseJsonObject(errors.DisableAlreadyInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .disable_already_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainControllerLimitExceededException")) {
        const parsed_error: ?errors.DomainControllerLimitExceededException = aws.json.parseJsonObject(errors.DomainControllerLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_controller_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EnableAlreadyInProgressException")) {
        const parsed_error: ?errors.EnableAlreadyInProgressException = aws.json.parseJsonObject(errors.EnableAlreadyInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .enable_already_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EntityAlreadyExistsException")) {
        const parsed_error: ?errors.EntityAlreadyExistsException = aws.json.parseJsonObject(errors.EntityAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .entity_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EntityDoesNotExistException")) {
        const parsed_error: ?errors.EntityDoesNotExistException = aws.json.parseJsonObject(errors.EntityDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .entity_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatibleSettingsException")) {
        const parsed_error: ?errors.IncompatibleSettingsException = aws.json.parseJsonObject(errors.IncompatibleSettingsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_settings_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientPermissionsException")) {
        const parsed_error: ?errors.InsufficientPermissionsException = aws.json.parseJsonObject(errors.InsufficientPermissionsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_permissions_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateException")) {
        const parsed_error: ?errors.InvalidCertificateException = aws.json.parseJsonObject(errors.InvalidCertificateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_certificate_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidClientAuthStatusException")) {
        const parsed_error: ?errors.InvalidClientAuthStatusException = aws.json.parseJsonObject(errors.InvalidClientAuthStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_client_auth_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLDAPSStatusException")) {
        const parsed_error: ?errors.InvalidLDAPSStatusException = aws.json.parseJsonObject(errors.InvalidLDAPSStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ldaps_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPasswordException")) {
        const parsed_error: ?errors.InvalidPasswordException = aws.json.parseJsonObject(errors.InvalidPasswordException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_password_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        const parsed_error: ?errors.InvalidTargetException = aws.json.parseJsonObject(errors.InvalidTargetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IpRouteLimitExceededException")) {
        const parsed_error: ?errors.IpRouteLimitExceededException = aws.json.parseJsonObject(errors.IpRouteLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ip_route_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableCertificateException")) {
        const parsed_error: ?errors.NoAvailableCertificateException = aws.json.parseJsonObject(errors.NoAvailableCertificateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_certificate_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationsException")) {
        const parsed_error: ?errors.OrganizationsException = aws.json.parseJsonObject(errors.OrganizationsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organizations_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RegionLimitExceededException")) {
        const parsed_error: ?errors.RegionLimitExceededException = aws.json.parseJsonObject(errors.RegionLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .region_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        const parsed_error: ?errors.ServiceException = aws.json.parseJsonObject(errors.ServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ShareLimitExceededException")) {
        const parsed_error: ?errors.ShareLimitExceededException = aws.json.parseJsonObject(errors.ShareLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .share_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotLimitExceededException")) {
        const parsed_error: ?errors.SnapshotLimitExceededException = aws.json.parseJsonObject(errors.SnapshotLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        const parsed_error: ?errors.TagLimitExceededException = aws.json.parseJsonObject(errors.TagLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedSettingsException")) {
        const parsed_error: ?errors.UnsupportedSettingsException = aws.json.parseJsonObject(errors.UnsupportedSettingsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_settings_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserDoesNotExistException")) {
        const parsed_error: ?errors.UserDoesNotExistException = aws.json.parseJsonObject(errors.UserDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_does_not_exist_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
