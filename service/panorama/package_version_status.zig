const std = @import("std");

pub const PackageVersionStatus = enum {
    register_pending,
    register_completed,
    failed,
    deleting,

    pub const json_field_names = .{
        .register_pending = "REGISTER_PENDING",
        .register_completed = "REGISTER_COMPLETED",
        .failed = "FAILED",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .register_pending => "REGISTER_PENDING",
            .register_completed => "REGISTER_COMPLETED",
            .failed => "FAILED",
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
