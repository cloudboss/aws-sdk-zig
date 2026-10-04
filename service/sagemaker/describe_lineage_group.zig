const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;

pub const DescribeLineageGroupInput = struct {
    /// The name of the lineage group.
    lineage_group_name: []const u8,

    pub const json_field_names = .{
        .lineage_group_name = "LineageGroupName",
    };
};

pub const DescribeLineageGroupOutput = struct {
    created_by: ?UserContext = null,

    /// The creation time of lineage group.
    creation_time: ?i64 = null,

    /// The description of the lineage group.
    description: ?[]const u8 = null,

    /// The display name of the lineage group.
    display_name: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// The last modified time of the lineage group.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the lineage group.
    lineage_group_arn: ?[]const u8 = null,

    /// The name of the lineage group.
    lineage_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .description = "Description",
        .display_name = "DisplayName",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .lineage_group_arn = "LineageGroupArn",
        .lineage_group_name = "LineageGroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLineageGroupInput, options: CallOptions) !DescribeLineageGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLineageGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeLineageGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLineageGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLineageGroupOutput, body, allocator);
}
