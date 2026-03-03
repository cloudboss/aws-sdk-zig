const std = @import("std");

pub const PositionFiltering = enum {
    /// Filters device position updates according to their sample time
    time_based,
    /// Filters device position updates according to the distance between them
    distance_based,
    /// Filters device position updates according to their accuracy
    accuracy_based,

    pub const json_field_names = .{
        .time_based = "TimeBased",
        .distance_based = "DistanceBased",
        .accuracy_based = "AccuracyBased",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .time_based => "TimeBased",
            .distance_based => "DistanceBased",
            .accuracy_based => "AccuracyBased",
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
