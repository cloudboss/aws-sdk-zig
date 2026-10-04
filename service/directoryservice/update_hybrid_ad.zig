const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HybridAdministratorAccountUpdate = @import("hybrid_administrator_account_update.zig").HybridAdministratorAccountUpdate;
const HybridCustomerInstancesSettings = @import("hybrid_customer_instances_settings.zig").HybridCustomerInstancesSettings;

pub const UpdateHybridADInput = struct {
    /// The identifier of the hybrid directory to update.
    directory_id: []const u8,

    /// We create a hybrid directory administrator account when we create a hybrid
    /// directory.
    /// Use `HybridAdministratorAccountUpdate` to recover the hybrid directory
    /// administrator account if you have deleted it.
    ///
    /// To recover your hybrid directory administrator account, we need temporary
    /// access to a
    /// user in your self-managed AD with administrator permissions in the form of a
    /// secret from
    /// Amazon Web Services Secrets Manager. We use these credentials once during
    /// recovery and don't store them.
    ///
    /// If your hybrid directory administrator account exists, then you don’t need
    /// to use
    /// `HybridAdministratorAccountUpdate`, even if you have updated your
    /// self-managed AD administrator user.
    hybrid_administrator_account_update: ?HybridAdministratorAccountUpdate = null,

    /// Updates to the self-managed AD configuration, including DNS server IP
    /// addresses and
    /// Amazon Web Services System Manager managed node identifiers.
    self_managed_instances_settings: ?HybridCustomerInstancesSettings = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .hybrid_administrator_account_update = "HybridAdministratorAccountUpdate",
        .self_managed_instances_settings = "SelfManagedInstancesSettings",
    };
};

pub const UpdateHybridADOutput = struct {
    /// The identifier of the assessment performed to validate the update
    /// configuration. This
    /// assessment ensures the updated settings are compatible with your
    /// environment.
    assessment_id: ?[]const u8 = null,

    /// The identifier of the updated hybrid directory.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
        .directory_id = "DirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHybridADInput, options: CallOptions) !UpdateHybridADOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHybridADInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.UpdateHybridAD");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHybridADOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateHybridADOutput, body, allocator);
}
