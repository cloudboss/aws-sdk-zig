# AWS SDK for Zig

An AWS SDK for Zig, providing AWS service clients from [Smithy models](https://aws.amazon.com/blogs/aws/introducing-aws-api-models-and-publicly-available-resources-for-aws-api-definitions/), built using a Kotlin code generator.

Requires Zig 0.15.0 or later.

## Available Services

See the [`service/`](./service/) directory for the complete list of AWS services generated.

## Features

- **Pagination** -- Handling of paginated responses through paginator wrappers of API operations that contain `.next()` methods.
- **Presigned URLs** -- Generate presigned URLs for S3 and other services.
- **Waiters** -- Wait for API operations to finish.
- **Streaming responses** -- Efficient handling of large payloads.
- **Flexible checksums** -- Automatic data integrity validation for S3 request/response bodies using CRC32, CRC32C, CRC64NVME, SHA256, or SHA1.
- **Event streams** -- Server-push event handling (~15 operations across 8 services).

## Quick Start

See the [`examples/`](./examples/) directory for a full Zig module.

To add the SDK as a dependency, run:

```
zig fetch --save git+https://github.com/cloudboss/aws-sdk-zig
```

```zig
const std = @import("std");

const aws = @import("aws");
const s3 = @import("s3");

pub fn main() !void {
    var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Load configuration from the environment and/or ~/.aws directory.
    var config = try aws.Config.load(allocator, .{});
    defer config.deinit();

    // Create the S3 client.
    var client = s3.Client.init(allocator, &config);
    defer client.deinit();

    // List all buckets.
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const result = try client.listBuckets(arena.allocator(), .{}, .{});

    if (result.buckets) |buckets| {
        for (buckets) |bucket| {
            if (bucket.name) |name| {
                std.debug.print("{s}\n", .{name});
            }
        }
    }
}
```

## Configuration

Configuration is loaded automatically from standard AWS sources:

```zig
// Load from environment + config files (default profile or AWS_PROFILE environment variable).
var cfg = try aws.Config.load(allocator, .{});

// Use a specific profile.
var cfg = try aws.Config.load(allocator, .{ .profile = "staging" });

// Override the endpoint (useful for e.g. LocalStack).
var cfg = try aws.Config.load(allocator, .{ .endpoint_url = "http://localhost:4566" });
```

## Credential Providers

Credentials are resolved automatically in this order:

1. **Environment** -- `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`
2. **Shared credentials file** -- `~/.aws/credentials`
3. **Web Identity Token** -- For OIDC/EKS workloads (`AWS_WEB_IDENTITY_TOKEN_FILE`)
4. **ECS container credentials** -- Via `AWS_CONTAINER_CREDENTIALS_RELATIVE_URI`
5. **EC2 Instance Metadata** -- IMDS v2

Additional providers (SSO, process credentials, assume role) can be configured through AWS profiles.

## Endpoint Resolution

The SDK resolves endpoints across all 8 AWS partitions:

- **aws** -- Standard commercial regions (`us-east-1`, `eu-west-1`, etc.)
- **aws-cn** -- China regions (`cn-north-1`, `cn-northwest-1`)
- **aws-us-gov** -- GovCloud regions (`us-gov-west-1`, `us-gov-east-1`)
- **aws-iso** -- C2S regions
- **aws-iso-b** -- SC2S regions
- **aws-iso-e** -- European isolated regions
- **aws-iso-f** -- HCI regions
- **aws-eusc** -- European Sovereign Cloud

FIPS and dual-stack endpoints are supported where available. S3 additionally supports virtual-hosted-style addressing and transfer acceleration.

## Error Handling

Operations return errors that can be inspected with a diagnostic:

```zig
var diagnostic: sts.ServiceError = undefined;
var result = client.getCallerIdentity(arena.allocator(), .{}, .{
    .diagnostic = &diagnostic,
}) catch |err| {
    if (err == error.ServiceError) {
        defer diagnostic.deinit();
        std.debug.print(
            "Service error: {s} - {s}\n",
            .{ diagnostic.code(), diagnostic.message() },
        );
    } else {
        std.debug.print("Unexpected error: {any}\n", .{err});
    }
    return err;
};
defer result.deinit();
```

Every service defines `ServiceError` so this pattern can be used.

## Development

```bash
# Run unit tests
make test

# Run integration tests
make test-integration

# Run a single integration test scenario
make test-integration SCENARIO=s3

# Regenerate service code from Smithy models
make codegen
```

## License

MIT
