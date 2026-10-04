const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileShareInfo = @import("file_share_info.zig").FileShareInfo;

pub const ListFileSharesInput = struct {
    /// The Amazon Resource Name (ARN) of the gateway whose file shares you want to
    /// list. If
    /// this field is not present, all file shares under your account are listed.
    gateway_arn: ?[]const u8 = null,

    /// The maximum number of file shares to return in the response. The value must
    /// be an
    /// integer with a value greater than zero. Optional.
    limit: ?i32 = null,

    /// Opaque pagination token returned from a previous ListFileShares operation.
    /// If present,
    /// `Marker` specifies where to continue the list from after a previous call to
    /// ListFileShares. Optional.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .limit = "Limit",
        .marker = "Marker",
    };
};

pub const ListFileSharesOutput = struct {
    /// An array of information about the S3 File Gateway's file shares.
    file_share_info_list: ?[]const FileShareInfo = null,

    /// If the request includes `Marker`, the response returns that value in this
    /// field.
    marker: ?[]const u8 = null,

    /// If a value is present, there are more file shares to return. In a subsequent
    /// request,
    /// use `NextMarker` as the value for `Marker` to retrieve the next set
    /// of file shares.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_share_info_list = "FileShareInfoList",
        .marker = "Marker",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFileSharesInput, options: CallOptions) !ListFileSharesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFileSharesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.ListFileShares");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFileSharesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFileSharesOutput, body, allocator);
}
