const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Campaign = @import("campaign.zig").Campaign;

pub const DescribeCampaignInput = struct {
    /// The Amazon Resource Name (ARN) of the campaign.
    campaign_arn: []const u8,

    pub const json_field_names = .{
        .campaign_arn = "campaignArn",
    };
};

pub const DescribeCampaignOutput = struct {
    /// The `latestCampaignUpdate` field is only returned when the campaign has had
    /// at least one `UpdateCampaign` call.
    ///
    /// The properties of the campaign.
    ///
    /// The `latestCampaignUpdate` field is only returned when the campaign has had
    /// at least one `UpdateCampaign` call.
    campaign: ?Campaign = null,

    pub const json_field_names = .{
        .campaign = "campaign",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCampaignInput, options: CallOptions) !DescribeCampaignOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCampaignInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.DescribeCampaign");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCampaignOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCampaignOutput, body, allocator);
}
