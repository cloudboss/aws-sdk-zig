const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationResourceDetailedStatusFilters = @import("organization_resource_detailed_status_filters.zig").OrganizationResourceDetailedStatusFilters;
const OrganizationConformancePackDetailedStatus = @import("organization_conformance_pack_detailed_status.zig").OrganizationConformancePackDetailedStatus;

pub const GetOrganizationConformancePackDetailedStatusInput = struct {
    /// An `OrganizationResourceDetailedStatusFilters` object.
    filters: ?OrganizationResourceDetailedStatusFilters = null,

    /// The maximum number of `OrganizationConformancePackDetailedStatuses` returned
    /// on each page.
    /// If you do not specify a number, Config uses the default. The default is 100.
    limit: ?i32 = null,

    /// The nextToken string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The name of organization conformance pack for which you want status details
    /// for member accounts.
    organization_conformance_pack_name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
        .organization_conformance_pack_name = "OrganizationConformancePackName",
    };
};

pub const GetOrganizationConformancePackDetailedStatusOutput = struct {
    /// The nextToken string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// A list of `OrganizationConformancePackDetailedStatus` objects.
    organization_conformance_pack_detailed_statuses: ?[]const OrganizationConformancePackDetailedStatus = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .organization_conformance_pack_detailed_statuses = "OrganizationConformancePackDetailedStatuses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOrganizationConformancePackDetailedStatusInput, options: CallOptions) !GetOrganizationConformancePackDetailedStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOrganizationConformancePackDetailedStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetOrganizationConformancePackDetailedStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOrganizationConformancePackDetailedStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOrganizationConformancePackDetailedStatusOutput, body, allocator);
}
