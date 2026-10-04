const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LongTermPricingType = @import("long_term_pricing_type.zig").LongTermPricingType;
const SnowballType = @import("snowball_type.zig").SnowballType;

pub const CreateLongTermPricingInput = struct {
    /// Specifies whether the current long-term pricing type for the device should
    /// be
    /// renewed.
    is_long_term_pricing_auto_renew: ?bool = null,

    /// The type of long-term pricing option you want for the device, either 1-year
    /// or 3-year
    /// long-term pricing.
    long_term_pricing_type: LongTermPricingType,

    /// The type of Snow Family devices to use for the long-term pricing job.
    snowball_type: SnowballType,

    pub const json_field_names = .{
        .is_long_term_pricing_auto_renew = "IsLongTermPricingAutoRenew",
        .long_term_pricing_type = "LongTermPricingType",
        .snowball_type = "SnowballType",
    };
};

pub const CreateLongTermPricingOutput = struct {
    /// The ID of the long-term pricing type for the device.
    long_term_pricing_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .long_term_pricing_id = "LongTermPricingId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLongTermPricingInput, options: CallOptions) !CreateLongTermPricingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snowball", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLongTermPricingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.CreateLongTermPricing");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLongTermPricingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLongTermPricingOutput, body, allocator);
}
