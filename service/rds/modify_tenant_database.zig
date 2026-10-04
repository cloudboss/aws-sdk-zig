const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TenantDatabase = @import("tenant_database.zig").TenantDatabase;
const serde = @import("serde.zig");

pub const ModifyTenantDatabaseInput = struct {
    /// The identifier of the DB instance that contains the tenant database that you
    /// are modifying. This parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing DB instance.
    db_instance_identifier: []const u8,

    /// Specifies whether to manage the master user password with Amazon Web
    /// Services Secrets Manager.
    ///
    /// If the tenant database doesn't manage the master user password with Amazon
    /// Web Services Secrets Manager, you can turn on this management. In this case,
    /// you can't specify `MasterUserPassword`.
    ///
    /// If the tenant database already manages the master user password with Amazon
    /// Web Services Secrets Manager, and you specify that the master user password
    /// is not managed with Amazon Web Services Secrets Manager, then you must
    /// specify `MasterUserPassword`. In this case, Amazon RDS deletes the secret
    /// and uses the new password for the master user specified by
    /// `MasterUserPassword`.
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

    /// The new password for the master user of the specified tenant database in
    /// your DB instance.
    ///
    /// Amazon RDS operations never return the password, so this action provides a
    /// way to regain access to a tenant database user if the password is lost. This
    /// includes restoring privileges that might have been accidentally revoked.
    ///
    /// Constraints:
    ///
    /// * Can include any printable ASCII character except `/`, `"` (double quote),
    ///   `@`, `&` (ampersand), and `'` (single quote).
    ///
    /// Length constraints:
    ///
    /// * Must contain between 8 and 30 characters.
    master_user_password: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier to encrypt a secret that is
    /// automatically generated and managed in Amazon Web Services Secrets Manager.
    ///
    /// This setting is valid only if both of the following conditions are met:
    ///
    /// * The tenant database doesn't manage the master user password in Amazon Web
    ///   Services Secrets Manager.
    ///
    /// If the tenant database already manages the master user password in Amazon
    /// Web Services Secrets Manager, you can't change the KMS key used to encrypt
    /// the secret.
    /// * You're turning on `ManageMasterUserPassword` to manage the master user
    ///   password in Amazon Web Services Secrets Manager.
    ///
    /// If you're turning on `ManageMasterUserPassword` and don't specify
    /// `MasterUserSecretKmsKeyId`, then the `aws/secretsmanager` KMS key is used to
    /// encrypt the secret. If the secret is in a different Amazon Web Services
    /// account, then you can't use the `aws/secretsmanager` KMS key to encrypt the
    /// secret, and you must use a self-managed KMS key.
    ///
    /// The Amazon Web Services KMS key identifier is any of the following:
    ///
    /// * Key ARN
    /// * Key ID
    /// * Alias ARN
    /// * Alias name for the KMS key
    ///
    /// To use a KMS key in a different Amazon Web Services account, specify the key
    /// ARN or alias ARN.
    ///
    /// A default KMS key exists for your Amazon Web Services account. Your Amazon
    /// Web Services account has a different default KMS key for each Amazon Web
    /// Services Region.
    master_user_secret_kms_key_id: ?[]const u8 = null,

    /// The new name of the tenant database when renaming a tenant database. This
    /// parameter isn’t case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Can't be the string null or any other reserved word.
    /// * Can't be longer than 8 characters.
    new_tenant_db_name: ?[]const u8 = null,

    /// Specifies whether to rotate the secret managed by Amazon Web Services
    /// Secrets Manager for the master user password.
    ///
    /// This setting is valid only if the master user password is managed by RDS in
    /// Amazon Web Services Secrets Manager for the DB instance. The secret value
    /// contains the updated password.
    ///
    /// For more information, see [Password management with Amazon Web Services
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html) in the *Amazon RDS User Guide.*
    ///
    /// Constraints:
    ///
    /// * You must apply the change immediately when rotating the master user
    ///   password.
    rotate_master_user_password: ?bool = null,

    /// The user-supplied name of the tenant database that you want to modify. This
    /// parameter isn’t case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing tenant database.
    tenant_db_name: []const u8,
};

pub const ModifyTenantDatabaseOutput = struct {
    tenant_database: ?TenantDatabase = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyTenantDatabaseInput, options: CallOptions) !ModifyTenantDatabaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyTenantDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyTenantDatabase&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.manage_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.master_user_secret_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.new_tenant_db_name) |v| {
        try body_buf.appendSlice(allocator, "&NewTenantDBName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.rotate_master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&RotateMasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyTenantDatabaseOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyTenantDatabaseResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyTenantDatabaseOutput = .{};
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
