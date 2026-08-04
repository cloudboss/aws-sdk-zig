const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const JobListEntry = @import("job_list_entry.zig").JobListEntry;

pub const ListClusterJobsInput = struct {
    /// The 39-character ID for the cluster that you want to list, for example
    /// `CID123e4567-e89b-12d3-a456-426655440000`.
    cluster_id: []const u8,

    /// The number of `JobListEntry` objects to return.
    max_results: ?i32 = null,

    /// HTTP requests are stateless. To identify what object comes "next" in the
    /// list of
    /// `JobListEntry` objects, you have the option of specifying `NextToken`
    /// as the starting point for your returned list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListClusterJobsOutput = struct {
    /// Each `JobListEntry` object contains a job's state, a job's ID, and a value
    /// that indicates whether the job is a job part, in the case of export jobs.
    job_list_entries: ?[]const JobListEntry = null,

    /// HTTP requests are stateless. If you use the automatically generated
    /// `NextToken` value in your next `ListClusterJobsResult` call, your list
    /// of returned jobs will start from this point in the array.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_list_entries = "JobListEntries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClusterJobsInput, options: CallOptions) !ListClusterJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snowball", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClusterJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.ListClusterJobs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClusterJobsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListClusterJobsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClusterLimitExceededException")) {
        const parsed_error: ?errors.ClusterLimitExceededException = aws.json.parseJsonObject(errors.ClusterLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "Ec2RequestFailedException")) {
        const parsed_error: ?errors.Ec2RequestFailedException = aws.json.parseJsonObject(errors.Ec2RequestFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ec_2_request_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAddressException")) {
        const parsed_error: ?errors.InvalidAddressException = aws.json.parseJsonObject(errors.InvalidAddressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_address_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputCombinationException")) {
        const parsed_error: ?errors.InvalidInputCombinationException = aws.json.parseJsonObject(errors.InvalidInputCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidJobStateException")) {
        const parsed_error: ?errors.InvalidJobStateException = aws.json.parseJsonObject(errors.InvalidJobStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_job_state_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidResourceException")) {
        const parsed_error: ?errors.InvalidResourceException = aws.json.parseJsonObject(errors.InvalidResourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSRequestFailedException")) {
        const parsed_error: ?errors.KMSRequestFailedException = aws.json.parseJsonObject(errors.KMSRequestFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_request_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReturnShippingLabelAlreadyExistsException")) {
        const parsed_error: ?errors.ReturnShippingLabelAlreadyExistsException = aws.json.parseJsonObject(errors.ReturnShippingLabelAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .return_shipping_label_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAddressException")) {
        const parsed_error: ?errors.UnsupportedAddressException = aws.json.parseJsonObject(errors.UnsupportedAddressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_address_exception = typed_error } };
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
