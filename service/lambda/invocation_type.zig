const std = @import("std");

pub const InvocationType = enum {
    event,
    request_response,
    dry_run,

    pub const json_field_names = .{
        .event = "Event",
        .request_response = "RequestResponse",
        .dry_run = "DryRun",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event => "Event",
            .request_response => "RequestResponse",
            .dry_run => "DryRun",
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
