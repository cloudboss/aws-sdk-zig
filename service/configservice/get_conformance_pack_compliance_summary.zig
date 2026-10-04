const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConformancePackComplianceSummary = @import("conformance_pack_compliance_summary.zig").ConformancePackComplianceSummary;

pub const GetConformancePackComplianceSummaryInput = struct {
    /// Names of conformance packs.
    conformance_pack_names: []const []const u8,

    /// The maximum number of conformance packs returned on each page.
    limit: ?i32 = null,

    /// The nextToken string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_names = "ConformancePackNames",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const GetConformancePackComplianceSummaryOutput = struct {
    /// A list of `ConformancePackComplianceSummary` objects.
    conformance_pack_compliance_summary_list: ?[]const ConformancePackComplianceSummary = null,

    /// The nextToken string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .conformance_pack_compliance_summary_list = "ConformancePackComplianceSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConformancePackComplianceSummaryInput, options: CallOptions) !GetConformancePackComplianceSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConformancePackComplianceSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetConformancePackComplianceSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConformancePackComplianceSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetConformancePackComplianceSummaryOutput, body, allocator);
}
