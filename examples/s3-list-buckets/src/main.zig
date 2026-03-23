const std = @import("std");

const aws = @import("aws");
const s3 = @import("s3");

pub fn main() !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Load configuration from the environment and/or ~/.aws directory.
    var config = try aws.Config.load(allocator, .{});
    defer config.deinit();

    // Create an S3 client.
    var client = s3.Client.init(allocator, &config);
    defer client.deinit();

    // Create an arena allocator to hold the API output.
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_allocator = arena.allocator();

    // Use a diagnostic to capture any service error details if the API call fails.
    var diagnostic: s3.ServiceError = undefined;

    // List all S3 buckets with pagination.
    var paginator = client.listBucketsPaginator(.{});
    while (!paginator.done) {
        const result = paginator.next(
            arena_allocator,
            .{ .diagnostic = &diagnostic },
        ) catch |err| {
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
}
