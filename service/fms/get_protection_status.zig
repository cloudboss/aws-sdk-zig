const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SecurityServiceType = @import("security_service_type.zig").SecurityServiceType;

pub const GetProtectionStatusInput = struct {
    /// The end of the time period to query for the attacks. This is a `timestamp`
    /// type. The
    /// request syntax listing indicates a `number` type because the default used by
    /// Firewall Manager is Unix time in seconds. However, any valid `timestamp`
    /// format is
    /// allowed.
    end_time: ?i64 = null,

    /// Specifies the number of objects that you want Firewall Manager to return for
    /// this request. If you have more
    /// objects than the number that you specify for `MaxResults`, the response
    /// includes a
    /// `NextToken` value that you can use to get another batch of objects.
    max_results: ?i32 = null,

    /// The Amazon Web Services account that is in scope of the policy that you want
    /// to get the details
    /// for.
    member_account_id: ?[]const u8 = null,

    /// If you specify a value for `MaxResults` and you have more objects than the
    /// number that you specify
    /// for `MaxResults`, Firewall Manager returns a `NextToken` value in the
    /// response, which you can use to retrieve another group of
    /// objects. For the second and subsequent `GetProtectionStatus` requests,
    /// specify the value of `NextToken`
    /// from the previous response to get information about another batch of
    /// objects.
    next_token: ?[]const u8 = null,

    /// The ID of the policy for which you want to get the attack information.
    policy_id: []const u8,

    /// The start of the time period to query for the attacks. This is a `timestamp`
    /// type. The
    /// request syntax listing indicates a `number` type because the default used by
    /// Firewall Manager is Unix time in seconds. However, any valid `timestamp`
    /// format is
    /// allowed.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .member_account_id = "MemberAccountId",
        .next_token = "NextToken",
        .policy_id = "PolicyId",
        .start_time = "StartTime",
    };
};

pub const GetProtectionStatusOutput = struct {
    /// The ID of the Firewall Manager administrator account for this policy.
    admin_account_id: ?[]const u8 = null,

    /// Details about the attack, including the following:
    ///
    /// * Attack type
    ///
    /// * Account ID
    ///
    /// * ARN of the resource attacked
    ///
    /// * Start time of the attack
    ///
    /// * End time of the attack (ongoing attacks will not have an end time)
    ///
    /// The details are in JSON format.
    data: ?[]const u8 = null,

    /// If you have more objects than the number that you specified for `MaxResults`
    /// in the request,
    /// the response includes a `NextToken` value. To list more objects, submit
    /// another
    /// `GetProtectionStatus` request, and specify the `NextToken` value from the
    /// response in the
    /// `NextToken` value in the next request.
    ///
    /// Amazon Web Services SDKs provide auto-pagination that identify `NextToken`
    /// in a response and
    /// make subsequent request calls automatically on your behalf. However, this
    /// feature is not
    /// supported by `GetProtectionStatus`. You must submit subsequent requests with
    /// `NextToken` using your own processes.
    next_token: ?[]const u8 = null,

    /// The service type that is protected by the policy. Currently, this is always
    /// `SHIELD_ADVANCED`.
    service_type: ?SecurityServiceType = null,

    pub const json_field_names = .{
        .admin_account_id = "AdminAccountId",
        .data = "Data",
        .next_token = "NextToken",
        .service_type = "ServiceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProtectionStatusInput, options: CallOptions) !GetProtectionStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fms");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProtectionStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.GetProtectionStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProtectionStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetProtectionStatusOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
