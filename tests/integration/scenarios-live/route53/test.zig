const std = @import("std");
const aws = @import("aws");
const route53 = @import("route53");
const ec2 = @import("ec2");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_r53_client: ?route53.Client = null;
var shared_ec2_client: ?ec2.Client = null;
var shared_cfg: ?aws.Config = null;

var shared_zone_id_buf: [64]u8 = undefined;
var shared_zone_id: []const u8 = "";
var shared_vpc_id_buf: [64]u8 = undefined;
var shared_vpc_id: []const u8 = "";
var shared_zone_name_buf: [128]u8 = undefined;
var shared_zone_name: []const u8 = "";
var shared_caller_ref_buf: [32]u8 = undefined;
var shared_caller_ref: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    shared_cfg = try aws.Config.load(allocator, .{});
    shared_r53_client = route53.Client.init(allocator, &shared_cfg.?);
    shared_ec2_client = ec2.Client.init(allocator, &shared_cfg.?);

    const ts = std.time.timestamp();

    // Create VPC for private hosted zone association.
    const vpc_result = try shared_ec2_client.?.createVpc(
        arena.allocator(),
        .{ .cidr_block = "10.88.0.0/16" },
        .{},
    );
    const vpc = vpc_result.vpc orelse return error.MissingVpc;
    const vpc_id = vpc.vpc_id orelse return error.MissingVpcId;
    @memcpy(shared_vpc_id_buf[0..vpc_id.len], vpc_id);
    shared_vpc_id = shared_vpc_id_buf[0..vpc_id.len];

    // Tag the VPC.
    _ = try shared_ec2_client.?.createTags(
        arena.allocator(),
        .{
            .resources = &.{shared_vpc_id},
            .tags = &.{
                .{
                    .key = "aws-sdk-zig-test",
                    .value = "true",
                },
                .{
                    .key = "created-by",
                    .value = "integration-test",
                },
            },
        },
        .{},
    );

    std.Thread.sleep(200 * std.time.ns_per_ms);

    // Create private hosted zone.
    shared_caller_ref = try std.fmt.bufPrint(
        &shared_caller_ref_buf,
        "{d}",
        .{ts},
    );
    shared_zone_name = try std.fmt.bufPrint(
        &shared_zone_name_buf,
        "sdk-zig-live-{d}.internal",
        .{ts},
    );

    const zone_result = try shared_r53_client.?.createHostedZone(
        arena.allocator(),
        .{
            .name = shared_zone_name,
            .caller_reference = shared_caller_ref,
            .vpc = .{
                .vpc_region = .us_east_1,
                .vpc_id = shared_vpc_id,
            },
            .hosted_zone_config = .{
                .private_zone = true,
            },
        },
        .{},
    );

    const hz = zone_result.hosted_zone orelse
        return error.MissingHostedZone;
    const full_id = hz.id;

    // Strip /hostedzone/ prefix.
    const prefix = "/hostedzone/";
    const zone_id = if (std.mem.startsWith(
        u8,
        full_id,
        prefix,
    ))
        full_id[prefix.len..]
    else
        full_id;

    @memcpy(shared_zone_id_buf[0..zone_id.len], zone_id);
    shared_zone_id = shared_zone_id_buf[0..zone_id.len];

    std.Thread.sleep(200 * std.time.ns_per_ms);

    // Tag the hosted zone.
    _ = try shared_r53_client.?.changeTagsForResource(
        arena.allocator(),
        .{
            .resource_id = shared_zone_id,
            .resource_type = .hostedzone,
            .add_tags = &.{
                .{
                    .key = "aws-sdk-zig-test",
                    .value = "true",
                },
                .{
                    .key = "created-by",
                    .value = "integration-test",
                },
            },
        },
        .{},
    );
}

