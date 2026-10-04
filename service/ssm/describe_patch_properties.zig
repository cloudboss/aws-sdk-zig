const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const PatchSet = @import("patch_set.zig").PatchSet;
const PatchProperty = @import("patch_property.zig").PatchProperty;

pub const DescribePatchPropertiesInput = struct {
    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The operating system type for which to list patches.
    operating_system: OperatingSystem,

    /// Indicates whether to list patches for the Windows operating system or for
    /// applications
    /// released by Microsoft. Not applicable for the Linux or macOS operating
    /// systems.
    patch_set: ?PatchSet = null,

    /// The patch property for which you want to view patch details.
    property: PatchProperty,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .operating_system = "OperatingSystem",
        .patch_set = "PatchSet",
        .property = "Property",
    };
};

pub const DescribePatchPropertiesOutput = struct {
    /// The token for the next set of items to return. (You use this token in the
    /// next call.)
    next_token: ?[]const u8 = null,

    /// A list of the properties for patches matching the filter request parameters.
    properties: ?[]const []const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .properties = "Properties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePatchPropertiesInput, options: CallOptions) !DescribePatchPropertiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePatchPropertiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribePatchProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePatchPropertiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePatchPropertiesOutput, body, allocator);
}
