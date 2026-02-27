const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OwnershipSettings = @import("ownership_settings.zig").OwnershipSettings;
const SpaceSettings = @import("space_settings.zig").SpaceSettings;
const SpaceSharingSettings = @import("space_sharing_settings.zig").SpaceSharingSettings;
const SpaceStatus = @import("space_status.zig").SpaceStatus;

pub const DescribeSpaceInput = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .space_name = "SpaceName",
    };
};

pub const DescribeSpaceOutput = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// The ID of the associated domain.
    domain_id: ?[]const u8 = null,

    /// The failure reason.
    failure_reason: ?[]const u8 = null,

    /// The ID of the space's profile in the Amazon EFS volume.
    home_efs_file_system_uid: ?[]const u8 = null,

    /// The last modified time.
    last_modified_time: ?i64 = null,

    /// The collection of ownership settings for a space.
    ownership_settings: ?OwnershipSettings = null,

    /// The space's Amazon Resource Name (ARN).
    space_arn: ?[]const u8 = null,

    /// The name of the space that appears in the Amazon SageMaker Studio UI.
    space_display_name: ?[]const u8 = null,

    /// The name of the space.
    space_name: ?[]const u8 = null,

    /// A collection of space settings.
    space_settings: ?SpaceSettings = null,

    /// The collection of space sharing settings for a space.
    space_sharing_settings: ?SpaceSharingSettings = null,

    /// The status.
    status: ?SpaceStatus = null,

    /// Returns the URL of the space. If the space is created with Amazon Web
    /// Services IAM Identity Center (Successor to Amazon Web Services Single
    /// Sign-On) authentication, users can navigate to the URL after appending the
    /// respective redirect parameter for the application type to be federated
    /// through Amazon Web Services IAM Identity Center.
    ///
    /// The following application types are supported:
    ///
    /// * Studio Classic: `&redirect=JupyterServer`
    /// * JupyterLab: `&redirect=JupyterLab`
    /// * Code Editor, based on Code-OSS, Visual Studio Code - Open Source:
    ///   `&redirect=CodeEditor`
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .failure_reason = "FailureReason",
        .home_efs_file_system_uid = "HomeEfsFileSystemUid",
        .last_modified_time = "LastModifiedTime",
        .ownership_settings = "OwnershipSettings",
        .space_arn = "SpaceArn",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings = "SpaceSettings",
        .space_sharing_settings = "SpaceSharingSettings",
        .status = "Status",
        .url = "Url",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSpaceInput, options: Options) !DescribeSpaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeSpace");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeSpaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSpaceOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
