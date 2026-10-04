const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RemediationExceptionResourceKey = @import("remediation_exception_resource_key.zig").RemediationExceptionResourceKey;
const FailedDeleteRemediationExceptionsBatch = @import("failed_delete_remediation_exceptions_batch.zig").FailedDeleteRemediationExceptionsBatch;

pub const DeleteRemediationExceptionsInput = struct {
    /// The name of the Config rule for which you want to delete remediation
    /// exception configuration.
    config_rule_name: []const u8,

    /// An exception list of resource exception keys to be processed with the
    /// current request. Config adds exception for each resource key. For example,
    /// Config adds 3 exceptions for 3 resource keys.
    resource_keys: []const RemediationExceptionResourceKey,

    pub const json_field_names = .{
        .config_rule_name = "ConfigRuleName",
        .resource_keys = "ResourceKeys",
    };
};

pub const DeleteRemediationExceptionsOutput = struct {
    /// Returns a list of failed delete remediation exceptions batch objects. Each
    /// object in the batch consists of a list of failed items and failure messages.
    failed_batches: ?[]const FailedDeleteRemediationExceptionsBatch = null,

    pub const json_field_names = .{
        .failed_batches = "FailedBatches",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRemediationExceptionsInput, options: CallOptions) !DeleteRemediationExceptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRemediationExceptionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DeleteRemediationExceptions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRemediationExceptionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteRemediationExceptionsOutput, body, allocator);
}
