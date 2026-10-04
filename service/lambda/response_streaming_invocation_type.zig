const std = @import("std");

pub const ResponseStreamingInvocationType = enum {
    request_response,
    dry_run,

    pub const json_field_names = .{
        .request_response = "RequestResponse",
        .dry_run = "DryRun",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request_response => "RequestResponse",
            .dry_run => "DryRun",
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
