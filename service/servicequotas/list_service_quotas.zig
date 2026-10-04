const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppliedLevelEnum = @import("applied_level_enum.zig").AppliedLevelEnum;
const ServiceQuota = @import("service_quota.zig").ServiceQuota;

pub const ListServiceQuotasInput = struct {
    /// Specifies the maximum number of results that you want included on each
    /// page of the response. If you do not include this parameter, it defaults to a
    /// value appropriate
    /// to the operation. If additional items exist beyond those included in the
    /// current response, the
    /// `NextToken` response element is present and has a value (is not null).
    /// Include that
    /// value as the `NextToken` request parameter in the next call to the operation
    /// to get
    /// the next part of the results.
    ///
    /// An API operation can return fewer results than the maximum even when there
    /// are
    /// more results available. You should check `NextToken` after every operation
    /// to ensure
    /// that you receive all of the results.
    max_results: ?i32 = null,

    /// Specifies a value for receiving additional results after you
    /// receive a `NextToken` response in a previous request. A `NextToken`
    /// response indicates that more output is available. Set this parameter to the
    /// value of the previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    /// Filters the response to return applied quota values for the `ACCOUNT`,
    /// `RESOURCE`, or `ALL` levels. `ACCOUNT` is the default.
    quota_applied_at_level: ?AppliedLevelEnum = null,

    /// Specifies the quota identifier. To find the quota code for a specific
    /// quota, use the ListServiceQuotas operation, and look for the
    /// `QuotaCode` response in the output for the quota you want.
    quota_code: ?[]const u8 = null,

    /// Specifies the service identifier. To find the service code value
    /// for an Amazon Web Services service, use the ListServices operation.
    service_code: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .quota_applied_at_level = "QuotaAppliedAtLevel",
        .quota_code = "QuotaCode",
        .service_code = "ServiceCode",
    };
};

pub const ListServiceQuotasOutput = struct {
    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    /// Information about the quotas.
    quotas: ?[]const ServiceQuota = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .quotas = "Quotas",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceQuotasInput, options: CallOptions) !ListServiceQuotasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceQuotasInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.ListServiceQuotas");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceQuotasOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServiceQuotasOutput, body, allocator);
}
