const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;

pub const PutResourceAttributesInput = struct {
    /// Optional boolean flag to indicate whether any effect should take place. Used
    /// to test if
    /// the caller has permission to make the call.
    dry_run: ?bool = null,

    /// Unique identifier that references the migration task. *Do not store personal
    /// data in this field.*
    migration_task_name: []const u8,

    /// The name of the ProgressUpdateStream.
    progress_update_stream: []const u8,

    /// Information about the resource that is being migrated. This data will be
    /// used to map the
    /// task to a resource in the Application Discovery Service repository.
    ///
    /// Takes the object array of `ResourceAttribute` where the `Type`
    /// field is reserved for the following values: `IPV4_ADDRESS | IPV6_ADDRESS |
    /// MAC_ADDRESS | FQDN | VM_MANAGER_ID | VM_MANAGED_OBJECT_REFERENCE | VM_NAME |
    /// VM_PATH
    /// | BIOS_ID | MOTHERBOARD_SERIAL_NUMBER` where the identifying value can be a
    /// string up to 256 characters.
    ///
    /// * If any "VM" related value is set for a `ResourceAttribute` object,
    /// it is required that `VM_MANAGER_ID`, as a minimum, is always set. If
    /// `VM_MANAGER_ID` is not set, then all "VM" fields will be discarded
    /// and "VM" fields will not be used for matching the migration task to a server
    /// in
    /// Application Discovery Service repository. See the
    /// [Example](https://docs.aws.amazon.com/migrationhub/latest/ug/API_PutResourceAttributes.html#API_PutResourceAttributes_Examples) section below for a use case of specifying "VM" related
    /// values.
    ///
    /// * If a server you are trying to match has multiple IP or MAC addresses, you
    /// should provide as many as you know in separate type/value pairs passed to
    /// the
    /// `ResourceAttributeList` parameter to maximize the chances of
    /// matching.
    resource_attribute_list: []const ResourceAttribute,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .migration_task_name = "MigrationTaskName",
        .progress_update_stream = "ProgressUpdateStream",
        .resource_attribute_list = "ResourceAttributeList",
    };
};

pub const PutResourceAttributesOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourceAttributesInput, options: Options) !PutResourceAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhub");

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

fn serializeRequest(alloc: std.mem.Allocator, input: PutResourceAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub", "Migration Hub", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSMigrationHub.PutResourceAttributes");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutResourceAttributesOutput {
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
    if (std.mem.eql(u8, error_code, "DryRunOperation")) {
        return .{ .arena = arena, .kind = .{ .dry_run_operation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HomeRegionNotSetException")) {
        return .{ .arena = arena, .kind = .{ .home_region_not_set_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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
    if (std.mem.eql(u8, error_code, "PolicyErrorException")) {
        return .{ .arena = arena, .kind = .{ .policy_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedOperation")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_operation = .{
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
