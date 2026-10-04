const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EwsAvailabilityProvider = @import("ews_availability_provider.zig").EwsAvailabilityProvider;
const LambdaAvailabilityProvider = @import("lambda_availability_provider.zig").LambdaAvailabilityProvider;

pub const TestAvailabilityConfigurationInput = struct {
    /// The domain to which the provider applies. If this field is provided, a
    /// stored availability provider associated to this domain name will be tested.
    domain_name: ?[]const u8 = null,

    ews_provider: ?EwsAvailabilityProvider = null,

    lambda_provider: ?LambdaAvailabilityProvider = null,

    /// The WorkMail organization where the availability provider will be tested.
    organization_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .ews_provider = "EwsProvider",
        .lambda_provider = "LambdaProvider",
        .organization_id = "OrganizationId",
    };
};

pub const TestAvailabilityConfigurationOutput = struct {
    /// String containing the reason for a failed test if `TestPassed` is false.
    failure_reason: ?[]const u8 = null,

    /// Boolean indicating whether the test passed or failed.
    test_passed: ?bool = null,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .test_passed = "TestPassed",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestAvailabilityConfigurationInput, options: CallOptions) !TestAvailabilityConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestAvailabilityConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.TestAvailabilityConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestAvailabilityConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestAvailabilityConfigurationOutput, body, allocator);
}
