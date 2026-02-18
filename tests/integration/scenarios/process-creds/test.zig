const std = @import("std");
const aws = @import("aws");

test "process provider executes command and returns credentials" {
    const allocator = std.testing.allocator;

    var provider = aws.process_creds.ProcessProvider{
        .command = "/tmp/cred-helper.sh",
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings("AKIAPROCESS123", creds.access_key_id);
    try std.testing.expectEqualStrings("processSecretKey123", creds.secret_access_key);
    try std.testing.expectEqualStrings("processToken123", creds.session_token.?);
    try std.testing.expect(creds.expiration != null);
}

test "process provider caches credentials" {
    const allocator = std.testing.allocator;

    var provider = aws.process_creds.ProcessProvider{
        .command = "/tmp/cred-helper.sh",
    };

    // First call
    const creds1 = try provider.getCredentials(allocator);
    // Second call should return cached
    const creds2 = try provider.getCredentials(allocator);

    // Both should be the same object (cached)
    try std.testing.expectEqualStrings(creds1.access_key_id, creds2.access_key_id);

    // Free once -- both point to the same cached credentials
    allocator.free(creds1.access_key_id);
    allocator.free(creds1.secret_access_key);
    if (creds1.session_token) |t| allocator.free(t);
}

test "process provider returns error on non-zero exit" {
    const provider = aws.process_creds.ProcessProvider{
        .command = "/tmp/cred-helper-fail.sh",
    };

    var cp = aws.CredentialsProvider{ .process = provider };
    _ = &cp;
    const result = cp.getCredentials(std.testing.allocator);
    try std.testing.expectError(error.CredentialsNotFound, result);
}

test "process provider works via CredentialsProvider union" {
    const allocator = std.testing.allocator;

    var cp = aws.CredentialsProvider{
        .process = .{
            .command = "/tmp/cred-helper.sh",
        },
    };

    const creds = try cp.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expect(creds.access_key_id.len > 0);
}

test "process provider returns error for malformed JSON output" {
    const allocator = std.testing.allocator;

    // Create a script that outputs invalid JSON
    const script_path = "/tmp/cred-helper-badjson.sh";
    const script_content = "#!/bin/sh\necho '{broken'\n";

    var file = try std.fs.cwd().createFile(script_path, .{});
    defer file.close();
    try file.writeAll(script_content);

    // Make the script executable using chmod command
    var chmod_child = std.process.Child.init(&.{ "chmod", "+x", script_path }, allocator);
    _ = try chmod_child.spawn();
    _ = try chmod_child.wait();

    // Create provider with the malformed JSON script
    const provider = aws.process_creds.ProcessProvider{
        .command = script_path,
    };

    var cp = aws.CredentialsProvider{ .process = provider };
    _ = &cp;
    const result = cp.getCredentials(allocator);
    try std.testing.expectError(error.CredentialsNotFound, result);
}
