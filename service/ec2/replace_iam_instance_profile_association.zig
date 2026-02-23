const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IamInstanceProfileSpecification = @import("iam_instance_profile_specification.zig").IamInstanceProfileSpecification;
const IamInstanceProfileAssociation = @import("iam_instance_profile_association.zig").IamInstanceProfileAssociation;
const serde = @import("serde.zig");

pub const ReplaceIamInstanceProfileAssociationInput = struct {
    /// The ID of the existing IAM instance profile association.
    association_id: []const u8,

    /// The IAM instance profile.
    iam_instance_profile: IamInstanceProfileSpecification,
};

pub const ReplaceIamInstanceProfileAssociationOutput = struct {
    /// Information about the IAM instance profile association.
    iam_instance_profile_association: ?IamInstanceProfileAssociation = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReplaceIamInstanceProfileAssociationInput, options: Options) !ReplaceIamInstanceProfileAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ReplaceIamInstanceProfileAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ReplaceIamInstanceProfileAssociation&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&AssociationId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.association_id);
    if (input.iam_instance_profile.arn) |sv| {
        try body_buf.appendSlice(alloc, "&IamInstanceProfile.Arn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.iam_instance_profile.name) |sv| {
        try body_buf.appendSlice(alloc, "&IamInstanceProfile.Name=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ReplaceIamInstanceProfileAssociationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ReplaceIamInstanceProfileAssociationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "iamInstanceProfileAssociation")) {
                    result.iam_instance_profile_association = try serde.deserializeIamInstanceProfileAssociation(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
