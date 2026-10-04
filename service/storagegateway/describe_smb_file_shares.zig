const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SMBFileShareInfo = @import("smb_file_share_info.zig").SMBFileShareInfo;

pub const DescribeSMBFileSharesInput = struct {
    /// An array containing the Amazon Resource Name (ARN) of each file share to be
    /// described.
    file_share_arn_list: []const []const u8,

    pub const json_field_names = .{
        .file_share_arn_list = "FileShareARNList",
    };
};

pub const DescribeSMBFileSharesOutput = struct {
    /// An array containing a description for each requested file share.
    smb_file_share_info_list: ?[]const SMBFileShareInfo = null,

    pub const json_field_names = .{
        .smb_file_share_info_list = "SMBFileShareInfoList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSMBFileSharesInput, options: CallOptions) !DescribeSMBFileSharesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSMBFileSharesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeSMBFileShares");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSMBFileSharesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSMBFileSharesOutput, body, allocator);
}
