const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResolverRuleInput, options: Options) !CreateResolverRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53resolver");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateResolverRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "Route53Resolver.CreateResolverRule");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateResolverRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResolverRuleOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyDocument")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_document = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceException")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
