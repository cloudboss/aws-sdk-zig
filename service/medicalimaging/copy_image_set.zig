const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CopyImageSetInformation = @import("copy_image_set_information.zig").CopyImageSetInformation;
const CopyDestinationImageSetProperties = @import("copy_destination_image_set_properties.zig").CopyDestinationImageSetProperties;
const CopySourceImageSetProperties = @import("copy_source_image_set_properties.zig").CopySourceImageSetProperties;

pub const CopyImageSetInput = struct {
    /// Copy image set information.
    copy_image_set_information: CopyImageSetInformation,

    /// The data store identifier.
    datastore_id: []const u8,

    /// Providing this parameter will force completion of the `CopyImageSet`
    /// operation, even if there are inconsistent Patient, Study, and/or Series
    /// level metadata elements between the `sourceImageSet` and
    /// `destinationImageSet`.
    force: ?bool = null,

    /// Providing this parameter will configure the `CopyImageSet` operation to
    /// promote the given image set to the primary DICOM hierarchy. If successful, a
    /// new primary image set ID will be returned as the destination image set.
    promote_to_primary: ?bool = null,

    /// The source image set identifier.
    source_image_set_id: []const u8,

    pub const json_field_names = .{
        .copy_image_set_information = "copyImageSetInformation",
        .datastore_id = "datastoreId",
        .force = "force",
        .promote_to_primary = "promoteToPrimary",
        .source_image_set_id = "sourceImageSetId",
    };
};

pub const CopyImageSetOutput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// The properties of the destination image set.
    destination_image_set_properties: ?CopyDestinationImageSetProperties = null,

    /// The properties of the source image set.
    source_image_set_properties: ?CopySourceImageSetProperties = null,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .destination_image_set_properties = "destinationImageSetProperties",
        .source_image_set_properties = "sourceImageSetProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyImageSetInput, options: CallOptions) !CopyImageSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medical-imaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyImageSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datastore/");
    try path_buf.appendSlice(allocator, input.datastore_id);
    try path_buf.appendSlice(allocator, "/imageSet/");
    try path_buf.appendSlice(allocator, input.source_image_set_id);
    try path_buf.appendSlice(allocator, "/copyImageSet");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.force) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "force=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.promote_to_primary) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "promoteToPrimary=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.copy_image_set_information, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyImageSetOutput {
    var result: CopyImageSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CopyImageSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
