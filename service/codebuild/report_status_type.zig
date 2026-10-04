const std = @import("std");

pub const ReportStatusType = enum {
    generating,
    succeeded,
    failed,
    incomplete,
    deleting,

    pub const json_field_names = .{
        .generating = "GENERATING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .incomplete = "INCOMPLETE",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .generating => "GENERATING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .incomplete => "INCOMPLETE",
            .deleting => "DELETING",
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
