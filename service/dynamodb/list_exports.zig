const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSummary = @import("export_summary.zig").ExportSummary;

pub const ListExportsInput = struct {
    /// Maximum number of results to return per page.
    max_results: ?i32 = null,

    /// An optional string that, if supplied, must be copied from the output of a
    /// previous
    /// call to `ListExports`. When provided in this manner, the API fetches the
    /// next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) associated with the exported table.
    table_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .table_arn = "TableArn",
    };
};

pub const ListExportsOutput = struct {
    /// A list of `ExportSummary` objects.
    export_summaries: ?[]const ExportSummary = null,

    /// If this value is returned, there are additional results to be displayed. To
    /// retrieve
    /// them, call `ListExports` again, with `NextToken` set to this
    /// value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_summaries = "ExportSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExportsInput, options: CallOptions) !ListExportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.ListExports");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExportsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListExportsOutput, body, allocator);
}
