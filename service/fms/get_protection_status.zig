const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityServiceType = @import("security_service_type.zig").SecurityServiceType;

pub const GetProtectionStatusInput = struct {
    /// The end of the time period to query for the attacks. This is a `timestamp`
    /// type. The
    /// request syntax listing indicates a `number` type because the default used by
    /// Firewall Manager is Unix time in seconds. However, any valid `timestamp`
    /// format is
    /// allowed.
    end_time: ?i64 = null,

    /// Specifies the number of objects that you want Firewall Manager to return for
    /// this request. If you have more
    /// objects than the number that you specify for `MaxResults`, the response
    /// includes a
    /// `NextToken` value that you can use to get another batch of objects.
    max_results: ?i32 = null,

    /// The Amazon Web Services account that is in scope of the policy that you want
    /// to get the details
    /// for.
    member_account_id: ?[]const u8 = null,

    /// If you specify a value for `MaxResults` and you have more objects than the
    /// number that you specify
    /// for `MaxResults`, Firewall Manager returns a `NextToken` value in the
    /// response, which you can use to retrieve another group of
    /// objects. For the second and subsequent `GetProtectionStatus` requests,
    /// specify the value of `NextToken`
    /// from the previous response to get information about another batch of
    /// objects.
    next_token: ?[]const u8 = null,

    /// The ID of the policy for which you want to get the attack information.
    policy_id: []const u8,

    /// The start of the time period to query for the attacks. This is a `timestamp`
    /// type. The
    /// request syntax listing indicates a `number` type because the default used by
    /// Firewall Manager is Unix time in seconds. However, any valid `timestamp`
    /// format is
    /// allowed.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .member_account_id = "MemberAccountId",
        .next_token = "NextToken",
        .policy_id = "PolicyId",
        .start_time = "StartTime",
    };
};

pub const GetProtectionStatusOutput = struct {
    /// The ID of the Firewall Manager administrator account for this policy.
    admin_account_id: ?[]const u8 = null,

    /// Details about the attack, including the following:
    ///
    /// * Attack type
    ///
    /// * Account ID
    ///
    /// * ARN of the resource attacked
    ///
    /// * Start time of the attack
    ///
    /// * End time of the attack (ongoing attacks will not have an end time)
    ///
    /// The details are in JSON format.
    data: ?[]const u8 = null,

    /// If you have more objects than the number that you specified for `MaxResults`
    /// in the request,
    /// the response includes a `NextToken` value. To list more objects, submit
    /// another
    /// `GetProtectionStatus` request, and specify the `NextToken` value from the
    /// response in the
    /// `NextToken` value in the next request.
    ///
    /// Amazon Web Services SDKs provide auto-pagination that identify `NextToken`
    /// in a response and
    /// make subsequent request calls automatically on your behalf. However, this
    /// feature is not
    /// supported by `GetProtectionStatus`. You must submit subsequent requests with
    /// `NextToken` using your own processes.
    next_token: ?[]const u8 = null,

    /// The service type that is protected by the policy. Currently, this is always
    /// `SHIELD_ADVANCED`.
    service_type: ?SecurityServiceType = null,

    pub const json_field_names = .{
        .admin_account_id = "AdminAccountId",
        .data = "Data",
        .next_token = "NextToken",
        .service_type = "ServiceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProtectionStatusInput, options: CallOptions) !GetProtectionStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProtectionStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.GetProtectionStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProtectionStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetProtectionStatusOutput, body, allocator);
}
