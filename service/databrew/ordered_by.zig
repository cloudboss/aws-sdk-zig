const std = @import("std");

pub const OrderedBy = enum {
    last_modified_date,

    pub const json_field_names = .{
        .last_modified_date = "LAST_MODIFIED_DATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .last_modified_date => "LAST_MODIFIED_DATE",
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
