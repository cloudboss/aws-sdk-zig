const std = @import("std");

pub const ValidationExceptionReason = enum {
    ca_cert_validity_too_short,
    invalid_ca_usage_mode,
    invalid_connector_type,
    invalid_state,
    no_client_token,
    unknown_operation,
    other,

    pub const json_field_names = .{
        .ca_cert_validity_too_short = "CA_CERT_VALIDITY_TOO_SHORT",
        .invalid_ca_usage_mode = "INVALID_CA_USAGE_MODE",
        .invalid_connector_type = "INVALID_CONNECTOR_TYPE",
        .invalid_state = "INVALID_STATE",
        .no_client_token = "NO_CLIENT_TOKEN",
        .unknown_operation = "UNKNOWN_OPERATION",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ca_cert_validity_too_short => "CA_CERT_VALIDITY_TOO_SHORT",
            .invalid_ca_usage_mode => "INVALID_CA_USAGE_MODE",
            .invalid_connector_type => "INVALID_CONNECTOR_TYPE",
            .invalid_state => "INVALID_STATE",
            .no_client_token => "NO_CLIENT_TOKEN",
            .unknown_operation => "UNKNOWN_OPERATION",
            .other => "OTHER",
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
