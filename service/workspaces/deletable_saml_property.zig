const std = @import("std");

pub const DeletableSamlProperty = enum {
    saml_properties_user_access_url,
    saml_properties_relay_state_parameter_name,

    pub const json_field_names = .{
        .saml_properties_user_access_url = "SAML_PROPERTIES_USER_ACCESS_URL",
        .saml_properties_relay_state_parameter_name = "SAML_PROPERTIES_RELAY_STATE_PARAMETER_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .saml_properties_user_access_url => "SAML_PROPERTIES_USER_ACCESS_URL",
            .saml_properties_relay_state_parameter_name => "SAML_PROPERTIES_RELAY_STATE_PARAMETER_NAME",
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
