const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PublicKey = @import("public_key.zig").PublicKey;

pub const ImportPublicKeyInput = struct {
    /// Name of the public key to be imported.
    name: ?[]const u8 = null,

    /// The content of the public key to be imported.
    public_key_material: []const u8,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html)
    /// in *Tagging AWS Resources and Tag Editor* for details, including
    /// restrictions that apply to tags and "Tag naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .name = "name",
        .public_key_material = "publicKeyMaterial",
        .tags = "tags",
    };
};

pub const ImportPublicKeyOutput = struct {
    /// The public key that was imported.
    public_key: ?PublicKey = null,

    pub const json_field_names = .{
        .public_key = "publicKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportPublicKeyInput, options: CallOptions) !ImportPublicKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportPublicKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ImportPublicKey";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"publicKeyMaterial\":");
    try aws.json.writeValue(@TypeOf(input.public_key_material), input.public_key_material, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportPublicKeyOutput {
    var result: ImportPublicKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ImportPublicKeyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
