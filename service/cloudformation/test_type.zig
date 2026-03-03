const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;

pub const TestTypeInput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    arn: ?[]const u8 = null,

    /// The S3 bucket to which CloudFormation delivers the contract test execution
    /// logs.
    ///
    /// CloudFormation delivers the logs by the time contract testing has completed
    /// and the extension
    /// has been assigned a test type status of `PASSED` or `FAILED`.
    ///
    /// The user calling `TestType` must be able to access items in the specified S3
    /// bucket. Specifically, the user needs the following permissions:
    ///
    /// * `GetObject`
    ///
    /// * `PutObject`
    ///
    /// For more information, see [Actions, Resources, and
    /// Condition Keys for Amazon
    /// S3](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html) in the *Identity and Access Management User Guide*.
    log_delivery_bucket: ?[]const u8 = null,

    /// The type of the extension to test.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    @"type": ?ThirdPartyType = null,

    /// The name of the extension to test.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    type_name: ?[]const u8 = null,

    /// The version of the extension to test.
    ///
    /// You can specify the version id with either `Arn`, or with `TypeName`
    /// and `Type`.
    ///
    /// If you don't specify a version, CloudFormation uses the default version of
    /// the extension in
    /// this account and Region for testing.
    version_id: ?[]const u8 = null,
};

pub const TestTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    type_version_arn: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestTypeInput, options: Options) !TestTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudformation");

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=TestType&Version=2010-05-15");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "&Arn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.log_delivery_bucket) |v| {
        try body_buf.appendSlice(allocator, "&LogDeliveryBucket=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_id) |v| {
        try body_buf.appendSlice(allocator, "&VersionId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TestTypeResult")) break;
            },
            else => {},
        }
    }

    var result: TestTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TypeVersionArn")) {
                    result.type_version_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CFNRegistryException")) {
        return .{ .arena = arena, .kind = .{ .cfn_registry_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChangeSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .change_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentResourcesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_resources_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreatedButModifiedException")) {
        return .{ .arena = arena, .kind = .{ .created_but_modified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GeneratedTemplateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .generated_template_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HookResultNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .hook_result_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapabilitiesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capabilities_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChangeSetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_change_set_status_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
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
    if (std.mem.eql(u8, error_code, "NameAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .name_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationIdAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .operation_id_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationStatusCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .operation_status_check_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanInProgressException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceScanNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_scan_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackInstanceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_instance_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackRefactorNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_refactor_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StackSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stack_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleRequestException")) {
        return .{ .arena = arena, .kind = .{ .stale_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TokenAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .token_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeConfigurationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_configuration_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .type_not_found_exception = .{
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
