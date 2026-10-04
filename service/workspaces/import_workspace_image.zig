const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Application = @import("application.zig").Application;
const WorkspaceImageIngestionProcess = @import("workspace_image_ingestion_process.zig").WorkspaceImageIngestionProcess;
const Tag = @import("tag.zig").Tag;

pub const ImportWorkspaceImageInput = struct {
    /// If specified, the version of Microsoft Office to subscribe to. Valid only
    /// for Windows 10 and 11
    /// BYOL images. For more information about subscribing to Office for BYOL
    /// images, see [ Bring
    /// Your Own Windows Desktop
    /// Licenses](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    ///
    /// * Although this parameter is an array, only one item is allowed at this
    /// time.
    ///
    /// * During the image import process, non-GPU DCV (formerly WSP) WorkSpaces
    ///   with Windows 11 support
    /// only `Microsoft_Office_2019`. GPU DCV (formerly WSP) WorkSpaces with Windows
    /// 11 do not
    /// support Office installation.
    applications: ?[]const Application = null,

    /// The identifier of the EC2 image.
    ec_2_image_id: []const u8,

    /// The description of the WorkSpace image.
    image_description: []const u8,

    /// The name of the WorkSpace image.
    image_name: []const u8,

    /// The ingestion process to be used when importing the image, depending on
    /// which protocol
    /// you want to use for your BYOL Workspace image, either PCoIP, WSP, or
    /// bring your own protocol (BYOP). To use DCV, specify a value that ends in
    /// `_WSP`. To use PCoIP, specify a value that does not end in `_WSP`.
    /// To use BYOP, specify a value that ends in `_BYOP`.
    ///
    /// For non-GPU-enabled bundles (bundles other than Graphics or GraphicsPro),
    /// specify
    /// `BYOL_REGULAR`, `BYOL_REGULAR_WSP`, or `BYOL_REGULAR_BYOP`,
    /// depending on the protocol.
    ///
    /// The `BYOL_REGULAR_BYOP` and `BYOL_GRAPHICS_G4DN_BYOP` values
    /// are only supported by Amazon WorkSpaces Core. Contact your account team to
    /// be
    /// allow-listed to use these values. For more information, see [Amazon
    /// WorkSpaces Core](http://aws.amazon.com/workspaces/core/).
    ingestion_process: WorkspaceImageIngestionProcess,

    /// The tags. Each WorkSpaces resource can have a maximum of 50 tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .applications = "Applications",
        .ec_2_image_id = "Ec2ImageId",
        .image_description = "ImageDescription",
        .image_name = "ImageName",
        .ingestion_process = "IngestionProcess",
        .tags = "Tags",
    };
};

pub const ImportWorkspaceImageOutput = struct {
    /// The identifier of the WorkSpace image.
    image_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "ImageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportWorkspaceImageInput, options: CallOptions) !ImportWorkspaceImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportWorkspaceImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.ImportWorkspaceImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportWorkspaceImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportWorkspaceImageOutput, body, allocator);
}
