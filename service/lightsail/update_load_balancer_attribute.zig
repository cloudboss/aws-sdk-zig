const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoadBalancerAttributeName = @import("load_balancer_attribute_name.zig").LoadBalancerAttributeName;
const Operation = @import("operation.zig").Operation;

pub const UpdateLoadBalancerAttributeInput = struct {
    /// The name of the attribute you want to update.
    attribute_name: LoadBalancerAttributeName,

    /// The value that you want to specify for the attribute name.
    ///
    /// The following values are supported depending on what you specify for the
    /// `attributeName` request parameter:
    ///
    /// * If you specify `HealthCheckPath` for the `attributeName` request
    /// parameter, then the `attributeValue` request parameter must be the path to
    /// ping
    /// on the target (for example, `/weather/us/wa/seattle`).
    ///
    /// * If you specify `SessionStickinessEnabled` for the
    /// `attributeName` request parameter, then the `attributeValue`
    /// request parameter must be `true` to activate session stickiness or
    /// `false` to deactivate session stickiness.
    ///
    /// * If you specify `SessionStickiness_LB_CookieDurationSeconds` for the
    /// `attributeName` request parameter, then the `attributeValue`
    /// request parameter must be an interger that represents the cookie duration in
    /// seconds.
    ///
    /// * If you specify `HttpsRedirectionEnabled` for the `attributeName`
    /// request parameter, then the `attributeValue` request parameter must be
    /// `true` to activate HTTP to HTTPS redirection or `false` to
    /// deactivate HTTP to HTTPS redirection.
    ///
    /// * If you specify `TlsPolicyName` for the `attributeName` request
    /// parameter, then the `attributeValue` request parameter must be the name of
    /// the
    /// TLS policy.
    ///
    /// Use the
    /// [GetLoadBalancerTlsPolicies](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetLoadBalancerTlsPolicies.html) action to get a list of TLS policy names that you
    /// can specify.
    attribute_value: []const u8,

    /// The name of the load balancer that you want to modify
    /// (`my-load-balancer`.
    load_balancer_name: []const u8,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .attribute_value = "attributeValue",
        .load_balancer_name = "loadBalancerName",
    };
};

pub const UpdateLoadBalancerAttributeOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLoadBalancerAttributeInput, options: CallOptions) !UpdateLoadBalancerAttributeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLoadBalancerAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.UpdateLoadBalancerAttribute");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLoadBalancerAttributeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLoadBalancerAttributeOutput, body, allocator);
}
