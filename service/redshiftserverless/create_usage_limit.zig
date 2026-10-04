const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageLimitBreachAction = @import("usage_limit_breach_action.zig").UsageLimitBreachAction;
const UsageLimitPeriod = @import("usage_limit_period.zig").UsageLimitPeriod;
const UsageLimitUsageType = @import("usage_limit_usage_type.zig").UsageLimitUsageType;
const UsageLimit = @import("usage_limit.zig").UsageLimit;

pub const CreateUsageLimitInput = struct {
    /// The limit amount. If time-based, this amount is in Redshift Processing Units
    /// (RPU) consumed per hour. If data-based, this amount is in terabytes (TB) of
    /// data transferred between Regions in cross-account sharing. The value must be
    /// a positive number.
    amount: i64,

    /// The action that Amazon Redshift Serverless takes when the limit is reached.
    /// The default is log.
    breach_action: ?UsageLimitBreachAction = null,

    /// The time period that the amount applies to. A weekly period begins on
    /// Sunday. The default is monthly.
    period: ?UsageLimitPeriod = null,

    /// The Amazon Resource Name (ARN) of the Amazon Redshift Serverless resource to
    /// create the usage limit for.
    resource_arn: []const u8,

    /// The type of Amazon Redshift Serverless usage to create a usage limit for.
    usage_type: UsageLimitUsageType,

    pub const json_field_names = .{
        .amount = "amount",
        .breach_action = "breachAction",
        .period = "period",
        .resource_arn = "resourceArn",
        .usage_type = "usageType",
    };
};

pub const CreateUsageLimitOutput = struct {
    /// The returned usage limit object.
    usage_limit: ?UsageLimit = null,

    pub const json_field_names = .{
        .usage_limit = "usageLimit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUsageLimitInput, options: CallOptions) !CreateUsageLimitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUsageLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateUsageLimit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUsageLimitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUsageLimitOutput, body, allocator);
}
