const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportDefinition = @import("report_definition.zig").ReportDefinition;

pub const DescribeReportDefinitionsInput = struct {
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeReportDefinitionsOutput = struct {
    next_token: ?[]const u8 = null,

    /// An Amazon Web Services Cost and Usage Report list owned by the account.
    report_definitions: ?[]const ReportDefinition = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .report_definitions = "ReportDefinitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReportDefinitionsInput, options: CallOptions) !DescribeReportDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cur", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReportDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cur", "Cost and Usage Report Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrigamiServiceGatewayService.DescribeReportDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReportDefinitionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReportDefinitionsOutput, body, allocator);
}
