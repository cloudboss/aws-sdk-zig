const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableRestoreStatus = @import("table_restore_status.zig").TableRestoreStatus;

pub const ListTableRestoreStatusInput = struct {
    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use nextToken to display the next page of results.
    max_results: ?i32 = null,

    /// The namespace from which to list all of the statuses of
    /// `RestoreTableFromSnapshot` operations .
    namespace_name: ?[]const u8 = null,

    /// If your initial `ListTableRestoreStatus` operation returns a nextToken, you
    /// can include the returned `nextToken` in following `ListTableRestoreStatus`
    /// operations. This will return results on the next page.
    next_token: ?[]const u8 = null,

    /// The workgroup from which to list all of the statuses of
    /// `RestoreTableFromSnapshot` operations.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .namespace_name = "namespaceName",
        .next_token = "nextToken",
        .workgroup_name = "workgroupName",
    };
};

pub const ListTableRestoreStatusOutput = struct {
    /// If your initial `ListTableRestoreStatus` operation returns a `nextToken`,
    /// you can include the returned `nextToken` in following
    /// `ListTableRestoreStatus` operations. This will returns results on the next
    /// page.
    next_token: ?[]const u8 = null,

    /// The array of returned `TableRestoreStatus` objects.
    table_restore_statuses: ?[]const TableRestoreStatus = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .table_restore_statuses = "tableRestoreStatuses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTableRestoreStatusInput, options: CallOptions) !ListTableRestoreStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTableRestoreStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.ListTableRestoreStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTableRestoreStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTableRestoreStatusOutput, body, allocator);
}
