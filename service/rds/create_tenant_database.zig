const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TenantDatabase = @import("tenant_database.zig").TenantDatabase;
const serde = @import("serde.zig");

pub const CreateTenantDatabaseInput = struct {
    /// The character set for your tenant database. If you don't specify a value,
    /// the character set name defaults to `AL32UTF8`.
    character_set_name: ?[]const u8 = null,

    /// The user-supplied DB instance identifier. RDS creates your tenant database
    /// in this DB instance. This parameter isn't case-sensitive.
    db_instance_identifier: []const u8,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*
    ///
    /// Constraints:
    ///
    /// * Can't manage the master user password with Amazon Web Services Secrets
    ///   Manager if `MasterUserPassword` is specified.
    manage_master_user_password: ?bool = null,

    /// The name for the master user account in your tenant database. RDS creates
    /// this user account in the tenant database and grants privileges to the master
    /// user. This parameter is case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 16 letters, numbers, or underscores.
    /// * First character must be a letter.
    /// * Can't be a reserved word for the chosen database engine.
    master_username: []const u8,

    /// The password for the master user in your tenant database.
    ///
    /// Constraints:
    ///
    /// * Must be 8 to 30 characters.
    /// * Can include any printable ASCII character except forward slash (`/`),
    ///   double quote (`"`), at symbol (`@`), ampersand (`&`), or single quote
    ///   (`'`).
    /// * Can't be specified when `ManageMasterUserPassword` is enabled.
    master_user_password: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier to encrypt a secret that is
    /// automatically generated and managed in Amazon Web Services Secrets Manager.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB instance.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key. To use a KMS key in a different Amazon
    /// Web Services account, specify the key ARN or alias ARN.
    ///
    /// If you don't specify `MasterUserSecretKmsKeyId`, then the
    /// `aws/secretsmanager` KMS key is used to encrypt the secret. If the secret is
    /// in a different Amazon Web Services account, then you can't use the
    /// `aws/secretsmanager` KMS key to encrypt the secret, and you must use a
    /// customer managed KMS key.
    ///
    /// There is a default KMS key for your Amazon Web Services account. Your Amazon
    /// Web Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    master_user_secret_kms_key_id: ?[]const u8 = null,

    /// The `NCHAR` value for the tenant database.
    nchar_character_set_name: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    /// The user-supplied name of the tenant database that you want to create in
    /// your DB instance. This parameter has the same constraints as `DBName` in
    /// `CreateDBInstance`.
    tenant_db_name: []const u8,
};

pub const CreateTenantDatabaseOutput = struct {
    tenant_database: ?TenantDatabase = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTenantDatabaseInput, options: CallOptions) !CreateTenantDatabaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTenantDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateTenantDatabase&Version=2014-10-31");
    if (input.character_set_name) |v| {
        try body_buf.appendSlice(allocator, "&CharacterSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&MasterUsername=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.master_username);
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_secret_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.nchar_character_set_name) |v| {
        try body_buf.appendSlice(allocator, "&NcharCharacterSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TenantDBName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.tenant_db_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTenantDatabaseOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTenantDatabaseResult")) break;
            },
            else => {},
        }
    }

    var result: CreateTenantDatabaseOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TenantDatabase")) {
                    result.tenant_database = try serde.deserializeTenantDatabase(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
