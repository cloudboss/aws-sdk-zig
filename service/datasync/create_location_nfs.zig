const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NfsMountOptions = @import("nfs_mount_options.zig").NfsMountOptions;
const OnPremConfig = @import("on_prem_config.zig").OnPremConfig;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationNfsInput = struct {
    /// Specifies the options that DataSync can use to mount your NFS file
    /// server.
    mount_options: ?NfsMountOptions = null,

    /// Specifies the Amazon Resource Name (ARN) of the DataSync agent that can
    /// connect to your NFS file server.
    ///
    /// You can specify more than one agent. For more information, see [Using
    /// multiple DataSync
    /// agents](https://docs.aws.amazon.com/datasync/latest/userguide/do-i-need-datasync-agent.html#multiple-agents).
    on_prem_config: OnPremConfig,

    /// Specifies the DNS name or IP address (IPv4 or IPv6) of the NFS file server
    /// that your DataSync agent connects to.
    server_hostname: []const u8,

    /// Specifies the export path in your NFS file server that you want DataSync to
    /// mount.
    ///
    /// This path (or a subdirectory of the path) is where DataSync transfers data
    /// to
    /// or from. For information on configuring an export for DataSync, see
    /// [Accessing NFS file
    /// servers](https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html#accessing-nfs).
    subdirectory: []const u8,

    /// Specifies labels that help you categorize, filter, and search for your
    /// Amazon Web Services resources. We recommend creating at least a name tag for
    /// your location.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .mount_options = "MountOptions",
        .on_prem_config = "OnPremConfig",
        .server_hostname = "ServerHostname",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationNfsOutput = struct {
    /// The ARN of the transfer location that you created for your NFS file server.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationNfsInput, options: Options) !CreateLocationNfsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLocationNfsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateLocationNfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLocationNfsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationNfsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
