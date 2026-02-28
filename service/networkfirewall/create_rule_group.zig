const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const RuleGroup = @import("rule_group.zig").RuleGroup;
const SourceMetadata = @import("source_metadata.zig").SourceMetadata;
const SummaryConfiguration = @import("summary_configuration.zig").SummaryConfiguration;
const Tag = @import("tag.zig").Tag;
const RuleGroupType = @import("rule_group_type.zig").RuleGroupType;
const RuleGroupResponse = @import("rule_group_response.zig").RuleGroupResponse;

pub const CreateRuleGroupInput = struct {
    /// Indicates whether you want Network Firewall to analyze the stateless rules
    /// in the rule group for rule behavior such as asymmetric routing. If set to
    /// `TRUE`, Network Firewall runs the analysis and then creates the rule group
    /// for you. To run the stateless rule group analyzer without creating the rule
    /// group, set `DryRun` to `TRUE`.
    analyze_rule_group: bool = false,

    /// The maximum operating resources that this rule group can use. Rule group
    /// capacity is fixed at creation.
    /// When you update a rule group, you are limited to this capacity. When you
    /// reference a rule group
    /// from a firewall policy, Network Firewall reserves this capacity for the rule
    /// group.
    ///
    /// You can retrieve the capacity that would be required for a rule group before
    /// you create the rule group by calling
    /// CreateRuleGroup with `DryRun` set to `TRUE`.
    ///
    /// You can't change or exceed this capacity when you update the rule group, so
    /// leave
    /// room for your rule group to grow.
    ///
    /// **Capacity for a stateless rule group**
    ///
    /// For a stateless rule group, the capacity required is the sum of the capacity
    /// requirements of the individual rules that you expect to have in the rule
    /// group.
    ///
    /// To calculate the capacity requirement of a single rule, multiply the
    /// capacity
    /// requirement values of each of the rule's match settings:
    ///
    /// * A match setting with no criteria specified has a value of 1.
    ///
    /// * A match setting with `Any` specified has a value of 1.
    ///
    /// * All other match settings have a value equal to the number of elements
    ///   provided in
    /// the setting. For example, a protocol setting ["UDP"] and a source setting
    /// ["10.0.0.0/24"] each have a value of 1. A protocol setting ["UDP","TCP"] has
    /// a value
    /// of 2. A source setting ["10.0.0.0/24","10.0.0.1/24","10.0.0.2/24"] has a
    /// value of 3.
    ///
    /// A rule with no criteria specified in any of its match settings has a
    /// capacity
    /// requirement of 1. A rule with protocol setting ["UDP","TCP"], source setting
    /// ["10.0.0.0/24","10.0.0.1/24","10.0.0.2/24"], and a single specification or
    /// no specification
    /// for each of the other match settings has a capacity requirement of 6.
    ///
    /// **Capacity for a stateful rule group**
    ///
    /// For a stateful rule group, the minimum capacity required is the number of
    /// individual rules that
    /// you expect to have in the rule group.
    capacity: i32,

    /// A description of the rule group.
    description: ?[]const u8 = null,

    /// Indicates whether you want Network Firewall to just check the validity of
    /// the request, rather than run the request.
    ///
    /// If set to `TRUE`, Network Firewall checks whether the request can run
    /// successfully,
    /// but doesn't actually make the requested changes. The call returns the value
    /// that the request would return if you ran it with
    /// dry run set to `FALSE`, but doesn't make additions or changes to your
    /// resources. This option allows you to make sure that you have
    /// the required permissions to run the request and that your request parameters
    /// are valid.
    ///
    /// If set to `FALSE`, Network Firewall makes the requested changes to your
    /// resources.
    dry_run: bool = false,

    /// A complex type that contains settings for encryption of your rule group
    /// resources.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// An object that defines the rule group rules.
    ///
    /// You must provide either this rule group setting or a `Rules` setting, but
    /// not both.
    rule_group: ?RuleGroup = null,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    rule_group_name: []const u8,

    /// A string containing stateful rule group rules specifications in Suricata
    /// flat format, with one rule
    /// per line. Use this to import your existing Suricata compatible rule groups.
    ///
    /// You must provide either this rules setting or a populated `RuleGroup`
    /// setting, but not both.
    ///
    /// You can provide your rule group specification in Suricata flat format
    /// through this setting when you create or update your rule group. The call
    /// response returns a RuleGroup object that Network Firewall has populated from
    /// your string.
    rules: ?[]const u8 = null,

    /// A complex type that contains metadata about the rule group that your own
    /// rule group is copied from. You can use the metadata to keep track of updates
    /// made to the originating rule group.
    source_metadata: ?SourceMetadata = null,

    /// An object that contains a `RuleOptions` array of strings.
    /// You use `RuleOptions` to determine which of the following RuleSummary values
    /// are returned in response to `DescribeRuleGroupSummary`.
    ///
    /// * `Metadata` - returns
    ///
    /// * `Msg`
    ///
    /// * `SID`
    summary_configuration: ?SummaryConfiguration = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// Indicates whether the rule group is stateless or stateful. If the rule group
    /// is stateless, it contains
    /// stateless rules. If it is stateful, it contains stateful rules.
    @"type": RuleGroupType,

    pub const json_field_names = .{
        .analyze_rule_group = "AnalyzeRuleGroup",
        .capacity = "Capacity",
        .description = "Description",
        .dry_run = "DryRun",
        .encryption_configuration = "EncryptionConfiguration",
        .rule_group = "RuleGroup",
        .rule_group_name = "RuleGroupName",
        .rules = "Rules",
        .source_metadata = "SourceMetadata",
        .summary_configuration = "SummaryConfiguration",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const CreateRuleGroupOutput = struct {
    /// The high-level properties of a rule group. This, along with the RuleGroup,
    /// define the rule group. You can retrieve all objects for a rule group by
    /// calling DescribeRuleGroup.
    rule_group_response: ?RuleGroupResponse = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the rule group. The token marks the state of the
    /// rule group resource at the time of the request.
    ///
    /// To make changes to the rule group, you provide the token in your request.
    /// Network Firewall uses the token to ensure that the rule group hasn't changed
    /// since you last retrieved it. If it has changed, the operation fails with an
    /// `InvalidTokenException`. If this happens, retrieve the rule group again to
    /// get a current copy of it with a current token. Reapply your changes as
    /// needed, then try the operation again using the new token.
    update_token: []const u8,

    pub const json_field_names = .{
        .rule_group_response = "RuleGroupResponse",
        .update_token = "UpdateToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleGroupInput, options: Options) !CreateRuleGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkfirewall");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRuleGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkfirewall", "Network Firewall", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "NetworkFirewall_20201112.CreateRuleGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRuleGroupOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidResourcePolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "LogDestinationPermissionException")) {
        return .{ .arena = arena, .kind = .{ .log_destination_permission_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceOwnerCheckException")) {
        return .{ .arena = arena, .kind = .{ .resource_owner_check_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
