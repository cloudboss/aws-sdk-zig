const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Alias = @import("alias.zig").Alias;

pub const DisassociateFileSystemAliasesInput = struct {
    /// An array of one or more DNS alias names to disassociate, or remove, from the
    /// file system.
    aliases: []const []const u8,

    client_request_token: ?[]const u8 = null,

    /// Specifies the file system from which to disassociate the DNS aliases.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
    };
};

pub const DisassociateFileSystemAliasesOutput = struct {
    /// An array of one or more DNS aliases that Amazon FSx is attempting to
    /// disassociate from the file system.
    aliases: ?[]const Alias = null,

    pub const json_field_names = .{
        .aliases = "Aliases",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateFileSystemAliasesInput, options: CallOptions) !DisassociateFileSystemAliasesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateFileSystemAliasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DisassociateFileSystemAliases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateFileSystemAliasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateFileSystemAliasesOutput, body, allocator);
}
