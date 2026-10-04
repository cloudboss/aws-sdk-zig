const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleTypeOption = @import("rule_type_option.zig").RuleTypeOption;
const Tag = @import("tag.zig").Tag;
const TargetAddress = @import("target_address.zig").TargetAddress;
const ResolverRule = @import("resolver_rule.zig").ResolverRule;

pub const CreateResolverRuleInput = struct {
    /// A unique string that identifies the request and that allows failed requests
    /// to be retried
    /// without the risk of running the operation twice. `CreatorRequestId` can be
    /// any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// DNS queries with the delegation records that match this domain name are
    /// forwarded to the resolvers on your
    /// network.
    delegation_record: ?[]const u8 = null,

    /// DNS queries for this domain name are forwarded to the IP addresses that you
    /// specify in `TargetIps`. If a query matches
    /// multiple Resolver rules (example.com and www.example.com), outbound DNS
    /// queries are routed using the Resolver rule that contains
    /// the most specific domain name (www.example.com).
    domain_name: ?[]const u8 = null,

    /// A friendly name that lets you easily find a rule in the Resolver dashboard
    /// in the Route 53 console.
    ///
    /// The name can be up to 64 characters long and can contain letters (a-z, A-Z),
    /// numbers (0-9), hyphens (-), underscores (_), and spaces. The name cannot
    /// consist of only numbers.
    name: ?[]const u8 = null,

    /// The ID of the outbound Resolver endpoint that you want to use to route DNS
    /// queries to the IP addresses that you specify
    /// in `TargetIps`.
    resolver_endpoint_id: ?[]const u8 = null,

    /// When you want to forward DNS queries for specified domain name to resolvers
    /// on your network, specify `FORWARD` or `DELEGATE`.
    ///
    /// When you have a forwarding rule to forward DNS queries for a domain to your
    /// network and you want Resolver to process queries for
    /// a subdomain of that domain, specify `SYSTEM`.
    ///
    /// For example, to forward DNS queries for example.com to resolvers on your
    /// network, you create a rule and specify `FORWARD`
    /// for `RuleType`. To then have Resolver process queries for apex.example.com,
    /// you create a rule and specify
    /// `SYSTEM` for `RuleType`.
    ///
    /// Currently, only Resolver can create rules that have a value of `RECURSIVE`
    /// for `RuleType`.
    rule_type: RuleTypeOption,

    /// A list of the tag keys and values that you want to associate with the
    /// endpoint.
    tags: ?[]const Tag = null,

    /// The IPs that you want Resolver to forward DNS queries to. You can specify
    /// either Ipv4 or Ipv6 addresses but not both in the same rule. Separate IP
    /// addresses with a space.
    ///
    /// `TargetIps` is available only when the value of `Rule type` is `FORWARD`.
    /// You should not provide TargetIps when the Rule type is `DELEGATE`.
    ///
    /// when creating a DELEGATE rule, you must not provide the `TargetIps`
    /// parameter. If you provide the `TargetIps`,
    /// you may receive an ERROR message similar to "Delegate resolver rules need to
    /// specify a nameserver name".
    /// This error means you should not provide `TargetIps`.
    target_ips: ?[]const TargetAddress = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .delegation_record = "DelegationRecord",
        .domain_name = "DomainName",
        .name = "Name",
        .resolver_endpoint_id = "ResolverEndpointId",
        .rule_type = "RuleType",
        .tags = "Tags",
        .target_ips = "TargetIps",
    };
};

pub const CreateResolverRuleOutput = struct {
    /// Information about the `CreateResolverRule` request, including the status of
    /// the request.
    resolver_rule: ?ResolverRule = null,

    pub const json_field_names = .{
        .resolver_rule = "ResolverRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResolverRuleInput, options: CallOptions) !CreateResolverRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResolverRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.CreateResolverRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResolverRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResolverRuleOutput, body, allocator);
}
