const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingFilter = @import("finding_filter.zig").FindingFilter;

pub const ListFindingsInput = struct {
    /// The ARNs of the assessment runs that generate the findings that you want to
    /// list.
    assessment_run_arns: ?[]const []const u8 = null,

    /// You can use this parameter to specify a subset of data to be included in the
    /// action's
    /// response.
    ///
    /// For a record to match a filter, all specified filter attributes must match.
    /// When
    /// multiple values are specified for a filter attribute, any of the values can
    /// match.
    filter: ?FindingFilter = null,

    /// You can use this parameter to indicate the maximum number of items you want
    /// in the
    /// response. The default value is 10. The maximum value is 500.
    max_results: ?i32 = null,

    /// You can use this parameter when paginating results. Set the value of this
    /// parameter
    /// to null on your first call to the **ListFindings** action.
    /// Subsequent calls to the action fill **nextToken** in the
    /// request with the value of **NextToken** from the previous
    /// response to continue listing data.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_run_arns = "assessmentRunArns",
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListFindingsOutput = struct {
    /// A list of ARNs that specifies the findings returned by the action.
    finding_arns: ?[]const []const u8 = null,

    /// When a response is generated, if there is more data to be listed, this
    /// parameter is
    /// present in the response and contains the value to use for the **nextToken**
    /// parameter in a subsequent pagination request. If there is no more
    /// data to be listed, this parameter is set to null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .finding_arns = "findingArns",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingsInput, options: CallOptions) !ListFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.ListFindings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFindingsOutput, body, allocator);
}
