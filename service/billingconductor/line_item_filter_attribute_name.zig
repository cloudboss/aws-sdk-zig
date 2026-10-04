const std = @import("std");

pub const LineItemFilterAttributeName = enum {
    line_item_type,
    service,

    pub const json_field_names = .{
        .line_item_type = "LINE_ITEM_TYPE",
        .service = "SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .line_item_type => "LINE_ITEM_TYPE",
            .service => "SERVICE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
