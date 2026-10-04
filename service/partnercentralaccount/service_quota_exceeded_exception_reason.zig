const std = @import("std");

pub const ServiceQuotaExceededExceptionReason = enum {
    limit_exceeded_number_of_email,
    limit_exceeded_number_of_domain,
    limit_exceeded_number_of_connection_invitation_per_day,
    limit_exceeded_number_of_active_connection,
    limit_exceeded_number_of_open_connection_invitation,
    limit_exceeded_number_of_profile_update_per_day,
    limit_exceeded_number_of_profile_visibility_update_per_day,

    pub const json_field_names = .{
        .limit_exceeded_number_of_email = "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
        .limit_exceeded_number_of_domain = "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
        .limit_exceeded_number_of_connection_invitation_per_day = "LIMIT_EXCEEDED_NUMBER_OF_CONNECTION_INVITATION_PER_DAY",
        .limit_exceeded_number_of_active_connection = "LIMIT_EXCEEDED_NUMBER_OF_ACTIVE_CONNECTION",
        .limit_exceeded_number_of_open_connection_invitation = "LIMIT_EXCEEDED_NUMBER_OF_OPEN_CONNECTION_INVITATION",
        .limit_exceeded_number_of_profile_update_per_day = "LIMIT_EXCEEDED_NUMBER_OF_PROFILE_UPDATE_PER_DAY",
        .limit_exceeded_number_of_profile_visibility_update_per_day = "LIMIT_EXCEEDED_NUMBER_OF_PROFILE_VISIBILITY_UPDATE_PER_DAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .limit_exceeded_number_of_email => "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
            .limit_exceeded_number_of_domain => "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
            .limit_exceeded_number_of_connection_invitation_per_day => "LIMIT_EXCEEDED_NUMBER_OF_CONNECTION_INVITATION_PER_DAY",
            .limit_exceeded_number_of_active_connection => "LIMIT_EXCEEDED_NUMBER_OF_ACTIVE_CONNECTION",
            .limit_exceeded_number_of_open_connection_invitation => "LIMIT_EXCEEDED_NUMBER_OF_OPEN_CONNECTION_INVITATION",
            .limit_exceeded_number_of_profile_update_per_day => "LIMIT_EXCEEDED_NUMBER_OF_PROFILE_UPDATE_PER_DAY",
            .limit_exceeded_number_of_profile_visibility_update_per_day => "LIMIT_EXCEEDED_NUMBER_OF_PROFILE_VISIBILITY_UPDATE_PER_DAY",
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
