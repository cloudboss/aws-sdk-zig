const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResolverRulePolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the rule that you want to share with
    /// another account.
    arn: []const u8,

    /// An Identity and Access Management policy statement that lists the rules that
    /// you want to share with another Amazon Web Services account and the
    /// operations that you want the account
    /// to be able to perform. You can specify the following operations in the
    /// `Action` section of the statement:
    ///
    /// * `route53resolver:GetResolverRule`
    ///
    /// * `route53resolver:AssociateResolverRule`
    ///
    /// * `route53resolver:DisassociateResolverRule`
    ///
    /// * `route53resolver:ListResolverRules`
    ///
    /// * `route53resolver:ListResolverRuleAssociations`
    ///
    /// In the `Resource` section of the statement, specify the ARN for the rule
    /// that you want to share with another account. Specify the same ARN
    /// that you specified in `Arn`.
    resolver_rule_policy: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .resolver_rule_policy = "ResolverRulePolicy",
    };
};

pub const PutResolverRulePolicyOutput = struct {
    /// Whether the `PutResolverRulePolicy` request was successful.
    return_value: ?bool = null,

    pub const json_field_names = .{
        .return_value = "ReturnValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResolverRulePolicyInput, options: CallOptions) !PutResolverRulePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResolverRulePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.PutResolverRulePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResolverRulePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResolverRulePolicyOutput, body, allocator);
}
