const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessGrantsLocationConfiguration = @import("access_grants_location_configuration.zig").AccessGrantsLocationConfiguration;
const Grantee = @import("grantee.zig").Grantee;
const Permission = @import("permission.zig").Permission;
const serde = @import("serde.zig");

pub const GetAccessGrantInput = struct {
    /// The ID of the access grant. S3 Access Grants auto-generates this ID when you
    /// create the access grant.
    access_grant_id: []const u8,

    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,
};

pub const GetAccessGrantOutput = struct {
    /// The Amazon Resource Name (ARN) of the access grant.
    access_grant_arn: ?[]const u8 = null,

    /// The ID of the access grant. S3 Access Grants auto-generates this ID when you
    /// create the access grant.
    access_grant_id: ?[]const u8 = null,

    /// The configuration options of the grant location. The grant location is the
    /// S3 path to the data to which you are granting access.
    access_grants_location_configuration: ?AccessGrantsLocationConfiguration = null,

    /// The ID of the registered location to which you are granting access. S3
    /// Access Grants assigns this ID when you register the location. S3 Access
    /// Grants assigns the ID `default` to the default location `s3://` and assigns
    /// an auto-generated ID to other locations that you register.
    access_grants_location_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an Amazon Web Services IAM Identity Center
    /// application associated with your Identity Center instance. If the grant
    /// includes an application ARN, the grantee can only access the S3 data through
    /// this application.
    application_arn: ?[]const u8 = null,

    /// The date and time when you created the access grant.
    created_at: ?i64 = null,

    /// The user, group, or role to which you are granting access. You can grant
    /// access to an IAM user or role. If you have added a corporate directory to
    /// Amazon Web Services IAM Identity Center and associated this Identity Center
    /// instance with the S3 Access Grants instance, the grantee can also be a
    /// corporate directory user or group.
    grantee: ?Grantee = null,

    /// The S3 path of the data to which you are granting access. It is the result
    /// of appending the `Subprefix` to the location scope.
    grant_scope: ?[]const u8 = null,

    /// The type of permission that was granted in the access grant. Can be one of
    /// the following values:
    ///
    /// * `READ` – Grant read-only access to the S3 data.
    ///
    /// * `WRITE` – Grant write-only access to the S3 data.
    ///
    /// * `READWRITE` – Grant both read and write access to the S3 data.
    permission: ?Permission = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccessGrantInput, options: CallOptions) !GetAccessGrantOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccessGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/accessgrantsinstance/grant/");
    try path_buf.appendSlice(allocator, input.access_grant_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccessGrantOutput {
    var result: GetAccessGrantOutput = .{};
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
                if (std.mem.eql(u8, e.local, "AccessGrantArn")) {
                    result.access_grant_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantId")) {
                    result.access_grant_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationConfiguration")) {
                    result.access_grants_location_configuration = try serde.deserializeAccessGrantsLocationConfiguration(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try serde.deserializeGrantee(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "GrantScope")) {
                    result.grant_scope = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = Permission.fromWireName(try reader.readElementText());
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
