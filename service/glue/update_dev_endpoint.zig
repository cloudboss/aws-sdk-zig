const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DevEndpointCustomLibraries = @import("dev_endpoint_custom_libraries.zig").DevEndpointCustomLibraries;

pub const UpdateDevEndpointInput = struct {
    /// The map of arguments to add the map of arguments used to configure the
    /// `DevEndpoint`.
    ///
    /// Valid arguments are:
    ///
    /// * `"--enable-glue-datacatalog": ""`
    ///
    /// You can specify a version of Python support for development endpoints by
    /// using the `Arguments` parameter in the `CreateDevEndpoint` or
    /// `UpdateDevEndpoint` APIs. If no arguments are provided, the version defaults
    /// to Python 2.
    add_arguments: ?[]const aws.map.StringMapEntry = null,

    /// The list of public keys for the `DevEndpoint` to use.
    add_public_keys: ?[]const []const u8 = null,

    /// Custom Python or Java libraries to be loaded in the `DevEndpoint`.
    custom_libraries: ?DevEndpointCustomLibraries = null,

    /// The list of argument keys to be deleted from the map of arguments used to
    /// configure the
    /// `DevEndpoint`.
    delete_arguments: ?[]const []const u8 = null,

    /// The list of public keys to be deleted from the `DevEndpoint`.
    delete_public_keys: ?[]const []const u8 = null,

    /// The name of the `DevEndpoint` to be updated.
    endpoint_name: []const u8,

    /// The public key for the `DevEndpoint` to use.
    public_key: ?[]const u8 = null,

    /// `True` if the list of custom libraries to be loaded in the development
    /// endpoint
    /// needs to be updated, or `False` if otherwise.
    update_etl_libraries: ?bool = null,

    pub const json_field_names = .{
        .add_arguments = "AddArguments",
        .add_public_keys = "AddPublicKeys",
        .custom_libraries = "CustomLibraries",
        .delete_arguments = "DeleteArguments",
        .delete_public_keys = "DeletePublicKeys",
        .endpoint_name = "EndpointName",
        .public_key = "PublicKey",
        .update_etl_libraries = "UpdateEtlLibraries",
    };
};

pub const UpdateDevEndpointOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDevEndpointInput, options: CallOptions) !UpdateDevEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDevEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateDevEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDevEndpointOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
