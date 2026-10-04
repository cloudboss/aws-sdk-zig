const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectoryEdition = @import("directory_edition.zig").DirectoryEdition;
const NetworkType = @import("network_type.zig").NetworkType;
const Tag = @import("tag.zig").Tag;
const DirectoryVpcSettings = @import("directory_vpc_settings.zig").DirectoryVpcSettings;

pub const CreateMicrosoftADInput = struct {
    /// A description for the directory. This label will appear on the Amazon Web
    /// Services console
    /// `Directory Details` page after the directory is created.
    description: ?[]const u8 = null,

    /// Managed Microsoft AD is available in two editions: `Standard` and
    /// `Enterprise`. `Enterprise` is the default.
    edition: ?DirectoryEdition = null,

    /// The fully qualified domain name for the Managed Microsoft AD directory, such
    /// as
    /// `corp.example.com`. This name will resolve inside your VPC only. It does not
    /// need
    /// to be publicly resolvable.
    name: []const u8,

    /// The network type for your domain. The default value is `IPv4` or `IPv6`
    /// based on the provided subnet capabilities.
    network_type: ?NetworkType = null,

    /// The password for the default administrative user named `Admin`.
    ///
    /// If you need to change the password for the administrator account, you can
    /// use the ResetUserPassword API call.
    password: []const u8,

    /// The NetBIOS name for your domain, such as `CORP`. If you don't specify a
    /// NetBIOS name, it will default to the first part of your directory DNS. For
    /// example,
    /// `CORP` for the directory DNS `corp.example.com`.
    short_name: ?[]const u8 = null,

    /// The tags to be assigned to the Managed Microsoft AD directory.
    tags: ?[]const Tag = null,

    /// Contains VPC information for the CreateDirectory or CreateMicrosoftAD
    /// operation.
    vpc_settings: DirectoryVpcSettings,

    pub const json_field_names = .{
        .description = "Description",
        .edition = "Edition",
        .name = "Name",
        .network_type = "NetworkType",
        .password = "Password",
        .short_name = "ShortName",
        .tags = "Tags",
        .vpc_settings = "VpcSettings",
    };
};

pub const CreateMicrosoftADOutput = struct {
    /// The identifier of the directory that was created.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMicrosoftADInput, options: CallOptions) !CreateMicrosoftADOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMicrosoftADInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.CreateMicrosoftAD");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMicrosoftADOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMicrosoftADOutput, body, allocator);
}
