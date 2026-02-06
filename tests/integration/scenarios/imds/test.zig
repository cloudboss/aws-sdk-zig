const std = @import("std");

const aws = @import("aws");

test "IMDS client retrieves instance ID" {
    const allocator = std.testing.allocator;
    var client = try aws.imds.Client.init(allocator, .{});
    defer client.deinit();

    const instance_id = try client.getInstanceId();
    defer allocator.free(instance_id);

    try std.testing.expectEqualStrings("i-test12345", instance_id);
}

test "IMDS client retrieves IAM credentials" {
    const allocator = std.testing.allocator;
    var client = try aws.imds.Client.init(allocator, .{});
    defer client.deinit();

    var creds = try client.getIamCredentials();
    defer creds.deinit();

    try std.testing.expectEqualStrings("ASIAIOSFODNN7EXAMPLE", creds.access_key_id);
    try std.testing.expectEqualStrings("wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY", creds.secret_access_key);
    try std.testing.expectEqualStrings("FwoGZXIvYXdzEBYaDM3fake0token1234567890==", creds.token);
    try std.testing.expect(creds.expiration > 0);
}

test "IMDS client retrieves region" {
    const allocator = std.testing.allocator;
    var client = try aws.imds.Client.init(allocator, .{});
    defer client.deinit();

    const region = try client.getRegion();
    defer allocator.free(region);

    try std.testing.expectEqualStrings("us-east-1", region);
}

test "IMDS client returns error for unknown path" {
    const allocator = std.testing.allocator;
    var client = try aws.imds.Client.init(allocator, .{});
    defer client.deinit();

    const result = client.getMetadata("/latest/meta-data/nonexistent");
    try std.testing.expectError(error.ImdsNotFound, result);
}
