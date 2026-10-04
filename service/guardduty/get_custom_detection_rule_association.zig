const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationDetail = @import("association_detail.zig").AssociationDetail;

pub const GetCustomDetectionRuleAssociationInput = struct {
    /// The unique identifier for the association.
    association_id: []const u8,

    /// The unique identifier for the custom detection rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .rule_id = "RuleId",
    };
};

pub const GetCustomDetectionRuleAssociationOutput = struct {
    /// The details of the custom detection rule association.
    rule_association: ?AssociationDetail = null,

    /// The tags associated with the custom detection rule association resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .rule_association = "RuleAssociation",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomDetectionRuleAssociationInput, options: CallOptions) !GetCustomDetectionRuleAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomDetectionRuleAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/custom-detection-rule/rule/");
    try path_buf.appendSlice(allocator, input.rule_id);
    try path_buf.appendSlice(allocator, "/association/");
    try path_buf.appendSlice(allocator, input.association_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomDetectionRuleAssociationOutput {
    const result: GetCustomDetectionRuleAssociationOutput = try aws.json.parseJsonObject(
        GetCustomDetectionRuleAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
