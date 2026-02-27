const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PosixUser = @import("posix_user.zig").PosixUser;
const RootDirectory = @import("root_directory.zig").RootDirectory;
const Tag = @import("tag.zig").Tag;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

pub const CreateAccessPointInput = struct {
    /// A string of up to 64 ASCII characters that Amazon EFS uses to ensure
    /// idempotent
    /// creation.
    client_token: []const u8,

    /// The ID of the EFS file system that the access point provides access to.
    file_system_id: []const u8,

    /// The operating system user and
    /// group applied to all file system requests made using the access point.
    posix_user: ?PosixUser = null,

    /// Specifies the directory on the EFS file system that the access point exposes
    /// as
    /// the root directory of your file system to NFS clients using the access
    /// point. The clients
    /// using the access point can only access the root directory and below. If the
    /// `RootDirectory` > `Path` specified does not exist, Amazon EFS creates it and
    /// applies the `CreationInfo` settings when a client connects to an
    /// access point. When specifying a `RootDirectory`, you must provide the
    /// `Path`, and the `CreationInfo`.
    ///
    /// Amazon EFS creates a root directory only if you have provided the
    /// CreationInfo: OwnUid, OwnGID, and permissions for the directory.
    /// If you do not provide this information, Amazon EFS does not create the root
    /// directory. If the root directory does not exist, attempts to mount
    /// using the access point will fail.
    root_directory: ?RootDirectory = null,

    /// Creates tags associated with the access point. Each tag is a key-value pair,
    /// each key must be unique. For more
    /// information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .file_system_id = "FileSystemId",
        .posix_user = "PosixUser",
        .root_directory = "RootDirectory",
        .tags = "Tags",
    };
};

pub const CreateAccessPointOutput = struct {
    /// The unique Amazon Resource Name (ARN) associated with the access
    /// point.
    access_point_arn: ?[]const u8 = null,

    /// The ID of the access point, assigned by Amazon EFS.
    access_point_id: ?[]const u8 = null,

    /// The opaque string specified in the request to ensure idempotent creation.
    client_token: ?[]const u8 = null,

    /// The ID of the EFS file system that the access point applies to.
    file_system_id: ?[]const u8 = null,

    /// Identifies the lifecycle phase of the access point.
    life_cycle_state: ?LifeCycleState = null,

    /// The name of the access point. This is the value of the `Name` tag.
    name: ?[]const u8 = null,

    /// Identifies the Amazon Web Services account that owns the access point
    /// resource.
    owner_id: ?[]const u8 = null,

    /// The full POSIX identity, including the user ID, group ID, and secondary
    /// group IDs on the access point that is used for all file operations by
    /// NFS clients using the access point.
    posix_user: ?PosixUser = null,

    /// The directory on the EFS file system that the access point exposes as the
    /// root
    /// directory to NFS clients using the access point.
    root_directory: ?RootDirectory = null,

    /// The tags associated with the access point, presented as an array of Tag
    /// objects.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .access_point_id = "AccessPointId",
        .client_token = "ClientToken",
        .file_system_id = "FileSystemId",
        .life_cycle_state = "LifeCycleState",
        .name = "Name",
        .owner_id = "OwnerId",
        .posix_user = "PosixUser",
        .root_directory = "RootDirectory",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessPointInput, options: Options) !CreateAccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "efs");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("efs", "EFS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-02-01/access-points";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ClientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"FileSystemId\":");
    try aws.json.writeValue(@TypeOf(input.file_system_id), input.file_system_id, alloc, &body_buf);
    has_prev = true;
    if (input.posix_user) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PosixUser\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.root_directory) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RootDirectory\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAccessPointOutput {
    var result: CreateAccessPointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAccessPointOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessPointAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .access_point_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessPointLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .access_point_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessPointNotFound")) {
        return .{ .arena = arena, .kind = .{ .access_point_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AvailabilityZonesMismatch")) {
        return .{ .arena = arena, .kind = .{ .availability_zones_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequest")) {
        return .{ .arena = arena, .kind = .{ .bad_request = .{
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
    if (std.mem.eql(u8, error_code, "DependencyTimeout")) {
        return .{ .arena = arena, .kind = .{ .dependency_timeout = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .file_system_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemInUse")) {
        return .{ .arena = arena, .kind = .{ .file_system_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .file_system_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemNotFound")) {
        return .{ .arena = arena, .kind = .{ .file_system_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectFileSystemLifeCycleState")) {
        return .{ .arena = arena, .kind = .{ .incorrect_file_system_life_cycle_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectMountTargetState")) {
        return .{ .arena = arena, .kind = .{ .incorrect_mount_target_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientThroughputCapacity")) {
        return .{ .arena = arena, .kind = .{ .insufficient_throughput_capacity = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IpAddressInUse")) {
        return .{ .arena = arena, .kind = .{ .ip_address_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MountTargetConflict")) {
        return .{ .arena = arena, .kind = .{ .mount_target_conflict = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MountTargetNotFound")) {
        return .{ .arena = arena, .kind = .{ .mount_target_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NetworkInterfaceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .network_interface_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoFreeAddressesInSubnet")) {
        return .{ .arena = arena, .kind = .{ .no_free_addresses_in_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFound")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .replication_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationNotFound")) {
        return .{ .arena = arena, .kind = .{ .replication_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecurityGroupLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .security_group_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecurityGroupNotFound")) {
        return .{ .arena = arena, .kind = .{ .security_group_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFound")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found = .{
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
    if (std.mem.eql(u8, error_code, "ThroughputLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .throughput_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequests")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAvailabilityZone")) {
        return .{ .arena = arena, .kind = .{ .unsupported_availability_zone = .{
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
