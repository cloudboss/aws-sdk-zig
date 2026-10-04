const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetDetailOrgAttributes = @import("dataset_detail_org_attributes.zig").DatasetDetailOrgAttributes;

pub const GetDataSetDetailsInput = struct {
    /// The unique identifier of the application that this data set is associated
    /// with.
    application_id: []const u8,

    /// The name of the data set.
    data_set_name: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_set_name = "dataSetName",
    };
};

pub const GetDataSetDetailsOutput = struct {
    /// The size of the block on disk.
    blocksize: ?i32 = null,

    /// The timestamp when the data set was created.
    creation_time: ?i64 = null,

    /// The name of the data set.
    data_set_name: []const u8,

    /// The type of data set. The only supported value is VSAM.
    data_set_org: ?DatasetDetailOrgAttributes = null,

    /// File size of the dataset.
    file_size: ?i64 = null,

    /// The last time the data set was referenced.
    last_referenced_time: ?i64 = null,

    /// The last time the data set was updated.
    last_updated_time: ?i64 = null,

    /// The location where the data set is stored.
    location: ?[]const u8 = null,

    /// The length of records in the data set.
    record_length: ?i32 = null,

    pub const json_field_names = .{
        .blocksize = "blocksize",
        .creation_time = "creationTime",
        .data_set_name = "dataSetName",
        .data_set_org = "dataSetOrg",
        .file_size = "fileSize",
        .last_referenced_time = "lastReferencedTime",
        .last_updated_time = "lastUpdatedTime",
        .location = "location",
        .record_length = "recordLength",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSetDetailsInput, options: CallOptions) !GetDataSetDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSetDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.data_set_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSetDetailsOutput {
    var result: GetDataSetDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataSetDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
