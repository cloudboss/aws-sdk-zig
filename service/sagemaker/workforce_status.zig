const std = @import("std");

pub const WorkforceStatus = enum {
    initializing,
    updating,
    deleting,
    failed,
    active,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .updating = "Updating",
        .deleting = "Deleting",
        .failed = "Failed",
        .active = "Active",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "Initializing",
            .updating => "Updating",
            .deleting => "Deleting",
            .failed => "Failed",
            .active => "Active",
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
