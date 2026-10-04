const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileSystemAssociationSummary = @import("file_system_association_summary.zig").FileSystemAssociationSummary;

pub const ListFileSystemAssociationsInput = struct {
    gateway_arn: ?[]const u8 = null,

    /// The maximum number of file system associations to return in the response. If
    /// present,
    /// `Limit` must be an integer with a value greater than zero. Optional.
    limit: ?i32 = null,

    /// Opaque pagination token returned from a previous
    /// `ListFileSystemAssociations`
    /// operation. If present, `Marker` specifies where to continue the list from
    /// after
    /// a previous call to `ListFileSystemAssociations`. Optional.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .limit = "Limit",
        .marker = "Marker",
    };
};

pub const ListFileSystemAssociationsOutput = struct {
    /// An array of information about the Amazon FSx gateway's file system
    /// associations.
    file_system_association_summary_list: ?[]const FileSystemAssociationSummary = null,

    /// If the request includes `Marker`, the response returns that value in this
    /// field.
    marker: ?[]const u8 = null,

    /// If a value is present, there are more file system associations to return. In
    /// a
    /// subsequent request, use `NextMarker` as the value for `Marker` to
    /// retrieve the next set of file system associations.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_association_summary_list = "FileSystemAssociationSummaryList",
        .marker = "Marker",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFileSystemAssociationsInput, options: CallOptions) !ListFileSystemAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFileSystemAssociationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.ListFileSystemAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFileSystemAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFileSystemAssociationsOutput, body, allocator);
}
