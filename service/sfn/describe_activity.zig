const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

pub const DescribeActivityInput = struct {
    /// The Amazon Resource Name (ARN) of the activity to describe.
    activity_arn: []const u8,

    pub const json_field_names = .{
        .activity_arn = "activityArn",
    };
};

pub const DescribeActivityOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the activity.
    activity_arn: []const u8,

    /// The date the activity is created.
    creation_date: i64,

    /// Settings for configured server-side encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the activity.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: []const u8,

    pub const json_field_names = .{
        .activity_arn = "activityArn",
        .creation_date = "creationDate",
        .encryption_configuration = "encryptionConfiguration",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeActivityInput, options: CallOptions) !DescribeActivityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeActivityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.DescribeActivity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeActivityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeActivityOutput, body, allocator);
}
