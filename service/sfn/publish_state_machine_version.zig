const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PublishStateMachineVersionInput = struct {
    /// An optional description of the state machine version.
    description: ?[]const u8 = null,

    /// Only publish the state machine version if the current state machine's
    /// revision ID matches the specified ID.
    ///
    /// Use this option to avoid publishing a version if the state machine changed
    /// since you last
    /// updated it. If the specified revision ID doesn't match the state machine's
    /// current revision
    /// ID, the API returns `ConflictException`.
    ///
    /// To specify an initial revision ID for a state machine with no revision ID
    /// assigned,
    /// specify the string `INITIAL` for the `revisionId` parameter. For
    /// example, you can specify a `revisionID` of `INITIAL` when you create a
    /// state machine using the CreateStateMachine API action.
    revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the state machine.
    state_machine_arn: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .revision_id = "revisionId",
        .state_machine_arn = "stateMachineArn",
    };
};

pub const PublishStateMachineVersionOutput = struct {
    /// The date the version was created.
    creation_date: i64,

    /// The Amazon Resource Name (ARN) (ARN) that identifies the state machine
    /// version.
    state_machine_version_arn: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .state_machine_version_arn = "stateMachineVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishStateMachineVersionInput, options: CallOptions) !PublishStateMachineVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishStateMachineVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.PublishStateMachineVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishStateMachineVersionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PublishStateMachineVersionOutput, body, allocator);
}
