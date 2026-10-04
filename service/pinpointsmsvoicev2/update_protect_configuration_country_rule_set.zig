const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtectConfigurationCountryRuleSetInformation = @import("protect_configuration_country_rule_set_information.zig").ProtectConfigurationCountryRuleSetInformation;
const NumberCapability = @import("number_capability.zig").NumberCapability;

pub const UpdateProtectConfigurationCountryRuleSetInput = struct {
    /// A map of ProtectConfigurationCountryRuleSetInformation objects that contain
    /// the details for the requested NumberCapability. The Key is the two-letter
    /// ISO country code. For a list of supported ISO country codes, see [Supported
    /// countries and regions (SMS
    /// channel)](https://docs.aws.amazon.com/sms-voice/latest/userguide/phone-numbers-sms-by-country.html) in the End User Messaging SMS User Guide.
    ///
    /// For example, to set the United States as allowed and Canada as blocked, the
    /// `CountryRuleSetUpdates` would be formatted as: `"CountryRuleSetUpdates": {
    /// "US" : { "ProtectStatus": "ALLOW" } "CA" : { "ProtectStatus": "BLOCK" } }`
    country_rule_set_updates: []const aws.map.MapEntry(ProtectConfigurationCountryRuleSetInformation),

    /// The number capability to apply the CountryRuleSetUpdates updates to.
    number_capability: NumberCapability,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .country_rule_set_updates = "CountryRuleSetUpdates",
        .number_capability = "NumberCapability",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};

pub const UpdateProtectConfigurationCountryRuleSetOutput = struct {
    /// An array of ProtectConfigurationCountryRuleSetInformation containing the
    /// rules for the NumberCapability.
    country_rule_set: ?[]const aws.map.MapEntry(ProtectConfigurationCountryRuleSetInformation) = null,

    /// The number capability that was updated
    number_capability: NumberCapability,

    /// The Amazon Resource Name (ARN) of the protect configuration.
    protect_configuration_arn: []const u8,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .country_rule_set = "CountryRuleSet",
        .number_capability = "NumberCapability",
        .protect_configuration_arn = "ProtectConfigurationArn",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProtectConfigurationCountryRuleSetInput, options: CallOptions) !UpdateProtectConfigurationCountryRuleSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProtectConfigurationCountryRuleSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.UpdateProtectConfigurationCountryRuleSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProtectConfigurationCountryRuleSetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateProtectConfigurationCountryRuleSetOutput, body, allocator);
}
