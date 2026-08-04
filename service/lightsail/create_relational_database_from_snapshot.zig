const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateRelationalDatabaseFromSnapshotInput = struct {
    /// The Availability Zone in which to create your new database. Use the
    /// `us-east-2a` case-sensitive format.
    ///
    /// You can get a list of Availability Zones by using the `get regions`
    /// operation.
    /// Be sure to add the `include relational database Availability Zones`
    /// parameter to
    /// your request.
    availability_zone: ?[]const u8 = null,

    /// Specifies the accessibility options for your new database. A value of `true`
    /// specifies a database that is available to resources outside of your
    /// Lightsail account. A
    /// value of `false` specifies a database that is available only to your
    /// Lightsail
    /// resources in the same region as your database.
    publicly_accessible: ?bool = null,

    /// The bundle ID for your new database. A bundle describes the performance
    /// specifications for
    /// your database.
    ///
    /// You can get a list of database bundle IDs by using the `get relational
    /// database
    /// bundles` operation.
    ///
    /// When creating a new database from a snapshot, you cannot choose a bundle
    /// that is smaller
    /// than the bundle of the source database.
    relational_database_bundle_id: ?[]const u8 = null,

    /// The name to use for your new Lightsail database resource.
    ///
    /// Constraints:
    ///
    /// * Must contain from 2 to 255 alphanumeric characters, or hyphens.
    ///
    /// * The first and last character must be a letter or number.
    relational_database_name: []const u8,

    /// The name of the database snapshot from which to create your new database.
    relational_database_snapshot_name: ?[]const u8 = null,

    /// The date and time to restore your database from.
    ///
    /// Constraints:
    ///
    /// * Must be before the latest restorable time for the database.
    ///
    /// * Cannot be specified if the `use latest restorable time` parameter is
    /// `true`.
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you wish to use a restore time of October 1, 2018, at 8 PM
    /// UTC, then
    /// you input `1538424000` as the restore time.
    restore_time: ?i64 = null,

    /// The name of the source database.
    source_relational_database_name: ?[]const u8 = null,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    /// Specifies whether your database is restored from the latest backup time. A
    /// value of
    /// `true` restores from the latest backup time.
    ///
    /// Default: `false`
    ///
    /// Constraints: Cannot be specified if the `restore time` parameter is
    /// provided.
    use_latest_restorable_time: ?bool = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .publicly_accessible = "publiclyAccessible",
        .relational_database_bundle_id = "relationalDatabaseBundleId",
        .relational_database_name = "relationalDatabaseName",
        .relational_database_snapshot_name = "relationalDatabaseSnapshotName",
        .restore_time = "restoreTime",
        .source_relational_database_name = "sourceRelationalDatabaseName",
        .tags = "tags",
        .use_latest_restorable_time = "useLatestRestorableTime",
    };
};

pub const CreateRelationalDatabaseFromSnapshotOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRelationalDatabaseFromSnapshotInput, options: CallOptions) !CreateRelationalDatabaseFromSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRelationalDatabaseFromSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateRelationalDatabaseFromSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRelationalDatabaseFromSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRelationalDatabaseFromSnapshotOutput, body, allocator);
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
