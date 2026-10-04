const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResponseAction = @import("response_action.zig").ResponseAction;

pub const EnableApplicationLayerAutomaticResponseInput = struct {
    /// Specifies the action setting that Shield Advanced should use in the WAF
    /// rules that it creates on behalf of the
    /// protected resource in response to DDoS attacks. You specify this as part of
    /// the configuration for the automatic application layer DDoS mitigation
    /// feature,
    /// when you enable or update automatic mitigation. Shield Advanced creates the
    /// WAF rules in a Shield Advanced-managed rule group, inside the web ACL that
    /// you have associated with the resource.
    action: ResponseAction,

    /// The ARN (Amazon Resource Name) of the protected resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .resource_arn = "ResourceArn",
    };
};

pub const EnableApplicationLayerAutomaticResponseOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableApplicationLayerAutomaticResponseInput, options: CallOptions) !EnableApplicationLayerAutomaticResponseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "shield", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableApplicationLayerAutomaticResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.EnableApplicationLayerAutomaticResponse");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableApplicationLayerAutomaticResponseOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
