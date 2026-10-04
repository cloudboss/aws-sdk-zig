const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentPermissionType = @import("document_permission_type.zig").DocumentPermissionType;
const AccountSharingInfo = @import("account_sharing_info.zig").AccountSharingInfo;

pub const DescribeDocumentPermissionInput = struct {
    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The name of the document for which you are the owner.
    name: []const u8,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The permission type for the document. The permission type can be
    /// *Share*.
    permission_type: DocumentPermissionType,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name = "Name",
        .next_token = "NextToken",
        .permission_type = "PermissionType",
    };
};

pub const DescribeDocumentPermissionOutput = struct {
    /// The account IDs that have permission to use this document. The ID can be
    /// either an
    /// Amazon Web Services account number or `all`.
    account_ids: ?[]const []const u8 = null,

    /// A list of Amazon Web Services accounts where the current document is shared
    /// and the version shared with
    /// each account.
    account_sharing_info_list: ?[]const AccountSharingInfo = null,

    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .account_sharing_info_list = "AccountSharingInfoList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDocumentPermissionInput, options: CallOptions) !DescribeDocumentPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDocumentPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeDocumentPermission");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDocumentPermissionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDocumentPermissionOutput, body, allocator);
}
