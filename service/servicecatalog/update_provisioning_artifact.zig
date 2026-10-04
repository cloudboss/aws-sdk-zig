const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningArtifactGuidance = @import("provisioning_artifact_guidance.zig").ProvisioningArtifactGuidance;
const ProvisioningArtifactDetail = @import("provisioning_artifact_detail.zig").ProvisioningArtifactDetail;
const Status = @import("status.zig").Status;

pub const UpdateProvisioningArtifactInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// Indicates whether the product version is active.
    ///
    /// Inactive provisioning artifacts are invisible to end users. End users cannot
    /// launch or update a provisioned product from an inactive provisioning
    /// artifact.
    active: ?bool = null,

    /// The updated description of the provisioning artifact.
    description: ?[]const u8 = null,

    /// Information set by the administrator to provide guidance to end users about
    /// which provisioning artifacts to use.
    ///
    /// The `DEFAULT` value indicates that the product version is active.
    ///
    /// The administrator can set the guidance to `DEPRECATED` to inform
    /// users that the product version is deprecated. Users are able to make updates
    /// to a provisioned product
    /// of a deprecated version but cannot launch new provisioned products using a
    /// deprecated version.
    guidance: ?ProvisioningArtifactGuidance = null,

    /// The updated name of the provisioning artifact.
    name: ?[]const u8 = null,

    /// The product identifier.
    product_id: []const u8,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .active = "Active",
        .description = "Description",
        .guidance = "Guidance",
        .name = "Name",
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
    };
};

pub const UpdateProvisioningArtifactOutput = struct {
    /// The URL of the CloudFormation template in Amazon S3 or GitHub in JSON
    /// format.
    info: ?[]const aws.map.StringMapEntry = null,

    /// Information about the provisioning artifact.
    provisioning_artifact_detail: ?ProvisioningArtifactDetail = null,

    /// The status of the current request.
    status: ?Status = null,

    pub const json_field_names = .{
        .info = "Info",
        .provisioning_artifact_detail = "ProvisioningArtifactDetail",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProvisioningArtifactInput, options: CallOptions) !UpdateProvisioningArtifactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProvisioningArtifactInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.UpdateProvisioningArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProvisioningArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProvisioningArtifactOutput, body, allocator);
}
