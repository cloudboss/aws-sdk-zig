const std = @import("std");

/// A pull request event that can start an automatic code review. For GitLab
/// repositories, pull request refers to a merge request.
pub const TriggerEvent = enum {
    /// A pull request that isn't a draft is opened, updated, or marked ready for
    /// review.
    pull_request_ready_for_review,
    /// A draft pull request is opened or updated.
    pull_request_draft,
    /// A label is added to a pull request. A filter group that selects this event
    /// must include a `LABEL` filter with the `INCLUDE` match mode, and a review
    /// starts only when the added label matches it.
    pull_request_label_added,

    pub const json_field_names = .{
        .pull_request_ready_for_review = "PULL_REQUEST_READY_FOR_REVIEW",
        .pull_request_draft = "PULL_REQUEST_DRAFT",
        .pull_request_label_added = "PULL_REQUEST_LABEL_ADDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pull_request_ready_for_review => "PULL_REQUEST_READY_FOR_REVIEW",
            .pull_request_draft => "PULL_REQUEST_DRAFT",
            .pull_request_label_added => "PULL_REQUEST_LABEL_ADDED",
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
