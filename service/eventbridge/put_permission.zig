const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Condition = @import("condition.zig").Condition;

pub const PutPermissionInput = struct {
    /// The action that you are enabling the other account to perform.
    action: ?[]const u8 = null,

    /// This parameter enables you to limit the permission to accounts that fulfill
    /// a certain
    /// condition, such as being a member of a certain Amazon Web Services
    /// organization. For more
    /// information about Amazon Web Services Organizations, see [What Is Amazon Web
    /// Services
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html) in the *Amazon Web Services Organizations User
    /// Guide*.
    ///
    /// If you specify `Condition` with an Amazon Web Services organization ID, and
    /// specify "*" as the value for `Principal`, you grant permission to all the
    /// accounts
    /// in the named organization.
    ///
    /// The `Condition` is a JSON string which must contain `Type`,
    /// `Key`, and `Value` fields.
    condition: ?Condition = null,

    /// The name of the event bus associated with the rule. If you omit this, the
    /// default event
    /// bus is used.
    event_bus_name: ?[]const u8 = null,

    /// A JSON string that describes the permission policy statement. You can
    /// include a
    /// `Policy` parameter in the request instead of using the `StatementId`,
    /// `Action`, `Principal`, or `Condition` parameters.
    policy: ?[]const u8 = null,

    /// The 12-digit Amazon Web Services account ID that you are permitting to put
    /// events to your
    /// default event bus. Specify "*" to permit any account to put events to your
    /// default event
    /// bus.
    ///
    /// If you specify "*" without specifying `Condition`, avoid creating rules that
    /// may match undesirable events. To create more secure rules, make sure that
    /// the event pattern
    /// for each rule contains an `account` field with a specific account ID from
    /// which to
    /// receive events. Rules with an account field do not match any events sent
    /// from other
    /// accounts.
    principal: ?[]const u8 = null,

    /// An identifier string for the external account that you are granting
    /// permissions to. If you
    /// later want to revoke the permission for this external account, specify this
    /// `StatementId` when you run
    /// [RemovePermission](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_RemovePermission.html).
    ///
    /// Each `StatementId` must be unique.
    statement_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .condition = "Condition",
        .event_bus_name = "EventBusName",
        .policy = "Policy",
        .principal = "Principal",
        .statement_id = "StatementId",
    };
};

const PutPermissionOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPermissionInput, options: Options) !PutPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "eventbridge");

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

fn serializeRequest(alloc: std.mem.Allocator, input: PutPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eventbridge", "EventBridge", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSEvents.PutPermission");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutPermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalStatusException")) {
        return .{ .arena = arena, .kind = .{ .illegal_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventPatternException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_pattern_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "ManagedRuleException")) {
        return .{ .arena = arena, .kind = .{ .managed_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .operation_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
