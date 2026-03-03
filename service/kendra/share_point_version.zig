const std = @import("std");

pub const SharePointVersion = enum {
    sharepoint_2013,
    sharepoint_2016,
    sharepoint_online,
    sharepoint_2019,

    pub const json_field_names = .{
        .sharepoint_2013 = "SHAREPOINT_2013",
        .sharepoint_2016 = "SHAREPOINT_2016",
        .sharepoint_online = "SHAREPOINT_ONLINE",
        .sharepoint_2019 = "SHAREPOINT_2019",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sharepoint_2013 => "SHAREPOINT_2013",
            .sharepoint_2016 => "SHAREPOINT_2016",
            .sharepoint_online => "SHAREPOINT_ONLINE",
            .sharepoint_2019 => "SHAREPOINT_2019",
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
