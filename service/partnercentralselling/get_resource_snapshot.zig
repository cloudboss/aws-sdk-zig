const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceType = @import("resource_type.zig").ResourceType;
const ResourceSnapshotPayload = @import("resource_snapshot_payload.zig").ResourceSnapshotPayload;

pub const GetResourceSnapshotInput = struct {
    /// Specifies the catalog related to the request. Valid values are:
    ///
    /// * AWS: Retrieves the snapshot from the production AWS environment.
    /// * Sandbox: Retrieves the snapshot from a sandbox environment used for
    ///   testing or development purposes.
    catalog: []const u8,

    /// The unique identifier of the engagement associated with the snapshot. This
    /// field links the snapshot to a specific engagement context.
    engagement_identifier: []const u8,

    /// The unique identifier of the specific resource that was snapshotted. The
    /// format and constraints of this identifier depend on the ResourceType
    /// specified. For `Opportunity` type, it will be an `opportunity ID`
    resource_identifier: []const u8,

    /// he name of the template that defines the schema for the snapshot. This
    /// template determines which subset of the resource data is included in the
    /// snapshot and must correspond to an existing and valid template for the
    /// specified `ResourceType`.
    resource_snapshot_template_identifier: []const u8,

    /// Specifies the type of resource that was snapshotted. This field determines
    /// the structure and content of the snapshot payload. Valid value
    /// includes:`Opportunity`: For opportunity-related data.
    resource_type: ResourceType,

    /// Specifies which revision of the snapshot to retrieve. If omitted returns the
    /// latest revision.
    revision: ?i32 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .engagement_identifier = "EngagementIdentifier",
        .resource_identifier = "ResourceIdentifier",
        .resource_snapshot_template_identifier = "ResourceSnapshotTemplateIdentifier",
        .resource_type = "ResourceType",
        .revision = "Revision",
    };
};

pub const GetResourceSnapshotOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the resource
    /// snapshot.
    arn: ?[]const u8 = null,

    /// The catalog in which the snapshot was created. Matches the Catalog specified
    /// in the request.
    catalog: []const u8,

    /// The timestamp when the snapshot was created, in ISO 8601 format (e.g.,
    /// "2023-06-01T14:30:00Z"). This allows for precise tracking of when the
    /// snapshot was taken.
    created_at: ?i64 = null,

    /// The AWS account ID of the principal (user or role) who created the snapshot.
    /// This helps in tracking the origin of the snapshot.
    created_by: ?[]const u8 = null,

    /// The identifier of the engagement associated with this snapshot. Matches the
    /// EngagementIdentifier specified in the request.
    engagement_id: ?[]const u8 = null,

    payload: ?ResourceSnapshotPayload = null,

    /// The identifier of the specific resource that was snapshotted. Matches the
    /// ResourceIdentifier specified in the request.
    resource_id: ?[]const u8 = null,

    /// The name of the view used for this snapshot. This is the same as the
    /// template name.
    resource_snapshot_template_name: ?[]const u8 = null,

    /// The type of the resource that was snapshotted. Matches the ResourceType
    /// specified in the request.
    resource_type: ?ResourceType = null,

    /// The revision number of this snapshot. This is a positive integer that is
    /// sequential and unique within the context of a resource view.
    revision: ?i32 = null,

    /// Target member accounts associated with the resource snapshot.
    target_member_accounts: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .engagement_id = "EngagementId",
        .payload = "Payload",
        .resource_id = "ResourceId",
        .resource_snapshot_template_name = "ResourceSnapshotTemplateName",
        .resource_type = "ResourceType",
        .revision = "Revision",
        .target_member_accounts = "TargetMemberAccounts",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceSnapshotInput, options: Options) !GetResourceSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetResourceSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSPartnerCentralSelling.GetResourceSnapshot");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetResourceSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceSnapshotOutput, body, alloc);
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
