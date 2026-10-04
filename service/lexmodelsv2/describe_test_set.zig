const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetModality = @import("test_set_modality.zig").TestSetModality;
const TestSetStatus = @import("test_set_status.zig").TestSetStatus;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;

pub const DescribeTestSetInput = struct {
    /// The test set Id for the test set request.
    test_set_id: []const u8,

    pub const json_field_names = .{
        .test_set_id = "testSetId",
    };
};

pub const DescribeTestSetOutput = struct {
    /// The creation date and time for the test set data.
    creation_date_time: ?i64 = null,

    /// The description of the test set.
    description: ?[]const u8 = null,

    /// The date and time for the last update of the test set data.
    last_updated_date_time: ?i64 = null,

    /// Indicates whether the test set is audio or text data.
    modality: ?TestSetModality = null,

    /// The total number of agent and user turn in the test set.
    num_turns: ?i32 = null,

    /// The roleARN used for any operation in the test set to access
    /// resources in the Amazon Web Services account.
    role_arn: ?[]const u8 = null,

    /// The status of the test set.
    status: ?TestSetStatus = null,

    /// The Amazon S3 storage location for the test set data.
    storage_location: ?TestSetStorageLocation = null,

    /// The test set Id for the test set response.
    test_set_id: ?[]const u8 = null,

    /// The test set name of the test set.
    test_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
        .modality = "modality",
        .num_turns = "numTurns",
        .role_arn = "roleArn",
        .status = "status",
        .storage_location = "storageLocation",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTestSetInput, options: CallOptions) !DescribeTestSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTestSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testsets/");
    try path_buf.appendSlice(allocator, input.test_set_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTestSetOutput {
    const result: DescribeTestSetOutput = try aws.json.parseJsonObject(
        DescribeTestSetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
