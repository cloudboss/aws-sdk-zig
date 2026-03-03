const std = @import("std");

/// The types of events that are sent to the event destination.
pub const EventType = enum {
    initiated_call,
    ringing,
    answered,
    completed_call,
    busy,
    failed,
    no_answer,

    pub const json_field_names = .{
        .initiated_call = "INITIATED_CALL",
        .ringing = "RINGING",
        .answered = "ANSWERED",
        .completed_call = "COMPLETED_CALL",
        .busy = "BUSY",
        .failed = "FAILED",
        .no_answer = "NO_ANSWER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiated_call => "INITIATED_CALL",
            .ringing => "RINGING",
            .answered => "ANSWERED",
            .completed_call => "COMPLETED_CALL",
            .busy => "BUSY",
            .failed => "FAILED",
            .no_answer => "NO_ANSWER",
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
