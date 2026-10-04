const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionCategory = @import("action_category.zig").ActionCategory;
const ActionConfigurationProperty = @import("action_configuration_property.zig").ActionConfigurationProperty;
const ArtifactDetails = @import("artifact_details.zig").ArtifactDetails;
const ActionTypeSettings = @import("action_type_settings.zig").ActionTypeSettings;
const Tag = @import("tag.zig").Tag;
const ActionType = @import("action_type.zig").ActionType;

pub const CreateCustomActionTypeInput = struct {
    /// The category of the custom action, such as a build action or a test
    /// action.
    category: ActionCategory,

    /// The configuration properties for the custom action.
    ///
    /// You can refer to a name in the configuration properties of the custom action
    /// within the URL templates by following the format of {Config:name}, as long
    /// as the
    /// configuration property is both required and not secret. For more
    /// information, see
    /// [Create a
    /// Custom Action for a
    /// Pipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/how-to-create-custom-action.html).
    configuration_properties: ?[]const ActionConfigurationProperty = null,

    /// The details of the input artifact for the action, such as its commit ID.
    input_artifact_details: ArtifactDetails,

    /// The details of the output artifact of the action, such as its commit ID.
    output_artifact_details: ArtifactDetails,

    /// The provider of the service used in the custom action, such as
    /// CodeDeploy.
    provider: []const u8,

    /// URLs that provide users information about this custom action.
    settings: ?ActionTypeSettings = null,

    /// The tags for the custom action.
    tags: ?[]const Tag = null,

    /// The version identifier of the custom action.
    version: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .configuration_properties = "configurationProperties",
        .input_artifact_details = "inputArtifactDetails",
        .output_artifact_details = "outputArtifactDetails",
        .provider = "provider",
        .settings = "settings",
        .tags = "tags",
        .version = "version",
    };
};

pub const CreateCustomActionTypeOutput = struct {
    /// Returns information about the details of an action type.
    action_type: ?ActionType = null,

    /// Specifies the tags applied to the custom action.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .action_type = "actionType",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomActionTypeInput, options: CallOptions) !CreateCustomActionTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomActionTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.CreateCustomActionType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomActionTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCustomActionTypeOutput, body, allocator);
}
