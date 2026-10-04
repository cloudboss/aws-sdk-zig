const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WalletPasswordSource = @import("wallet_password_source.zig").WalletPasswordSource;
const WalletPasswordSourceConfigurationInput = @import("wallet_password_source_configuration_input.zig").WalletPasswordSourceConfigurationInput;
const WalletType = @import("wallet_type.zig").WalletType;

pub const CreateAutonomousDatabaseWalletInput = struct {
    /// The unique identifier of the Autonomous Database to create a wallet for.
    autonomous_database_id: []const u8,

    /// A client-provided token to ensure the idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The password to encrypt the keys inside the wallet.
    password: ?[]const u8 = null,

    /// The source of the password for encrypting the wallet. When set to
    /// `CUSTOMER_MANAGED_AWS_SECRET`, the password is retrieved from an Amazon Web
    /// Services Secrets Manager secret.
    password_source: ?WalletPasswordSource = null,

    /// The configuration of the password source for the Autonomous Database wallet.
    password_source_configuration: ?WalletPasswordSourceConfigurationInput = null,

    /// The type of wallet to create, either a regional wallet or an instance
    /// wallet.
    wallet_type: ?WalletType = null,

    pub const json_field_names = .{
        .autonomous_database_id = "autonomousDatabaseId",
        .client_token = "clientToken",
        .password = "password",
        .password_source = "passwordSource",
        .password_source_configuration = "passwordSourceConfiguration",
        .wallet_type = "walletType",
    };
};

pub const CreateAutonomousDatabaseWalletOutput = struct {
    /// The generated wallet file for the Autonomous Database, returned as a
    /// compressed archive.
    autonomous_database_wallet_file: []const u8,

    pub const json_field_names = .{
        .autonomous_database_wallet_file = "autonomousDatabaseWalletFile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutonomousDatabaseWalletInput, options: CallOptions) !CreateAutonomousDatabaseWalletOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutonomousDatabaseWalletInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateAutonomousDatabaseWallet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutonomousDatabaseWalletOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAutonomousDatabaseWalletOutput, body, allocator);
}
