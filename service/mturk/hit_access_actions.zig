const std = @import("std");

pub const HITAccessActions = enum {
    accept,
    preview_and_accept,
    discover_preview_and_accept,

    pub const json_field_names = .{
        .accept = "Accept",
        .preview_and_accept = "PreviewAndAccept",
        .discover_preview_and_accept = "DiscoverPreviewAndAccept",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accept => "Accept",
            .preview_and_accept => "PreviewAndAccept",
            .discover_preview_and_accept => "DiscoverPreviewAndAccept",
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
