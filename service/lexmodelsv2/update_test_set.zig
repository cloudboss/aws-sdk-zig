const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetModality = @import("test_set_modality.zig").TestSetModality;
const TestSetStatus = @import("test_set_status.zig").TestSetStatus;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;

pub const UpdateTestSetInput = struct {
    /// The new test set description.
    description: ?[]const u8 = null,

    /// The test set Id for which update test operation to be performed.
    test_set_id: []const u8,

    /// The new test set name.
    test_set_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};

pub const UpdateTestSetOutput = struct {
    /// The creation date and time for the updated test set.
    creation_date_time: ?i64 = null,

    /// The test set description for the updated test set.
    description: ?[]const u8 = null,

    /// The date and time of the last update for the updated test set.
    last_updated_date_time: ?i64 = null,

    /// Indicates whether audio or text is used for the updated test set.
    modality: ?TestSetModality = null,

    /// The number of conversation turns from the updated test set.
    num_turns: ?i32 = null,

    /// The roleARN used for any operation in the test set to access
    /// resources in the Amazon Web Services account.
    role_arn: ?[]const u8 = null,

    /// The status for the updated test set.
    status: ?TestSetStatus = null,

    /// The Amazon S3 storage location for the updated test set.
    storage_location: ?TestSetStorageLocation = null,

    /// The test set Id for which update test operation to be performed.
    test_set_id: ?[]const u8 = null,

    /// The test set name for the updated test set.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTestSetInput, options: CallOptions) !UpdateTestSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTestSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testsets/");
    try path_buf.appendSlice(allocator, input.test_set_id);
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"testSetName\":");
    try aws.json.writeValue(@TypeOf(input.test_set_name), input.test_set_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTestSetOutput {
    const result: UpdateTestSetOutput = try aws.json.parseJsonObject(
        UpdateTestSetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
