const std = @import("std");

/// Optional. When you request a list of queues, you can choose to list them
/// alphabetically by NAME or chronologically by CREATION_DATE. If you don't
/// specify, the service will list them by creation date.
pub const QueueListBy = enum {
    name,
    creation_date,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_date = "CREATION_DATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .creation_date => "CREATION_DATE",
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
