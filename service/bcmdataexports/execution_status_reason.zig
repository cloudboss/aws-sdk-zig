const std = @import("std");

pub const ExecutionStatusReason = enum {
    insufficient_permission,
    bill_owner_changed,
    internal_failure,

    pub const json_field_names = .{
        .insufficient_permission = "INSUFFICIENT_PERMISSION",
        .bill_owner_changed = "BILL_OWNER_CHANGED",
        .internal_failure = "INTERNAL_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_permission => "INSUFFICIENT_PERMISSION",
            .bill_owner_changed => "BILL_OWNER_CHANGED",
            .internal_failure => "INTERNAL_FAILURE",
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
