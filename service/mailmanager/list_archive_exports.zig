const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSummary = @import("export_summary.zig").ExportSummary;

pub const ListArchiveExportsInput = struct {
    /// The identifier of the archive.
    archive_id: []const u8,

    /// If NextToken is returned, there are more results available. The value of
    /// NextToken is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The maximum number of archive export jobs that are returned per call. You
    /// can use NextToken to obtain further pages of archives.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListArchiveExportsOutput = struct {
    /// The list of export job identifiers and statuses.
    exports: ?[]const ExportSummary = null,

    /// If present, use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .exports = "Exports",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListArchiveExportsInput, options: CallOptions) !ListArchiveExportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListArchiveExportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.ListArchiveExports");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListArchiveExportsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListArchiveExportsOutput, body, allocator);
}
