const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;

pub const TestTypeInput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    arn: ?[]const u8 = null,

    /// The S3 bucket to which CloudFormation delivers the contract test execution
    /// logs.
    ///
    /// CloudFormation delivers the logs by the time contract testing has completed
    /// and the extension
    /// has been assigned a test type status of `PASSED` or `FAILED`.
    ///
    /// The user calling `TestType` must be able to access items in the specified S3
    /// bucket. Specifically, the user needs the following permissions:
    ///
    /// * `GetObject`
    ///
    /// * `PutObject`
    ///
    /// For more information, see [Actions, Resources, and
    /// Condition Keys for Amazon
    /// S3](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html) in the *Identity and Access Management User Guide*.
    log_delivery_bucket: ?[]const u8 = null,

    /// The type of the extension to test.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    type: ?ThirdPartyType = null,

    /// The name of the extension to test.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    type_name: ?[]const u8 = null,

    /// The version of the extension to test.
    ///
    /// You can specify the version id with either `Arn`, or with `TypeName`
    /// and `Type`.
    ///
    /// If you don't specify a version, CloudFormation uses the default version of
    /// the extension in
    /// this account and Region for testing.
    version_id: ?[]const u8 = null,
};

pub const TestTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    type_version_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestTypeInput, options: CallOptions) !TestTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=TestType&Version=2010-05-15");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "&Arn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.log_delivery_bucket) |v| {
        try body_buf.appendSlice(allocator, "&LogDeliveryBucket=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type) |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_id) |v| {
        try body_buf.appendSlice(allocator, "&VersionId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TestTypeResult")) break;
            },
            else => {},
        }
    }

    var result: TestTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TypeVersionArn")) {
                    result.type_version_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
