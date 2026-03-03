const std = @import("std");

pub const AgentStatus = enum {
    creating,
    preparing,
    prepared,
    not_prepared,
    deleting,
    failed,
    versioning,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .preparing = "PREPARING",
        .prepared = "PREPARED",
        .not_prepared = "NOT_PREPARED",
        .deleting = "DELETING",
        .failed = "FAILED",
        .versioning = "VERSIONING",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .preparing => "PREPARING",
            .prepared => "PREPARED",
            .not_prepared => "NOT_PREPARED",
            .deleting => "DELETING",
            .failed => "FAILED",
            .versioning => "VERSIONING",
            .updating => "UPDATING",
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
