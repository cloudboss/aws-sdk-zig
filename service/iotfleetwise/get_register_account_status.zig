const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const IamRegistrationResponse = @import("iam_registration_response.zig").IamRegistrationResponse;
const TimestreamRegistrationResponse = @import("timestream_registration_response.zig").TimestreamRegistrationResponse;

pub const GetRegisterAccountStatusInput = struct {
};

pub const GetRegisterAccountStatusOutput = struct {
    /// The status of registering your account and resources. The status can be one
    /// of:
    ///
    /// * `REGISTRATION_SUCCESS` - The Amazon Web Services resource is successfully
    /// registered.
    ///
    /// * `REGISTRATION_PENDING` - Amazon Web Services IoT FleetWise is processing
    ///   the registration
    /// request. This process takes approximately five minutes to complete.
    ///
    /// * `REGISTRATION_FAILURE` - Amazon Web Services IoT FleetWise can't register
    ///   the AWS resource.
    /// Try again later.
    account_status: RegistrationStatus,

    /// The time the account was registered, in seconds since epoch (January 1, 1970
    /// at
    /// midnight UTC time).
    creation_time: i64,

    /// The unique ID of the Amazon Web Services account, provided at account
    /// creation.
    customer_account_id: []const u8,

    /// Information about the registered IAM resources or errors, if any.
    iam_registration_response: ?IamRegistrationResponse = null,

    /// The time this registration was last updated, in seconds since epoch (January
    /// 1, 1970
    /// at midnight UTC time).
    last_modification_time: i64,

    /// Information about the registered Amazon Timestream resources or errors, if
    /// any.
    timestream_registration_response: ?TimestreamRegistrationResponse = null,

    pub const json_field_names = .{
        .account_status = "accountStatus",
        .creation_time = "creationTime",
        .customer_account_id = "customerAccountId",
        .iam_registration_response = "iamRegistrationResponse",
        .last_modification_time = "lastModificationTime",
        .timestream_registration_response = "timestreamRegistrationResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegisterAccountStatusInput, options: CallOptions) !GetRegisterAccountStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotfleetwise");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegisterAccountStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetRegisterAccountStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegisterAccountStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRegisterAccountStatusOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DecoderManifestValidationException")) {
        return .{ .arena = arena, .kind = .{ .decoder_manifest_validation_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidNodeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_node_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSignalsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_signals_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
