const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParametersFilter = @import("parameters_filter.zig").ParametersFilter;
const ParameterStringFilter = @import("parameter_string_filter.zig").ParameterStringFilter;
const ParameterMetadata = @import("parameter_metadata.zig").ParameterMetadata;

pub const DescribeParametersInput = struct {
    /// This data type is deprecated. Instead, use `ParameterFilters`.
    filters: ?[]const ParametersFilter = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// Filters to limit the request results.
    parameter_filters: ?[]const ParameterStringFilter = null,

    /// Lists parameters that are shared with you.
    ///
    /// By default when using this option, the command returns parameters that have
    /// been shared
    /// using a standard Resource Access Manager Resource Share. In order for a
    /// parameter that was shared
    /// using the PutResourcePolicy command to be returned, the associated
    /// `RAM Resource Share Created From Policy` must have been promoted to
    /// a standard Resource Share using the RAM
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html) API operation.
    ///
    /// For more information about sharing parameters, see [Working with
    /// shared
    /// parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-shared-parameters.html) in the *Amazon Web Services Systems Manager User Guide*.
    shared: ?bool = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .parameter_filters = "ParameterFilters",
        .shared = "Shared",
    };
};

pub const DescribeParametersOutput = struct {
    /// The token to use when requesting the next set of items.
    next_token: ?[]const u8 = null,

    /// Parameters returned by the request.
    parameters: ?[]const ParameterMetadata = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .parameters = "Parameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeParametersInput, options: CallOptions) !DescribeParametersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeParametersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeParameters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeParametersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeParametersOutput, body, allocator);
}
