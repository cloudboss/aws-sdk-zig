const std = @import("std");

/// The type of action that occurred for the resource and produced the policy
/// finding:
pub const FindingActionType = enum {
    aws_api_call,

    pub const json_field_names = .{
        .aws_api_call = "AWS_API_CALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_api_call => "AWS_API_CALL",
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
