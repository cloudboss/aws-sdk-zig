const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RevisionLocation = @import("revision_location.zig").RevisionLocation;
const RevisionInfo = @import("revision_info.zig").RevisionInfo;

pub const BatchGetApplicationRevisionsInput = struct {
    /// The name of an CodeDeploy application about which to get revision
    /// information.
    application_name: []const u8,

    /// An array of `RevisionLocation` objects that specify information to get
    /// about the application revisions, including type and location. The maximum
    /// number of
    /// `RevisionLocation` objects you can specify is 25.
    revisions: []const RevisionLocation,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .revisions = "revisions",
    };
};

pub const BatchGetApplicationRevisionsOutput = struct {
    /// The name of the application that corresponds to the revisions.
    application_name: ?[]const u8 = null,

    /// Information about errors that might have occurred during the API call.
    error_message: ?[]const u8 = null,

    /// Additional information about the revisions, including the type and location.
    revisions: ?[]const RevisionInfo = null,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .error_message = "errorMessage",
        .revisions = "revisions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetApplicationRevisionsInput, options: CallOptions) !BatchGetApplicationRevisionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetApplicationRevisionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.BatchGetApplicationRevisions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetApplicationRevisionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetApplicationRevisionsOutput, body, allocator);
}
