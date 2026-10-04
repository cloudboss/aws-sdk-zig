const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TargetResourceConfiguration = @import("target_resource_configuration.zig").TargetResourceConfiguration;
const BlueGreenDeployment = @import("blue_green_deployment.zig").BlueGreenDeployment;
const serde = @import("serde.zig");

pub const CreateBlueGreenDeploymentInput = struct {
    /// The name of the blue/green deployment.
    ///
    /// Constraints:
    ///
    /// * Can't be the same as an existing blue/green deployment name in the same
    ///   account and Amazon Web Services Region.
    blue_green_deployment_name: []const u8,

    /// The Amazon Resource Name (ARN) of the source production database.
    ///
    /// Specify the database that you want to clone. The blue/green deployment
    /// creates this database in the green environment. You can make updates to the
    /// database in the green environment, such as an engine version upgrade. When
    /// you are ready, you can switch the database in the green environment to be
    /// the production database.
    source: []const u8,

    /// Tags to assign to the blue/green deployment.
    tags: ?[]const Tag = null,

    /// The amount of storage in gibibytes (GiB) to allocate for the green DB
    /// instance. You can choose to increase or decrease the allocated storage on
    /// the green DB instance.
    ///
    /// This setting doesn't apply to Amazon Aurora blue/green deployments.
    target_allocated_storage: ?i32 = null,

    /// The DB cluster parameter group associated with the Aurora DB cluster in the
    /// green environment.
    ///
    /// To test parameter changes, specify a DB cluster parameter group that is
    /// different from the one associated with the source DB cluster.
    target_db_cluster_parameter_group_name: ?[]const u8 = null,

    /// Specify the DB instance class for the databases in the green environment.
    ///
    /// This parameter only applies to RDS DB instances, because DB instances within
    /// an Aurora DB cluster can have multiple different instance classes. If you're
    /// creating a blue/green deployment from an Aurora DB cluster, don't specify
    /// this parameter. After the green environment is created, you can individually
    /// modify the instance classes of the DB instances within the green DB cluster.
    target_db_instance_class: ?[]const u8 = null,

    /// The DB parameter group associated with the DB instance in the green
    /// environment.
    ///
    /// To test parameter changes, specify a DB parameter group that is different
    /// from the one associated with the source DB instance.
    target_db_parameter_group_name: ?[]const u8 = null,

    /// The engine version of the database in the green environment.
    ///
    /// Specify the engine version to upgrade to in the green environment.
    target_engine_version: ?[]const u8 = null,

    /// The amount of Provisioned IOPS (input/output operations per second) to
    /// allocate for the green DB instance. For information about valid IOPS values,
    /// see [Amazon RDS DB instance
    /// storage](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html) in the *Amazon RDS User Guide*.
    ///
    /// This setting doesn't apply to Amazon Aurora blue/green deployments.
    target_iops: ?i32 = null,

    /// Specifies resource-level configuration overrides for the green environment.
    ///
    /// Each entry identifies a resource in the blue environment by its Amazon
    /// Resource Name (ARN). It defines the desired configuration for the
    /// corresponding resource in the green environment. Any resource that you don't
    /// include in this parameter retains the same configuration as its counterpart
    /// in the blue environment.
    ///
    /// Use this parameter when one or more resources in the green environment
    /// require a different configuration than what they have in the blue
    /// environment.
    ///
    /// Constraints:
    ///
    /// * You can't specify the same `SourceArn` in more than one entry.
    target_resource_configurations: ?[]const TargetResourceConfiguration = null,

    /// The storage throughput value for the green DB instance.
    ///
    /// This setting applies only to the `gp3` storage type.
    ///
    /// This setting doesn't apply to Amazon Aurora blue/green deployments.
    target_storage_throughput: ?i32 = null,

    /// The storage type to associate with the green DB instance.
    ///
    /// Valid Values: `gp2 | gp3 | io1 | io2`
    ///
    /// This setting doesn't apply to Amazon Aurora blue/green deployments.
    target_storage_type: ?[]const u8 = null,

    /// Whether to upgrade the storage file system configuration on the green
    /// database. This option migrates the green DB instance from the older 32-bit
    /// file system to the preferred configuration. For more information, see
    /// [Upgrading the storage file system for a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.UpgradeFileSystem).
    upgrade_target_storage_config: ?bool = null,
};

pub const CreateBlueGreenDeploymentOutput = struct {
    blue_green_deployment: ?BlueGreenDeployment = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBlueGreenDeploymentInput, options: CallOptions) !CreateBlueGreenDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBlueGreenDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateBlueGreenDeployment&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&BlueGreenDeploymentName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.blue_green_deployment_name);
    try body_buf.appendSlice(allocator, "&Source=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source);
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
    if (input.target_allocated_storage) |v| {
        try body_buf.appendSlice(allocator, "&TargetAllocatedStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.target_db_cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&TargetDBClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_db_instance_class) |v| {
        try body_buf.appendSlice(allocator, "&TargetDBInstanceClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_db_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&TargetDBParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_engine_version) |v| {
        try body_buf.appendSlice(allocator, "&TargetEngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_iops) |v| {
        try body_buf.appendSlice(allocator, "&TargetIops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.target_resource_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetResourceConfigurations.TargetResourceConfiguration.{d}.SourceArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.source_arn);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.target_kms_key_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetResourceConfigurations.TargetResourceConfiguration.{d}.TargetKmsKeyId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.target_storage_throughput) |v| {
        try body_buf.appendSlice(allocator, "&TargetStorageThroughput=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.target_storage_type) |v| {
        try body_buf.appendSlice(allocator, "&TargetStorageType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.upgrade_target_storage_config) |v| {
        try body_buf.appendSlice(allocator, "&UpgradeTargetStorageConfig=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBlueGreenDeploymentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateBlueGreenDeploymentResult")) break;
            },
            else => {},
        }
    }

    var result: CreateBlueGreenDeploymentOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BlueGreenDeployment")) {
                    result.blue_green_deployment = try serde.deserializeBlueGreenDeployment(allocator, &reader);
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
