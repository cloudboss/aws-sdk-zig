const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const IamRegistrationResponse = @import("iam_registration_response.zig").IamRegistrationResponse;
const TimestreamRegistrationResponse = @import("timestream_registration_response.zig").TimestreamRegistrationResponse;

pub const GetRegisterAccountStatusInput = struct {};

pub const GetRegisterAccountStatusOutput = struct {
    /// The status of registering your account and resources. The status can be one
    /// of:
    ///
    /// * `REGISTRATION_SUCCESS` - The Amazon Web Services resource is successfully
    /// registered.
    ///
    /// * `REGISTRATION_PENDING` - Amazon Web Services IoT FleetWise is processing
    ///   the registration
    /// request. This process takes approximately five minutes to complete.
    ///
    /// * `REGISTRATION_FAILURE` - Amazon Web Services IoT FleetWise can't register
    ///   the AWS resource.
    /// Try again later.
    account_status: RegistrationStatus,

    /// The time the account was registered, in seconds since epoch (January 1, 1970
    /// at
    /// midnight UTC time).
    creation_time: i64,

    /// The unique ID of the Amazon Web Services account, provided at account
    /// creation.
    customer_account_id: []const u8,

    /// Information about the registered IAM resources or errors, if any.
    iam_registration_response: ?IamRegistrationResponse = null,

    /// The time this registration was last updated, in seconds since epoch (January
    /// 1, 1970
    /// at midnight UTC time).
    last_modification_time: i64,

    /// Information about the registered Amazon Timestream resources or errors, if
    /// any.
    timestream_registration_response: ?TimestreamRegistrationResponse = null,

    pub const json_field_names = .{
        .account_status = "accountStatus",
        .creation_time = "creationTime",
        .customer_account_id = "customerAccountId",
        .iam_registration_response = "iamRegistrationResponse",
        .last_modification_time = "lastModificationTime",
        .timestream_registration_response = "timestreamRegistrationResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegisterAccountStatusInput, options: CallOptions) !GetRegisterAccountStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegisterAccountStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetRegisterAccountStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegisterAccountStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRegisterAccountStatusOutput, body, allocator);
}
