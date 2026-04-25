const std = @import("std");

/// The current status of the RCS agent.
///
/// * `CREATED`: The RCS agent has been created.
/// * `PENDING`: The RCS agent is pending review.
/// * `TESTING`: The RCS agent is in testing.
/// * `PARTIAL`: The RCS agent is partially active.
/// * `ACTIVE`: The RCS agent is active and available for use.
/// * `DELETED`: The RCS agent has been deleted.
pub const RcsAgentStatus = enum {
    created,
    pending,
    testing,
    partial,
    active,
    deleted,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .testing = "TESTING",
        .partial = "PARTIAL",
        .active = "ACTIVE",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .pending => "PENDING",
            .testing => "TESTING",
            .partial => "PARTIAL",
            .active => "ACTIVE",
            .deleted => "DELETED",
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
