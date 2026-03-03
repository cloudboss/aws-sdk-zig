const std = @import("std");

pub const ConnectionState = enum {
    ordering,
    requested,
    pending,
    available,
    down,
    deleting,
    deleted,
    rejected,
    unknown,

    pub const json_field_names = .{
        .ordering = "ordering",
        .requested = "requested",
        .pending = "pending",
        .available = "available",
        .down = "down",
        .deleting = "deleting",
        .deleted = "deleted",
        .rejected = "rejected",
        .unknown = "unknown",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ordering => "ordering",
            .requested => "requested",
            .pending => "pending",
            .available => "available",
            .down => "down",
            .deleting => "deleting",
            .deleted => "deleted",
            .rejected => "rejected",
            .unknown => "unknown",
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
