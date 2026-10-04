const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportCodeCoverageSortByType = @import("report_code_coverage_sort_by_type.zig").ReportCodeCoverageSortByType;
const SortOrderType = @import("sort_order_type.zig").SortOrderType;
const CodeCoverage = @import("code_coverage.zig").CodeCoverage;

pub const DescribeCodeCoveragesInput = struct {
    /// The maximum line coverage percentage to report.
    max_line_coverage_percentage: ?f64 = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The minimum line coverage percentage to report.
    min_line_coverage_percentage: ?f64 = null,

    /// The `nextToken` value returned from a previous call to
    /// `DescribeCodeCoverages`. This specifies the next item to return. To
    /// return the beginning of the list, exclude this parameter.
    next_token: ?[]const u8 = null,

    /// The ARN of the report for which test cases are returned.
    report_arn: []const u8,

    /// Specifies how the results are sorted. Possible values are:
    ///
    /// **FILE_PATH**
    ///
    /// The results are sorted by file path.
    ///
    /// **LINE_COVERAGE_PERCENTAGE**
    ///
    /// The results are sorted by the percentage of lines that are covered.
    sort_by: ?ReportCodeCoverageSortByType = null,

    /// Specifies if the results are sorted in ascending or descending order.
    sort_order: ?SortOrderType = null,

    pub const json_field_names = .{
        .max_line_coverage_percentage = "maxLineCoveragePercentage",
        .max_results = "maxResults",
        .min_line_coverage_percentage = "minLineCoveragePercentage",
        .next_token = "nextToken",
        .report_arn = "reportArn",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const DescribeCodeCoveragesOutput = struct {
    /// An array of `CodeCoverage` objects that contain the results.
    code_coverages: ?[]const CodeCoverage = null,

    /// If there are more items to return, this contains a token that is passed to a
    /// subsequent
    /// call to `DescribeCodeCoverages` to retrieve the next set of items.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_coverages = "codeCoverages",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCodeCoveragesInput, options: CallOptions) !DescribeCodeCoveragesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCodeCoveragesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.DescribeCodeCoverages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCodeCoveragesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCodeCoveragesOutput, body, allocator);
}
