const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const NotifyConfigurationTier = @import("notify_configuration_tier.zig").NotifyConfigurationTier;
const NotifyConfigurationUseCase = @import("notify_configuration_use_case.zig").NotifyConfigurationUseCase;
const NotifyCountryInformation = @import("notify_country_information.zig").NotifyCountryInformation;

pub const ListNotifyCountriesInput = struct {
    /// An array of channels to filter the results by.
    channels: ?[]const NumberCapability = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// The tier to filter the results by.
    tier: ?NotifyConfigurationTier = null,

    /// An array of use cases to filter the results by.
    use_cases: ?[]const NotifyConfigurationUseCase = null,

    pub const json_field_names = .{
        .channels = "Channels",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .tier = "Tier",
        .use_cases = "UseCases",
    };
};

pub const ListNotifyCountriesOutput = struct {
    /// The token to be used for the next set of paginated results. If this field is
    /// empty then there are no more results.
    next_token: ?[]const u8 = null,

    /// An array of NotifyCountryInformation objects that contain the results.
    notify_countries: ?[]const NotifyCountryInformation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .notify_countries = "NotifyCountries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotifyCountriesInput, options: CallOptions) !ListNotifyCountriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotifyCountriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.ListNotifyCountries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotifyCountriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListNotifyCountriesOutput, body, allocator);
}
