const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationMode = @import("association_mode.zig").AssociationMode;
const AssociationDetail = @import("association_detail.zig").AssociationDetail;

pub const CreateCustomDetectionRuleAssociationInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. Maximum 64 characters.
    client_token: ?[]const u8 = null,

    /// The rule execution mode. Valid values: `LIVE` | `DRY_RUN`.
    mode: AssociationMode,

    /// The unique identifier for the custom detection rule.
    rule_id: []const u8,

    /// The tags to be added to the new custom detection rule association resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .mode = "Mode",
        .rule_id = "RuleId",
        .tags = "Tags",
    };
};

pub const CreateCustomDetectionRuleAssociationOutput = struct {
    /// The details of the newly created custom detection rule association.
    rule_association: ?AssociationDetail = null,

    pub const json_field_names = .{
        .rule_association = "RuleAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomDetectionRuleAssociationInput, options: CallOptions) !CreateCustomDetectionRuleAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomDetectionRuleAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/custom-detection-rule/association";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Mode\":");
    try aws.json.writeValue(@TypeOf(input.mode), input.mode, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuleId\":");
    try aws.json.writeValue(@TypeOf(input.rule_id), input.rule_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomDetectionRuleAssociationOutput {
    const result: CreateCustomDetectionRuleAssociationOutput = try aws.json.parseJsonObject(
        CreateCustomDetectionRuleAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
