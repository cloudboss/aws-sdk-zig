const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MigrationAlert = @import("migration_alert.zig").MigrationAlert;
const MigrationStatus = @import("migration_status.zig").MigrationStatus;
const MigrationStrategy = @import("migration_strategy.zig").MigrationStrategy;
const Locale = @import("locale.zig").Locale;

pub const GetMigrationInput = struct {
    /// The unique identifier of the migration to view. The
    /// `migrationID` is returned by the operation.
    migration_id: []const u8,

    pub const json_field_names = .{
        .migration_id = "migrationId",
    };
};

pub const GetMigrationOutput = struct {
    /// A list of alerts and warnings that indicate issues with the migration
    /// for the Amazon Lex V1 bot to Amazon Lex V2. You receive a warning when an
    /// Amazon Lex V1
    /// feature has a different implementation if Amazon Lex V2.
    ///
    /// For more information, see [Migrating a
    /// bot](https://docs.aws.amazon.com/lexv2/latest/dg/migrate.html) in the
    /// *Amazon Lex V2
    /// developer guide*.
    alerts: ?[]const MigrationAlert = null,

    /// The unique identifier of the migration. This is the same as the
    /// identifier used when calling the `GetMigration`
    /// operation.
    migration_id: ?[]const u8 = null,

    /// Indicates the status of the migration. When the status is
    /// `COMPLETE` the migration is finished and the bot is available
    /// in Amazon Lex V2. There may be alerts and warnings that need to be resolved
    /// to
    /// complete the migration.
    migration_status: ?MigrationStatus = null,

    /// The strategy used to conduct the migration.
    ///
    /// * `CREATE_NEW` - Creates a new Amazon Lex V2 bot and migrates
    /// the Amazon Lex V1 bot to the new bot.
    ///
    /// * `UPDATE_EXISTING` - Overwrites the existing Amazon Lex V2 bot
    /// metadata and the locale being migrated. It doesn't change any other
    /// locales in the Amazon Lex V2 bot. If the locale doesn't exist, a new locale
    /// is created in the Amazon Lex V2 bot.
    migration_strategy: ?MigrationStrategy = null,

    /// The date and time that the migration started.
    migration_timestamp: ?i64 = null,

    /// The locale of the Amazon Lex V1 bot migrated to Amazon Lex V2.
    v_1_bot_locale: ?Locale = null,

    /// The name of the Amazon Lex V1 bot migrated to Amazon Lex V2.
    v_1_bot_name: ?[]const u8 = null,

    /// The version of the Amazon Lex V1 bot migrated to Amazon Lex V2.
    v_1_bot_version: ?[]const u8 = null,

    /// The unique identifier of the Amazon Lex V2 bot that the Amazon Lex V1 is
    /// being
    /// migrated to.
    v_2_bot_id: ?[]const u8 = null,

    /// The IAM role that Amazon Lex uses to run the Amazon Lex V2 bot.
    v_2_bot_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .alerts = "alerts",
        .migration_id = "migrationId",
        .migration_status = "migrationStatus",
        .migration_strategy = "migrationStrategy",
        .migration_timestamp = "migrationTimestamp",
        .v_1_bot_locale = "v1BotLocale",
        .v_1_bot_name = "v1BotName",
        .v_1_bot_version = "v1BotVersion",
        .v_2_bot_id = "v2BotId",
        .v_2_bot_role = "v2BotRole",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMigrationInput, options: CallOptions) !GetMigrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelbuildingservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMigrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelbuildingservice", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/migrations/");
    try path_buf.appendSlice(allocator, input.migration_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMigrationOutput {
    var result: GetMigrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMigrationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
