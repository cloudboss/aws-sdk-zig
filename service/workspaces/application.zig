const std = @import("std");

pub const Application = enum {
    microsoft_office_2016,
    microsoft_office_2019,

    pub const json_field_names = .{
        .microsoft_office_2016 = "Microsoft_Office_2016",
        .microsoft_office_2019 = "Microsoft_Office_2019",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .microsoft_office_2016 => "Microsoft_Office_2016",
            .microsoft_office_2019 => "Microsoft_Office_2019",
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
