const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLakeDataset = @import("data_lake_dataset.zig").DataLakeDataset;

pub const UpdateDataLakeDatasetInput = struct {
    /// The updated description of the data lake dataset.
    description: ?[]const u8 = null,

    /// The Amazon Web Services Chain instance identifier.
    instance_id: []const u8,

    /// The name of the dataset. For **asc** namespace, the name must be one of the
    /// supported data entities under
    /// [https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html).
    name: []const u8,

    /// The namespace of the dataset, besides the custom defined namespace, every
    /// instance comes with below pre-defined namespaces:
    ///
    /// * **asc** - For information on the Amazon Web Services Supply Chain
    ///   supported datasets see
    ///   [https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html](https://docs.aws.amazon.com/aws-supply-chain/latest/userguide/data-model-asc.html).
    ///
    /// * **default** - For datasets with custom user-defined schemas.
    namespace: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .instance_id = "instanceId",
        .name = "name",
        .namespace = "namespace",
    };
};

pub const UpdateDataLakeDatasetOutput = struct {
    /// The updated dataset details.
    dataset: ?DataLakeDataset = null,

    pub const json_field_names = .{
        .dataset = "dataset",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataLakeDatasetInput, options: CallOptions) !UpdateDataLakeDatasetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataLakeDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/datalake/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataLakeDatasetOutput {
    var result: UpdateDataLakeDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDataLakeDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
