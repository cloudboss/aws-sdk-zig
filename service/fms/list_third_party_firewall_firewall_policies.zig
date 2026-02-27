const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ThirdPartyFirewall = @import("third_party_firewall.zig").ThirdPartyFirewall;
const ThirdPartyFirewallFirewallPolicy = @import("third_party_firewall_firewall_policy.zig").ThirdPartyFirewallFirewallPolicy;

pub const ListThirdPartyFirewallFirewallPoliciesInput = struct {
    /// The maximum number of third-party firewall policies that you want Firewall
    /// Manager to return. If
    /// the specified third-party firewall vendor is associated with more than
    /// `MaxResults` firewall policies, the response includes a
    /// `NextToken` element. `NextToken` contains an encrypted token that identifies
    /// the first third-party firewall policies
    /// that Firewall Manager will return if you submit another request.
    max_results: i32,

    /// If the previous response included a `NextToken` element, the specified
    /// third-party firewall vendor is associated with more
    /// third-party firewall policies. To get more third-party firewall policies,
    /// submit another `ListThirdPartyFirewallFirewallPoliciesRequest` request.
    ///
    /// For the value of `NextToken`, specify the value of `NextToken` from the
    /// previous response.
    /// If the previous response didn't include a `NextToken` element, there are no
    /// more third-party firewall policies to
    /// get.
    next_token: ?[]const u8 = null,

    /// The name of the third-party firewall vendor.
    third_party_firewall: ThirdPartyFirewall,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .third_party_firewall = "ThirdPartyFirewall",
    };
};

pub const ListThirdPartyFirewallFirewallPoliciesOutput = struct {
    /// The value that you will use for `NextToken` in the next
    /// `ListThirdPartyFirewallFirewallPolicies` request.
    next_token: ?[]const u8 = null,

    /// A list that contains one `ThirdPartyFirewallFirewallPolicies` element for
    /// each third-party firewall policies that the specified
    /// third-party firewall vendor is associated with. Each
    /// `ThirdPartyFirewallFirewallPolicies` element contains the firewall policy
    /// name and ID.
    third_party_firewall_firewall_policies: ?[]const ThirdPartyFirewallFirewallPolicy = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .third_party_firewall_firewall_policies = "ThirdPartyFirewallFirewallPolicies",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListThirdPartyFirewallFirewallPoliciesInput, options: Options) !ListThirdPartyFirewallFirewallPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fms");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListThirdPartyFirewallFirewallPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSFMS_20180101.ListThirdPartyFirewallFirewallPolicies");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListThirdPartyFirewallFirewallPoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListThirdPartyFirewallFirewallPoliciesOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
