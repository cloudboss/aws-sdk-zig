const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningArtifactProperties = @import("provisioning_artifact_properties.zig").ProvisioningArtifactProperties;
const ProvisioningArtifactDetail = @import("provisioning_artifact_detail.zig").ProvisioningArtifactDetail;
const Status = @import("status.zig").Status;

pub const CreateProvisioningArtifactInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The configuration for the provisioning artifact.
    parameters: ProvisioningArtifactProperties,

    /// The product identifier.
    product_id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .idempotency_token = "IdempotencyToken",
        .parameters = "Parameters",
        .product_id = "ProductId",
    };
};

pub const CreateProvisioningArtifactOutput = struct {
    /// Specify the template source with one of the following options, but not both.
    /// Keys
    /// accepted: [ `LoadTemplateFromURL`, `ImportFromPhysicalId` ].
    ///
    /// Use the URL of the CloudFormation template in Amazon S3 or GitHub in JSON
    /// format.
    ///
    /// `LoadTemplateFromURL`
    ///
    /// Use the URL of the CloudFormation template in Amazon S3 or GitHub in JSON
    /// format.
    ///
    /// `ImportFromPhysicalId`
    ///
    /// Use the physical id of the resource that contains the template; currently
    /// supports CloudFormation stack ARN.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProvisioningArtifactInput, options: CallOptions) !CreateProvisioningArtifactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProvisioningArtifactInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.CreateProvisioningArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProvisioningArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProvisioningArtifactOutput, body, allocator);
}