test "zest.afterAll" {
    if (shared_r53_client) |*r53| {
        defer r53.deinit();

        if (shared_zone_id.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            const alloc = arena.allocator();

            // Delete all non-NS/SOA records before zone deletion.
            if (r53.listResourceRecordSets(
                alloc,
                .{ .hosted_zone_id = shared_zone_id },
                .{},
            )) |rrs| {
                if (rrs.resource_record_sets) |sets| {
                    for (sets) |rrset| {
                        const rtype = rrset.type;
                        if (rtype == .ns or rtype == .soa)
                            continue;
                        _ = r53.changeResourceRecordSets(
                            alloc,
                            .{
                                .hosted_zone_id = shared_zone_id,
                                .change_batch = .{
                                    .changes = &.{.{
                                        .action = .delete,
                                        .resource_record_set = rrset,
                                    }},
                                },
                            },
                            .{},
                        ) catch {};
                        std.Thread.sleep(
                            200 * std.time.ns_per_ms,
                        );
                    }
                }
            } else |_| {}

            std.Thread.sleep(200 * std.time.ns_per_ms);

            _ = r53.deleteHostedZone(
                alloc,
                .{ .id = shared_zone_id },
                .{},
            ) catch {};
        }
    }

    if (shared_ec2_client) |*ec2c| {
        defer ec2c.deinit();
        if (shared_vpc_id.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            _ = ec2c.deleteVpc(
                arena.allocator(),
                .{ .vpc_id = shared_vpc_id },
                .{},
            ) catch {};
        }
    }

    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "getHostedZone returns zone details" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.getHostedZone(
        arena.allocator(),
        .{ .id = shared_zone_id },
        .{},
    );

    const hz = result.hosted_zone orelse
        return error.MissingHostedZone;
    const config = hz.config orelse
        return error.MissingHostedZoneConfig;
    try std.testing.expect(config.private_zone);
}

test "listHostedZones includes created zone" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.listHostedZones(
        arena.allocator(),
        .{},
        .{},
    );

    const zones = result.hosted_zones orelse
        return error.MissingHostedZones;
    var found = false;
    for (zones) |z| {
        const prefix = "/hostedzone/";
        const zid = if (std.mem.startsWith(
            u8,
            z.id,
            prefix,
        ))
            z.id[prefix.len..]
        else
            z.id;
        if (std.mem.eql(u8, zid, shared_zone_id)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "changeResourceRecordSets creates A record" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var fqdn_buf: [256]u8 = undefined;
    const fqdn = try std.fmt.bufPrint(
        &fqdn_buf,
        "test.{s}",
        .{shared_zone_name},
    );

    _ = try client.changeResourceRecordSets(
        arena.allocator(),
        .{
            .hosted_zone_id = shared_zone_id,
            .change_batch = .{
                .changes = &.{.{
                    .action = .upsert,
                    .resource_record_set = .{
                        .name = fqdn,
                        .type = .a,
                        .ttl = 60,
                        .resource_records = &.{
                            .{ .value = "10.0.0.1" },
                        },
                    },
                }},
            },
        },
        .{},
    );

    std.Thread.sleep(200 * std.time.ns_per_ms);
}

test "listResourceRecordSets includes A record" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.listResourceRecordSets(
        arena.allocator(),
        .{ .hosted_zone_id = shared_zone_id },
        .{},
    );

    const sets = result.resource_record_sets orelse
        return error.MissingResourceRecordSets;
    var found = false;
    for (sets) |rrset| {
        if (rrset.type == .a) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "changeResourceRecordSets deletes A record" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    var fqdn_buf: [256]u8 = undefined;
    const fqdn = try std.fmt.bufPrint(
        &fqdn_buf,
        "test.{s}",
        .{shared_zone_name},
    );

    _ = try client.changeResourceRecordSets(
        arena.allocator(),
        .{
            .hosted_zone_id = shared_zone_id,
            .change_batch = .{
                .changes = &.{.{
                    .action = .delete,
                    .resource_record_set = .{
                        .name = fqdn,
                        .type = .a,
                        .ttl = 60,
                        .resource_records = &.{
                            .{ .value = "10.0.0.1" },
                        },
                    },
                }},
            },
        },
        .{},
    );

    std.Thread.sleep(200 * std.time.ns_per_ms);
}

test "listHostedZonesByName returns zone" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.listHostedZonesByName(
        arena.allocator(),
        .{ .dns_name = shared_zone_name },
        .{},
    );

    const zones = result.hosted_zones orelse
        return error.MissingHostedZones;
    var found = false;
    for (zones) |z| {
        const prefix = "/hostedzone/";
        const zid = if (std.mem.startsWith(
            u8,
            z.id,
            prefix,
        ))
            z.id[prefix.len..]
        else
            z.id;
        if (std.mem.eql(u8, zid, shared_zone_id)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "getHostedZoneCount returns positive count" {
    const client = &shared_r53_client.?;
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try client.getHostedZoneCount(
        arena.allocator(),
        .{},
        .{},
    );

    try std.testing.expect(result.hosted_zone_count > 0);
}
