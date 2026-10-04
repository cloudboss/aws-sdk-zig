const std = @import("std");

pub const WorkloadEstimateStatus = enum {
    updating,
    valid,
    invalid,
    action_needed,

    pub const json_field_names = .{
        .updating = "UPDATING",
        .valid = "VALID",
        .invalid = "INVALID",
        .action_needed = "ACTION_NEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .updating => "UPDATING",
            .valid => "VALID",
            .invalid => "INVALID",
            .action_needed => "ACTION_NEEDED",
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
