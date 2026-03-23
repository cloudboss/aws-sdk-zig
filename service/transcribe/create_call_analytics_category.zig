const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InputType = @import("input_type.zig").InputType;
const Rule = @import("rule.zig").Rule;
const Tag = @import("tag.zig").Tag;
const CategoryProperties = @import("category_properties.zig").CategoryProperties;

pub const CreateCallAnalyticsCategoryInput = struct {
    /// A unique name, chosen by you, for your Call Analytics category. It's helpful
    /// to use a
    /// detailed naming system that will make sense to you in the future. For
    /// example, it's
    /// better to use `sentiment-positive-last30seconds` for a category over a
    /// generic name like `test-category`.
    ///
    /// Category names are case sensitive.
    category_name: []const u8,

    /// Choose whether you want to create a real-time or a post-call category for
    /// your Call
    /// Analytics transcription.
    ///
    /// Specifying `POST_CALL` assigns your category to post-call transcriptions;
    /// categories with this input type cannot be applied to streaming (real-time)
    /// transcriptions.
    ///
    /// Specifying `REAL_TIME` assigns your category to streaming transcriptions;
    /// categories with this input type cannot be applied to post-call
    /// transcriptions.
    ///
    /// If you do not include `InputType`, your category is created as a post-call
    /// category by default.
    input_type: ?InputType = null,

    /// Rules define a Call Analytics category. When creating a new category, you
    /// must create
    /// between 1 and 20 rules for that category. For each rule, you specify a
    /// filter you want
    /// applied to the attributes of a call. For example, you can choose a sentiment
    /// filter that
    /// detects if a customer's sentiment was positive during the last 30 seconds of
    /// the call.
    rules: []const Rule,

    /// Adds one or more custom tags, each in the form of a key:value pair, to a new
    /// call analytics category at the time you start this new job.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .category_name = "CategoryName",
        .input_type = "InputType",
        .rules = "Rules",
        .tags = "Tags",
    };
};

pub const CreateCallAnalyticsCategoryOutput = struct {
    /// Provides you with the properties of your new category, including its
    /// associated
    /// rules.
    category_properties: ?CategoryProperties = null,

    pub const json_field_names = .{
        .category_properties = "CategoryProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCallAnalyticsCategoryInput, options: CallOptions) !CreateCallAnalyticsCategoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transcribe");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCallAnalyticsCategoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.CreateCallAnalyticsCategory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCallAnalyticsCategoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCallAnalyticsCategoryOutput, body, allocator);
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
