const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBInstance = @import("db_instance.zig").DBInstance;
const serde = @import("serde.zig");

pub const CreateDBInstanceInput = struct {
    /// This parameter does not apply to Amazon DocumentDB. Amazon DocumentDB does
    /// not perform minor version upgrades regardless of the value set.
    ///
    /// Default: `false`
    auto_minor_version_upgrade: ?bool = null,

    /// The Amazon EC2 Availability Zone that the instance is created in.
    ///
    /// Default: A random, system-chosen Availability Zone in the endpoint's Amazon
    /// Web Services Region.
    ///
    /// Example: `us-east-1d`
    availability_zone: ?[]const u8 = null,

    /// The CA certificate identifier to use for the DB instance's server
    /// certificate.
    ///
    /// For more information, see [Updating Your Amazon DocumentDB TLS
    /// Certificates](https://docs.aws.amazon.com/documentdb/latest/developerguide/ca_cert_rotation.html) and
    /// [
    /// Encrypting Data in
    /// Transit](https://docs.aws.amazon.com/documentdb/latest/developerguide/security.encryption.ssl.html) in the *Amazon DocumentDB Developer
    /// Guide*.
    ca_certificate_identifier: ?[]const u8 = null,

    /// A value that indicates whether to copy tags from the DB instance to
    /// snapshots of the DB instance. By default, tags are not copied.
    copy_tags_to_snapshot: ?bool = null,

    /// The identifier of the cluster that the instance will belong to.
    db_cluster_identifier: []const u8,

    /// The compute and memory capacity of the instance; for example,
    /// `db.r5.large`.
    db_instance_class: []const u8,

    /// The instance identifier. This parameter is stored as a lowercase string.
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
    db_instance_identifier: []const u8,

    /// A value that indicates whether to enable Performance Insights for the DB
    /// Instance. For
    /// more information, see [Using Amazon
    /// Performance
    /// Insights](https://docs.aws.amazon.com/documentdb/latest/developerguide/performance-insights.html).
    enable_performance_insights: ?bool = null,

    /// The name of the database engine to be used for this instance.
    ///
    /// Valid value: `docdb`
    engine: []const u8,

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

    /// The time range each week during which system maintenance can occur, in
    /// Universal
    /// Coordinated Time (UTC).
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// The default is a 30-minute window selected at random from an 8-hour block of
    /// time for
    /// each Amazon Web Services Region, occurring on a random day of the week.
    ///
    /// Valid days: Mon, Tue, Wed, Thu, Fri, Sat, Sun
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// A value that specifies the order in which an Amazon DocumentDB replica is
    /// promoted to the
    /// primary instance after a failure of the existing primary instance.
    ///
    /// Default: 1
    ///
    /// Valid values: 0-15
    promotion_tier: ?i32 = null,

    /// The tags to be assigned to the instance. You can assign up to
    /// 10 tags to an instance.
    tags: ?[]const Tag = null,
};

pub const CreateDBInstanceOutput = struct {
    db_instance: ?DBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBInstanceInput, options: CallOptions) !CreateDBInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "DocDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBInstance&Version=2014-10-31");
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ca_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&CACertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.copy_tags_to_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&CopyTagsToSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    try body_buf.appendSlice(allocator, "&DBInstanceClass=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_class);
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.enable_performance_insights) |v| {
        try body_buf.appendSlice(allocator, "&EnablePerformanceInsights=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBInstanceResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBInstanceOutput = .{};
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
