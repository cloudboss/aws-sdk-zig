const std = @import("std");

pub const ScalingActivityStatusCode = enum {
    pending,
    in_progress,
    successful,
    overridden,
    unfulfilled,
    failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .successful = "Successful",
        .overridden = "Overridden",
        .unfulfilled = "Unfulfilled",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .in_progress => "InProgress",
            .successful => "Successful",
            .overridden => "Overridden",
            .unfulfilled => "Unfulfilled",
            .failed => "Failed",
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
