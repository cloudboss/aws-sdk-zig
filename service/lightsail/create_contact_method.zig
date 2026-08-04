const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ContactProtocol = @import("contact_protocol.zig").ContactProtocol;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateContactMethodInput = struct {
    /// The destination of the contact method, such as an email address or a mobile
    /// phone
    /// number.
    ///
    /// Use the E.164 format when specifying a mobile phone number. E.164 is a
    /// standard for the
    /// phone number structure used for international telecommunication. Phone
    /// numbers that follow
    /// this format can have a maximum of 15 digits, and they are prefixed with the
    /// plus character (+)
    /// and the country code. For example, a U.S. phone number in E.164 format would
    /// be specified as
    /// +1XXX5550100. For more information, see
    /// [E.164](https://en.wikipedia.org/wiki/E.164) on *Wikipedia*.
    contact_endpoint: []const u8,

    /// The protocol of the contact method, such as `Email` or `SMS` (text
    /// messaging).
    ///
    /// The `SMS` protocol is supported only in the following Amazon Web Services
    /// Regions.
    ///
    /// * US East (N. Virginia) (`us-east-1`)
    ///
    /// * US West (Oregon) (`us-west-2`)
    ///
    /// * Europe (Ireland) (`eu-west-1`)
    ///
    /// * Asia Pacific (Tokyo) (`ap-northeast-1`)
    ///
    /// * Asia Pacific (Singapore) (`ap-southeast-1`)
    ///
    /// * Asia Pacific (Sydney) (`ap-southeast-2`)
    ///
    /// For a list of countries/regions where SMS text messages can be sent, and the
    /// latest
    /// Amazon Web Services Regions where SMS text messaging is supported, see
    /// [Supported Regions and
    /// Countries](https://docs.aws.amazon.com/sns/latest/dg/sns-supported-regions-countries.html) in the *Amazon SNS Developer
    /// Guide*.
    ///
    /// For more information about notifications in Amazon Lightsail, see
    /// [Notifications in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-notifications).
    protocol: ContactProtocol,

    /// The tag keys and optional values to add to the contact method during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .contact_endpoint = "contactEndpoint",
        .protocol = "protocol",
        .tags = "tags",
    };
};

pub const CreateContactMethodOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactMethodInput, options: CallOptions) !CreateContactMethodOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContactMethodInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateContactMethod");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContactMethodOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContactMethodOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        const parsed_error: ?errors.AccountSetupInProgressException = aws.json.parseJsonObject(errors.AccountSetupInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?errors.InvalidInputException = aws.json.parseJsonObject(errors.InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        const parsed_error: ?errors.OperationFailureException = aws.json.parseJsonObject(errors.OperationFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        const parsed_error: ?errors.RegionSetupInProgressException = aws.json.parseJsonObject(errors.RegionSetupInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        const parsed_error: ?errors.UnauthenticatedException = aws.json.parseJsonObject(errors.UnauthenticatedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unauthenticated_exception = typed_error } };
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
