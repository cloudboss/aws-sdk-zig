const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityRulesetFilterCriteria = @import("data_quality_ruleset_filter_criteria.zig").DataQualityRulesetFilterCriteria;
const DataQualityRulesetListDetails = @import("data_quality_ruleset_list_details.zig").DataQualityRulesetListDetails;

pub const ListDataQualityRulesetsInput = struct {
    /// The filter criteria.
    filter: ?DataQualityRulesetFilterCriteria = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A paginated token to offset the results.
    next_token: ?[]const u8 = null,

    /// A list of key-value pair tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .tags = "Tags",
    };
};

pub const ListDataQualityRulesetsOutput = struct {
    /// A pagination token, if more results are available.
    next_token: ?[]const u8 = null,

    /// A paginated list of rulesets for the specified list of Glue tables.
    rulesets: ?[]const DataQualityRulesetListDetails = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rulesets = "Rulesets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataQualityRulesetsInput, options: CallOptions) !ListDataQualityRulesetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataQualityRulesetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListDataQualityRulesets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataQualityRulesetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDataQualityRulesetsOutput, body, allocator);
}
