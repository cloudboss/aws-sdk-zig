const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceActionAssociation = @import("service_action_association.zig").ServiceActionAssociation;
const FailedServiceActionAssociation = @import("failed_service_action_association.zig").FailedServiceActionAssociation;

pub const BatchDisassociateServiceActionFromProvisioningArtifactInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// One or more associations, each consisting of the Action ID, the Product ID,
    /// and the Provisioning Artifact ID.
    service_action_associations: []const ServiceActionAssociation,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .service_action_associations = "ServiceActionAssociations",
    };
};

pub const BatchDisassociateServiceActionFromProvisioningArtifactOutput = struct {
    /// An object that contains a list of errors, along with information to help you
    /// identify the self-service action.
    failed_service_action_associations: ?[]const FailedServiceActionAssociation = null,

    pub const json_field_names = .{
        .failed_service_action_associations = "FailedServiceActionAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateServiceActionFromProvisioningArtifactInput, options: CallOptions) !BatchDisassociateServiceActionFromProvisioningArtifactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateServiceActionFromProvisioningArtifactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.BatchDisassociateServiceActionFromProvisioningArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateServiceActionFromProvisioningArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDisassociateServiceActionFromProvisioningArtifactOutput, body, allocator);
}
