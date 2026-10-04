const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransitGatewayRequestPolicyRule = @import("transit_gateway_request_policy_rule.zig").TransitGatewayRequestPolicyRule;
const TransitGatewayPolicyTableEntry = @import("transit_gateway_policy_table_entry.zig").TransitGatewayPolicyTableEntry;
const serde = @import("serde.zig");

pub const ModifyTransitGatewayPolicyTableEntryInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The updated matching criteria for the policy table entry. Unspecified fields
    /// retain their current values.
    policy_rule: ?TransitGatewayRequestPolicyRule = null,

    /// The rule number of the policy table entry to modify.
    policy_rule_number: []const u8,

    /// The ID of the transit gateway route table to use for traffic matching this
    /// rule.
    target_route_table_id: ?[]const u8 = null,

    /// The ID of the transit gateway policy table.
    transit_gateway_policy_table_id: []const u8,
};

pub const ModifyTransitGatewayPolicyTableEntryOutput = struct {
    /// Describes a transit gateway policy table entry
    transit_gateway_policy_table_entry: ?TransitGatewayPolicyTableEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyTransitGatewayPolicyTableEntryInput, options: CallOptions) !ModifyTransitGatewayPolicyTableEntryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyTransitGatewayPolicyTableEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyTransitGatewayPolicyTableEntry&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.policy_rule) |v| {
        if (v.destination_cidr_block) |sv| {
            try body_buf.appendSlice(allocator, "&PolicyRule.DestinationCidrBlock=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.destination_port_range) |sv| {
            try body_buf.appendSlice(allocator, "&PolicyRule.DestinationPortRange=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.meta_data) |sv| {
            if (sv.meta_data_key) |sv2| {
                try body_buf.appendSlice(allocator, "&PolicyRule.MetaData.MetaDataKey=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.meta_data_value) |sv2| {
                try body_buf.appendSlice(allocator, "&PolicyRule.MetaData.MetaDataValue=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(allocator, "&PolicyRule.Protocol=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.source_cidr_block) |sv| {
            try body_buf.appendSlice(allocator, "&PolicyRule.SourceCidrBlock=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.source_port_range) |sv| {
            try body_buf.appendSlice(allocator, "&PolicyRule.SourcePortRange=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(allocator, "&PolicyRuleNumber=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_rule_number);
    if (input.target_route_table_id) |v| {
        try body_buf.appendSlice(allocator, "&TargetRouteTableId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TransitGatewayPolicyTableId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.transit_gateway_policy_table_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyTransitGatewayPolicyTableEntryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyTransitGatewayPolicyTableEntryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "transitGatewayPolicyTableEntry")) {
                    result.transit_gateway_policy_table_entry = try serde.deserializeTransitGatewayPolicyTableEntry(allocator, &reader);
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
