const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyComplianceDetail = @import("policy_compliance_detail.zig").PolicyComplianceDetail;

pub const GetComplianceDetailInput = struct {
    /// The Amazon Web Services account that owns the resources that you want to get
    /// the details for.
    member_account: []const u8,

    /// The ID of the policy that you want to get the details for. `PolicyId` is
    /// returned by `PutPolicy` and by `ListPolicies`.
    policy_id: []const u8,

    pub const json_field_names = .{
        .member_account = "MemberAccount",
        .policy_id = "PolicyId",
    };
};

pub const GetComplianceDetailOutput = struct {
    /// Information about the resources and the policy that you specified in the
    /// `GetComplianceDetail` request.
    policy_compliance_detail: ?PolicyComplianceDetail = null,

    pub const json_field_names = .{
        .policy_compliance_detail = "PolicyComplianceDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComplianceDetailInput, options: CallOptions) !GetComplianceDetailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComplianceDetailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.GetComplianceDetail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComplianceDetailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetComplianceDetailOutput, body, allocator);
}
