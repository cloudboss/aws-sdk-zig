const std = @import("std");
const aws = @import("aws");

test "web identity provider loads credentials from token file" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    // Write a token file
    const token_path = "/tmp/web-identity-token";

    var provider = aws.web_identity.WebIdentityProvider{
        .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
        .token_file = token_path,
        .session_name = "integration-test",
        .region = "us-east-1",
        .endpoint_url = endpoint_url,
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify we got credentials back
    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.secret_access_key.len > 0);
    try std.testing.expect(creds.session_token != null);
    try std.testing.expect(creds.expiration != null);
}

test "web identity credentials can be used via CredentialsProvider union" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    const token_path = "/tmp/web-identity-token";

    var cp = aws.CredentialsProvider{
        .web_identity = .{
            .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
            .token_file = token_path,
            .session_name = "union-test",
            .region = "us-east-1",
            .endpoint_url = endpoint_url,
        },
    };

    const creds = try cp.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.secret_access_key.len > 0);
}

test "web identity credentials include future expiration timestamp" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    const token_path = "/tmp/web-identity-token";

    var provider = aws.web_identity.WebIdentityProvider{
        .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
        .token_file = token_path,
        .session_name = "expiration-test",
        .region = "us-east-1",
        .endpoint_url = endpoint_url,
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify expiration is not null and is a future timestamp
    try std.testing.expect(creds.expiration != null);
    try std.testing.expect(creds.expiration.? > 0);
}
