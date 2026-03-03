const std = @import("std");

pub const SyncConfigurationType = enum {
    cfn_stack_sync,

    pub const json_field_names = .{
        .cfn_stack_sync = "CFN_STACK_SYNC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cfn_stack_sync => "CFN_STACK_SYNC",
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
