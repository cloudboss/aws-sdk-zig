const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MpaOperation = @import("mpa_operation.zig").MpaOperation;
const MpaTeamAssociation = @import("mpa_team_association.zig").MpaTeamAssociation;

pub const AssociateMpaTeamInput = struct {
    /// The protected operation to associate with the MPA team. Currently, the only
    /// supported value is `IMPORT_ROOT_PUBLIC_KEY_CERTIFICATE`.
    action: MpaOperation,

    /// The ARN of the MPA team to associate with the protected operation.
    mpa_team_arn: []const u8,

    /// The comment from the requester explaining the reason for the association.
    ///
    /// Don't include personal, confidential or sensitive information in this field.
    /// This field may be displayed in plaintext in CloudTrail logs and other
    /// output.
    requester_comment: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .mpa_team_arn = "MpaTeamArn",
        .requester_comment = "RequesterComment",
    };
};

pub const AssociateMpaTeamOutput = struct {
    /// The details of the MPA team association.
    mpa_team_association: ?MpaTeamAssociation = null,

    pub const json_field_names = .{
        .mpa_team_association = "MpaTeamAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateMpaTeamInput, options: CallOptions) !AssociateMpaTeamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "payment-cryptography", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateMpaTeamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlplane.payment-cryptography", "Payment Cryptography", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PaymentCryptographyControlPlane.AssociateMpaTeam");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateMpaTeamOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(AssociateMpaTeamOutput, body, allocator);
}
