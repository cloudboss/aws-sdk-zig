const std = @import("std");

pub const EventType = enum {
    viewer_request,
    viewer_response,
    origin_request,
    origin_response,

    pub const json_field_names = .{
        .viewer_request = "viewer-request",
        .viewer_response = "viewer-response",
        .origin_request = "origin-request",
        .origin_response = "origin-response",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .viewer_request => "viewer-request",
            .viewer_response => "viewer-response",
            .origin_request => "origin-request",
            .origin_response => "origin-response",
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
