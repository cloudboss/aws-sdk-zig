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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
