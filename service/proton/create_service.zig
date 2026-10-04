const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Service = @import("service.zig").Service;

pub const CreateServiceInput = struct {
    /// The name of the code repository branch that holds the code that's deployed
    /// in Proton.
    /// *Don't* include this parameter if your service template
    /// *doesn't* include a service pipeline.
    branch_name: ?[]const u8 = null,

    /// A description of the Proton service.
    description: ?[]const u8 = null,

    /// The service name.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the repository connection. For more
    /// information, see
    /// [Setting up an
    /// AWS CodeStar
    /// connection](https://docs.aws.amazon.com/proton/latest/userguide/setting-up-for-service.html#setting-up-vcontrol) in the *Proton User Guide*.
    /// *Don't* include this parameter if your service template
    /// *doesn't* include a service pipeline.
    repository_connection_arn: ?[]const u8 = null,

    /// The ID of the code repository. *Don't* include this parameter if your
    /// service template *doesn't* include a service pipeline.
    repository_id: ?[]const u8 = null,

    /// A link to a spec file that provides inputs as defined in the service
    /// template bundle
    /// schema file. The spec file is in YAML format. *Don’t* include pipeline
    /// inputs in the spec if your service template *doesn’t* include a service
    /// pipeline. For more information, see [Create a
    /// service](https://docs.aws.amazon.com/proton/latest/userguide/ag-create-svc.html) in the
    /// *Proton User Guide*.
    spec: []const u8,

    /// An optional list of metadata items that you can associate with the Proton
    /// service. A tag is
    /// a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    /// The major version of the service template that was used to create the
    /// service.
    template_major_version: []const u8,

    /// The minor version of the service template that was used to create the
    /// service.
    template_minor_version: ?[]const u8 = null,

    /// The name of the service template that's used to create the service.
    template_name: []const u8,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .description = "description",
        .name = "name",
        .repository_connection_arn = "repositoryConnectionArn",
        .repository_id = "repositoryId",
        .spec = "spec",
        .tags = "tags",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};

pub const CreateServiceOutput = struct {
    /// The service detail data that's returned by Proton.
    service: ?Service = null,

    pub const json_field_names = .{
        .service = "service",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceInput, options: CallOptions) !CreateServiceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateServiceOutput, body, allocator);
}
