const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentDeploymentUpdateType = @import("component_deployment_update_type.zig").ComponentDeploymentUpdateType;
const Component = @import("component.zig").Component;

pub const UpdateComponentInput = struct {
    /// The client token for the updated component.
    client_token: ?[]const u8 = null,

    /// The deployment type. It defines the mode for updating a component, as
    /// follows:
    ///
    /// `NONE`
    ///
    /// In this mode, a deployment *doesn't* occur. Only the requested metadata
    /// parameters are updated. You can only specify
    /// `description` in this mode.
    ///
    /// `CURRENT_VERSION`
    ///
    /// In this mode, the component is deployed and updated with the new
    /// `serviceSpec`, `templateSource`, and/or `type`
    /// that you provide. Only requested parameters are updated.
    deployment_type: ComponentDeploymentUpdateType,

    /// An optional customer-provided description of the component.
    description: ?[]const u8 = null,

    /// The name of the component to update.
    name: []const u8,

    /// The name of the service instance that you want to attach this component to.
    /// Don't specify to keep the component's current service instance attachment.
    /// Specify an empty string to detach the component from the service instance
    /// it's attached to. Specify non-empty values for both
    /// `serviceInstanceName` and `serviceName` or for neither of them.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service that `serviceInstanceName` is associated with. Don't
    /// specify to keep the component's current service instance
    /// attachment. Specify an empty string to detach the component from the service
    /// instance it's attached to. Specify non-empty values for both
    /// `serviceInstanceName` and `serviceName` or for neither of them.
    service_name: ?[]const u8 = null,

    /// The service spec that you want the component to use to access service
    /// inputs. Set this only when the component is attached to a service
    /// instance.
    service_spec: ?[]const u8 = null,

    /// A path to the Infrastructure as Code (IaC) file describing infrastructure
    /// that a custom component provisions.
    ///
    /// Components support a single IaC file, even if you use Terraform as your
    /// template language.
    template_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .deployment_type = "deploymentType",
        .description = "description",
        .name = "name",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .service_spec = "serviceSpec",
        .template_file = "templateFile",
    };
};

pub const UpdateComponentOutput = struct {
    /// The detailed data of the updated component.
    component: ?Component = null,

    pub const json_field_names = .{
        .component = "component",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComponentInput, options: CallOptions) !UpdateComponentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComponentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateComponentOutput, body, allocator);
}
