const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackagingType = @import("packaging_type.zig").PackagingType;
const ScriptDetails = @import("script_details.zig").ScriptDetails;
const S3Location = @import("s3_location.zig").S3Location;
const AppBlock = @import("app_block.zig").AppBlock;

pub const CreateAppBlockInput = struct {
    /// The description of the app block.
    description: ?[]const u8 = null,

    /// The display name of the app block. This is not displayed to the user.
    display_name: ?[]const u8 = null,

    /// The name of the app block.
    name: []const u8,

    /// The packaging type of the app block.
    packaging_type: ?PackagingType = null,

    /// The post setup script details of the app block. This can only be provided
    /// for the
    /// `APPSTREAM2` PackagingType.
    post_setup_script_details: ?ScriptDetails = null,

    /// The setup script details of the app block. This must be provided for the
    /// `CUSTOM` PackagingType.
    setup_script_details: ?ScriptDetails = null,

    /// The source S3 location of the app block.
    source_s3_location: S3Location,

    /// The tags assigned to the app block.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .name = "Name",
        .packaging_type = "PackagingType",
        .post_setup_script_details = "PostSetupScriptDetails",
        .setup_script_details = "SetupScriptDetails",
        .source_s3_location = "SourceS3Location",
        .tags = "Tags",
    };
};

pub const CreateAppBlockOutput = struct {
    /// The app block.
    app_block: ?AppBlock = null,

    pub const json_field_names = .{
        .app_block = "AppBlock",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAppBlockInput, options: CallOptions) !CreateAppBlockOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAppBlockInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateAppBlock");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAppBlockOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAppBlockOutput, body, allocator);
}
