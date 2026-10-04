const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConstraintSummary = @import("constraint_summary.zig").ConstraintSummary;
const ProvisioningArtifactOutput = @import("provisioning_artifact_output.zig").ProvisioningArtifactOutput;
const ProvisioningArtifactParameter = @import("provisioning_artifact_parameter.zig").ProvisioningArtifactParameter;
const ProvisioningArtifactPreferences = @import("provisioning_artifact_preferences.zig").ProvisioningArtifactPreferences;
const TagOptionSummary = @import("tag_option_summary.zig").TagOptionSummary;
const UsageInstruction = @import("usage_instruction.zig").UsageInstruction;

pub const DescribeProvisioningParametersInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The path identifier of the product. This value is optional if the product
    /// has a default path, and required if the product has more than one path.
    /// To list the paths for a product, use ListLaunchPaths. You must provide the
    /// name or ID, but not both.
    path_id: ?[]const u8 = null,

    /// The name of the path. You must provide the name or ID, but not both.
    path_name: ?[]const u8 = null,

    /// The product identifier. You must provide the product name or ID, but not
    /// both.
    product_id: ?[]const u8 = null,

    /// The name of the product. You must provide the name or ID, but not both.
    product_name: ?[]const u8 = null,

    /// The identifier of the provisioning artifact. You must provide the name or
    /// ID, but not both.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The name of the provisioning artifact. You must provide the name or ID, but
    /// not both.
    provisioning_artifact_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .path_id = "PathId",
        .path_name = "PathName",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_artifact_name = "ProvisioningArtifactName",
    };
};

pub const DescribeProvisioningParametersOutput = struct {
    /// Information about the constraints used to provision the product.
    constraint_summaries: ?[]const ConstraintSummary = null,

    /// A list of the keys and descriptions of the outputs. These outputs can be
    /// referenced from a provisioned product launched from this provisioning
    /// artifact.
    provisioning_artifact_output_keys: ?[]const ProvisioningArtifactOutput = null,

    /// The output of the provisioning artifact.
    provisioning_artifact_outputs: ?[]const ProvisioningArtifactOutput = null,

    /// Information about the parameters used to provision the product.
    provisioning_artifact_parameters: ?[]const ProvisioningArtifactParameter = null,

    /// An object that contains information about preferences, such as Regions and
    /// accounts, for the provisioning artifact.
    provisioning_artifact_preferences: ?ProvisioningArtifactPreferences = null,

    /// Information about the TagOptions associated with the resource.
    tag_options: ?[]const TagOptionSummary = null,

    /// Any additional metadata specifically related to the provisioning of the
    /// product. For
    /// example, see the `Version` field of the CloudFormation template.
    usage_instructions: ?[]const UsageInstruction = null,

    pub const json_field_names = .{
        .constraint_summaries = "ConstraintSummaries",
        .provisioning_artifact_output_keys = "ProvisioningArtifactOutputKeys",
        .provisioning_artifact_outputs = "ProvisioningArtifactOutputs",
        .provisioning_artifact_parameters = "ProvisioningArtifactParameters",
        .provisioning_artifact_preferences = "ProvisioningArtifactPreferences",
        .tag_options = "TagOptions",
        .usage_instructions = "UsageInstructions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProvisioningParametersInput, options: CallOptions) !DescribeProvisioningParametersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProvisioningParametersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribeProvisioningParameters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProvisioningParametersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProvisioningParametersOutput, body, allocator);
}
