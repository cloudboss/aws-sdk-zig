const std = @import("std");
const aws = @import("aws");

const athena = @import("athena");
const bedrock = @import("bedrock");
const comprehend = @import("comprehend");
const emr = @import("emr");
const firehose = @import("firehose");
const glue = @import("glue");
const opensearch = @import("opensearch");
const rekognition = @import("rekognition");
const sagemaker = @import("sagemaker");
const textract = @import("textract");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "athena listWorkGroups" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = athena.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listWorkGroups(
        arena.allocator(),
        .{},
        .{},
    );
}

test "glue getDatabases" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = glue.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.getDatabases(
        arena.allocator(),
        .{},
        .{},
    );
}

test "firehose listDeliveryStreams" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = firehose.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listDeliveryStreams(
        arena.allocator(),
        .{},
        .{},
    );
}

test "opensearch listDomainNames" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = opensearch.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listDomainNames(
        arena.allocator(),
        .{},
        .{},
    );
}

test "comprehend listEntitiesDetectionJobs" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = comprehend.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listEntitiesDetectionJobs(
        arena.allocator(),
        .{},
        .{},
    );
}

test "rekognition listCollections" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = rekognition.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listCollections(
        arena.allocator(),
        .{},
        .{},
    );
}

test "sagemaker listNotebookInstances" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = sagemaker.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listNotebookInstances(
        arena.allocator(),
        .{},
        .{},
    );
}

test "bedrock listFoundationModels" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = bedrock.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listFoundationModels(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "emr listClusters" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = emr.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "textract listAdapterVersions" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = textract.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listAdapterVersions(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}
