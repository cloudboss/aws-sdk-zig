const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateRelationalDatabaseInput = struct {
    /// The Availability Zone in which to create your new database. Use the
    /// `us-east-2a` case-sensitive format.
    ///
    /// You can get a list of Availability Zones by using the `get regions`
    /// operation.
    /// Be sure to add the `include relational database Availability Zones`
    /// parameter to
    /// your request.
    availability_zone: ?[]const u8 = null,

    /// The meaning of this parameter differs according to the database engine you
    /// use.
    ///
    /// **MySQL**
    ///
    /// The name of the database to create when the Lightsail database resource is
    /// created. If
    /// this parameter isn't specified, no database is created in the database
    /// resource.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 64 letters or numbers.
    ///
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits
    /// (0- 9).
    ///
    /// * Can't be a word reserved by the specified database engine.
    ///
    /// For more information about reserved words in MySQL, see the Keywords and
    /// Reserved
    /// Words articles for [MySQL
    /// 5.6](https://dev.mysql.com/doc/refman/5.6/en/keywords.html), [MySQL
    /// 5.7](https://dev.mysql.com/doc/refman/5.7/en/keywords.html), and [MySQL
    /// 8.0](https://dev.mysql.com/doc/refman/8.0/en/keywords.html).
    ///
    /// **PostgreSQL**
    ///
    /// The name of the database to create when the Lightsail database resource is
    /// created. If
    /// this parameter isn't specified, a database named `postgres` is created in
    /// the
    /// database resource.
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 63 letters or numbers.
    ///
    /// * Must begin with a letter. Subsequent characters can be letters,
    ///   underscores, or digits
    /// (0- 9).
    ///
    /// * Can't be a word reserved by the specified database engine.
    ///
    /// For more information about reserved words in PostgreSQL, see the SQL Key
    /// Words
    /// articles for [PostgreSQL
    /// 9.6](https://www.postgresql.org/docs/9.6/sql-keywords-appendix.html),
    /// [PostgreSQL
    /// 10](https://www.postgresql.org/docs/10/sql-keywords-appendix.html),
    /// [PostgreSQL
    /// 11](https://www.postgresql.org/docs/11/sql-keywords-appendix.html), and
    /// [PostgreSQL
    /// 12](https://www.postgresql.org/docs/12/sql-keywords-appendix.html).
    master_database_name: []const u8,

    /// The name for the master user.
    ///
    /// **MySQL**
    ///
    /// Constraints:
    ///
    /// * Required for MySQL.
    ///
    /// * Must be 1 to 16 letters or numbers. Can contain underscores.
    ///
    /// * First character must be a letter.
    ///
    /// * Can't be a reserved word for the chosen database engine.
    ///
    /// For more information about reserved words in MySQL 5.6 or 5.7, see the
    /// Keywords and
    /// Reserved Words articles for [MySQL
    /// 5.6](https://dev.mysql.com/doc/refman/5.6/en/keywords.html), [MySQL
    /// 5.7](https://dev.mysql.com/doc/refman/5.7/en/keywords.html), or [MySQL
    /// 8.0](https://dev.mysql.com/doc/refman/8.0/en/keywords.html).
    ///
    /// **PostgreSQL**
    ///
    /// Constraints:
    ///
    /// * Required for PostgreSQL.
    ///
    /// * Must be 1 to 63 letters or numbers. Can contain underscores.
    ///
    /// * First character must be a letter.
    ///
    /// * Can't be a reserved word for the chosen database engine.
    ///
    /// For more information about reserved words in MySQL 5.6 or 5.7, see the
    /// Keywords and
    /// Reserved Words articles for [PostgreSQL
    /// 9.6](https://www.postgresql.org/docs/9.6/sql-keywords-appendix.html),
    /// [PostgreSQL
    /// 10](https://www.postgresql.org/docs/10/sql-keywords-appendix.html),
    /// [PostgreSQL
    /// 11](https://www.postgresql.org/docs/11/sql-keywords-appendix.html), and
    /// [PostgreSQL
    /// 12](https://www.postgresql.org/docs/12/sql-keywords-appendix.html).
    master_username: []const u8,

    /// The password for the master user. The password can include any printable
    /// ASCII character
    /// except "/", """, or "@". It cannot contain spaces.
    ///
    /// **MySQL**
    ///
    /// Constraints: Must contain from 8 to 41 characters.
    ///
    /// **PostgreSQL**
    ///
    /// Constraints: Must contain from 8 to 128 characters.
    master_user_password: ?[]const u8 = null,

    /// The daily time range during which automated backups are created for your new
    /// database if
    /// automated backups are enabled.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each
    /// AWS Region. For more information about the preferred backup window time
    /// blocks for each
    /// region, see the [Working With
    /// Backups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow) guide in the Amazon Relational Database Service documentation.
    ///
    /// Constraints:
    ///
    /// * Must be in the `hh24:mi-hh24:mi` format.
    ///
    /// Example: `16:00-16:30`
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Must not conflict with the preferred maintenance window.
    ///
    /// * Must be at least 30 minutes.
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur on your new
    /// database.
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for each
    /// AWS Region, occurring on a random day of the week.
    ///
    /// Constraints:
    ///
    /// * Must be in the `ddd:hh24:mi-ddd:hh24:mi` format.
    ///
    /// * Valid days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.
    ///
    /// * Must be at least 30 minutes.
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Example: `Tue:17:00-Tue:17:30`
    preferred_maintenance_window: ?[]const u8 = null,

    /// Specifies the accessibility options for your new database. A value of `true`
    /// specifies a database that is available to resources outside of your
    /// Lightsail account. A
    /// value of `false` specifies a database that is available only to your
    /// Lightsail
    /// resources in the same region as your database.
    publicly_accessible: ?bool = null,

    /// The blueprint ID for your new database. A blueprint describes the major
    /// engine version of
    /// a database.
    ///
    /// You can get a list of database blueprints IDs by using the `get relational
    /// database
    /// blueprints` operation.
    relational_database_blueprint_id: []const u8,

    /// The bundle ID for your new database. A bundle describes the performance
    /// specifications for
    /// your database.
    ///
    /// You can get a list of database bundle IDs by using the `get relational
    /// database
    /// bundles` operation.
    relational_database_bundle_id: []const u8,

    /// The name to use for your new Lightsail database resource.
    ///
    /// Constraints:
    ///
    /// * Must contain from 2 to 255 alphanumeric characters, or hyphens.
    ///
    /// * The first and last character must be a letter or number.
    relational_database_name: []const u8,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .master_database_name = "masterDatabaseName",
        .master_username = "masterUsername",
        .master_user_password = "masterUserPassword",
        .preferred_backup_window = "preferredBackupWindow",
        .preferred_maintenance_window = "preferredMaintenanceWindow",
        .publicly_accessible = "publiclyAccessible",
        .relational_database_blueprint_id = "relationalDatabaseBlueprintId",
        .relational_database_bundle_id = "relationalDatabaseBundleId",
        .relational_database_name = "relationalDatabaseName",
        .tags = "tags",
    };
};

pub const CreateRelationalDatabaseOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRelationalDatabaseInput, options: Options) !CreateRelationalDatabaseOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRelationalDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateRelationalDatabase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRelationalDatabaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRelationalDatabaseOutput, body, allocator);
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
