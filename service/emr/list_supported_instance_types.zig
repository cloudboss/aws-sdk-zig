const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SupportedInstanceType = @import("supported_instance_type.zig").SupportedInstanceType;

pub const ListSupportedInstanceTypesInput = struct {
    /// The pagination token that marks the next set of results to retrieve.
    marker: ?[]const u8 = null,

    /// The Amazon EMR release label determines the [versions of open-source
    /// application
    /// packages](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-app-versions-6.x.html) that Amazon EMR has installed on the cluster.
    /// Release labels are in the format `emr-x.x.x`, where x.x.x is an Amazon EMR
    /// release number such as `emr-6.10.0`. For more information about Amazon EMR
    /// releases and their included application versions and features, see the
    /// *
    /// [Amazon EMR Release
    /// Guide](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-components.html)
    /// *.
    release_label: []const u8,

    pub const json_field_names = .{
        .marker = "Marker",
        .release_label = "ReleaseLabel",
    };
};

pub const ListSupportedInstanceTypesOutput = struct {
    /// The pagination token that marks the next set of results to retrieve.
    marker: ?[]const u8 = null,

    /// The list of instance types that the release specified in
    /// `ListSupportedInstanceTypesInput$ReleaseLabel` supports, filtered by Amazon
    /// Web Services Region.
    supported_instance_types: ?[]const SupportedInstanceType = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .supported_instance_types = "SupportedInstanceTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSupportedInstanceTypesInput, options: CallOptions) !ListSupportedInstanceTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSupportedInstanceTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.ListSupportedInstanceTypes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSupportedInstanceTypesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSupportedInstanceTypesOutput, body, allocator);
}
