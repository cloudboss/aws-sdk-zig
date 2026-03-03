const std = @import("std");

pub const InstanceAttributeType = enum {
    inbound_calls,
    outbound_calls,
    contactflow_logs,
    contact_lens,
    auto_resolve_best_voices,
    use_custom_tts_voices,
    early_media,
    multi_party_conference,
    high_volume_outbound,
    enhanced_contact_monitoring,
    enhanced_chat_monitoring,
    multi_party_chat_conference,
    message_streaming,

    pub const json_field_names = .{
        .inbound_calls = "INBOUND_CALLS",
        .outbound_calls = "OUTBOUND_CALLS",
        .contactflow_logs = "CONTACTFLOW_LOGS",
        .contact_lens = "CONTACT_LENS",
        .auto_resolve_best_voices = "AUTO_RESOLVE_BEST_VOICES",
        .use_custom_tts_voices = "USE_CUSTOM_TTS_VOICES",
        .early_media = "EARLY_MEDIA",
        .multi_party_conference = "MULTI_PARTY_CONFERENCE",
        .high_volume_outbound = "HIGH_VOLUME_OUTBOUND",
        .enhanced_contact_monitoring = "ENHANCED_CONTACT_MONITORING",
        .enhanced_chat_monitoring = "ENHANCED_CHAT_MONITORING",
        .multi_party_chat_conference = "MULTI_PARTY_CHAT_CONFERENCE",
        .message_streaming = "MESSAGE_STREAMING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inbound_calls => "INBOUND_CALLS",
            .outbound_calls => "OUTBOUND_CALLS",
            .contactflow_logs => "CONTACTFLOW_LOGS",
            .contact_lens => "CONTACT_LENS",
            .auto_resolve_best_voices => "AUTO_RESOLVE_BEST_VOICES",
            .use_custom_tts_voices => "USE_CUSTOM_TTS_VOICES",
            .early_media => "EARLY_MEDIA",
            .multi_party_conference => "MULTI_PARTY_CONFERENCE",
            .high_volume_outbound => "HIGH_VOLUME_OUTBOUND",
            .enhanced_contact_monitoring => "ENHANCED_CONTACT_MONITORING",
            .enhanced_chat_monitoring => "ENHANCED_CHAT_MONITORING",
            .multi_party_chat_conference => "MULTI_PARTY_CHAT_CONFERENCE",
            .message_streaming => "MESSAGE_STREAMING",
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
