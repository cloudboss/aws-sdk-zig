const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceQuota = @import("service_quota.zig").ServiceQuota;

pub const GetServiceQuotaInput = struct {
    /// Specifies the resource with an Amazon Resource Name (ARN).
    context_id: ?[]const u8 = null,

    /// Specifies the quota identifier. To find the quota code for a specific
    /// quota, use the ListServiceQuotas operation, and look for the
    /// `QuotaCode` response in the output for the quota you want.
    quota_code: []const u8,

    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: []const u8,

    pub const json_field_names = .{
        .context_id = "ContextId",
        .quota_code = "QuotaCode",
        .service_code = "ServiceCode",
    };
};

pub const GetServiceQuotaOutput = struct {
    /// Information about the quota.
    quota: ?ServiceQuota = null,

    pub const json_field_names = .{
        .quota = "Quota",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceQuotaInput, options: CallOptions) !GetServiceQuotaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicequotas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceQuotaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.GetServiceQuota");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceQuotaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetServiceQuotaOutput, body, allocator);
}
