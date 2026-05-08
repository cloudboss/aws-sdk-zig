const std = @import("std");

pub const CustomAdType = enum {
    program,
    chapter,
    unscheduled_event,
    alternate_content_opportunity,
    network,

    pub const json_field_names = .{
        .program = "PROGRAM",
        .chapter = "CHAPTER",
        .unscheduled_event = "UNSCHEDULED_EVENT",
        .alternate_content_opportunity = "ALTERNATE_CONTENT_OPPORTUNITY",
        .network = "NETWORK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .program => "PROGRAM",
            .chapter => "CHAPTER",
            .unscheduled_event => "UNSCHEDULED_EVENT",
            .alternate_content_opportunity => "ALTERNATE_CONTENT_OPPORTUNITY",
            .network => "NETWORK",
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
