const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UploadType = @import("upload_type.zig").UploadType;
const Upload = @import("upload.zig").Upload;

pub const ListUploadsInput = struct {
    /// The Amazon Resource Name (ARN) of the project for which you want to list
    /// uploads.
    arn: []const u8,

    /// An identifier that was returned from the previous call to this operation,
    /// which can
    /// be used to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    /// The type of upload.
    ///
    /// Must be one of the following values:
    ///
    /// * ANDROID_APP
    ///
    /// * IOS_APP
    ///
    /// * WEB_APP
    ///
    /// * EXTERNAL_DATA
    ///
    /// * APPIUM_JAVA_JUNIT_TEST_PACKAGE
    ///
    /// * APPIUM_JAVA_TESTNG_TEST_PACKAGE
    ///
    /// * APPIUM_PYTHON_TEST_PACKAGE
    ///
    /// * APPIUM_NODE_TEST_PACKAGE
    ///
    /// * APPIUM_RUBY_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_JAVA_JUNIT_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_JAVA_TESTNG_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_PYTHON_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_NODE_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_RUBY_TEST_PACKAGE
    ///
    /// * INSTRUMENTATION_TEST_PACKAGE
    ///
    /// * XCTEST_TEST_PACKAGE
    ///
    /// * XCTEST_UI_TEST_PACKAGE
    ///
    /// * APPIUM_JAVA_JUNIT_TEST_SPEC
    ///
    /// * APPIUM_JAVA_TESTNG_TEST_SPEC
    ///
    /// * APPIUM_PYTHON_TEST_SPEC
    ///
    /// * APPIUM_NODE_TEST_SPEC
    ///
    /// * APPIUM_RUBY_TEST_SPEC
    ///
    /// * APPIUM_WEB_JAVA_JUNIT_TEST_SPEC
    ///
    /// * APPIUM_WEB_JAVA_TESTNG_TEST_SPEC
    ///
    /// * APPIUM_WEB_PYTHON_TEST_SPEC
    ///
    /// * APPIUM_WEB_NODE_TEST_SPEC
    ///
    /// * APPIUM_WEB_RUBY_TEST_SPEC
    ///
    /// * INSTRUMENTATION_TEST_SPEC
    ///
    /// * XCTEST_UI_TEST_SPEC
    @"type": ?UploadType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .next_token = "nextToken",
        .@"type" = "type",
    };
};

pub const ListUploadsOutput = struct {
    /// If the number of items that are returned is significantly large, this is an
    /// identifier that is also
    /// returned. It can be used in a subsequent call to this operation to return
    /// the next set of items in the
    /// list.
    next_token: ?[]const u8 = null,

    /// Information about the uploads.
    uploads: ?[]const Upload = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .uploads = "uploads",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUploadsInput, options: CallOptions) !ListUploadsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUploadsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.ListUploads");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUploadsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListUploadsOutput, body, allocator);
}
