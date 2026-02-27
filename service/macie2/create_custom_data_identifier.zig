const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SeverityLevel = @import("severity_level.zig").SeverityLevel;

pub const CreateCustomDataIdentifierInput = struct {
    /// A unique, case-sensitive token that you provide to ensure the idempotency of
    /// the request.
    client_token: ?[]const u8 = null,

    /// A custom description of the custom data identifier. The description can
    /// contain as many as 512 characters.
    ///
    /// We strongly recommend that you avoid including any sensitive data in the
    /// description of a custom data identifier. Other users of your account might
    /// be able to see this description, depending on the actions that they're
    /// allowed to perform in Amazon Macie.
    description: ?[]const u8 = null,

    /// An array that lists specific character sequences (*ignore words*) to exclude
    /// from the results. If the text matched by the regular expression contains any
    /// string in this array, Amazon Macie ignores it. The array can contain as many
    /// as 10 ignore words. Each ignore word can contain 4-90 UTF-8 characters.
    /// Ignore words are case sensitive.
    ignore_words: ?[]const []const u8 = null,

    /// An array that lists specific character sequences (*keywords*), one of which
    /// must precede and be within proximity (maximumMatchDistance) of the regular
    /// expression to match. The array can contain as many as 50 keywords. Each
    /// keyword can contain 3-90 UTF-8 characters. Keywords aren't case sensitive.
    keywords: ?[]const []const u8 = null,

    /// The maximum number of characters that can exist between the end of at least
    /// one complete character sequence specified by the keywords array and the end
    /// of the text that matches the regex pattern. If a complete keyword precedes
    /// all the text that matches the pattern and the keyword is within the
    /// specified distance, Amazon Macie includes the result. The distance can be
    /// 1-300 characters. The default value is 50.
    maximum_match_distance: ?i32 = null,

    /// A custom name for the custom data identifier. The name can contain as many
    /// as 128 characters.
    ///
    /// We strongly recommend that you avoid including any sensitive data in the
    /// name of a custom data identifier. Other users of your account might be able
    /// to see this name, depending on the actions that they're allowed to perform
    /// in Amazon Macie.
    name: []const u8,

    /// The regular expression (*regex*) that defines the pattern to match. The
    /// expression can contain as many as 512 characters.
    regex: []const u8,

    /// The severity to assign to findings that the custom data identifier produces,
    /// based on the number of occurrences of text that match the custom data
    /// identifier's detection criteria. You can specify as many as three
    /// SeverityLevel objects in this array, one for each severity: LOW, MEDIUM, or
    /// HIGH. If you specify more than one, the occurrences thresholds must be in
    /// ascending order by severity, moving from LOW to HIGH. For example, 1 for
    /// LOW, 50 for MEDIUM, and 100 for HIGH. If an S3 object contains fewer
    /// occurrences than the lowest specified threshold, Amazon Macie doesn't create
    /// a finding.
    ///
    /// If you don't specify any values for this array, Macie creates findings for
    /// S3 objects that contain at least one occurrence of text that matches the
    /// detection criteria, and Macie assigns the MEDIUM severity to those findings.
    severity_levels: ?[]const SeverityLevel = null,

    /// A map of key-value pairs that specifies the tags to associate with the
    /// custom data identifier.
    ///
    /// A custom data identifier can have a maximum of 50 tags. Each tag consists of
    /// a tag key and an associated tag value. The maximum length of a tag key is
    /// 128 characters. The maximum length of a tag value is 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .ignore_words = "ignoreWords",
        .keywords = "keywords",
        .maximum_match_distance = "maximumMatchDistance",
        .name = "name",
        .regex = "regex",
        .severity_levels = "severityLevels",
        .tags = "tags",
    };
};

pub const CreateCustomDataIdentifierOutput = struct {
    /// The unique identifier for the custom data identifier that was created.
    custom_data_identifier_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_data_identifier_id = "customDataIdentifierId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomDataIdentifierInput, options: Options) !CreateCustomDataIdentifierOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "macie2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCustomDataIdentifierInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/custom-data-identifiers";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ignore_words) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ignoreWords\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.keywords) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"keywords\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.maximum_match_distance) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"maximumMatchDistance\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"regex\":");
    try aws.json.writeValue(@TypeOf(input.regex), input.regex, alloc, &body_buf);
    has_prev = true;
    if (input.severity_levels) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"severityLevels\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCustomDataIdentifierOutput {
    var result: CreateCustomDataIdentifierOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCustomDataIdentifierOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
