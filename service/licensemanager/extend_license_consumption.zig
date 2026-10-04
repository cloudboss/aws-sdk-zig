const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExtendLicenseConsumptionInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request. Provides an error response if you do not have
    /// the required permissions.
    dry_run: ?bool = null,

    /// License consumption token.
    license_consumption_token: []const u8,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .license_consumption_token = "LicenseConsumptionToken",
    };
};

pub const ExtendLicenseConsumptionOutput = struct {
    /// Date and time at which the license consumption expires.
    expiration: ?[]const u8 = null,

    /// License consumption token.
    license_consumption_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .expiration = "Expiration",
        .license_consumption_token = "LicenseConsumptionToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExtendLicenseConsumptionInput, options: CallOptions) !ExtendLicenseConsumptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExtendLicenseConsumptionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.ExtendLicenseConsumption");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExtendLicenseConsumptionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExtendLicenseConsumptionOutput, body, allocator);
}
