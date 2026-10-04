const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Resource = @import("resource.zig").Resource;
const Attachment = @import("attachment.zig").Attachment;

pub const UpdateCrossAccountAttachmentInput = struct {
    /// The principals to add to the cross-account attachment. A principal is an
    /// account or the Amazon Resource Name (ARN)
    /// of an accelerator that the attachment gives permission to work with
    /// resources from another account. The resources
    /// are also listed in the attachment.
    ///
    /// To add more than one principal, separate the account numbers or accelerator
    /// ARNs, or both, with commas.
    add_principals: ?[]const []const u8 = null,

    /// The resources to add to the cross-account attachment. A resource listed in a
    /// cross-account attachment can be used
    /// with an accelerator by the principals that are listed in the attachment.
    ///
    /// To add more than one resource, separate the resource ARNs with commas.
    add_resources: ?[]const Resource = null,

    /// The Amazon Resource Name (ARN) of the cross-account attachment to update.
    attachment_arn: []const u8,

    /// The name of the cross-account attachment.
    name: ?[]const u8 = null,

    /// The principals to remove from the cross-account attachment. A principal is
    /// an account or the Amazon Resource Name (ARN)
    /// of an accelerator that the attachment gives permission to work with
    /// resources from another account. The resources
    /// are also listed in the attachment.
    ///
    /// To remove more than one principal, separate the account numbers or
    /// accelerator ARNs, or both, with commas.
    remove_principals: ?[]const []const u8 = null,

    /// The resources to remove from the cross-account attachment. A resource listed
    /// in a cross-account attachment can be used
    /// with an accelerator by the principals that are listed in the attachment.
    ///
    /// To remove more than one resource, separate the resource ARNs with commas.
    remove_resources: ?[]const Resource = null,

    pub const json_field_names = .{
        .add_principals = "AddPrincipals",
        .add_resources = "AddResources",
        .attachment_arn = "AttachmentArn",
        .name = "Name",
        .remove_principals = "RemovePrincipals",
        .remove_resources = "RemoveResources",
    };
};

pub const UpdateCrossAccountAttachmentOutput = struct {
    /// Information about the updated cross-account attachment.
    cross_account_attachment: ?Attachment = null,

    pub const json_field_names = .{
        .cross_account_attachment = "CrossAccountAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCrossAccountAttachmentInput, options: CallOptions) !UpdateCrossAccountAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCrossAccountAttachmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.UpdateCrossAccountAttachment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCrossAccountAttachmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCrossAccountAttachmentOutput, body, allocator);
}
