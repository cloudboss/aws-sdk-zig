const std = @import("std");

/// Webhook events that can auto-trigger a capability. PULL_REQUEST_* events
/// apply to RELEASE_READINESS_REVIEW; WORKFLOW_* events apply to
/// RELEASE_SHEPHERDING.
pub const TriggerEvent = enum {
    /// A change request is created, updated, or marked ready for review while in a
    /// non-draft state.
    pull_request_ready_for_review,
    /// A change request is created or updated while in draft state.
    pull_request_draft,

    pub const json_field_names = .{
        .pull_request_ready_for_review = "PULL_REQUEST_READY_FOR_REVIEW",
        .pull_request_draft = "PULL_REQUEST_DRAFT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pull_request_ready_for_review => "PULL_REQUEST_READY_FOR_REVIEW",
            .pull_request_draft => "PULL_REQUEST_DRAFT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
