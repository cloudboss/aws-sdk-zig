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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
