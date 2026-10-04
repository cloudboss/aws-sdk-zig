const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBInstance = @import("db_instance.zig").DBInstance;
const serde = @import("serde.zig");

pub const ModifyDBInstanceInput = struct {
    /// Specifies whether the modifications in this request and any pending
    /// modifications are
    /// asynchronously applied as soon as possible, regardless of the
    /// `PreferredMaintenanceWindow` setting for the instance.
    ///
    /// If this parameter is set to `false`, changes to the instance are
    /// applied during the next maintenance window. Some parameter changes can cause
    /// an outage
    /// and are applied on the next reboot.
    ///
    /// Default: `false`
    apply_immediately: ?bool = null,

    /// This parameter does not apply to Amazon DocumentDB. Amazon DocumentDB does
    /// not perform minor version upgrades regardless of the value set.
    auto_minor_version_upgrade: ?bool = null,

    /// Indicates the certificate that needs to be associated with the instance.
    ca_certificate_identifier: ?[]const u8 = null,

    /// Specifies whether the DB instance is restarted when you rotate your
    /// SSL/TLS certificate.
    ///
    /// By default, the DB instance is restarted when you rotate your SSL/TLS
    /// certificate. The certificate
    /// is not updated until the DB instance is restarted.
    ///
    /// Set this parameter only if you are *not* using SSL/TLS to connect to the DB
    /// instance.
    ///
    /// If you are using SSL/TLS to connect to the DB instance, see [Updating Your
    /// Amazon DocumentDB TLS
    /// Certificates](https://docs.aws.amazon.com/documentdb/latest/developerguide/ca_cert_rotation.html) and
    /// [
    /// Encrypting Data in
    /// Transit](https://docs.aws.amazon.com/documentdb/latest/developerguide/security.encryption.ssl.html) in the *Amazon DocumentDB Developer
    /// Guide*.
    certificate_rotation_restart: ?bool = null,

    /// A value that indicates whether to copy all tags from the DB instance to
    /// snapshots of the DB instance. By default, tags are not copied.
    copy_tags_to_snapshot: ?bool = null,

    /// The new compute and memory capacity of the instance; for example,
    /// `db.r5.large`. Not all instance classes are available in all Amazon Web
    /// Services Regions.
    ///
    /// If you modify the instance class, an outage occurs during the change. The
    /// change is
    /// applied during the next maintenance window, unless `ApplyImmediately` is
    /// specified as `true` for this request.
    ///
    /// Default: Uses existing setting.
    db_instance_class: ?[]const u8 = null,

    /// The instance identifier. This value is stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing `DBInstance`.
    db_instance_identifier: []const u8,

    /// A value that indicates whether to enable Performance Insights for the DB
    /// Instance. For
    /// more information, see [Using Amazon
    /// Performance
    /// Insights](https://docs.aws.amazon.com/documentdb/latest/developerguide/performance-insights.html).
    enable_performance_insights: ?bool = null,

    /// The new instance identifier for the instance when renaming an instance. When
    /// you change the instance identifier, an instance reboot occurs immediately if
    /// you set `Apply Immediately` to `true`. It occurs during the next maintenance
    /// window if you set `Apply Immediately` to `false`. This value is stored as a
    /// lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    ///
    /// * The first character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `mydbinstance`
    new_db_instance_identifier: ?[]const u8 = null,

    /// The KMS key identifier for encryption of Performance Insights
    /// data.
    ///
    /// The KMS key identifier is the key ARN, key ID, alias ARN, or alias name
    /// for the KMS key.
    ///
    /// If you do not specify a value for PerformanceInsightsKMSKeyId, then Amazon
    /// DocumentDB uses your
    /// default KMS key. There is a default KMS key for your
    /// Amazon Web Services account. Your Amazon Web Services account has a
    /// different
    /// default KMS key for each Amazon Web Services region.
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// The weekly time range (in UTC) during which system maintenance can occur,
    /// which might
    /// result in an outage. Changing this parameter doesn't result in an outage
    /// except in the
    /// following situation, and the change is asynchronously applied as soon as
    /// possible. If
    /// there are pending actions that cause a reboot, and the maintenance window is
    /// changed to
    /// include the current time, changing this parameter causes a reboot of the
    /// instance. If
    /// you are moving this window to the current time, there must be at least 30
    /// minutes
    /// between the current time and end of the window to ensure that pending
    /// changes are
    /// applied.
    ///
    /// Default: Uses existing setting.
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// Valid days: Mon, Tue, Wed, Thu, Fri, Sat, Sun
    ///
    /// Constraints: Must be at least 30 minutes.
    preferred_maintenance_window: ?[]const u8 = null,

    /// A value that specifies the order in which an Amazon DocumentDB replica is
    /// promoted to the primary instance after a failure of the existing primary
    /// instance.
    ///
    /// Default: 1
    ///
    /// Valid values: 0-15
    promotion_tier: ?i32 = null,
};

pub const ModifyDBInstanceOutput = struct {
    db_instance: ?DBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBInstanceInput, options: CallOptions) !ModifyDBInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "DocDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBInstance&Version=2014-10-31");
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ca_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CACertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.certificate_rotation_restart) |v| {
        try body_buf.appendSlice(allocator, "&CertificateRotationRestart=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.db_instance_class) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.enable_performance_insights) |v| {
        try body_buf.appendSlice(allocator, "&EnablePerformanceInsights=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.new_db_instance_identifier) |v| {
        try body_buf.appendSlice(allocator, "&NewDBInstanceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.performance_insights_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&PerformanceInsightsKMSKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.promotion_tier) |v| {
        try body_buf.appendSlice(allocator, "&PromotionTier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBInstanceResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBInstanceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstance")) {
                    result.db_instance = try serde.deserializeDBInstance(allocator, &reader);
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
