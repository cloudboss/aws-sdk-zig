const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RemediationConfiguration = @import("remediation_configuration.zig").RemediationConfiguration;
const FailedRemediationBatch = @import("failed_remediation_batch.zig").FailedRemediationBatch;

pub const PutRemediationConfigurationsInput = struct {
    /// A list of remediation configuration objects.
    remediation_configurations: []const RemediationConfiguration,

    pub const json_field_names = .{
        .remediation_configurations = "RemediationConfigurations",
    };
};

pub const PutRemediationConfigurationsOutput = struct {
    /// Returns a list of failed remediation batch objects.
    failed_batches: ?[]const FailedRemediationBatch = null,

    pub const json_field_names = .{
        .failed_batches = "FailedBatches",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRemediationConfigurationsInput, options: CallOptions) !PutRemediationConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRemediationConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutRemediationConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRemediationConfigurationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutRemediationConfigurationsOutput, body, allocator);
}
