const AssertionSource = @import("assertion_source.zig").AssertionSource;

/// Represents a resilience assertion for a service.
pub const Assertion = struct {
    /// The unique identifier of the assertion.
    assertion_id: []const u8,

    /// The timestamp when the assertion was created.
    created_at: ?i64 = null,

    service_arn: []const u8,

    /// The source of the assertion, indicating whether it was AI-generated or
    /// created by a user.
    source: AssertionSource,

    /// The text content of the assertion.
    text: []const u8,

    /// The timestamp when the assertion was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .assertion_id = "assertionId",
        .created_at = "createdAt",
        .service_arn = "serviceArn",
        .source = "source",
        .text = "text",
        .updated_at = "updatedAt",
    };
};
