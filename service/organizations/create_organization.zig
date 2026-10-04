const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrganizationFeatureSet = @import("organization_feature_set.zig").OrganizationFeatureSet;
const Organization = @import("organization.zig").Organization;

pub const CreateOrganizationInput = struct {
    /// Specifies the feature set supported by the new organization. Each feature
    /// set supports
    /// different levels of functionality.
    ///
    /// * `CONSOLIDATED_BILLING`: All member accounts have their bills
    /// consolidated to and paid by the management account. For more information,
    /// see
    /// [Consolidated
    /// billing](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#feature-set-cb-only) in the
    /// *Organizations User Guide*.
    ///
    /// The consolidated billing feature subset isn't available for organizations in
    /// the Amazon Web Services GovCloud (US) Region.
    ///
    /// * `ALL`: In addition to all the features supported by the
    /// consolidated billing feature set, the management account can also apply any
    /// policy type to any member account in the organization. For more information,
    /// see
    /// [All
    /// features](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#feature-set-all) in the *Organizations User Guide*.
    feature_set: ?OrganizationFeatureSet = null,

    pub const json_field_names = .{
        .feature_set = "FeatureSet",
    };
};

pub const CreateOrganizationOutput = struct {
    /// A structure that contains details about the newly created organization.
    organization: ?Organization = null,

    pub const json_field_names = .{
        .organization = "Organization",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOrganizationInput, options: CallOptions) !CreateOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.CreateOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOrganizationOutput, body, allocator);
}
