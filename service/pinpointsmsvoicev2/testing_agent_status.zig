const std = @import("std");

/// The current status of the testing agent.
///
/// * `CREATED`: The testing agent has been created.
/// * `PENDING`: The testing agent is pending activation.
/// * `ACTIVE`: The testing agent is active and available for use.
pub const TestingAgentStatus = enum {
    created,
    pending,
    active,

    pub const json_field_names = .{
        .created = "CREATED",
        .pending = "PENDING",
        .active = "ACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .pending => "PENDING",
            .active => "ACTIVE",
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
