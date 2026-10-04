const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateAccessGrantsInstanceInput = struct {
    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// If you would like to associate your S3 Access Grants instance with an Amazon
    /// Web Services IAM Identity Center instance, use this field to pass the Amazon
    /// Resource Name (ARN) of the Amazon Web Services IAM Identity Center instance
    /// that you are associating with your S3 Access Grants instance. An IAM
    /// Identity Center instance is your corporate identity directory that you added
    /// to the IAM Identity Center. You can use the
    /// [ListInstances](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListInstances.html) API operation to retrieve a list of your Identity Center instances and their ARNs.
    identity_center_arn: ?[]const u8 = null,

    /// The Amazon Web Services resource tags that you are adding to the S3 Access
    /// Grants instance. Each tag is a label consisting of a user-defined key and
    /// value. Tags can help you manage, identify, organize, search for, and filter
    /// resources.
    tags: ?[]const Tag = null,
};

pub const CreateAccessGrantsInstanceOutput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services IAM Identity
    /// Center instance that you are associating with your S3 Access Grants
    /// instance. An IAM Identity Center instance is your corporate identity
    /// directory that you added to the IAM Identity Center. You can use the
    /// [ListInstances](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListInstances.html) API operation to retrieve a list of your Identity Center instances and their ARNs.
    access_grants_instance_arn: ?[]const u8 = null,

    /// The ID of the S3 Access Grants instance. The ID is `default`. You can have
    /// one S3 Access Grants instance per Region per account.
    access_grants_instance_id: ?[]const u8 = null,

    /// The date and time when you created the S3 Access Grants instance.
    created_at: ?i64 = null,

    /// If you associated your S3 Access Grants instance with an Amazon Web Services
    /// IAM Identity Center instance, this field returns the Amazon Resource Name
    /// (ARN) of the IAM Identity Center instance application; a subresource of the
    /// original Identity Center instance. S3 Access Grants creates this Identity
    /// Center application for the specific S3 Access Grants instance.
    identity_center_application_arn: ?[]const u8 = null,

    /// If you associated your S3 Access Grants instance with an Amazon Web Services
    /// IAM Identity Center instance, this field returns the Amazon Resource Name
    /// (ARN) of the IAM Identity Center instance application; a subresource of the
    /// original Identity Center instance. S3 Access Grants creates this Identity
    /// Center application for the specific S3 Access Grants instance.
    identity_center_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services IAM Identity
    /// Center instance that you are associating with your S3 Access Grants
    /// instance. An IAM Identity Center instance is your corporate identity
    /// directory that you added to the IAM Identity Center. You can use the
    /// [ListInstances](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListInstances.html) API operation to retrieve a list of your Identity Center instances and their ARNs.
    identity_center_instance_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessGrantsInstanceInput, options: CallOptions) !CreateAccessGrantsInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessGrantsInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/accessgrantsinstance";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateAccessGrantsInstanceRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    if (input.identity_center_arn) |v| {
        try body_buf.appendSlice(allocator, "<IdentityCenterArn>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</IdentityCenterArn>");
    }
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTagList(allocator, &body_buf, v, "Tag");
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateAccessGrantsInstanceRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessGrantsInstanceOutput {
    var result: CreateAccessGrantsInstanceOutput = .{};
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
                if (std.mem.eql(u8, e.local, "AccessGrantsInstanceArn")) {
                    result.access_grants_instance_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccessGrantsInstanceId")) {
                    result.access_grants_instance_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreatedAt")) {
                    result.created_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "IdentityCenterApplicationArn")) {
                    result.identity_center_application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityCenterArn")) {
                    result.identity_center_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IdentityCenterInstanceArn")) {
                    result.identity_center_instance_arn = try allocator.dupe(u8, try reader.readElementText());
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
