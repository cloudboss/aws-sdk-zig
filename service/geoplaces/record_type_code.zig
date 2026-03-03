const std = @import("std");

pub const RecordTypeCode = enum {
    firm,
    general,
    high_rise,
    post_office_box,
    rural,
    street,

    pub const json_field_names = .{
        .firm = "Firm",
        .general = "General",
        .high_rise = "HighRise",
        .post_office_box = "PostOfficeBox",
        .rural = "Rural",
        .street = "Street",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .firm => "Firm",
            .general => "General",
            .high_rise => "HighRise",
            .post_office_box => "PostOfficeBox",
            .rural => "Rural",
            .street => "Street",
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
