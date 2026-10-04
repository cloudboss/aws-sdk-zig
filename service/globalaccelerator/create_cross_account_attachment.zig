const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Resource = @import("resource.zig").Resource;
const Tag = @import("tag.zig").Tag;
const Attachment = @import("attachment.zig").Attachment;

pub const CreateCrossAccountAttachmentInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency—that is, the
    /// uniqueness—of the request.
    idempotency_token: []const u8,

    /// The name of the cross-account attachment.
    name: []const u8,

    /// The principals to include in the cross-account attachment. A principal can
    /// be an Amazon Web Services account
    /// number or the Amazon Resource Name (ARN) for an accelerator.
    principals: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) for the resources to include in the
    /// cross-account attachment. A resource can
    /// be any supported Amazon Web Services resource type for Global Accelerator or
    /// a CIDR range for a
    /// bring your own IP address (BYOIP) address pool.
    resources: ?[]const Resource = null,

    /// Add tags for a cross-account attachment.
    ///
    /// For more information, see [Tagging
    /// in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/tagging-in-global-accelerator.html) in the *Global Accelerator Developer Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .idempotency_token = "IdempotencyToken",
        .name = "Name",
        .principals = "Principals",
        .resources = "Resources",
        .tags = "Tags",
    };
};

pub const CreateCrossAccountAttachmentOutput = struct {
    /// Information about the cross-account attachment.
    cross_account_attachment: ?Attachment = null,

    pub const json_field_names = .{
        .cross_account_attachment = "CrossAccountAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCrossAccountAttachmentInput, options: CallOptions) !CreateCrossAccountAttachmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "globalaccelerator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCrossAccountAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.CreateCrossAccountAttachment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCrossAccountAttachmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCrossAccountAttachmentOutput, body, allocator);
}
