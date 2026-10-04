const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomModelDeploymentStatus = @import("custom_model_deployment_status.zig").CustomModelDeploymentStatus;
const CustomModelDeploymentUpdateDetails = @import("custom_model_deployment_update_details.zig").CustomModelDeploymentUpdateDetails;

pub const GetCustomModelDeploymentInput = struct {
    /// The Amazon Resource Name (ARN) or name of the custom model deployment to
    /// retrieve information about.
    custom_model_deployment_identifier: []const u8,

    pub const json_field_names = .{
        .custom_model_deployment_identifier = "customModelDeploymentIdentifier",
    };
};

pub const GetCustomModelDeploymentOutput = struct {
    /// The date and time when the custom model deployment was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the custom model deployment.
    custom_model_deployment_arn: []const u8,

    /// The description of the custom model deployment.
    description: ?[]const u8 = null,

    /// If the deployment status is `FAILED`, this field contains a message
    /// describing the failure reason.
    failure_message: ?[]const u8 = null,

    /// The date and time when the custom model deployment was last updated.
    last_updated_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the custom model associated with this
    /// deployment.
    model_arn: []const u8,

    /// The name of the custom model deployment.
    model_deployment_name: []const u8,

    /// The status of the custom model deployment. Possible values are:
    ///
    /// * `CREATING` - The deployment is being set up and prepared for inference.
    /// * `ACTIVE` - The deployment is ready and available for inference requests.
    /// * `FAILED` - The deployment failed to be created or became unavailable.
    status: CustomModelDeploymentStatus,

    /// Details about any pending or completed updates to the custom model
    /// deployment, including the new model ARN and update status.
    update_details: ?CustomModelDeploymentUpdateDetails = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .custom_model_deployment_arn = "customModelDeploymentArn",
        .description = "description",
        .failure_message = "failureMessage",
        .last_updated_at = "lastUpdatedAt",
        .model_arn = "modelArn",
        .model_deployment_name = "modelDeploymentName",
        .status = "status",
        .update_details = "updateDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomModelDeploymentInput, options: CallOptions) !GetCustomModelDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomModelDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/model-customization/custom-model-deployments/");
    try path_buf.appendSlice(allocator, input.custom_model_deployment_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomModelDeploymentOutput {
    var result: GetCustomModelDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCustomModelDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
