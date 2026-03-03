const std = @import("std");

pub const AgentAliasStatus = enum {
    creating,
    prepared,
    failed,
    updating,
    deleting,
    dissociated,

    pub const json_field_names = .{
        .creating = "CREATING",
        .prepared = "PREPARED",
        .failed = "FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .dissociated = "DISSOCIATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .prepared => "PREPARED",
            .failed => "FAILED",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .dissociated => "DISSOCIATED",
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
