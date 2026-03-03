const std = @import("std");

pub const EventType = enum {
    send,
    reject,
    bounce,
    complaint,
    delivery,
    open,
    click,
    rendering_failure,

    pub const json_field_names = .{
        .send = "send",
        .reject = "reject",
        .bounce = "bounce",
        .complaint = "complaint",
        .delivery = "delivery",
        .open = "open",
        .click = "click",
        .rendering_failure = "renderingFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send => "send",
            .reject => "reject",
            .bounce => "bounce",
            .complaint => "complaint",
            .delivery => "delivery",
            .open => "open",
            .click => "click",
            .rendering_failure => "renderingFailure",
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
