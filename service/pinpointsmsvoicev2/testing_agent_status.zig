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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
