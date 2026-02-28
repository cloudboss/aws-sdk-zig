const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const Consolidation = @import("consolidation.zig").Consolidation;

pub const GetAutoMergingPreviewInput = struct {
    /// How the auto-merging process should resolve conflicts between different
    /// profiles.
    conflict_resolution: ConflictResolution,

    /// A list of matching attributes that represent matching criteria.
    consolidation: Consolidation,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// Minimum confidence score required for profiles within a matching group to be
    /// merged
    /// during the auto-merge process.
    min_allowed_confidence_score_for_merging: ?f64 = null,

    pub const json_field_names = .{
        .conflict_resolution = "ConflictResolution",
        .consolidation = "Consolidation",
        .domain_name = "DomainName",
        .min_allowed_confidence_score_for_merging = "MinAllowedConfidenceScoreForMerging",
    };
};

pub const GetAutoMergingPreviewOutput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The number of match groups in the domain that have been reviewed in this
    /// preview dry
    /// run.
    number_of_matches_in_sample: ?i64 = null,

    /// The number of profiles found in this preview dry run.
    number_of_profiles_in_sample: ?i64 = null,

    /// The number of profiles that would be merged if this wasn't a preview dry
    /// run.
    number_of_profiles_will_be_merged: ?i64 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .number_of_matches_in_sample = "NumberOfMatchesInSample",
        .number_of_profiles_in_sample = "NumberOfProfilesInSample",
        .number_of_profiles_will_be_merged = "NumberOfProfilesWillBeMerged",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutoMergingPreviewInput, options: Options) !GetAutoMergingPreviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "customerprofiles");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetAutoMergingPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/domains/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/identity-resolution-jobs/auto-merging-preview");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ConflictResolution\":");
    try aws.json.writeValue(@TypeOf(input.conflict_resolution), input.conflict_resolution, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Consolidation\":");
    try aws.json.writeValue(@TypeOf(input.consolidation), input.consolidation, alloc, &body_buf);
    has_prev = true;
    if (input.min_allowed_confidence_score_for_merging) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MinAllowedConfidenceScoreForMerging\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAutoMergingPreviewOutput {
    var result: GetAutoMergingPreviewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAutoMergingPreviewOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
