const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IamResources = @import("iam_resources.zig").IamResources;
const TimestreamResources = @import("timestream_resources.zig").TimestreamResources;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

pub const RegisterAccountInput = struct {
    /// The IAM resource that allows Amazon Web Services IoT FleetWise to send data
    /// to Amazon Timestream.
    iam_resources: ?IamResources = null,

    timestream_resources: ?TimestreamResources = null,

    pub const json_field_names = .{
        .iam_resources = "iamResources",
        .timestream_resources = "timestreamResources",
    };
};

pub const RegisterAccountOutput = struct {
    /// The time the account was registered, in seconds since epoch (January 1, 1970
    /// at
    /// midnight UTC time).
    creation_time: i64,

    /// The registered IAM resource that allows Amazon Web Services IoT FleetWise to
    /// send data to Amazon Timestream.
    iam_resources: ?IamResources = null,

    /// The time this registration was last updated, in seconds since epoch (January
    /// 1, 1970
    /// at midnight UTC time).
    last_modification_time: i64,

    /// The status of registering your Amazon Web Services account, IAM role, and
    /// Timestream resources.
    register_account_status: RegistrationStatus,

    timestream_resources: ?TimestreamResources = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .iam_resources = "iamResources",
        .last_modification_time = "lastModificationTime",
        .register_account_status = "registerAccountStatus",
        .timestream_resources = "timestreamResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterAccountInput, options: CallOptions) !RegisterAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.RegisterAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterAccountOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RegisterAccountOutput, body, allocator);
}
