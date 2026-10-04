const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FsxProtocol = @import("fsx_protocol.zig").FsxProtocol;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationFsxOpenZfsInput = struct {
    /// The Amazon Resource Name (ARN) of the FSx for OpenZFS file system.
    fsx_filesystem_arn: []const u8,

    /// The type of protocol that DataSync uses to access your file system.
    protocol: FsxProtocol,

    /// The ARNs of the security groups that are used to configure the FSx for
    /// OpenZFS file
    /// system.
    security_group_arns: []const []const u8,

    /// A subdirectory in the location's path that must begin with `/fsx`. DataSync
    /// uses this subdirectory to read or write data (depending on whether the file
    /// system is a source or destination location).
    subdirectory: ?[]const u8 = null,

    /// The key-value pair that represents a tag that you want to add to the
    /// resource. The value
    /// can be an empty string. This value helps you manage, filter, and search for
    /// your resources. We
    /// recommend that you create a name tag for your location.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .fsx_filesystem_arn = "FsxFilesystemArn",
        .protocol = "Protocol",
        .security_group_arns = "SecurityGroupArns",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationFsxOpenZfsOutput = struct {
    /// The ARN of the FSx for OpenZFS file system location that you created.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationFsxOpenZfsInput, options: CallOptions) !CreateLocationFsxOpenZfsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datasync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLocationFsxOpenZfsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateLocationFsxOpenZfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLocationFsxOpenZfsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationFsxOpenZfsOutput, body, allocator);
}
