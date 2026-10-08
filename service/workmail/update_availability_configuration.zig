const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EwsAvailabilityProvider = @import("ews_availability_provider.zig").EwsAvailabilityProvider;
const LambdaAvailabilityProvider = @import("lambda_availability_provider.zig").LambdaAvailabilityProvider;

pub const UpdateAvailabilityConfigurationInput = struct {
    /// The domain to which the provider applies the availability configuration.
    domain_name: []const u8,

    /// The EWS availability provider definition. The request must contain exactly
    /// one provider
    /// definition, either `EwsProvider` or `LambdaProvider`. The previously
    /// stored provider will be overridden by the one provided.
    ews_provider: ?EwsAvailabilityProvider = null,

    /// The Lambda availability provider definition. The request must contain
    /// exactly one
    /// provider definition, either `EwsProvider` or `LambdaProvider`. The
    /// previously stored provider will be overridden by the one provided.
    lambda_provider: ?LambdaAvailabilityProvider = null,

    /// The WorkMail organization for which the `AvailabilityConfiguration` will be
    /// updated.
    organization_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .ews_provider = "EwsProvider",
        .lambda_provider = "LambdaProvider",
        .organization_id = "OrganizationId",
    };
};

pub const UpdateAvailabilityConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAvailabilityConfigurationInput, options: CallOptions) !UpdateAvailabilityConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAvailabilityConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.UpdateAvailabilityConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAvailabilityConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
