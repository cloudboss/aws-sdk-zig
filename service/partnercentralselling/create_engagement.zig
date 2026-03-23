const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EngagementContextDetails = @import("engagement_context_details.zig").EngagementContextDetails;

pub const CreateEngagementInput = struct {
    /// The `CreateEngagementRequest$Catalog` parameter specifies the catalog
    /// related to the engagement. Accepted values are `AWS` and `Sandbox`, which
    /// determine the environment in which the engagement is managed.
    catalog: []const u8,

    /// The `CreateEngagementRequest$ClientToken` parameter specifies a unique,
    /// case-sensitive identifier to ensure that the request is handled exactly
    /// once. The value must not exceed sixty-four alphanumeric characters.
    client_token: []const u8,

    /// The `Contexts` field is a required array of objects, with a maximum of 5
    /// contexts allowed, specifying detailed information about customer projects
    /// associated with the Engagement. Each context object contains a `Type` field
    /// indicating the context type, which must be `CustomerProject` in this
    /// version, and a `Payload` field containing the `CustomerProject` details. The
    /// `CustomerProject` object is composed of two main components: `Customer` and
    /// `Project`. The `Customer` object includes information such as `CompanyName`,
    /// `WebsiteUrl`, `Industry`, and `CountryCode`, providing essential details
    /// about the customer. The `Project` object contains `Title`,
    /// `BusinessProblem`, and `TargetCompletionDate`, offering insights into the
    /// specific project associated with the customer. This structure allows
    /// comprehensive context to be included within the Engagement, facilitating
    /// effective collaboration between parties by providing relevant customer and
    /// project information.
    contexts: ?[]const EngagementContextDetails = null,

    /// Provides a description of the `Engagement`.
    description: []const u8,

    /// Specifies the title of the `Engagement`.
    title: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .contexts = "Contexts",
        .description = "Description",
        .title = "Title",
    };
};

pub const CreateEngagementOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the engagement.
    arn: ?[]const u8 = null,

    /// Unique identifier assigned to the newly created engagement.
    id: ?[]const u8 = null,

    /// The timestamp indicating when the engagement was last modified, in ISO 8601
    /// format (UTC). For newly created engagements, this value matches the creation
    /// timestamp. Example: "2023-05-01T20:37:46Z".
    modified_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .modified_at = "ModifiedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEngagementInput, options: CallOptions) !CreateEngagementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentral");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEngagementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.CreateEngagement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEngagementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEngagementOutput, body, allocator);
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
