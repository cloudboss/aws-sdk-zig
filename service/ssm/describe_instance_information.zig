const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceInformationStringFilter = @import("instance_information_string_filter.zig").InstanceInformationStringFilter;
const InstanceInformationFilter = @import("instance_information_filter.zig").InstanceInformationFilter;
const InstanceInformation = @import("instance_information.zig").InstanceInformation;

pub const DescribeInstanceInformationInput = struct {
    /// One or more filters. Use a filter to return a more specific list of managed
    /// nodes. You can
    /// filter based on tags applied to your managed nodes. Tag filters can't be
    /// combined with other
    /// filter types. Use this `Filters` data type instead of
    /// `InstanceInformationFilterList`, which is deprecated.
    filters: ?[]const InstanceInformationStringFilter = null,

    /// This is a legacy method. We recommend that you don't use this method.
    /// Instead, use the
    /// `Filters` data type. `Filters` enables you to return node information by
    /// filtering based on tags applied to managed nodes.
    ///
    /// Attempting to use `InstanceInformationFilterList` and `Filters` leads
    /// to an exception error.
    instance_information_filter_list: ?[]const InstanceInformationFilter = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results. The default
    /// value is 10 items.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .instance_information_filter_list = "InstanceInformationFilterList",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeInstanceInformationOutput = struct {
    /// The managed node information list.
    instance_information_list: ?[]const InstanceInformation = null,

    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_information_list = "InstanceInformationList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceInformationInput, options: CallOptions) !DescribeInstanceInformationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstanceInformationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeInstanceInformation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstanceInformationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInstanceInformationOutput, body, allocator);
}
