const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeFileSystemPolicyInput = struct {
    /// Specifies which EFS file system to retrieve the `FileSystemPolicy`
    /// for.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
    };
};

pub const DescribeFileSystemPolicyOutput = struct {
    /// Specifies the EFS file system to which the `FileSystemPolicy`
    /// applies.
    file_system_id: ?[]const u8 = null,

    /// The JSON formatted `FileSystemPolicy` for the EFS file
    /// system.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFileSystemPolicyInput, options: CallOptions) !DescribeFileSystemPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFileSystemPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFileSystemPolicyOutput {
    var result: DescribeFileSystemPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeFileSystemPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
