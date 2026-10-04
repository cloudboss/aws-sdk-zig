const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObjectLambdaConfiguration = @import("object_lambda_configuration.zig").ObjectLambdaConfiguration;
const ObjectLambdaAccessPointAlias = @import("object_lambda_access_point_alias.zig").ObjectLambdaAccessPointAlias;
const serde = @import("serde.zig");

pub const CreateAccessPointForObjectLambdaInput = struct {
    /// The Amazon Web Services account ID for owner of the specified Object Lambda
    /// Access Point.
    account_id: []const u8,

    /// Object Lambda Access Point configuration as a JSON document.
    configuration: ObjectLambdaConfiguration,

    /// The name you want to assign to this Object Lambda Access Point.
    name: []const u8,
};

pub const CreateAccessPointForObjectLambdaOutput = struct {
    /// The alias of the Object Lambda Access Point.
    alias: ?ObjectLambdaAccessPointAlias = null,

    /// Specifies the ARN for the Object Lambda Access Point.
    object_lambda_access_point_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessPointForObjectLambdaInput, options: CallOptions) !CreateAccessPointForObjectLambdaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessPointForObjectLambdaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/accesspointforobjectlambda/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateAccessPointForObjectLambdaRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<Configuration>");
    try serde.serializeObjectLambdaConfiguration(allocator, &body_buf, input.configuration);
    try body_buf.appendSlice(allocator, "</Configuration>");
    try body_buf.appendSlice(allocator, "</CreateAccessPointForObjectLambdaRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessPointForObjectLambdaOutput {
    var result: CreateAccessPointForObjectLambdaOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try serde.deserializeObjectLambdaAccessPointAlias(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "ObjectLambdaAccessPointArn")) {
                    result.object_lambda_access_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
