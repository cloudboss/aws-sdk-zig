const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationRecommendation = @import("organization_recommendation.zig").OrganizationRecommendation;

pub const GetOrganizationRecommendationInput = struct {
    /// The Recommendation identifier
    organization_recommendation_identifier: []const u8,

    pub const json_field_names = .{
        .organization_recommendation_identifier = "organizationRecommendationIdentifier",
    };
};

pub const GetOrganizationRecommendationOutput = struct {
    /// The Recommendation
    organization_recommendation: ?OrganizationRecommendation = null,

    pub const json_field_names = .{
        .organization_recommendation = "organizationRecommendation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOrganizationRecommendationInput, options: CallOptions) !GetOrganizationRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "trustedadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOrganizationRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("trustedadvisor", "TrustedAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/organization-recommendations/");
    try path_buf.appendSlice(allocator, input.organization_recommendation_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOrganizationRecommendationOutput {
    const result: GetOrganizationRecommendationOutput = try aws.json.parseJsonObject(
        GetOrganizationRecommendationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
