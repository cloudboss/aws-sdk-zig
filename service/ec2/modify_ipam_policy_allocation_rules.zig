const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpamPolicyAllocationRuleRequest = @import("ipam_policy_allocation_rule_request.zig").IpamPolicyAllocationRuleRequest;
const IpamPolicyResourceType = @import("ipam_policy_resource_type.zig").IpamPolicyResourceType;
const IpamPolicyDocument = @import("ipam_policy_document.zig").IpamPolicyDocument;
const serde = @import("serde.zig");

pub const ModifyIpamPolicyAllocationRulesInput = struct {
    /// The new allocation rules to apply to the IPAM policy.
    ///
    /// Allocation rules are optional configurations within an IPAM policy that map
    /// Amazon Web Services resource types to specific IPAM pools. If no rules are
    /// defined, the resource types default to using Amazon-provided IP addresses.
    allocation_rules: ?[]const IpamPolicyAllocationRuleRequest = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM policy whose allocation rules you want to modify.
    ipam_policy_id: []const u8,

    /// The locale for which to modify the allocation rules.
    locale: []const u8,

    /// The resource type for which to modify the allocation rules.
    ///
    /// The Amazon Web Services service or resource type that can use IP addresses
    /// through IPAM policies. Supported services and resource types include:
    ///
    /// * Elastic IP addresses
    resource_type: IpamPolicyResourceType,
};

pub const ModifyIpamPolicyAllocationRulesOutput = struct {
    /// The modified IPAM policy containing the updated allocation rules.
    ipam_policy_document: ?IpamPolicyDocument = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpamPolicyAllocationRulesInput, options: CallOptions) !ModifyIpamPolicyAllocationRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpamPolicyAllocationRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyIpamPolicyAllocationRules&Version=2016-11-15");
    if (input.allocation_rules) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.source_ipam_pool_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllocationRule.{d}.SourceIpamPoolId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamPolicyId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_policy_id);
    try body_buf.appendSlice(allocator, "&Locale=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.locale);
    try body_buf.appendSlice(allocator, "&ResourceType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_type.wireName());

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpamPolicyAllocationRulesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamPolicyAllocationRulesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPolicyDocument")) {
                    result.ipam_policy_document = try serde.deserializeIpamPolicyDocument(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
