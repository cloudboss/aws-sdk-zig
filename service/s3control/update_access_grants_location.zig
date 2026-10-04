const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAccessGrantsLocationInput = struct {
    /// The ID of the registered location that you are updating. S3 Access Grants
    /// assigns this ID when you register the location. S3 Access Grants assigns the
    /// ID `default` to the default location `s3://` and assigns an auto-generated
    /// ID to other locations that you register.
    ///
    /// The ID of the registered location to which you are granting access. S3
    /// Access Grants assigned this ID when you registered the location. S3 Access
    /// Grants assigns the ID `default` to the default location `s3://` and assigns
    /// an auto-generated ID to other locations that you register.
    ///
    /// If you are passing the `default` location, you cannot create an access grant
    /// for the entire default location. You must also specify a bucket or a bucket
    /// and prefix in the `Subprefix` field.
    access_grants_location_id: []const u8,

    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role for the registered location.
    /// S3 Access Grants assumes this role to manage access to the registered
    /// location.
    iam_role_arn: []const u8,
};

pub const UpdateAccessGrantsLocationOutput = struct {
    /// The Amazon Resource Name (ARN) of the registered location that you are
    /// updating.
    access_grants_location_arn: ?[]const u8 = null,

    /// The ID of the registered location to which you are granting access. S3
    /// Access Grants assigned this ID when you registered the location. S3 Access
    /// Grants assigns the ID `default` to the default location `s3://` and assigns
    /// an auto-generated ID to other locations that you register.
    access_grants_location_id: ?[]const u8 = null,

    /// The date and time when you registered the location.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role of the registered location.
    /// S3 Access Grants assumes this role to manage access to the registered
    /// location.
    iam_role_arn: ?[]const u8 = null,

    /// The S3 URI path of the location that you are updating. You cannot update the
    /// scope of the registered location. The location scope can be the default S3
    /// location `s3://`, the S3 path to a bucket `s3://`, or the S3 path to a
    /// bucket and prefix `s3:///`.
    location_scope: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessGrantsLocationInput, options: CallOptions) !UpdateAccessGrantsLocationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessGrantsLocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/accessgrantsinstance/location/");
    try path_buf.appendSlice(allocator, input.access_grants_location_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateAccessGrantsLocationRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<IAMRoleArn>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.iam_role_arn);
    try body_buf.appendSlice(allocator, "</IAMRoleArn>");
    try body_buf.appendSlice(allocator, "</UpdateAccessGrantsLocationRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessGrantsLocationOutput {
    var result: UpdateAccessGrantsLocationOutput = .{};
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
                if (std.mem.eql(u8, e.local, "AccessGrantsLocationArn")) {
                    result.access_grants_location_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IAMRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LocationScope")) {
                    result.location_scope = try allocator.dupe(u8, try reader.readElementText());
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
