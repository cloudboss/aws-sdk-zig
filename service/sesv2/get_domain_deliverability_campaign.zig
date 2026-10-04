const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainDeliverabilityCampaign = @import("domain_deliverability_campaign.zig").DomainDeliverabilityCampaign;

pub const GetDomainDeliverabilityCampaignInput = struct {
    /// The unique identifier for the campaign. The Deliverability dashboard
    /// automatically generates
    /// and assigns this identifier to a campaign.
    campaign_id: []const u8,

    pub const json_field_names = .{
        .campaign_id = "CampaignId",
    };
};

pub const GetDomainDeliverabilityCampaignOutput = struct {
    /// An object that contains the deliverability data for the campaign.
    domain_deliverability_campaign: ?DomainDeliverabilityCampaign = null,

    pub const json_field_names = .{
        .domain_deliverability_campaign = "DomainDeliverabilityCampaign",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainDeliverabilityCampaignInput, options: CallOptions) !GetDomainDeliverabilityCampaignOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainDeliverabilityCampaignInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/deliverability-dashboard/campaigns/");
    try path_buf.appendSlice(allocator, input.campaign_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainDeliverabilityCampaignOutput {
    var result: GetDomainDeliverabilityCampaignOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDomainDeliverabilityCampaignOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
