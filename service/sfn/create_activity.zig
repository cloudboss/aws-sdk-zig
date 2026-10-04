const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const Tag = @import("tag.zig").Tag;

pub const CreateActivityInput = struct {
    /// Settings to configure server-side encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the activity to create. This name must be unique for your Amazon
    /// Web Services account and region for 90 days. For more information,
    /// see [
    /// Limits Related to State Machine
    /// Executions](https://docs.aws.amazon.com/step-functions/latest/dg/limits.html#service-limits-state-machine-executions) in the *Step Functions Developer Guide*.
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

    /// The list of tags to add to a resource.
    ///
    /// An array of key-value pairs. For more information, see [Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Amazon Web Services Billing and Cost Management User
    /// Guide*, and [Controlling Access Using IAM
    /// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_iam-tags.html).
    ///
    /// Tags may only contain Unicode letters, digits, white space, or these
    /// symbols: `_ . : / = + - @`.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .encryption_configuration = "encryptionConfiguration",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateActivityOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the created activity.
    activity_arn: []const u8,

    /// The date the activity is created.
    creation_date: i64,

    pub const json_field_names = .{
        .activity_arn = "activityArn",
        .creation_date = "creationDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateActivityInput, options: CallOptions) !CreateActivityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateActivityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.CreateActivity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateActivityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateActivityOutput, body, allocator);
}
