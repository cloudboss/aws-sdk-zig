const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OciIamRole = @import("oci_iam_role.zig").OciIamRole;
const OciIdentityDomain = @import("oci_identity_domain.zig").OciIdentityDomain;
const OciOnboardingStatus = @import("oci_onboarding_status.zig").OciOnboardingStatus;
const SubscriptionError = @import("subscription_error.zig").SubscriptionError;

pub const GetOciOnboardingStatusInput = struct {};

pub const GetOciOnboardingStatusOutput = struct {
    /// The list of Amazon Web Services Identity and Access Management (IAM) service
    /// roles used for Autonomous Database integration with Oracle Cloud
    /// Infrastructure (OCI).
    autonomous_database_oci_integration_iam_roles: ?[]const OciIamRole = null,

    /// The existing OCI tenancy activation link for your Amazon Web Services
    /// account.
    existing_tenancy_activation_link: ?[]const u8 = null,

    /// The unique identifier of the Oracle Cloud Infrastructure (OCI) compartment
    /// that is linked to your Amazon Web Services account.
    linked_oci_compartment_id: ?[]const u8 = null,

    /// The unique identifier of the Oracle Cloud Infrastructure (OCI) tenancy that
    /// is linked to your Amazon Web Services account.
    linked_oci_tenancy_id: ?[]const u8 = null,

    /// A new OCI tenancy activation link for your Amazon Web Services account.
    new_tenancy_activation_link: ?[]const u8 = null,

    /// The Oracle Cloud Infrastructure (OCI) identity domain information in the
    /// onboarding status response.
    oci_identity_domain: ?OciIdentityDomain = null,

    status: ?OciOnboardingStatus = null,

    /// The list of errors that occurred during the subscription process for your
    /// Amazon Web Services account, if any.
    subscription_errors: ?[]const SubscriptionError = null,

    pub const json_field_names = .{
        .autonomous_database_oci_integration_iam_roles = "autonomousDatabaseOciIntegrationIamRoles",
        .existing_tenancy_activation_link = "existingTenancyActivationLink",
        .linked_oci_compartment_id = "linkedOciCompartmentId",
        .linked_oci_tenancy_id = "linkedOciTenancyId",
        .new_tenancy_activation_link = "newTenancyActivationLink",
        .oci_identity_domain = "ociIdentityDomain",
        .status = "status",
        .subscription_errors = "subscriptionErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOciOnboardingStatusInput, options: CallOptions) !GetOciOnboardingStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOciOnboardingStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.GetOciOnboardingStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOciOnboardingStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOciOnboardingStatusOutput, body, allocator);
}
