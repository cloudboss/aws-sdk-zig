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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
