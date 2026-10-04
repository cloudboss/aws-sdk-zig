const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectoryConnectSettings = @import("directory_connect_settings.zig").DirectoryConnectSettings;
const NetworkType = @import("network_type.zig").NetworkType;
const DirectorySize = @import("directory_size.zig").DirectorySize;
const Tag = @import("tag.zig").Tag;

pub const ConnectDirectoryInput = struct {
    /// A DirectoryConnectSettings object that contains additional information
    /// for the operation.
    connect_settings: DirectoryConnectSettings,

    /// A description for the directory.
    description: ?[]const u8 = null,

    /// The fully qualified name of your self-managed directory, such as
    /// `corp.example.com`.
    name: []const u8,

    /// The network type for your directory. The default value is `IPv4` or
    /// `IPv6` based on the provided subnet capabilities.
    network_type: ?NetworkType = null,

    /// The password for your self-managed user account.
    password: []const u8,

    /// The NetBIOS name of your self-managed directory, such as `CORP`.
    short_name: ?[]const u8 = null,

    /// The size of the directory.
    size: DirectorySize,

    /// The tags to be assigned to AD Connector.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connect_settings = "ConnectSettings",
        .description = "Description",
        .name = "Name",
        .network_type = "NetworkType",
        .password = "Password",
        .short_name = "ShortName",
        .size = "Size",
        .tags = "Tags",
    };
};

pub const ConnectDirectoryOutput = struct {
    /// The identifier of the new directory.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConnectDirectoryInput, options: CallOptions) !ConnectDirectoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ConnectDirectoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.ConnectDirectory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConnectDirectoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ConnectDirectoryOutput, body, allocator);
}
