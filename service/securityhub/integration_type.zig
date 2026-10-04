const std = @import("std");

pub const IntegrationType = enum {
    send_findings_to_security_hub,
    receive_findings_from_security_hub,
    update_findings_in_security_hub,

    pub const json_field_names = .{
        .send_findings_to_security_hub = "SEND_FINDINGS_TO_SECURITY_HUB",
        .receive_findings_from_security_hub = "RECEIVE_FINDINGS_FROM_SECURITY_HUB",
        .update_findings_in_security_hub = "UPDATE_FINDINGS_IN_SECURITY_HUB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send_findings_to_security_hub => "SEND_FINDINGS_TO_SECURITY_HUB",
            .receive_findings_from_security_hub => "RECEIVE_FINDINGS_FROM_SECURITY_HUB",
            .update_findings_in_security_hub => "UPDATE_FINDINGS_IN_SECURITY_HUB",
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
