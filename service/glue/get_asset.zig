const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetFormEntry = @import("asset_form_entry.zig").AssetFormEntry;
const IterableFormEntry = @import("iterable_form_entry.zig").IterableFormEntry;

pub const GetAssetInput = struct {
    /// The unique identifier of the asset to retrieve.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetAssetOutput = struct {
    /// The identifier of the asset type for this asset.
    asset_type_id: []const u8,

    /// Additional attachments on the asset for more context, keyed by attachment
    /// name.
    attachments: ?[]const aws.map.MapEntry(AssetFormEntry) = null,

    /// The timestamp at which the asset was created.
    created_at: ?i64 = null,

    /// The description of the asset.
    description: ?[]const u8 = null,

    /// The forms on the asset, keyed by form name.
    forms: ?[]const aws.map.MapEntry(AssetFormEntry) = null,

    /// The identifiers of the glossary terms associated with the asset.
    glossary_terms: ?[]const []const u8 = null,

    /// The unique identifier of the asset.
    id: []const u8,

    /// The iterable forms available on the asset, keyed by form name (for example,
    /// `columns`). Use the form name with `ListIterableForms` or
    /// `BatchGetIterableForms` to retrieve the form's items.
    iterable_forms: ?[]const aws.map.MapEntry(IterableFormEntry) = null,

    /// The name of the asset.
    name: ?[]const u8 = null,

    /// The timestamp at which the asset was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .asset_type_id = "AssetTypeId",
        .attachments = "Attachments",
        .created_at = "CreatedAt",
        .description = "Description",
        .forms = "Forms",
        .glossary_terms = "GlossaryTerms",
        .id = "Id",
        .iterable_forms = "IterableForms",
        .name = "Name",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetInput, options: CallOptions) !GetAssetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetAsset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAssetOutput, body, allocator);
}
