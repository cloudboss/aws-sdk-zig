const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataProviderSettings = @import("data_provider_settings.zig").DataProviderSettings;
const Tag = @import("tag.zig").Tag;
const DataProvider = @import("data_provider.zig").DataProvider;

pub const CreateDataProviderInput = struct {
    /// A user-friendly name for the data provider.
    data_provider_name: ?[]const u8 = null,

    /// A user-friendly description of the data provider.
    description: ?[]const u8 = null,

    /// The type of database engine for the data provider.
    ///
    /// Valid values: `aurora`, `aurora-postgresql`, `db2`,
    /// `db2-zos`, `docdb`, `mariadb`, `mongodb`,
    /// `mysql`, `oracle`, `postgres`, `redshift`,
    /// `sqlserver`, and `sybase`. A value of `aurora` represents
    /// Amazon Aurora MySQL-Compatible Edition.
    engine: []const u8,

    /// The settings in JSON format for a data provider.
    settings: DataProviderSettings,

    /// One or more tags to be assigned to the data provider.
    tags: ?[]const Tag = null,

    /// Indicates whether the data provider is virtual.
    virtual: ?bool = null,

    pub const json_field_names = .{
        .data_provider_name = "DataProviderName",
        .description = "Description",
        .engine = "Engine",
        .settings = "Settings",
        .tags = "Tags",
        .virtual = "Virtual",
    };
};

pub const CreateDataProviderOutput = struct {
    /// The data provider that was created.
    data_provider: ?DataProvider = null,

    pub const json_field_names = .{
        .data_provider = "DataProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataProviderInput, options: CallOptions) !CreateDataProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataProviderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateDataProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataProviderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataProviderOutput, body, allocator);
}
