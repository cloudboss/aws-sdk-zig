const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterStringFilter = @import("parameter_string_filter.zig").ParameterStringFilter;
const Parameter = @import("parameter.zig").Parameter;

pub const GetParametersByPathInput = struct {
    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// A token to start the list. Use this token to get the next set of results.
    next_token: ?[]const u8 = null,

    /// Filters to limit the request results.
    ///
    /// The following `Key` values are supported for `GetParametersByPath`:
    /// `Type`, `KeyId`, and `Label`.
    ///
    /// The following `Key` values aren't supported for
    /// `GetParametersByPath`: `tag`, `DataType`, `Name`,
    /// `Path`, and `Tier`.
    parameter_filters: ?[]const ParameterStringFilter = null,

    /// The hierarchy for the parameter. Hierarchies start with a forward slash (/).
    /// The hierarchy
    /// is the parameter name except the last part of the parameter. For the API
    /// call to succeed, the
    /// last part of the parameter name can't be in the path. A parameter name
    /// hierarchy can have a
    /// maximum of 15 levels. Here is an example of a hierarchy:
    /// `/Finance/Prod/IAD/WinServ2016/license33 `
    path: []const u8,

    /// Retrieve all parameters within a hierarchy.
    ///
    /// If a user has access to a path, then the user can access all levels of that
    /// path. For
    /// example, if a user has permission to access path `/a`, then the user can
    /// also access
    /// `/a/b`. Even if a user has explicitly been denied access in IAM for
    /// parameter `/a/b`, they can still call the GetParametersByPath API operation
    /// recursively for `/a` and view `/a/b`.
    recursive: ?bool = null,

    /// Retrieve all parameters in a hierarchy with their value decrypted.
    with_decryption: ?bool = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .parameter_filters = "ParameterFilters",
        .path = "Path",
        .recursive = "Recursive",
        .with_decryption = "WithDecryption",
    };
};

pub const GetParametersByPathOutput = struct {
    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of parameters found in the specified hierarchy.
    parameters: ?[]const Parameter = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .parameters = "Parameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetParametersByPathInput, options: CallOptions) !GetParametersByPathOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetParametersByPathInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetParametersByPath");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetParametersByPathOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetParametersByPathOutput, body, allocator);
}
