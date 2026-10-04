const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateSoftwareToImageBuilderInput = struct {
    /// The name of the target image builder instance.
    image_builder_name: []const u8,

    /// The list of license included applications to associate with the image
    /// builder.
    ///
    /// Possible values include the following:
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Project_2021_Professional_32Bit
    ///
    /// * Microsoft_Project_2021_Professional_64Bit
    ///
    /// * Microsoft_Project_2024_Professional_32Bit
    ///
    /// * Microsoft_Project_2024_Professional_64Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Project_2021_Standard_32Bit
    ///
    /// * Microsoft_Project_2021_Standard_64Bit
    ///
    /// * Microsoft_Project_2024_Standard_32Bit
    ///
    /// * Microsoft_Project_2024_Standard_64Bit
    software_names: []const []const u8,

    pub const json_field_names = .{
        .image_builder_name = "ImageBuilderName",
        .software_names = "SoftwareNames",
    };
};

pub const AssociateSoftwareToImageBuilderOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateSoftwareToImageBuilderInput, options: CallOptions) !AssociateSoftwareToImageBuilderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateSoftwareToImageBuilderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.AssociateSoftwareToImageBuilder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateSoftwareToImageBuilderOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
