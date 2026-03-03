const std = @import("std");

pub const ContactFlowType = enum {
    contact_flow,
    customer_queue,
    customer_hold,
    customer_whisper,
    agent_hold,
    agent_whisper,
    outbound_whisper,
    agent_transfer,
    queue_transfer,
    campaign,

    pub const json_field_names = .{
        .contact_flow = "CONTACT_FLOW",
        .customer_queue = "CUSTOMER_QUEUE",
        .customer_hold = "CUSTOMER_HOLD",
        .customer_whisper = "CUSTOMER_WHISPER",
        .agent_hold = "AGENT_HOLD",
        .agent_whisper = "AGENT_WHISPER",
        .outbound_whisper = "OUTBOUND_WHISPER",
        .agent_transfer = "AGENT_TRANSFER",
        .queue_transfer = "QUEUE_TRANSFER",
        .campaign = "CAMPAIGN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contact_flow => "CONTACT_FLOW",
            .customer_queue => "CUSTOMER_QUEUE",
            .customer_hold => "CUSTOMER_HOLD",
            .customer_whisper => "CUSTOMER_WHISPER",
            .agent_hold => "AGENT_HOLD",
            .agent_whisper => "AGENT_WHISPER",
            .outbound_whisper => "OUTBOUND_WHISPER",
            .agent_transfer => "AGENT_TRANSFER",
            .queue_transfer => "QUEUE_TRANSFER",
            .campaign => "CAMPAIGN",
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
