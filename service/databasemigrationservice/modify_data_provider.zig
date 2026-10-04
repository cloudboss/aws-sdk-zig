const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataProviderSettings = @import("data_provider_settings.zig").DataProviderSettings;
const DataProvider = @import("data_provider.zig").DataProvider;

pub const ModifyDataProviderInput = struct {
    /// The identifier of the data provider. Identifiers must begin with a letter
    /// and must contain only ASCII letters, digits, and hyphens. They can't end
    /// with
    /// a hyphen, or contain two consecutive hyphens.
    data_provider_identifier: []const u8,

    /// The name of the data provider.
    data_provider_name: ?[]const u8 = null,

    /// A user-friendly description of the data provider.
    description: ?[]const u8 = null,

    /// The type of database engine for the data provider. Valid values include
    /// `"aurora"`,
    /// `"aurora-postgresql"`, `"mysql"`, `"oracle"`, `"postgres"`,
    /// `"sqlserver"`, `redshift`, `mariadb`, `mongodb`, `db2`, `db2-zos`, `docdb`,
    /// and `sybase`. A value of `"aurora"` represents Amazon Aurora
    /// MySQL-Compatible Edition.
    engine: ?[]const u8 = null,

    /// If this attribute is Y, the current call to `ModifyDataProvider` replaces
    /// all
    /// existing data provider settings with the exact settings that you specify in
    /// this call. If this
    /// attribute is N, the current call to `ModifyDataProvider` does two things:
    ///
    /// * It replaces any data provider settings that already exist with new values,
    /// for settings with the same names.
    ///
    /// * It creates new data provider settings that you specify in the call,
    /// for settings with different names.
    exact_settings: ?bool = null,

    /// The settings in JSON format for a data provider.
    settings: ?DataProviderSettings = null,

    /// Indicates whether the data provider is virtual.
    virtual: ?bool = null,

    pub const json_field_names = .{
        .data_provider_identifier = "DataProviderIdentifier",
        .data_provider_name = "DataProviderName",
        .description = "Description",
        .engine = "Engine",
        .exact_settings = "ExactSettings",
        .settings = "Settings",
        .virtual = "Virtual",
    };
};

pub const ModifyDataProviderOutput = struct {
    /// The data provider that was modified.
    data_provider: ?DataProvider = null,

    pub const json_field_names = .{
        .data_provider = "DataProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDataProviderInput, options: CallOptions) !ModifyDataProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDataProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyDataProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDataProviderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyDataProviderOutput, body, allocator);
}
