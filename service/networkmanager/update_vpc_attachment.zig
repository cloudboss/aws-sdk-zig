const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcOptions = @import("vpc_options.zig").VpcOptions;
const VpcAttachment = @import("vpc_attachment.zig").VpcAttachment;

pub const UpdateVpcAttachmentInput = struct {
    /// Adds a subnet ARN to the VPC attachment.
    add_subnet_arns: ?[]const []const u8 = null,

    /// The ID of the attachment.
    attachment_id: []const u8,

    /// Additional options for updating the VPC attachment.
    options: ?VpcOptions = null,

    /// Removes a subnet ARN from the attachment.
    remove_subnet_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .add_subnet_arns = "AddSubnetArns",
        .attachment_id = "AttachmentId",
        .options = "Options",
        .remove_subnet_arns = "RemoveSubnetArns",
    };
};

pub const UpdateVpcAttachmentOutput = struct {
    /// Describes the updated VPC attachment.
    vpc_attachment: ?VpcAttachment = null,

    pub const json_field_names = .{
        .vpc_attachment = "VpcAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVpcAttachmentInput, options: CallOptions) !UpdateVpcAttachmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVpcAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/vpc-attachments/");
    try path_buf.appendSlice(allocator, input.attachment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.add_subnet_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AddSubnetArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Options\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_subnet_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RemoveSubnetArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVpcAttachmentOutput {
    const result: UpdateVpcAttachmentOutput = try aws.json.parseJsonObject(
        UpdateVpcAttachmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
