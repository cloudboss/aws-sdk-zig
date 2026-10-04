const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Rule = @import("rule.zig").Rule;

pub const DescribeRulesetInput = struct {
    /// The name of the ruleset to be described.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeRulesetOutput = struct {
    /// The date and time that the ruleset was created.
    create_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the user who created the ruleset.
    created_by: ?[]const u8 = null,

    /// The description of the ruleset.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user who last modified the ruleset.
    last_modified_by: ?[]const u8 = null,

    /// The modification date and time of the ruleset.
    last_modified_date: ?i64 = null,

    /// The name of the ruleset.
    name: []const u8,

    /// The Amazon Resource Name (ARN) for the ruleset.
    resource_arn: ?[]const u8 = null,

    /// A list of rules that are defined with the ruleset. A rule includes one
    /// or more checks to be validated on a DataBrew dataset.
    rules: ?[]const Rule = null,

    /// Metadata tags that have been applied to the ruleset.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of a resource (dataset) that the ruleset is
    /// associated with.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .description = "Description",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .resource_arn = "ResourceArn",
        .rules = "Rules",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRulesetInput, options: CallOptions) !DescribeRulesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRulesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rulesets/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRulesetOutput {
    const result: DescribeRulesetOutput = try aws.json.parseJsonObject(
        DescribeRulesetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
