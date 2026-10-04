const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetGenerationDataSource = @import("test_set_generation_data_source.zig").TestSetGenerationDataSource;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;
const TestSetGenerationStatus = @import("test_set_generation_status.zig").TestSetGenerationStatus;

pub const StartTestSetGenerationInput = struct {
    /// The test set description for the test set generation request.
    description: ?[]const u8 = null,

    /// The data source for the test set generation.
    generation_data_source: TestSetGenerationDataSource,

    /// The roleARN used for any operation in the test set to access
    /// resources in the Amazon Web Services account.
    role_arn: []const u8,

    /// The Amazon S3 storage location for the test set generation.
    storage_location: TestSetStorageLocation,

    /// The test set name for the test set generation request.
    test_set_name: []const u8,

    /// A list of tags to add to the test set. You can only add tags when you
    /// import/generate a new test set. You can't use the `UpdateTestSet` operation
    /// to update tags. To update tags, use the `TagResource` operation.
    test_set_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .generation_data_source = "generationDataSource",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_name = "testSetName",
        .test_set_tags = "testSetTags",
    };
};

pub const StartTestSetGenerationOutput = struct {
    /// The creation date and time for the test set generation.
    creation_date_time: ?i64 = null,

    /// The description used for the test set generation.
    description: ?[]const u8 = null,

    /// The data source for the test set generation.
    generation_data_source: ?TestSetGenerationDataSource = null,

    /// The roleARN used for any operation in the test set to access resources
    /// in the Amazon Web Services account.
    role_arn: ?[]const u8 = null,

    /// The Amazon S3 storage location for the test set generation.
    storage_location: ?TestSetStorageLocation = null,

    /// The unique identifier of the test set generation to describe.
    test_set_generation_id: ?[]const u8 = null,

    /// The status for the test set generation.
    test_set_generation_status: ?TestSetGenerationStatus = null,

    /// The test set name used for the test set generation.
    test_set_name: ?[]const u8 = null,

    /// A list of tags that was used for the test set that is being generated.
    test_set_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .description = "description",
        .generation_data_source = "generationDataSource",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_generation_id = "testSetGenerationId",
        .test_set_generation_status = "testSetGenerationStatus",
        .test_set_name = "testSetName",
        .test_set_tags = "testSetTags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTestSetGenerationInput, options: CallOptions) !StartTestSetGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTestSetGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/testsetgenerations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"generationDataSource\":");
    try aws.json.writeValue(@TypeOf(input.generation_data_source), input.generation_data_source, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"storageLocation\":");
    try aws.json.writeValue(@TypeOf(input.storage_location), input.storage_location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"testSetName\":");
    try aws.json.writeValue(@TypeOf(input.test_set_name), input.test_set_name, allocator, &body_buf);
    has_prev = true;
    if (input.test_set_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"testSetTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTestSetGenerationOutput {
    const result: StartTestSetGenerationOutput = try aws.json.parseJsonObject(
        StartTestSetGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
