const std = @import("std");
const aws = @import("aws");

const apigateway = @import("apigateway");
const apigatewayv2 = @import("apigatewayv2");
const appmesh = @import("appmesh");
const cloudfront = @import("cloudfront");
const directconnect = @import("directconnect");
const elbv2 = @import("elasticloadbalancingv2");
const globalaccelerator = @import("globalaccelerator");
const networkfirewall = @import("networkfirewall");
const networkmanager = @import("networkmanager");
const servicediscovery = @import("servicediscovery");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "cloudfront listDistributions" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = cloudfront.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listDistributions(
        arena.allocator(),
        .{},
        .{},
    );
}

test "directconnect describeConnections" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = directconnect.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeConnections(
        arena.allocator(),
        .{},
        .{},
    );
}

test "globalaccelerator listAccelerators" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = globalaccelerator.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listAccelerators(
        arena.allocator(),
        .{},
        .{},
    );
}

test "networkfirewall listFirewalls" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = networkfirewall.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listFirewalls(
        arena.allocator(),
        .{},
        .{},
    );
}

test "networkmanager describeGlobalNetworks" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = networkmanager.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeGlobalNetworks(
        arena.allocator(),
        .{},
        .{},
    );
}

test "servicediscovery listNamespaces" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = servicediscovery.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listNamespaces(
        arena.allocator(),
        .{},
        .{},
    );
}

test "appmesh listMeshes" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = appmesh.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listMeshes(
        arena.allocator(),
        .{},
        .{},
    );
}

test "elasticloadbalancingv2 describeLoadBalancers" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = elbv2.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeLoadBalancers(
        arena.allocator(),
        .{},
        .{},
    );
}

test "apigateway getRestApis" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = apigateway.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.getRestApis(
        arena.allocator(),
        .{},
        .{},
    );
}

test "apigatewayv2 getApis" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = apigatewayv2.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.getApis(
        arena.allocator(),
        .{},
        .{},
    );
}
