const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UploadType = @import("upload_type.zig").UploadType;
const Upload = @import("upload.zig").Upload;

pub const CreateUploadInput = struct {
    /// The upload's content type (for example, `application/octet-stream`).
    content_type: ?[]const u8 = null,

    /// The upload's file name. The name should not contain any forward slashes
    /// (`/`). If you are
    /// uploading an iOS app, the file name must end with the `.ipa` extension. If
    /// you are uploading an
    /// Android app, the file name must end with the `.apk` extension. For all
    /// others, the file name must
    /// end with the `.zip` file extension.
    name: []const u8,

    /// The ARN of the project for the upload.
    project_arn: []const u8,

    /// The upload's upload type.
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
    ///
    /// If you call `CreateUpload` with `WEB_APP` specified, AWS
    /// Device Farm throws an `ArgumentException` error.
    type: UploadType,

    pub const json_field_names = .{
        .content_type = "contentType",
        .name = "name",
        .project_arn = "projectArn",
        .type = "type",
    };
};

pub const CreateUploadOutput = struct {
    /// The newly created upload.
    upload: ?Upload = null,

    pub const json_field_names = .{
        .upload = "upload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUploadInput, options: CallOptions) !CreateUploadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUploadInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.CreateUpload");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUploadOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUploadOutput, body, allocator);
}
