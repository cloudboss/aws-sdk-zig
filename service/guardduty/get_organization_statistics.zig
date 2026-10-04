const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationDetails = @import("organization_details.zig").OrganizationDetails;

pub const GetOrganizationStatisticsInput = struct {};

pub const GetOrganizationStatisticsOutput = struct {
    /// Information about the statistics report for your organization.
    organization_details: ?OrganizationDetails = null,

    pub const json_field_names = .{
        .organization_details = "OrganizationDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOrganizationStatisticsInput, options: CallOptions) !GetOrganizationStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOrganizationStatisticsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organization/statistics";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOrganizationStatisticsOutput {
    var result: GetOrganizationStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetOrganizationStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
