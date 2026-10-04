const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;
const Tag = @import("tag.zig").Tag;

pub const CreateRescoreExecutionPlanInput = struct {
    /// You can set additional capacity units to meet the
    /// needs of your rescore execution plan. You are given a single
    /// capacity unit by default. If you want to use the default
    /// capacity, you don't set additional capacity units. For more
    /// information on the default capacity and additional capacity
    /// units, see [Adjusting
    /// capacity](https://docs.aws.amazon.com/kendra/latest/dg/adjusting-capacity.html).
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// A token that you provide to identify the request to create
    /// a rescore execution plan. Multiple calls to the
    /// `CreateRescoreExecutionPlanRequest` API with the
    /// same client token will create only one rescore execution plan.
    client_token: ?[]const u8 = null,

    /// A description for the rescore execution plan.
    description: ?[]const u8 = null,

    /// A name for the rescore execution plan.
    name: []const u8,

    /// A list of key-value pairs that identify or categorize your
    /// rescore execution plan. You can also use tags to help control
    /// access to the rescore execution plan. Tag keys and values can
    /// consist of Unicode letters, digits, white space, and any of
    /// the following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateRescoreExecutionPlanOutput = struct {
    /// The Amazon Resource Name (ARN) of the rescore
    /// execution plan.
    arn: []const u8,

    /// The identifier of the rescore execution plan.
    id: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRescoreExecutionPlanInput, options: CallOptions) !CreateRescoreExecutionPlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra-ranking", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRescoreExecutionPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra-ranking", "Kendra Ranking", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraRerankingFrontendService.CreateRescoreExecutionPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRescoreExecutionPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRescoreExecutionPlanOutput, body, allocator);
}
