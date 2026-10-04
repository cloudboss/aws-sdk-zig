const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StatusDetailFilters = @import("status_detail_filters.zig").StatusDetailFilters;
const MemberAccountStatus = @import("member_account_status.zig").MemberAccountStatus;

pub const GetOrganizationConfigRuleDetailedStatusInput = struct {
    /// A `StatusDetailFilters` object.
    filters: ?StatusDetailFilters = null,

    /// The maximum number of `OrganizationConfigRuleDetailedStatus` returned on
    /// each page. If you do not specify a number, Config uses the default. The
    /// default is 100.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The name of your organization Config rule for which you want status details
    /// for member accounts.
    organization_config_rule_name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
        .organization_config_rule_name = "OrganizationConfigRuleName",
    };
};

pub const GetOrganizationConfigRuleDetailedStatusOutput = struct {
    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// A list of `MemberAccountStatus` objects.
    organization_config_rule_detailed_status: ?[]const MemberAccountStatus = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .organization_config_rule_detailed_status = "OrganizationConfigRuleDetailedStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOrganizationConfigRuleDetailedStatusInput, options: CallOptions) !GetOrganizationConfigRuleDetailedStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOrganizationConfigRuleDetailedStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetOrganizationConfigRuleDetailedStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOrganizationConfigRuleDetailedStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOrganizationConfigRuleDetailedStatusOutput, body, allocator);
}
