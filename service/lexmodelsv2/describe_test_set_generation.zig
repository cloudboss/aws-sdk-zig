const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetGenerationDataSource = @import("test_set_generation_data_source.zig").TestSetGenerationDataSource;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;
const TestSetGenerationStatus = @import("test_set_generation_status.zig").TestSetGenerationStatus;

pub const DescribeTestSetGenerationInput = struct {
    /// The unique identifier of the test set generation.
    test_set_generation_id: []const u8,

    pub const json_field_names = .{
        .test_set_generation_id = "testSetGenerationId",
    };
};

pub const DescribeTestSetGenerationOutput = struct {
    /// The creation date and time for the test set generation.
    creation_date_time: ?i64 = null,

    /// The test set description for the test set generation.
    description: ?[]const u8 = null,

    /// The reasons the test set generation failed.
    failure_reasons: ?[]const []const u8 = null,

    /// The data source of the test set used for the test set generation.
    generation_data_source: ?TestSetGenerationDataSource = null,

    /// The date and time of the last update for the test set generation.
    last_updated_date_time: ?i64 = null,

    /// The roleARN of the test set used for the test set generation.
    role_arn: ?[]const u8 = null,

    /// The Amazon S3 storage location for the test set generation.
    storage_location: ?TestSetStorageLocation = null,

    /// The unique identifier of the test set generation.
    test_set_generation_id: ?[]const u8 = null,

    /// The status for the test set generation.
    test_set_generation_status: ?TestSetGenerationStatus = null,

    /// The unique identifier for the test set created for the generated test set.
    test_set_id: ?[]const u8 = null,

    /// The test set name for the generated test set.
    test_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .description = "description",
        .failure_reasons = "failureReasons",
        .generation_data_source = "generationDataSource",
        .last_updated_date_time = "lastUpdatedDateTime",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_generation_id = "testSetGenerationId",
        .test_set_generation_status = "testSetGenerationStatus",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTestSetGenerationInput, options: CallOptions) !DescribeTestSetGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTestSetGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testsetgenerations/");
    try path_buf.appendSlice(allocator, input.test_set_generation_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTestSetGenerationOutput {
    const result: DescribeTestSetGenerationOutput = try aws.json.parseJsonObject(
        DescribeTestSetGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
