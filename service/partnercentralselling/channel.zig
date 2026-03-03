const std = @import("std");

pub const Channel = enum {
    aws_marketing_central,
    content_syndication,
    display,
    email,
    live_event,
    out_of_home,
    print,
    search,
    social,
    telemarketing,
    tv,
    video,
    virtual_event,

    pub const json_field_names = .{
        .aws_marketing_central = "AWS Marketing Central",
        .content_syndication = "Content Syndication",
        .display = "Display",
        .email = "Email",
        .live_event = "Live Event",
        .out_of_home = "Out Of Home (OOH)",
        .print = "Print",
        .search = "Search",
        .social = "Social",
        .telemarketing = "Telemarketing",
        .tv = "TV",
        .video = "Video",
        .virtual_event = "Virtual Event",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_marketing_central => "AWS Marketing Central",
            .content_syndication => "Content Syndication",
            .display => "Display",
            .email => "Email",
            .live_event => "Live Event",
            .out_of_home => "Out Of Home (OOH)",
            .print => "Print",
            .search => "Search",
            .social => "Social",
            .telemarketing => "Telemarketing",
            .tv => "TV",
            .video => "Video",
            .virtual_event => "Virtual Event",
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
