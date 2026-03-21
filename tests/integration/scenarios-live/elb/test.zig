const std = @import("std");
const aws = @import("aws");
const ec2 = @import("ec2");

const elb = @import("elasticloadbalancing");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: elb.Client = undefined;
var shared_ec2_client: ec2.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

var lb_name_buf: [32]u8 = undefined;
var lb_name: []const u8 = "";
var subnet_id_buf: [64]u8 = undefined;
var subnet_id: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = elb.Client.init(allocator, &shared_cfg);
    shared_ec2_client = ec2.Client.init(allocator, &shared_cfg);

    lb_name = try std.fmt.bufPrint(
        &lb_name_buf,
        "sdk-zig-live-elb-{d}",
        .{@mod(std.time.timestamp(), 100000)},
    );

    const describe_subnets_result = try shared_ec2_client.describeSubnets(
        arena.allocator(),
        .{ .filters = &.{.{
            .name = "state",
            .values = &.{"available"},
        }} },
        .{},
    );
    const subnets = describe_subnets_result.subnets orelse
        return error.MissingSubnets;
    if (subnets.len == 0) return error.MissingSubnets;
    const discovered_subnet_id = subnets[0].subnet_id orelse
        return error.MissingSubnetId;
    @memcpy(subnet_id_buf[0..discovered_subnet_id.len], discovered_subnet_id);
    subnet_id = subnet_id_buf[0..discovered_subnet_id.len];

    _ = try shared_client.createLoadBalancer(
        arena.allocator(),
        .{
            .load_balancer_name = lb_name,
            .listeners = &.{.{
                .protocol = "HTTP",
                .load_balancer_port = 80,
                .instance_protocol = "HTTP",
                .instance_port = 80,
            }},
            .subnets = &.{subnet_id},
            .scheme = "internal",
        },
        .{},
    );

    _ = try shared_client.addTags(
        arena.allocator(),
        .{
            .load_balancer_names = &.{lb_name},
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

    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    if (lb_name.len > 0) {
        _ = shared_client.deleteLoadBalancer(
            arena.allocator(),
            .{ .load_balancer_name = lb_name },
            .{},
        ) catch {};
    }
    shared_client.deinit();
    shared_ec2_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "describeLoadBalancers includes created LB" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.describeLoadBalancers(
        arena.allocator(),
        .{ .load_balancer_names = &.{lb_name} },
        .{},
    );

    const lbs = result.load_balancer_descriptions orelse
        return error.MissingLoadBalancerDescriptions;
    var found = false;
    for (lbs) |lb| {
        const name = lb.load_balancer_name orelse continue;
        if (std.mem.eql(u8, name, lb_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "describeLoadBalancerAttributes returns attributes" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result =
        try shared_client.describeLoadBalancerAttributes(
            arena.allocator(),
            .{ .load_balancer_name = lb_name },
            .{},
        );

    const attrs = result.load_balancer_attributes orelse
        return error.MissingLoadBalancerAttributes;
    const has_detail = attrs.access_log != null or
        attrs.connection_settings != null or
        attrs.connection_draining != null or
        attrs.cross_zone_load_balancing != null;
    try std.testing.expect(has_detail);
}

test "describeTags returns applied tags" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.describeTags(
        arena.allocator(),
        .{ .load_balancer_names = &.{lb_name} },
        .{},
    );

    const descs = result.tag_descriptions orelse
        return error.MissingTagDescriptions;
    var found = false;
    for (descs) |desc| {
        const tags = desc.tags orelse continue;
        for (tags) |tag| {
            if (std.mem.eql(
                u8,
                tag.key,
                "aws-sdk-zig-test",
            )) {
                found = true;
                break;
            }
        }
        if (found) break;
    }
    try std.testing.expect(found);
}

test "configureHealthCheck sets health check params" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.configureHealthCheck(
        arena.allocator(),
        .{
            .load_balancer_name = lb_name,
            .health_check = .{
                .target = "HTTP:80/",
                .interval = 30,
                .timeout = 5,
                .unhealthy_threshold = 2,
                .healthy_threshold = 10,
            },
        },
        .{},
    );

    const hc = result.health_check orelse
        return error.MissingHealthCheck;
    try std.testing.expectEqualStrings(
        "HTTP:80/",
        hc.target,
    );
}

test "describeInstanceHealth returns empty list" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.describeInstanceHealth(
        arena.allocator(),
        .{ .load_balancer_name = lb_name },
        .{},
    );

    if (result.instance_states) |states| {
        try std.testing.expectEqual(0, states.len);
    }
}

test "modifyLoadBalancerAttributes enables cross-zone LB" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = try shared_client.modifyLoadBalancerAttributes(
        arena.allocator(),
        .{
            .load_balancer_name = lb_name,
            .load_balancer_attributes = .{
                .cross_zone_load_balancing = .{
                    .enabled = true,
                },
            },
        },
        .{},
    );
}
