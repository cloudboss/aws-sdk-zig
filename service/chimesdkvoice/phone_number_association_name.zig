const std = @import("std");

pub const PhoneNumberAssociationName = enum {
    voice_connector_id,
    voice_connector_group_id,
    sip_rule_id,

    pub const json_field_names = .{
        .voice_connector_id = "VoiceConnectorId",
        .voice_connector_group_id = "VoiceConnectorGroupId",
        .sip_rule_id = "SipRuleId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .voice_connector_id => "VoiceConnectorId",
            .voice_connector_group_id => "VoiceConnectorGroupId",
            .sip_rule_id => "SipRuleId",
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
