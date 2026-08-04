const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AppliedLevelEnum = @import("applied_level_enum.zig").AppliedLevelEnum;
const RequestStatus = @import("request_status.zig").RequestStatus;
const RequestedServiceQuotaChange = @import("requested_service_quota_change.zig").RequestedServiceQuotaChange;

pub const ListRequestedServiceQuotaChangeHistoryInput = struct {
    /// Specifies the maximum number of results that you want included on each
    /// page of the response. If you do not include this parameter, it defaults to a
    /// value appropriate
    /// to the operation. If additional items exist beyond those included in the
    /// current response, the
    /// `NextToken` response element is present and has a value (is not null).
    /// Include that
    /// value as the `NextToken` request parameter in the next call to the operation
    /// to get
    /// the next part of the results.
    ///
    /// An API operation can return fewer results than the maximum even when there
    /// are
    /// more results available. You should check `NextToken` after every operation
    /// to ensure
    /// that you receive all of the results.
    max_results: ?i32 = null,

    /// Specifies a value for receiving additional results after you
    /// receive a `NextToken` response in a previous request. A `NextToken`
    /// response indicates that more output is available. Set this parameter to the
    /// value of the previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    /// Filters the response to return quota requests for the `ACCOUNT`, `RESOURCE`,
    /// or `ALL` levels. `ACCOUNT` is the default.
    quota_requested_at_level: ?AppliedLevelEnum = null,

    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: ?[]const u8 = null,

    /// Specifies that you want to filter the results to only the requests with the
    /// matching
    /// status.
    status: ?RequestStatus = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .quota_requested_at_level = "QuotaRequestedAtLevel",
        .service_code = "ServiceCode",
        .status = "Status",
    };
};

pub const ListRequestedServiceQuotaChangeHistoryOutput = struct {
    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    /// Information about the quota increase requests.
    requested_quotas: ?[]const RequestedServiceQuotaChange = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .requested_quotas = "RequestedQuotas",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRequestedServiceQuotaChangeHistoryInput, options: CallOptions) !ListRequestedServiceQuotaChangeHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicequotas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRequestedServiceQuotaChangeHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.ListRequestedServiceQuotaChangeHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRequestedServiceQuotaChangeHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRequestedServiceQuotaChangeHistoryOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "AWSServiceAccessNotEnabledException")) {
        const parsed_error: ?errors.AWSServiceAccessNotEnabledException = aws.json.parseJsonObject(errors.AWSServiceAccessNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .aws_service_access_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DependencyAccessDeniedException")) {
        const parsed_error: ?errors.DependencyAccessDeniedException = aws.json.parseJsonObject(errors.DependencyAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dependency_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalArgumentException")) {
        const parsed_error: ?errors.IllegalArgumentException = aws.json.parseJsonObject(errors.IllegalArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        const parsed_error: ?errors.InvalidPaginationTokenException = aws.json.parseJsonObject(errors.InvalidPaginationTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        const parsed_error: ?errors.InvalidResourceStateException = aws.json.parseJsonObject(errors.InvalidResourceStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableOrganizationException")) {
        const parsed_error: ?errors.NoAvailableOrganizationException = aws.json.parseJsonObject(errors.NoAvailableOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchResourceException")) {
        const parsed_error: ?errors.NoSuchResourceException = aws.json.parseJsonObject(errors.NoSuchResourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_resource_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        const parsed_error: ?errors.OrganizationNotInAllFeaturesModeException = aws.json.parseJsonObject(errors.OrganizationNotInAllFeaturesModeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_not_in_all_features_mode_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QuotaExceededException")) {
        const parsed_error: ?errors.QuotaExceededException = aws.json.parseJsonObject(errors.QuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        const parsed_error: ?errors.ResourceAlreadyExistsException = aws.json.parseJsonObject(errors.ResourceAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaTemplateNotInUseException")) {
        const parsed_error: ?errors.ServiceQuotaTemplateNotInUseException = aws.json.parseJsonObject(errors.ServiceQuotaTemplateNotInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_template_not_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagPolicyViolationException")) {
        const parsed_error: ?errors.TagPolicyViolationException = aws.json.parseJsonObject(errors.TagPolicyViolationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_policy_violation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TemplatesNotAvailableInRegionException")) {
        const parsed_error: ?errors.TemplatesNotAvailableInRegionException = aws.json.parseJsonObject(errors.TemplatesNotAvailableInRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .templates_not_available_in_region_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        const parsed_error: ?errors.TooManyRequestsException = aws.json.parseJsonObject(errors.TooManyRequestsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_requests_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
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
