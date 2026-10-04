const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseAssetRule = @import("license_asset_rule.zig").LicenseAssetRule;
const Tag = @import("tag.zig").Tag;

pub const CreateLicenseAssetRulesetInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: []const u8,

    /// License asset ruleset description.
    description: ?[]const u8 = null,

    /// License asset ruleset name.
    name: []const u8,

    /// License asset rules.
    rules: []const LicenseAssetRule,

    /// Tags to add to the license asset ruleset.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .rules = "Rules",
        .tags = "Tags",
    };
};

pub const CreateLicenseAssetRulesetOutput = struct {
    /// Amazon Resource Name (ARN) of the license asset ruleset.
    license_asset_ruleset_arn: []const u8,

    pub const json_field_names = .{
        .license_asset_ruleset_arn = "LicenseAssetRulesetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseAssetRulesetInput, options: CallOptions) !CreateLicenseAssetRulesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseAssetRulesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateLicenseAssetRuleset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseAssetRulesetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateLicenseAssetRulesetOutput, body, allocator);
}
