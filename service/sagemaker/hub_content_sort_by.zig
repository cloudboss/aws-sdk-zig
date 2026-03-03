const std = @import("std");

pub const HubContentSortBy = enum {
    hub_content_name,
    creation_time,
    hub_content_status,

    pub const json_field_names = .{
        .hub_content_name = "HubContentName",
        .creation_time = "CreationTime",
        .hub_content_status = "HubContentStatus",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hub_content_name => "HubContentName",
            .creation_time => "CreationTime",
            .hub_content_status => "HubContentStatus",
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
