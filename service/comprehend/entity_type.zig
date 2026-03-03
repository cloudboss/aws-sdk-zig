const std = @import("std");

pub const EntityType = enum {
    person,
    location,
    organization,
    commercial_item,
    event,
    date,
    quantity,
    title,
    other,

    pub const json_field_names = .{
        .person = "PERSON",
        .location = "LOCATION",
        .organization = "ORGANIZATION",
        .commercial_item = "COMMERCIAL_ITEM",
        .event = "EVENT",
        .date = "DATE",
        .quantity = "QUANTITY",
        .title = "TITLE",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .person => "PERSON",
            .location => "LOCATION",
            .organization => "ORGANIZATION",
            .commercial_item => "COMMERCIAL_ITEM",
            .event => "EVENT",
            .date => "DATE",
            .quantity => "QUANTITY",
            .title => "TITLE",
            .other => "OTHER",
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
