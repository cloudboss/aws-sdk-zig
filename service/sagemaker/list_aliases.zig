const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListAliasesInput = struct {
    /// The alias of the image version.
    alias: ?[]const u8 = null,

    /// The name of the image.
    image_name: []const u8,

    /// The maximum number of aliases to return.
    max_results: ?i32 = null,

    /// If the previous call to `ListAliases` didn't return the full set of aliases,
    /// the call returns a token for retrieving the next set of aliases.
    next_token: ?[]const u8 = null,

    /// The version of the image. If image version is not specified, the aliases of
    /// all versions of the image are listed.
    version: ?i32 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .image_name = "ImageName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .version = "Version",
    };
};

pub const ListAliasesOutput = struct {
    /// A token for getting the next set of aliases, if more aliases exist.
    next_token: ?[]const u8 = null,

    /// A list of SageMaker AI image version aliases.
    sage_maker_image_version_aliases: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sage_maker_image_version_aliases = "SageMakerImageVersionAliases",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAliasesInput, options: CallOptions) !ListAliasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAliasesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListAliases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAliasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAliasesOutput, body, allocator);
}
