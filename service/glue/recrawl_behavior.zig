const std = @import("std");

pub const RecrawlBehavior = enum {
    crawl_everything,
    crawl_new_folders_only,
    crawl_event_mode,

    pub const json_field_names = .{
        .crawl_everything = "CRAWL_EVERYTHING",
        .crawl_new_folders_only = "CRAWL_NEW_FOLDERS_ONLY",
        .crawl_event_mode = "CRAWL_EVENT_MODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crawl_everything => "CRAWL_EVERYTHING",
            .crawl_new_folders_only => "CRAWL_NEW_FOLDERS_ONLY",
            .crawl_event_mode => "CRAWL_EVENT_MODE",
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
