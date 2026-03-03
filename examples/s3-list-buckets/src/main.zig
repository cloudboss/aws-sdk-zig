const std = @import("std");

const aws = @import("aws");
const s3 = @import("s3");

pub fn main() !void {
    var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Initialize arena allocator for API output.
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    // Load configuration from the environment and/or ~/.aws directory.
    var config = try aws.Config.load(allocator, .{});
    defer config.deinit();

    // Create an S3 client.
    var client = s3.Client.init(allocator, &config);
    defer client.deinit();

    // List all S3 buckets.
    var diagnostic: s3.ServiceError = undefined;
    const result = client.listBuckets(arena.allocator(), .{}, .{ .diagnostic = &diagnostic }) catch |err| {
        if (err == error.ServiceError) {
            defer diagnostic.deinit();
            std.debug.print(
                "Service error: {s} - {s}\n",
                .{ diagnostic.code(), diagnostic.message() },
            );
        } else {
            std.debug.print("Unexpected error: {any}\n", .{err});
        }
        return;
    };
    if (result.buckets) |buckets| {
        for (buckets) |bucket| {
            if (bucket.name) |name| {
                std.debug.print("{s}\n", .{name});
            }
        }
    }
}
