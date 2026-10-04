const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerType = @import("customer_type.zig").CustomerType;
const IncidentResponder = @import("incident_responder.zig").IncidentResponder;
const MembershipAccountsConfigurations = @import("membership_accounts_configurations.zig").MembershipAccountsConfigurations;
const MembershipStatus = @import("membership_status.zig").MembershipStatus;
const OptInFeature = @import("opt_in_feature.zig").OptInFeature;
const AwsRegion = @import("aws_region.zig").AwsRegion;

pub const GetMembershipInput = struct {
    /// Required element for GetMembership to identify the membership ID to query.
    membership_id: []const u8,

    pub const json_field_names = .{
        .membership_id = "membershipId",
    };
};

pub const GetMembershipOutput = struct {
    /// Response element for GetMembership that provides the account configured to
    /// manage the membership.
    account_id: ?[]const u8 = null,

    /// Response element for GetMembership that provides the configured membership
    /// type. Options include ` Standalone | Organizations`.
    customer_type: ?CustomerType = null,

    /// Response element for GetMembership that provides the configured membership
    /// incident response team members.
    incident_response_team: ?[]const IncidentResponder = null,

    /// The `membershipAccountsConfigurations` field contains the configuration
    /// details for member accounts within the Amazon Web Services Organizations
    /// membership structure.
    ///
    /// This field returns a structure containing information about:
    ///
    /// * Account configurations for member accounts
    /// * Membership settings and preferences
    /// * Account-level permissions and roles
    membership_accounts_configurations: ?MembershipAccountsConfigurations = null,

    /// Response element for GetMembership that provides the configured membership
    /// activation timestamp.
    membership_activation_timestamp: ?i64 = null,

    /// Response element for GetMembership that provides the membership ARN.
    membership_arn: ?[]const u8 = null,

    /// Response element for GetMembership that provides the configured membership
    /// name deactivation timestamp.
    membership_deactivation_timestamp: ?i64 = null,

    /// Response element for GetMembership that provides the queried membership ID.
    membership_id: []const u8,

    /// Response element for GetMembership that provides the configured membership
    /// name.
    membership_name: ?[]const u8 = null,

    /// Response element for GetMembership that provides the current membership
    /// status.
    membership_status: ?MembershipStatus = null,

    /// Response element for GetMembership that provides the number of accounts in
    /// the membership.
    number_of_accounts_covered: ?i64 = null,

    /// Response element for GetMembership that provides the if opt-in features have
    /// been enabled.
    opt_in_features: ?[]const OptInFeature = null,

    /// Response element for GetMembership that provides the region configured to
    /// manage the membership.
    region: ?AwsRegion = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .customer_type = "customerType",
        .incident_response_team = "incidentResponseTeam",
        .membership_accounts_configurations = "membershipAccountsConfigurations",
        .membership_activation_timestamp = "membershipActivationTimestamp",
        .membership_arn = "membershipArn",
        .membership_deactivation_timestamp = "membershipDeactivationTimestamp",
        .membership_id = "membershipId",
        .membership_name = "membershipName",
        .membership_status = "membershipStatus",
        .number_of_accounts_covered = "numberOfAccountsCovered",
        .opt_in_features = "optInFeatures",
        .region = "region",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMembershipInput, options: CallOptions) !GetMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/membership/");
    try path_buf.appendSlice(allocator, input.membership_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMembershipOutput {
    var result: GetMembershipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMembershipOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
