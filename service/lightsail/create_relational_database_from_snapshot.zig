const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRelationalDatabaseFromSnapshotInput, options: Options) !CreateRelationalDatabaseFromSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRelationalDatabaseFromSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.CreateRelationalDatabaseFromSnapshot");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateRelationalDatabaseFromSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRelationalDatabaseFromSnapshotOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
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
