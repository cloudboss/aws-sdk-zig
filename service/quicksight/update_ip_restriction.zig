const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateIpRestrictionInput = struct {
    /// The ID of the Amazon Web Services account that contains the IP rules.
    aws_account_id: []const u8,

    /// A value that specifies whether IP rules are turned on.
    enabled: ?bool = null,

    /// A map that describes the updated IP rules with CIDR ranges and descriptions.
    ip_restriction_rule_map: ?[]const aws.map.StringMapEntry = null,

    /// A map of allowed VPC endpoint IDs and their corresponding rule descriptions.
    vpc_endpoint_id_restriction_rule_map: ?[]const aws.map.StringMapEntry = null,

    /// A map of VPC IDs and their corresponding rules. When you configure this
    /// parameter, traffic from all VPC endpoints that are present in the specified
    /// VPC is allowed.
    vpc_id_restriction_rule_map: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .enabled = "Enabled",
        .ip_restriction_rule_map = "IpRestrictionRuleMap",
        .vpc_endpoint_id_restriction_rule_map = "VpcEndpointIdRestrictionRuleMap",
        .vpc_id_restriction_rule_map = "VpcIdRestrictionRuleMap",
    };
};

pub const UpdateIpRestrictionOutput = struct {
    /// The ID of the Amazon Web Services account that contains the IP rules.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIpRestrictionInput, options: CallOptions) !UpdateIpRestrictionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIpRestrictionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/ip-restriction");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Enabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip_restriction_rule_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IpRestrictionRuleMap\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_endpoint_id_restriction_rule_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcEndpointIdRestrictionRuleMap\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_id_restriction_rule_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcIdRestrictionRuleMap\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIpRestrictionOutput {
    var result: UpdateIpRestrictionOutput = try aws.json.parseJsonObject(
        UpdateIpRestrictionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
