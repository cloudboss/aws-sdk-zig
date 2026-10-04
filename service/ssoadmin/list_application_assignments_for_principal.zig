const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListApplicationAssignmentsFilter = @import("list_application_assignments_filter.zig").ListApplicationAssignmentsFilter;
const PrincipalType = @import("principal_type.zig").PrincipalType;
const ApplicationAssignmentForPrincipal = @import("application_assignment_for_principal.zig").ApplicationAssignmentForPrincipal;

pub const ListApplicationAssignmentsForPrincipalInput = struct {
    /// Filters the output to include only assignments associated with the
    /// application that has the specified ARN.
    filter: ?ListApplicationAssignmentsFilter = null,

    /// Specifies the instance of IAM Identity Center that contains principal and
    /// applications.
    instance_arn: []const u8,

    /// Specifies the total number of results that you want included in each
    /// response. If additional items exist beyond the number you specify, the
    /// `NextToken` response element is returned with a value (not null). Include
    /// the specified value as the `NextToken` request parameter in the next call to
    /// the operation to get the next set of results. Note that the service might
    /// return fewer results than the maximum even when there are more results
    /// available. You should check `NextToken` after every operation to ensure that
    /// you receive all of the results.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `NextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `NextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// Specifies the unique identifier of the principal for which you want to
    /// retrieve its assignments.
    principal_id: []const u8,

    /// Specifies the type of the principal for which you want to retrieve its
    /// assignments.
    principal_type: PrincipalType,

    pub const json_field_names = .{
        .filter = "Filter",
        .instance_arn = "InstanceArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
    };
};

pub const ListApplicationAssignmentsForPrincipalOutput = struct {
    /// An array list of the application assignments for the specified principal.
    application_assignments: ?[]const ApplicationAssignmentForPrincipal = null,

    /// If present, this value indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter in a subsequent call to the operation to get the next part of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_assignments = "ApplicationAssignments",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationAssignmentsForPrincipalInput, options: CallOptions) !ListApplicationAssignmentsForPrincipalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationAssignmentsForPrincipalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.ListApplicationAssignmentsForPrincipal");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationAssignmentsForPrincipalOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListApplicationAssignmentsForPrincipalOutput, body, allocator);
}
