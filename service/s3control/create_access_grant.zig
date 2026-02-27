const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessGrantsLocationConfiguration = @import("access_grants_location_configuration.zig").AccessGrantsLocationConfiguration;
const Grantee = @import("grantee.zig").Grantee;
const Permission = @import("permission.zig").Permission;
const S3PrefixType = @import("s3_prefix_type.zig").S3PrefixType;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateAccessGrantInput = struct {
    /// The configuration options of the grant location. The grant location is the
    /// S3 path to the data to which you are granting access. It contains the
    /// `S3SubPrefix` field. The grant scope is the result of appending the
    /// subprefix to the location scope of the registered location.
    access_grants_location_configuration: ?AccessGrantsLocationConfiguration = null,

    /// The ID of the registered location to which you are granting access. S3
    /// Access Grants assigns this ID when you register the location. S3 Access
    /// Grants assigns the ID `default` to the default location `s3://` and assigns
    /// an auto-generated ID to other locations that you register.
    ///
    /// If you are passing the `default` location, you cannot create an access grant
    /// for the entire default location. You must also specify a bucket or a bucket
    /// and prefix in the `Subprefix` field.
    access_grants_location_id: []const u8,

    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of an Amazon Web Services IAM Identity Center
    /// application associated with your Identity Center instance. If an application
    /// ARN is included in the request to create an access grant, the grantee can
    /// only access the S3 data through this application.
    application_arn: ?[]const u8 = null,

    /// The user, group, or role to which you are granting access. You can grant
    /// access to an IAM user or role. If you have added your corporate directory to
    /// Amazon Web Services IAM Identity Center and associated your Identity Center
    /// instance with your S3 Access Grants instance, the grantee can also be a
    /// corporate directory user or group.
    grantee: Grantee,

    /// The type of access that you are granting to your S3 data, which can be set
    /// to one of the following values:
    ///
    /// * `READ` – Grant read-only access to the S3 data.
    ///
    /// * `WRITE` – Grant write-only access to the S3 data.
    ///
    /// * `READWRITE` – Grant both read and write access to the S3 data.
    permission: Permission,

    /// The type of `S3SubPrefix`. The only possible value is `Object`. Pass this
    /// value if the access grant scope is an object. Do not pass this value if the
    /// access grant scope is a bucket or a bucket and a prefix.
    s3_prefix_type: ?S3PrefixType = null,

    /// The Amazon Web Services resource tags that you are adding to the access
    /// grant. Each tag is a label consisting of a user-defined key and value. Tags
    /// can help you manage, identify, organize, search for, and filter resources.
    tags: ?[]const Tag = null,
};

pub const CreateAccessGrantOutput = struct {
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
    /// access to an IAM user or role. If you have added your corporate directory to
    /// Amazon Web Services IAM Identity Center and associated your Identity Center
    /// instance with your S3 Access Grants instance, the grantee can also be a
    /// corporate directory user or group.
    grantee: ?Grantee = null,

    /// The S3 path of the data to which you are granting access. It is the result
    /// of appending the `Subprefix` to the location scope.
    grant_scope: ?[]const u8 = null,

    /// The type of access that you are granting to your S3 data, which can be set
    /// to one of the following values:
    ///
    /// * `READ` – Grant read-only access to the S3 data.
    ///
    /// * `WRITE` – Grant write-only access to the S3 data.
    ///
    /// * `READWRITE` – Grant both read and write access to the S3 data.
    permission: ?Permission = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessGrantInput, options: Options) !CreateAccessGrantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3control");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAccessGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3control", "S3 Control", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v20180820/accessgrantsinstance/grant";

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<CreateAccessGrantRequest>");
    if (input.access_grants_location_configuration) |v| {
        try body_buf.appendSlice(alloc, "<AccessGrantsLocationConfiguration>");
        try serde.serializeAccessGrantsLocationConfiguration(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</AccessGrantsLocationConfiguration>");
    }
    try body_buf.appendSlice(alloc, "<AccessGrantsLocationId>");
    try aws.xml.appendXmlEscaped(alloc, &body_buf, input.access_grants_location_id);
    try body_buf.appendSlice(alloc, "</AccessGrantsLocationId>");
    if (input.application_arn) |v| {
        try body_buf.appendSlice(alloc, "<ApplicationArn>");
        try aws.xml.appendXmlEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</ApplicationArn>");
    }
    try body_buf.appendSlice(alloc, "<Grantee>");
    try serde.serializeGrantee(alloc, &body_buf, input.grantee);
    try body_buf.appendSlice(alloc, "</Grantee>");
    try body_buf.appendSlice(alloc, "<Permission>");
    try body_buf.appendSlice(alloc, @tagName(input.permission));
    try body_buf.appendSlice(alloc, "</Permission>");
    if (input.s3_prefix_type) |v| {
        try body_buf.appendSlice(alloc, "<S3PrefixType>");
        try body_buf.appendSlice(alloc, @tagName(v));
        try body_buf.appendSlice(alloc, "</S3PrefixType>");
    }
    if (input.tags) |v| {
        try body_buf.appendSlice(alloc, "<Tags>");
        try serde.serializeTagList(alloc, &body_buf, v, "Tag");
        try body_buf.appendSlice(alloc, "</Tags>");
    }
    try body_buf.appendSlice(alloc, "</CreateAccessGrantRequest>");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    try request.headers.put(alloc, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAccessGrantOutput {
    var result: CreateAccessGrantOutput = .{};
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
                    result.access_grant_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantId")) {
                    result.access_grant_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationConfiguration")) {
                    result.access_grants_location_configuration = try serde.deserializeAccessGrantsLocationConfiguration(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AccessGrantsLocationId")) {
                    result.access_grants_location_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApplicationArn")) {
                    result.application_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Grantee")) {
                    result.grantee = try serde.deserializeGrantee(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "GrantScope")) {
                    result.grant_scope = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Permission")) {
                    result.permission = std.meta.stringToEnum(Permission, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobStatusException")) {
        return .{ .arena = arena, .kind = .{ .job_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchPublicAccessBlockConfiguration")) {
        return .{ .arena = arena, .kind = .{ .no_such_public_access_block_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
