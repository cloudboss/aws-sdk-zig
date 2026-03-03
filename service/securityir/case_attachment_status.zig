const std = @import("std");

pub const CaseAttachmentStatus = enum {
    verified,
    failed,
    pending,

    pub const json_field_names = .{
        .verified = "Verified",
        .failed = "Failed",
        .pending = "Pending",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .verified => "Verified",
            .failed => "Failed",
            .pending => "Pending",
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
