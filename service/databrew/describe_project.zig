const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Sample = @import("sample.zig").Sample;
const SessionStatus = @import("session_status.zig").SessionStatus;

pub const DescribeProjectInput = struct {
    /// The name of the project to be described.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeProjectOutput = struct {
    /// The date and time that the project was created.
    create_date: ?i64 = null,

    /// The identifier (user name) of the user who created the project.
    created_by: ?[]const u8 = null,

    /// The dataset associated with the project.
    dataset_name: ?[]const u8 = null,

    /// The identifier (user name) of the user who last modified the project.
    last_modified_by: ?[]const u8 = null,

    /// The date and time that the project was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the project.
    name: []const u8,

    /// The date and time when the project was opened.
    open_date: ?i64 = null,

    /// The identifier (user name) of the user that opened the project for use.
    opened_by: ?[]const u8 = null,

    /// The recipe associated with this job.
    recipe_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the project.
    resource_arn: ?[]const u8 = null,

    /// The ARN of the Identity and Access Management (IAM) role to be assumed when
    /// DataBrew runs the job.
    role_arn: ?[]const u8 = null,

    sample: ?Sample = null,

    /// Describes the current state of the session:
    ///
    /// * `PROVISIONING` - allocating resources for the session.
    ///
    /// * `INITIALIZING` - getting the session ready for first use.
    ///
    /// * `ASSIGNED` - the session is ready for use.
    session_status: ?SessionStatus = null,

    /// Metadata tags associated with this project.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .dataset_name = "DatasetName",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .open_date = "OpenDate",
        .opened_by = "OpenedBy",
        .recipe_name = "RecipeName",
        .resource_arn = "ResourceArn",
        .role_arn = "RoleArn",
        .sample = "Sample",
        .session_status = "SessionStatus",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProjectInput, options: Options) !DescribeProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "databrew");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProjectOutput {
    var result: DescribeProjectOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeProjectOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
