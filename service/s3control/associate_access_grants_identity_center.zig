const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateAccessGrantsIdentityCenterInput = struct {
    /// The Amazon Web Services account ID of the S3 Access Grants instance.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services IAM Identity
    /// Center instance that you are associating with your S3 Access Grants
    /// instance. An IAM Identity Center instance is your corporate identity
    /// directory that you added to the IAM Identity Center. You can use the
    /// [ListInstances](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListInstances.html) API operation to retrieve a list of your Identity Center instances and their ARNs.
    identity_center_arn: []const u8,
};

pub const AssociateAccessGrantsIdentityCenterOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateAccessGrantsIdentityCenterInput, options: CallOptions) !AssociateAccessGrantsIdentityCenterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateAccessGrantsIdentityCenterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/accessgrantsinstance/identitycenter";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<AssociateAccessGrantsIdentityCenterRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<IdentityCenterArn>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.identity_center_arn);
    try body_buf.appendSlice(allocator, "</IdentityCenterArn>");
    try body_buf.appendSlice(allocator, "</AssociateAccessGrantsIdentityCenterRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateAccessGrantsIdentityCenterOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateAccessGrantsIdentityCenterOutput = .{};

    return result;
}
