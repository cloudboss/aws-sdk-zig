const std = @import("std");

pub const WorkspaceFontFamily = enum {
    arial,
    courier_new,
    georgia,
    times_new_roman,
    trebuchet,
    verdana,

    pub const json_field_names = .{
        .arial = "Arial",
        .courier_new = "Courier New",
        .georgia = "Georgia",
        .times_new_roman = "Times New Roman",
        .trebuchet = "Trebuchet",
        .verdana = "Verdana",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arial => "Arial",
            .courier_new => "Courier New",
            .georgia => "Georgia",
            .times_new_roman => "Times New Roman",
            .trebuchet => "Trebuchet",
            .verdana => "Verdana",
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
