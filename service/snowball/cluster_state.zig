const std = @import("std");

pub const ClusterState = enum {
    awaiting_quorum,
    pending,
    in_use,
    complete,
    cancelled,

    pub const json_field_names = .{
        .awaiting_quorum = "AwaitingQuorum",
        .pending = "Pending",
        .in_use = "InUse",
        .complete = "Complete",
        .cancelled = "Cancelled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .awaiting_quorum => "AwaitingQuorum",
            .pending => "Pending",
            .in_use => "InUse",
            .complete => "Complete",
            .cancelled => "Cancelled",
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
