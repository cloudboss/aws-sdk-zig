const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationMode = @import("application_mode.zig").ApplicationMode;
const ApplicationPreferences = @import("application_preferences.zig").ApplicationPreferences;
const DatabasePreferences = @import("database_preferences.zig").DatabasePreferences;
const PrioritizeBusinessGoals = @import("prioritize_business_goals.zig").PrioritizeBusinessGoals;

pub const PutPortfolioPreferencesInput = struct {
    /// The classification for application component types.
    application_mode: ?ApplicationMode = null,

    /// The transformation preferences for non-database applications.
    application_preferences: ?ApplicationPreferences = null,

    /// The transformation preferences for database applications.
    database_preferences: ?DatabasePreferences = null,

    /// The rank of the business goals based on priority.
    prioritize_business_goals: ?PrioritizeBusinessGoals = null,

    pub const json_field_names = .{
        .application_mode = "applicationMode",
        .application_preferences = "applicationPreferences",
        .database_preferences = "databasePreferences",
        .prioritize_business_goals = "prioritizeBusinessGoals",
    };
};

pub const PutPortfolioPreferencesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPortfolioPreferencesInput, options: CallOptions) !PutPortfolioPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutPortfolioPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/put-portfolio-preferences";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.application_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"applicationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.application_preferences) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"applicationPreferences\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.database_preferences) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"databasePreferences\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prioritize_business_goals) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"prioritizeBusinessGoals\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPortfolioPreferencesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutPortfolioPreferencesOutput = .{};

    return result;
}
