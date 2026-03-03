const std = @import("std");

pub const ContactInitiationMethod = enum {
    inbound,
    outbound,
    transfer,
    queue_transfer,
    callback,
    api,
    disconnect,
    monitor,
    external_outbound,
    webrtc_api,
    agent_reply,
    flow,

    pub const json_field_names = .{
        .inbound = "INBOUND",
        .outbound = "OUTBOUND",
        .transfer = "TRANSFER",
        .queue_transfer = "QUEUE_TRANSFER",
        .callback = "CALLBACK",
        .api = "API",
        .disconnect = "DISCONNECT",
        .monitor = "MONITOR",
        .external_outbound = "EXTERNAL_OUTBOUND",
        .webrtc_api = "WEBRTC_API",
        .agent_reply = "AGENT_REPLY",
        .flow = "FLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inbound => "INBOUND",
            .outbound => "OUTBOUND",
            .transfer => "TRANSFER",
            .queue_transfer => "QUEUE_TRANSFER",
            .callback => "CALLBACK",
            .api => "API",
            .disconnect => "DISCONNECT",
            .monitor => "MONITOR",
            .external_outbound => "EXTERNAL_OUTBOUND",
            .webrtc_api => "WEBRTC_API",
            .agent_reply => "AGENT_REPLY",
            .flow => "FLOW",
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
