const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentAcl = @import("document_acl.zig").DocumentAcl;
const AssociatedUser = @import("associated_user.zig").AssociatedUser;
const AssociatedGroup = @import("associated_group.zig").AssociatedGroup;

pub const CheckDocumentAccessInput = struct {
    /// The unique identifier of the application. This is required to identify the
    /// specific Amazon Q Business application context for the document access
    /// check.
    application_id: []const u8,

    /// The unique identifier of the data source. Identifies the specific data
    /// source from which the document originates. Should not be used when a
    /// document is uploaded directly with BatchPutDocument, as no dataSourceId is
    /// available or necessary.
    data_source_id: ?[]const u8 = null,

    /// The unique identifier of the document. Specifies which document's access
    /// permissions are being checked.
    document_id: []const u8,

    /// The unique identifier of the index. Used to locate the correct index within
    /// the application where the document is stored.
    index_id: []const u8,

    /// The unique identifier of the user. Used to check the access permissions for
    /// this specific user against the document's ACL.
    user_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .document_id = "documentId",
        .index_id = "indexId",
        .user_id = "userId",
    };
};

pub const CheckDocumentAccessOutput = struct {
    /// The Access Control List (ACL) associated with the document. Includes
    /// allowlist and denylist conditions that determine user access.
    document_acl: ?DocumentAcl = null,

    /// A boolean value indicating whether the specified user has access to the
    /// document, either direct access or transitive access via groups and aliases
    /// attached to the document.
    has_access: ?bool = null,

    /// An array of aliases associated with the user. This includes both global and
    /// local aliases, each with a name and type.
    user_aliases: ?[]const AssociatedUser = null,

    /// An array of groups the user is part of for the specified data source. Each
    /// group has a name and type.
    user_groups: ?[]const AssociatedGroup = null,

    pub const json_field_names = .{
        .document_acl = "documentAcl",
        .has_access = "hasAccess",
        .user_aliases = "userAliases",
        .user_groups = "userGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CheckDocumentAccessInput, options: CallOptions) !CheckDocumentAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CheckDocumentAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/index/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/documents/");
    try path_buf.appendSlice(allocator, input.document_id);
    try path_buf.appendSlice(allocator, "/check-document-access");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.data_source_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dataSourceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CheckDocumentAccessOutput {
    var result: CheckDocumentAccessOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CheckDocumentAccessOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
