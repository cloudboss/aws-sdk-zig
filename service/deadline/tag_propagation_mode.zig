const std = @import("std");

pub const TagPropagationMode = enum {
    no_propagation,
    propagate_tags_to_workers_at_launch,

    pub const json_field_names = .{
        .no_propagation = "NO_PROPAGATION",
        .propagate_tags_to_workers_at_launch = "PROPAGATE_TAGS_TO_WORKERS_AT_LAUNCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_propagation => "NO_PROPAGATION",
            .propagate_tags_to_workers_at_launch => "PROPAGATE_TAGS_TO_WORKERS_AT_LAUNCH",
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
