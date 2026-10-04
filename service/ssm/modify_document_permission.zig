const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentPermissionType = @import("document_permission_type.zig").DocumentPermissionType;

pub const ModifyDocumentPermissionInput = struct {
    /// The Amazon Web Services users that should have access to the document. The
    /// account IDs can either be a
    /// group of account IDs or *All*. You must specify a value for this parameter
    /// or
    /// the `AccountIdsToRemove` parameter.
    account_ids_to_add: ?[]const []const u8 = null,

    /// The Amazon Web Services users that should no longer have access to the
    /// document. The Amazon Web Services user
    /// can either be a group of account IDs or *All*. This action has a higher
    /// priority than `AccountIdsToAdd`. If you specify an ID to add and the same ID
    /// to
    /// remove, the system removes access to the document. You must specify a value
    /// for this parameter or
    /// the `AccountIdsToAdd` parameter.
    account_ids_to_remove: ?[]const []const u8 = null,

    /// The name of the document that you want to share.
    name: []const u8,

    /// The permission type for the document. The permission type can be
    /// *Share*.
    permission_type: DocumentPermissionType,

    /// (Optional) The version of the document to share. If it isn't specified, the
    /// system choose
    /// the `Default` version to share.
    shared_document_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids_to_add = "AccountIdsToAdd",
        .account_ids_to_remove = "AccountIdsToRemove",
        .name = "Name",
        .permission_type = "PermissionType",
        .shared_document_version = "SharedDocumentVersion",
    };
};

pub const ModifyDocumentPermissionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDocumentPermissionInput, options: CallOptions) !ModifyDocumentPermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDocumentPermissionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.ModifyDocumentPermission");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDocumentPermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
