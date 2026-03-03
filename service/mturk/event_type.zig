const std = @import("std");

pub const EventType = enum {
    assignment_accepted,
    assignment_abandoned,
    assignment_returned,
    assignment_submitted,
    assignment_rejected,
    assignment_approved,
    hit_created,
    hit_expired,
    hit_reviewable,
    hit_extended,
    hit_disposed,
    ping,

    pub const json_field_names = .{
        .assignment_accepted = "AssignmentAccepted",
        .assignment_abandoned = "AssignmentAbandoned",
        .assignment_returned = "AssignmentReturned",
        .assignment_submitted = "AssignmentSubmitted",
        .assignment_rejected = "AssignmentRejected",
        .assignment_approved = "AssignmentApproved",
        .hit_created = "HITCreated",
        .hit_expired = "HITExpired",
        .hit_reviewable = "HITReviewable",
        .hit_extended = "HITExtended",
        .hit_disposed = "HITDisposed",
        .ping = "Ping",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assignment_accepted => "AssignmentAccepted",
            .assignment_abandoned => "AssignmentAbandoned",
            .assignment_returned => "AssignmentReturned",
            .assignment_submitted => "AssignmentSubmitted",
            .assignment_rejected => "AssignmentRejected",
            .assignment_approved => "AssignmentApproved",
            .hit_created => "HITCreated",
            .hit_expired => "HITExpired",
            .hit_reviewable => "HITReviewable",
            .hit_extended => "HITExtended",
            .hit_disposed => "HITDisposed",
            .ping => "Ping",
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
