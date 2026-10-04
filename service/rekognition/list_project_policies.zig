const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectPolicy = @import("project_policy.zig").ProjectPolicy;

pub const ListProjectPoliciesInput = struct {
    /// The maximum number of results to return per paginated call. The largest
    /// value you can
    /// specify is 5. If you specify a value greater than 5, a ValidationException
    /// error
    /// occurs. The default value is 5.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more results to
    /// retrieve),
    /// Amazon Rekognition Custom Labels returns a pagination token in the response.
    /// You can use this pagination token
    /// to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The ARN of the project for which you want to list the project policies.
    project_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .project_arn = "ProjectArn",
    };
};

pub const ListProjectPoliciesOutput = struct {
    /// If the response is truncated, Amazon Rekognition returns this token that you
    /// can use in the
    /// subsequent request to retrieve the next set of project policies.
    next_token: ?[]const u8 = null,

    /// A list of project policies attached to the project.
    project_policies: ?[]const ProjectPolicy = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .project_policies = "ProjectPolicies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProjectPoliciesInput, options: CallOptions) !ListProjectPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProjectPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.ListProjectPolicies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProjectPoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListProjectPoliciesOutput, body, allocator);
}
