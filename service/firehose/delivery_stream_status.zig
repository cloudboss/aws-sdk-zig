const std = @import("std");

pub const DeliveryStreamStatus = enum {
    creating,
    creating_failed,
    deleting,
    deleting_failed,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .creating_failed = "CREATING_FAILED",
        .deleting = "DELETING",
        .deleting_failed = "DELETING_FAILED",
        .active = "ACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .creating_failed => "CREATING_FAILED",
            .deleting => "DELETING",
            .deleting_failed => "DELETING_FAILED",
            .active => "ACTIVE",
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
