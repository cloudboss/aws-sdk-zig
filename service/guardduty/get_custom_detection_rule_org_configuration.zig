const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationMode = @import("association_mode.zig").AssociationMode;
const DetectionRuleOrgConfiguration = @import("detection_rule_org_configuration.zig").DetectionRuleOrgConfiguration;

pub const GetCustomDetectionRuleOrgConfigurationInput = struct {
    /// The execution mode of the organization configuration to retrieve. Valid
    /// values: `LIVE` | `DRY_RUN`.
    mode: AssociationMode,

    /// The unique identifier for the custom detection rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .mode = "Mode",
        .rule_id = "RuleId",
    };
};

pub const GetCustomDetectionRuleOrgConfigurationOutput = struct {
    /// The details of the organization configuration.
    configuration: ?DetectionRuleOrgConfiguration = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomDetectionRuleOrgConfigurationInput, options: CallOptions) !GetCustomDetectionRuleOrgConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomDetectionRuleOrgConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/custom-detection-rule/org-configuration/");
    try path_buf.appendSlice(allocator, input.rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "mode=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.mode.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomDetectionRuleOrgConfigurationOutput {
    const result: GetCustomDetectionRuleOrgConfigurationOutput = try aws.json.parseJsonObject(
        GetCustomDetectionRuleOrgConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
