const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityTargetTable = @import("data_quality_target_table.zig").DataQualityTargetTable;

pub const CreateDataQualityRulesetInput = struct {
    /// Used for idempotency and is recommended to be set to a random ID (such as a
    /// UUID) to avoid creating or starting multiple instances of the same resource.
    client_token: ?[]const u8 = null,

    /// The name of the security configuration created with the data quality
    /// encryption option.
    data_quality_security_configuration: ?[]const u8 = null,

    /// A description of the data quality ruleset.
    description: ?[]const u8 = null,

    /// A unique name for the data quality ruleset.
    name: []const u8,

    /// A Data Quality Definition Language (DQDL) ruleset. For more information, see
    /// the Glue developer guide.
    ruleset: []const u8,

    /// A list of tags applied to the data quality ruleset.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A target table associated with the data quality ruleset.
    target_table: ?DataQualityTargetTable = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_quality_security_configuration = "DataQualitySecurityConfiguration",
        .description = "Description",
        .name = "Name",
        .ruleset = "Ruleset",
        .tags = "Tags",
        .target_table = "TargetTable",
    };
};

pub const CreateDataQualityRulesetOutput = struct {
    /// A unique name for the data quality ruleset.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataQualityRulesetInput, options: CallOptions) !CreateDataQualityRulesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataQualityRulesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateDataQualityRuleset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataQualityRulesetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataQualityRulesetOutput, body, allocator);
}
