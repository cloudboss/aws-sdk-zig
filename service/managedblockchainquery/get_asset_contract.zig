const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContractIdentifier = @import("contract_identifier.zig").ContractIdentifier;
const ContractMetadata = @import("contract_metadata.zig").ContractMetadata;
const QueryTokenStandard = @import("query_token_standard.zig").QueryTokenStandard;

pub const GetAssetContractInput = struct {
    /// Contains the blockchain address and network information about the contract.
    contract_identifier: ContractIdentifier,

    pub const json_field_names = .{
        .contract_identifier = "contractIdentifier",
    };
};

pub const GetAssetContractOutput = struct {
    /// Contains the blockchain address and network information about the contract.
    contract_identifier: ?ContractIdentifier = null,

    /// The address of the deployer of contract.
    deployer_address: []const u8,

    metadata: ?ContractMetadata = null,

    /// The token standard of the contract requested.
    token_standard: QueryTokenStandard,

    pub const json_field_names = .{
        .contract_identifier = "contractIdentifier",
        .deployer_address = "deployerAddress",
        .metadata = "metadata",
        .token_standard = "tokenStandard",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetContractInput, options: CallOptions) !GetAssetContractOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "managedblockchain-query", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssetContractInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain-query", "ManagedBlockchain Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-asset-contract";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contractIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.contract_identifier), input.contract_identifier, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssetContractOutput {
    const result: GetAssetContractOutput = try aws.json.parseJsonObject(
        GetAssetContractOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
