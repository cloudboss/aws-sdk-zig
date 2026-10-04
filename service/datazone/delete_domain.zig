const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const DeleteDomainInput = struct {
    /// Specifies whether to delete the domain along with all of its associated
    /// resources. When you use this parameter, Amazon DataZone deletes the domain
    /// and cleanly removes its associated resources without leaving orphaned
    /// resources behind. Amazon DataZone reports deletion progress in the
    /// `deleteProgress` field. Amazon DataZone reports any resources that it can't
    /// delete in the `failureReasons` field of the `GetDomain` response. You can't
    /// use this parameter together with `skipDeletionCheck`. If you don't specify a
    /// value, the default is `false`.
    cascade_delete: ?bool = null,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services domain that is to be deleted.
    identifier: []const u8,

    /// Specifies whether to skip the check that prevents deletion of a domain that
    /// still contains resources. When you use this parameter, Amazon DataZone
    /// deletes the domain but might not remove its associated resources, which can
    /// leave orphaned resources behind. To delete a domain and fully clean up its
    /// associated resources, use `cascadeDelete` instead. You can't use this
    /// parameter together with `cascadeDelete`.
    skip_deletion_check: ?bool = null,

    pub const json_field_names = .{
        .cascade_delete = "cascadeDelete",
        .client_token = "clientToken",
        .identifier = "identifier",
        .skip_deletion_check = "skipDeletionCheck",
    };
};

pub const DeleteDomainOutput = struct {
    /// The status of the domain.
    status: DomainStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDomainInput, options: CallOptions) !DeleteDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cascade_delete) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "cascadeDelete=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.skip_deletion_check) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "skipDeletionCheck=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDomainOutput {
    const result: DeleteDomainOutput = try aws.json.parseJsonObject(
        DeleteDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
