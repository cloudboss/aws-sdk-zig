const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShareMethod = @import("share_method.zig").ShareMethod;
const ShareTarget = @import("share_target.zig").ShareTarget;

pub const ShareDirectoryInput = struct {
    /// Identifier of the Managed Microsoft AD directory that you want to share with
    /// other
    /// Amazon Web Services accounts.
    directory_id: []const u8,

    /// The method used when sharing a directory to determine whether the directory
    /// should be
    /// shared within your Amazon Web Services organization (`ORGANIZATIONS`) or
    /// with any Amazon Web Services account
    /// by sending a directory sharing request (`HANDSHAKE`).
    share_method: ShareMethod,

    /// A directory share request that is sent by the directory owner to the
    /// directory consumer.
    /// The request includes a typed message to help the directory consumer
    /// administrator determine
    /// whether to approve or reject the share invitation.
    share_notes: ?[]const u8 = null,

    /// Identifier for the directory consumer account with whom the directory is to
    /// be
    /// shared.
    share_target: ShareTarget,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .share_method = "ShareMethod",
        .share_notes = "ShareNotes",
        .share_target = "ShareTarget",
    };
};

pub const ShareDirectoryOutput = struct {
    /// Identifier of the directory that is stored in the directory consumer account
    /// that is
    /// shared from the specified directory (`DirectoryId`).
    shared_directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .shared_directory_id = "SharedDirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ShareDirectoryInput, options: CallOptions) !ShareDirectoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ShareDirectoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.ShareDirectory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ShareDirectoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ShareDirectoryOutput, body, allocator);
}
