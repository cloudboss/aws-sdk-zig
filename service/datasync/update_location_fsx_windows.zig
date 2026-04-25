const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;

pub const UpdateLocationFsxWindowsInput = struct {
    /// Specifies configuration information for a DataSync-managed secret, such as a
    /// `Password` or set of credentials that DataSync uses to access a specific
    /// transfer location, and a customer-managed KMS key.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies configuration information for a customer-managed secret, such as a
    /// `Password` or set of credentials that DataSync uses to access a specific
    /// transfer location, and a customer-managed Identity and Access Management
    /// (IAM) role
    /// that provides access to the secret.
    custom_secret_config: ?CustomSecretConfig = null,

    /// Specifies the name of the Windows domain that your FSx for Windows File
    /// Server file system
    /// belongs to.
    ///
    /// If you have multiple Active Directory domains in your environment,
    /// configuring this
    /// parameter makes sure that DataSync connects to the right file system.
    domain: ?[]const u8 = null,

    /// Specifies the ARN of the FSx for Windows File Server transfer location that
    /// you're
    /// updating.
    location_arn: []const u8,

    /// Specifies the password of the user with the permissions to mount and access
    /// the files,
    /// folders, and file metadata in your FSx for Windows File Server file system.
    password: ?[]const u8 = null,

    /// Specifies a mount path for your file system using forward slashes. DataSync
    /// uses
    /// this subdirectory to read or write data (depending on whether the file
    /// system is a source or
    /// destination location).
    subdirectory: ?[]const u8 = null,

    /// Specifies the user with the permissions to mount and access the files,
    /// folders, and file
    /// metadata in your FSx for Windows File Server file system.
    ///
    /// For information about choosing a user with the right level of access for
    /// your transfer,
    /// see [required
    /// permissions](https://docs.aws.amazon.com/datasync/latest/userguide/create-fsx-location.html#create-fsx-windows-location-permissions) for FSx for Windows File Server locations.
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .cmk_secret_config = "CmkSecretConfig",
        .custom_secret_config = "CustomSecretConfig",
        .domain = "Domain",
        .location_arn = "LocationArn",
        .password = "Password",
        .subdirectory = "Subdirectory",
        .user = "User",
    };
};

pub const UpdateLocationFsxWindowsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLocationFsxWindowsInput, options: CallOptions) !UpdateLocationFsxWindowsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLocationFsxWindowsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.UpdateLocationFsxWindows");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLocationFsxWindowsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
