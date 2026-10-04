const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkType = @import("network_type.zig").NetworkType;
const DirectorySize = @import("directory_size.zig").DirectorySize;
const Tag = @import("tag.zig").Tag;
const DirectoryVpcSettings = @import("directory_vpc_settings.zig").DirectoryVpcSettings;

pub const CreateDirectoryInput = struct {
    /// A description for the directory.
    description: ?[]const u8 = null,

    /// The fully qualified name for the directory, such as `corp.example.com`.
    name: []const u8,

    /// The network type for your directory. Simple AD supports IPv4 and Dual-stack
    /// only.
    network_type: ?NetworkType = null,

    /// The password for the directory administrator. The directory creation process
    /// creates a
    /// directory administrator account with the user name `Administrator` and this
    /// password.
    ///
    /// If you need to change the password for the administrator account, you can
    /// use the ResetUserPassword API call.
    ///
    /// The regex pattern for this string is made up of the following conditions:
    ///
    /// * Length (?=^.{8,64}$) – Must be between 8 and 64 characters
    ///
    /// AND any 3 of the following password complexity rules required by Active
    /// Directory:
    ///
    /// * Numbers and upper case and lowercase (?=.*\d)(?=.*[A-Z])(?=.*[a-z])
    ///
    /// * Numbers and special characters and lower case
    /// (?=.*\d)(?=.*[^A-Za-z0-9\s])(?=.*[a-z])
    ///
    /// * Special characters and upper case and lower case
    /// (?=.*[^A-Za-z0-9\s])(?=.*[A-Z])(?=.*[a-z])
    ///
    /// * Numbers and upper case and special characters
    /// (?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9\s])
    ///
    /// For additional information about how Active Directory passwords are
    /// enforced, see [Password must meet complexity
    /// requirements](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements) on the Microsoft website.
    password: []const u8,

    /// The NetBIOS name of the directory, such as `CORP`.
    short_name: ?[]const u8 = null,

    /// The size of the directory.
    size: DirectorySize,

    /// The tags to be assigned to the Simple AD directory.
    tags: ?[]const Tag = null,

    /// A DirectoryVpcSettings object that contains additional information for
    /// the operation.
    vpc_settings: ?DirectoryVpcSettings = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .network_type = "NetworkType",
        .password = "Password",
        .short_name = "ShortName",
        .size = "Size",
        .tags = "Tags",
        .vpc_settings = "VpcSettings",
    };
};

pub const CreateDirectoryOutput = struct {
    /// The identifier of the directory that was created.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDirectoryInput, options: CallOptions) !CreateDirectoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDirectoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.CreateDirectory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDirectoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDirectoryOutput, body, allocator);
}
