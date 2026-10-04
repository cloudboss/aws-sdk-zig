const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsCredentials = @import("aws_credentials.zig").AwsCredentials;
const S3Location = @import("s3_location.zig").S3Location;

pub const GetExternalDataViewAccessDetailsInput = struct {
    /// The unique identifier for the Dataset.
    dataset_id: []const u8,

    /// The unique identifier for the Dataview that you want to access.
    data_view_id: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .data_view_id = "dataViewId",
    };
};

pub const GetExternalDataViewAccessDetailsOutput = struct {
    /// The credentials required to access the external Dataview from the S3
    /// location.
    credentials: ?AwsCredentials = null,

    /// The location where the external Dataview is stored.
    s_3_location: ?S3Location = null,

    pub const json_field_names = .{
        .credentials = "credentials",
        .s_3_location = "s3Location",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExternalDataViewAccessDetailsInput, options: CallOptions) !GetExternalDataViewAccessDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExternalDataViewAccessDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/dataviewsv2/");
    try path_buf.appendSlice(allocator, input.data_view_id);
    try path_buf.appendSlice(allocator, "/external-access-details");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExternalDataViewAccessDetailsOutput {
    const result: GetExternalDataViewAccessDetailsOutput = try aws.json.parseJsonObject(
        GetExternalDataViewAccessDetailsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
