const std = @import("std");

/// An email sending event type. For example, email sends, opens, and bounces
/// are all
/// email events.
pub const EventType = enum {
    send,
    reject,
    bounce,
    complaint,
    delivery,
    open,
    click,
    rendering_failure,
    delivery_delay,
    subscription,

    pub const json_field_names = .{
        .send = "SEND",
        .reject = "REJECT",
        .bounce = "BOUNCE",
        .complaint = "COMPLAINT",
        .delivery = "DELIVERY",
        .open = "OPEN",
        .click = "CLICK",
        .rendering_failure = "RENDERING_FAILURE",
        .delivery_delay = "DELIVERY_DELAY",
        .subscription = "SUBSCRIPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send => "SEND",
            .reject => "REJECT",
            .bounce => "BOUNCE",
            .complaint => "COMPLAINT",
            .delivery => "DELIVERY",
            .open => "OPEN",
            .click => "CLICK",
            .rendering_failure => "RENDERING_FAILURE",
            .delivery_delay => "DELIVERY_DELAY",
            .subscription => "SUBSCRIPTION",
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
