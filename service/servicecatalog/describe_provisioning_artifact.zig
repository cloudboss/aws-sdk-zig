const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningArtifactDetail = @import("provisioning_artifact_detail.zig").ProvisioningArtifactDetail;
const ProvisioningArtifactParameter = @import("provisioning_artifact_parameter.zig").ProvisioningArtifactParameter;
const Status = @import("status.zig").Status;

pub const DescribeProvisioningArtifactInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// Indicates if the API call response does or does not include additional
    /// details about the provisioning parameters.
    include_provisioning_artifact_parameters: ?bool = null,

    /// The product identifier.
    product_id: ?[]const u8 = null,

    /// The product name.
    product_name: ?[]const u8 = null,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The provisioning artifact name.
    provisioning_artifact_name: ?[]const u8 = null,

    /// Indicates whether a verbose level of detail is enabled.
    verbose: ?bool = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .include_provisioning_artifact_parameters = "IncludeProvisioningArtifactParameters",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_artifact_name = "ProvisioningArtifactName",
        .verbose = "Verbose",
    };
};

pub const DescribeProvisioningArtifactOutput = struct {
    /// The URL of the CloudFormation template in Amazon S3 or GitHub in JSON
    /// format.
    info: ?[]const aws.map.StringMapEntry = null,

    /// Information about the provisioning artifact.
    provisioning_artifact_detail: ?ProvisioningArtifactDetail = null,

    /// Information about the parameters used to provision the product.
    provisioning_artifact_parameters: ?[]const ProvisioningArtifactParameter = null,

    /// The status of the current request.
    status: ?Status = null,

    pub const json_field_names = .{
        .info = "Info",
        .provisioning_artifact_detail = "ProvisioningArtifactDetail",
        .provisioning_artifact_parameters = "ProvisioningArtifactParameters",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProvisioningArtifactInput, options: CallOptions) !DescribeProvisioningArtifactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProvisioningArtifactInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribeProvisioningArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProvisioningArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProvisioningArtifactOutput, body, allocator);
}
