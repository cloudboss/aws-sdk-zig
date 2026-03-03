const std = @import("std");

pub const TargetedSentimentEntityType = enum {
    person,
    location,
    organization,
    facility,
    brand,
    commercial_item,
    movie,
    music,
    book,
    software,
    game,
    personal_title,
    event,
    date,
    quantity,
    attribute,
    other,

    pub const json_field_names = .{
        .person = "PERSON",
        .location = "LOCATION",
        .organization = "ORGANIZATION",
        .facility = "FACILITY",
        .brand = "BRAND",
        .commercial_item = "COMMERCIAL_ITEM",
        .movie = "MOVIE",
        .music = "MUSIC",
        .book = "BOOK",
        .software = "SOFTWARE",
        .game = "GAME",
        .personal_title = "PERSONAL_TITLE",
        .event = "EVENT",
        .date = "DATE",
        .quantity = "QUANTITY",
        .attribute = "ATTRIBUTE",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .person => "PERSON",
            .location => "LOCATION",
            .organization => "ORGANIZATION",
            .facility => "FACILITY",
            .brand => "BRAND",
            .commercial_item => "COMMERCIAL_ITEM",
            .movie => "MOVIE",
            .music => "MUSIC",
            .book => "BOOK",
            .software => "SOFTWARE",
            .game => "GAME",
            .personal_title => "PERSONAL_TITLE",
            .event => "EVENT",
            .date => "DATE",
            .quantity => "QUANTITY",
            .attribute => "ATTRIBUTE",
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
