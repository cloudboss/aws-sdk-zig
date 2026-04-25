const std = @import("std");

pub const ServiceQuotaExceededExceptionReason = enum {
    limit_exceeded_number_of_email,
    limit_exceeded_number_of_domain,
    limit_exceeded_number_of_connection_invitation_per_day,
    limit_exceeded_number_of_active_connection,
    limit_exceeded_number_of_open_connection_invitation,

    pub const json_field_names = .{
        .limit_exceeded_number_of_email = "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
        .limit_exceeded_number_of_domain = "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
        .limit_exceeded_number_of_connection_invitation_per_day = "LIMIT_EXCEEDED_NUMBER_OF_CONNECTION_INVITATION_PER_DAY",
        .limit_exceeded_number_of_active_connection = "LIMIT_EXCEEDED_NUMBER_OF_ACTIVE_CONNECTION",
        .limit_exceeded_number_of_open_connection_invitation = "LIMIT_EXCEEDED_NUMBER_OF_OPEN_CONNECTION_INVITATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .limit_exceeded_number_of_email => "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
            .limit_exceeded_number_of_domain => "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
            .limit_exceeded_number_of_connection_invitation_per_day => "LIMIT_EXCEEDED_NUMBER_OF_CONNECTION_INVITATION_PER_DAY",
            .limit_exceeded_number_of_active_connection => "LIMIT_EXCEEDED_NUMBER_OF_ACTIVE_CONNECTION",
            .limit_exceeded_number_of_open_connection_invitation => "LIMIT_EXCEEDED_NUMBER_OF_OPEN_CONNECTION_INVITATION",
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
