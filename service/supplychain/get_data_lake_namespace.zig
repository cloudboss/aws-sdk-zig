const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLakeNamespace = @import("data_lake_namespace.zig").DataLakeNamespace;

pub const GetDataLakeNamespaceInput = struct {
    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// The name of the namespace. Besides the namespaces user created, you can also
    /// specify the pre-defined namespaces:
    ///
    /// * **asc** - Pre-defined namespace containing Amazon Web Services Supply
    ///   Chain supported datasets, see
    ///   [https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html).
    ///
    /// * **default** - Pre-defined namespace containing datasets with custom
    ///   user-defined schemas.
    name: []const u8,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .name = "name",
    };
};

pub const GetDataLakeNamespaceOutput = struct {
    /// The fetched namespace details.
    namespace: ?DataLakeNamespace = null,

    pub const json_field_names = .{
        .namespace = "namespace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataLakeNamespaceInput, options: CallOptions) !GetDataLakeNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataLakeNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/datalake/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataLakeNamespaceOutput {
    const result: GetDataLakeNamespaceOutput = try aws.json.parseJsonObject(
        GetDataLakeNamespaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
