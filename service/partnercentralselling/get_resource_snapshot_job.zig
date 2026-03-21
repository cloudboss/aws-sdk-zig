const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceType = @import("resource_type.zig").ResourceType;
const ResourceSnapshotJobStatus = @import("resource_snapshot_job_status.zig").ResourceSnapshotJobStatus;

pub const GetResourceSnapshotJobInput = struct {
    /// Specifies the catalog related to the request. Valid values are:
    ///
    /// * AWS: Retrieves the snapshot job from the production AWS environment.
    /// * Sandbox: Retrieves the snapshot job from a sandbox environment used for
    ///   testing or development purposes.
    catalog: []const u8,

    /// The unique identifier of the resource snapshot job to be retrieved. This
    /// identifier is crucial for pinpointing the specific job you want to query.
    resource_snapshot_job_identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .resource_snapshot_job_identifier = "ResourceSnapshotJobIdentifier",
    };
};

pub const GetResourceSnapshotJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the snapshot job. This globally unique
    /// identifier can be used for resource-specific operations across AWS services.
    arn: ?[]const u8 = null,

    /// The catalog in which the snapshot job was created. This will match the
    /// Catalog specified in the request.
    catalog: []const u8,

    /// The date and time when the snapshot job was created in ISO 8601 format
    /// (UTC). Example: "2023-05-01T20:37:46Z"
    created_at: ?i64 = null,

    /// The identifier of the engagement associated with this snapshot job. This
    /// links the job to a specific engagement context.
    engagement_id: ?[]const u8 = null,

    /// The unique identifier of the snapshot job. This matches the
    /// ResourceSnapshotJobIdentifier provided in the request.
    id: ?[]const u8 = null,

    /// If the job has encountered any failures, this field contains the error
    /// message from the most recent failure. This can be useful for troubleshooting
    /// issues with the job.
    last_failure: ?[]const u8 = null,

    /// The date and time of the last successful execution of the job, in ISO 8601
    /// format (UTC). Example: "2023-05-01T20:37:46Z"
    last_successful_execution_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the resource being snapshotted. This
    /// provides a globally unique identifier for the resource across AWS.
    resource_arn: ?[]const u8 = null,

    /// The identifier of the specific resource being snapshotted. The format might
    /// vary depending on the ResourceType.
    resource_id: ?[]const u8 = null,

    /// The name of the template used for creating the snapshot. This is the same as
    /// the template name. It defines the structure and content of the snapshot.
    resource_snapshot_template_name: ?[]const u8 = null,

    /// The type of resource being snapshotted. This would have "Opportunity" as a
    /// value as it is dependent on the supported resource type.
    resource_type: ?ResourceType = null,

    /// The current status of the snapshot job. Valid values:
    ///
    /// * STOPPED: The job is not currently running.
    /// * RUNNING: The job is actively executing.
    status: ?ResourceSnapshotJobStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .engagement_id = "EngagementId",
        .id = "Id",
        .last_failure = "LastFailure",
        .last_successful_execution_date = "LastSuccessfulExecutionDate",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_snapshot_template_name = "ResourceSnapshotTemplateName",
        .resource_type = "ResourceType",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceSnapshotJobInput, options: CallOptions) !GetResourceSnapshotJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceSnapshotJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.GetResourceSnapshotJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceSnapshotJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetResourceSnapshotJobOutput, body, allocator);
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
