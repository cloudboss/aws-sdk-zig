const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KMSKeyDetails = @import("kms_key_details.zig").KMSKeyDetails;
const Repository = @import("repository.zig").Repository;
const RepositoryAssociation = @import("repository_association.zig").RepositoryAssociation;

pub const AssociateRepositoryInput = struct {
    /// Amazon CodeGuru Reviewer uses this value to prevent the accidental creation
    /// of duplicate repository
    /// associations if there are failures and retries.
    client_request_token: ?[]const u8 = null,

    /// A `KMSKeyDetails` object that contains:
    ///
    /// * The encryption option for this repository association. It is either owned
    ///   by Amazon Web Services
    /// Key Management Service (KMS) (`AWS_OWNED_CMK`) or customer managed
    /// (`CUSTOMER_MANAGED_CMK`).
    ///
    /// * The ID of the Amazon Web Services KMS key that is associated with this
    ///   repository
    /// association.
    kms_key_details: ?KMSKeyDetails = null,

    /// The repository to associate.
    repository: Repository,

    /// An array of key-value pairs used to tag an associated repository. A tag is a
    /// custom attribute label with two parts:
    ///
    /// * A *tag key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// keys are case sensitive.
    ///
    /// * An optional field known as a *tag value* (for example,
    /// `111122223333`, `Production`, or a team name).
    /// Omitting the tag value is the same as using an empty string. Like tag keys,
    /// tag
    /// values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .kms_key_details = "KMSKeyDetails",
        .repository = "Repository",
        .tags = "Tags",
    };
};

pub const AssociateRepositoryOutput = struct {
    /// Information about the repository association.
    repository_association: ?RepositoryAssociation = null,

    /// An array of key-value pairs used to tag an associated repository. A tag is a
    /// custom attribute label with two parts:
    ///
    /// * A *tag key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// keys are case sensitive.
    ///
    /// * An optional field known as a *tag value* (for example,
    /// `111122223333`, `Production`, or a team name).
    /// Omitting the tag value is the same as using an empty string. Like tag keys,
    /// tag
    /// values are case sensitive.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .repository_association = "RepositoryAssociation",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateRepositoryInput, options: Options) !AssociateRepositoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codegurureviewer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateRepositoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codegurureviewer", "CodeGuru Reviewer", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/associations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KMSKeyDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Repository\":");
    try aws.json.writeValue(@TypeOf(input.repository), input.repository, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateRepositoryOutput {
    var result: AssociateRepositoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateRepositoryOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
