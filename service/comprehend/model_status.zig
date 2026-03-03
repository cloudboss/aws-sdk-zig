const std = @import("std");

pub const ModelStatus = enum {
    submitted,
    training,
    deleting,
    stop_requested,
    stopped,
    in_error,
    trained,
    trained_with_warning,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .training = "TRAINING",
        .deleting = "DELETING",
        .stop_requested = "STOP_REQUESTED",
        .stopped = "STOPPED",
        .in_error = "IN_ERROR",
        .trained = "TRAINED",
        .trained_with_warning = "TRAINED_WITH_WARNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .training => "TRAINING",
            .deleting => "DELETING",
            .stop_requested => "STOP_REQUESTED",
            .stopped => "STOPPED",
            .in_error => "IN_ERROR",
            .trained => "TRAINED",
            .trained_with_warning => "TRAINED_WITH_WARNING",
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
