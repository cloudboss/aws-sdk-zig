const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportFilter = @import("export_filter.zig").ExportFilter;
const ExportInfo = @import("export_info.zig").ExportInfo;

pub const DescribeExportTasksInput = struct {
    /// One or more unique identifiers used to query the status of an export
    /// request.
    export_ids: ?[]const []const u8 = null,

    /// One or more filters.
    ///
    /// * `AgentId` - ID of the agent whose collected data will be
    /// exported
    filters: ?[]const ExportFilter = null,

    /// The maximum number of volume results returned by `DescribeExportTasks` in
    /// paginated output. When this parameter is used, `DescribeExportTasks` only
    /// returns
    /// `maxResults` results in a single page along with a `nextToken`
    /// response element.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `DescribeExportTasks` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value. This value is null
    /// when there
    /// are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_ids = "exportIds",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeExportTasksOutput = struct {
    /// Contains one or more sets of export request details. When the status of a
    /// request is
    /// `SUCCEEDED`, the response includes a URL for an Amazon S3 bucket where you
    /// can
    /// view the data in a CSV file.
    exports_info: ?[]const ExportInfo = null,

    /// The `nextToken` value to include in a future
    /// `DescribeExportTasks` request. When the results of a
    /// `DescribeExportTasks` request exceed `maxResults`, this value can be
    /// used to retrieve the next page of results. This value is null when there are
    /// no more results
    /// to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .exports_info = "exportsInfo",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExportTasksInput, options: CallOptions) !DescribeExportTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExportTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.DescribeExportTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExportTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeExportTasksOutput, body, allocator);
}
