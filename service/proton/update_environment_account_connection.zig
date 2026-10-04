const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentAccountConnection = @import("environment_account_connection.zig").EnvironmentAccountConnection;

pub const UpdateEnvironmentAccountConnectionInput = struct {
    /// The Amazon Resource Name (ARN) of an IAM service role in the environment
    /// account. Proton uses this role to provision infrastructure resources
    /// using CodeBuild-based provisioning in the associated environment account.
    codebuild_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM service role that Proton uses when
    /// provisioning directly defined components in the associated
    /// environment account. It determines the scope of infrastructure that a
    /// component can provision in the account.
    ///
    /// The environment account connection must have a `componentRoleArn` to allow
    /// directly defined components to be associated with any
    /// environments running in the account.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    component_role_arn: ?[]const u8 = null,

    /// The ID of the environment account connection to update.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM service role that's associated
    /// with the environment account connection to update.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .codebuild_role_arn = "codebuildRoleArn",
        .component_role_arn = "componentRoleArn",
        .id = "id",
        .role_arn = "roleArn",
    };
};

pub const UpdateEnvironmentAccountConnectionOutput = struct {
    /// The environment account connection detail data that's returned by Proton.
    environment_account_connection: ?EnvironmentAccountConnection = null,

    pub const json_field_names = .{
        .environment_account_connection = "environmentAccountConnection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentAccountConnectionInput, options: CallOptions) !UpdateEnvironmentAccountConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentAccountConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateEnvironmentAccountConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentAccountConnectionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateEnvironmentAccountConnectionOutput, body, allocator);
}
