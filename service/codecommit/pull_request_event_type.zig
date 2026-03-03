const std = @import("std");

pub const PullRequestEventType = enum {
    pull_request_created,
    pull_request_status_changed,
    pull_request_source_reference_updated,
    pull_request_merge_state_changed,
    pull_request_approval_rule_created,
    pull_request_approval_rule_updated,
    pull_request_approval_rule_deleted,
    pull_request_approval_rule_overridden,
    pull_request_approval_state_changed,

    pub const json_field_names = .{
        .pull_request_created = "PULL_REQUEST_CREATED",
        .pull_request_status_changed = "PULL_REQUEST_STATUS_CHANGED",
        .pull_request_source_reference_updated = "PULL_REQUEST_SOURCE_REFERENCE_UPDATED",
        .pull_request_merge_state_changed = "PULL_REQUEST_MERGE_STATE_CHANGED",
        .pull_request_approval_rule_created = "PULL_REQUEST_APPROVAL_RULE_CREATED",
        .pull_request_approval_rule_updated = "PULL_REQUEST_APPROVAL_RULE_UPDATED",
        .pull_request_approval_rule_deleted = "PULL_REQUEST_APPROVAL_RULE_DELETED",
        .pull_request_approval_rule_overridden = "PULL_REQUEST_APPROVAL_RULE_OVERRIDDEN",
        .pull_request_approval_state_changed = "PULL_REQUEST_APPROVAL_STATE_CHANGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pull_request_created => "PULL_REQUEST_CREATED",
            .pull_request_status_changed => "PULL_REQUEST_STATUS_CHANGED",
            .pull_request_source_reference_updated => "PULL_REQUEST_SOURCE_REFERENCE_UPDATED",
            .pull_request_merge_state_changed => "PULL_REQUEST_MERGE_STATE_CHANGED",
            .pull_request_approval_rule_created => "PULL_REQUEST_APPROVAL_RULE_CREATED",
            .pull_request_approval_rule_updated => "PULL_REQUEST_APPROVAL_RULE_UPDATED",
            .pull_request_approval_rule_deleted => "PULL_REQUEST_APPROVAL_RULE_DELETED",
            .pull_request_approval_rule_overridden => "PULL_REQUEST_APPROVAL_RULE_OVERRIDDEN",
            .pull_request_approval_state_changed => "PULL_REQUEST_APPROVAL_STATE_CHANGED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
