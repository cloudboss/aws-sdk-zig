const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateBillOfMaterialsImportJobInput = struct {
    /// An idempotency token ensures the API request is only completed no more than
    /// once. This way, retrying the request will not trigger the operation multiple
    /// times. A client token is a unique, case-sensitive string of 33 to 128 ASCII
    /// characters. To make an idempotent API request, specify a client token in the
    /// request. You should not reuse the same client token for other requests. If
    /// you retry a successful request with the same client token, the request will
    /// succeed with no further actions being taken, and you will receive the same
    /// API response as the original successful request.
    client_token: ?[]const u8 = null,

    /// The AWS Supply Chain instance identifier.
    instance_id: []const u8,

    /// The S3 URI of the CSV file to be imported. The bucket must grant permissions
    /// for AWS Supply Chain to read the file.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .instance_id = "instanceId",
        .s_3_uri = "s3uri",
    };
};

pub const CreateBillOfMaterialsImportJobOutput = struct {
    /// The new BillOfMaterialsImportJob identifier.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBillOfMaterialsImportJobInput, options: CallOptions) !CreateBillOfMaterialsImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBillOfMaterialsImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/configuration/instances/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/bill-of-materials-import-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"s3uri\":");
    try aws.json.writeValue(@TypeOf(input.s_3_uri), input.s_3_uri, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBillOfMaterialsImportJobOutput {
    var result: CreateBillOfMaterialsImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBillOfMaterialsImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
