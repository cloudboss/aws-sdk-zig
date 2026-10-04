const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionType = @import("action_type.zig").ActionType;

pub const CreatePermissionInput = struct {
    /// The actions that the specified Amazon Web Services service principal can
    /// use. These include `IssueCertificate`, `GetCertificate`, and
    /// `ListPermissions`.
    actions: []const ActionType,

    /// The Amazon Resource Name (ARN) of the CA that grants the permissions. You
    /// can find the ARN by calling the
    /// [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html) action. This must have the following form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `.
    certificate_authority_arn: []const u8,

    /// The Amazon Web Services service or identity that receives the permission. At
    /// this time, the only valid principal is `acm.amazonaws.com`.
    principal: []const u8,

    /// The ID of the calling account.
    source_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .principal = "Principal",
        .source_account = "SourceAccount",
    };
};

pub const CreatePermissionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePermissionInput, options: CallOptions) !CreatePermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm-pca", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm-pca", "ACM PCA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.CreatePermission");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
