const std = @import("std");

pub const ContactMediaProcessingFailureMode = enum {
    deliver_unprocessed_message,
    do_not_deliver_unprocessed_message,

    pub const json_field_names = .{
        .deliver_unprocessed_message = "DELIVER_UNPROCESSED_MESSAGE",
        .do_not_deliver_unprocessed_message = "DO_NOT_DELIVER_UNPROCESSED_MESSAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deliver_unprocessed_message => "DELIVER_UNPROCESSED_MESSAGE",
            .do_not_deliver_unprocessed_message => "DO_NOT_DELIVER_UNPROCESSED_MESSAGE",
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
