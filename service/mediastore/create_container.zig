const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Tag = @import("tag.zig").Tag;
const Container = @import("container.zig").Container;

pub const CreateContainerInput = struct {
    /// The name for the container. The name must be from 1 to 255 characters.
    /// Container
    /// names must be unique to your AWS account within a specific region. As an
    /// example, you could
    /// create a container named `movies` in every region, as long as you don’t have
    /// an
    /// existing container with that name.
    container_name: []const u8,

    /// An array of key:value pairs that you define. These values can be anything
    /// that you want. Typically, the tag key represents a category (such as
    /// "environment") and the tag value represents a specific value within that
    /// category (such as "test," "development," or "production"). You can add up to
    /// 50
    /// tags to each container. For more information about tagging, including naming
    /// and usage conventions, see [Tagging Resources in
    /// MediaStore](https://docs.aws.amazon.com/mediastore/latest/ug/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .tags = "Tags",
    };
};

pub const CreateContainerOutput = struct {
    /// ContainerARN: The Amazon Resource Name (ARN) of the newly created container.
    /// The ARN
    /// has the following format: arn:aws:::container/. For example:
    /// arn:aws:mediastore:us-west-2:111122223333:container/movies
    ///
    /// ContainerName: The container name as specified in the request.
    ///
    /// CreationTime: Unix time stamp.
    ///
    /// Status: The status of container creation or deletion. The status is one of
    /// the
    /// following: `CREATING`, `ACTIVE`, or `DELETING`. While the
    /// service is creating the container, the status is `CREATING`. When an
    /// endpoint is
    /// available, the status changes to `ACTIVE`.
    ///
    /// The return value does not include the container's endpoint. To make
    /// downstream
    /// requests, you must obtain this value by using DescribeContainer or
    /// ListContainers.
    container: ?Container = null,

    pub const json_field_names = .{
        .container = "Container",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerInput, options: CallOptions) !CreateContainerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediastore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediastore", "MediaStore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MediaStore_20170901.CreateContainer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateContainerOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ContainerInUseException")) {
        const parsed_error: ?errors.ContainerInUseException = aws.json.parseJsonObject(errors.ContainerInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .container_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ContainerNotFoundException")) {
        const parsed_error: ?errors.ContainerNotFoundException = aws.json.parseJsonObject(errors.ContainerNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .container_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CorsPolicyNotFoundException")) {
        const parsed_error: ?errors.CorsPolicyNotFoundException = aws.json.parseJsonObject(errors.CorsPolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cors_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        const parsed_error: ?errors.PolicyNotFoundException = aws.json.parseJsonObject(errors.PolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_not_found_exception = typed_error } };
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
