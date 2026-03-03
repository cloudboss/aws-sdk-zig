const std = @import("std");

pub const ConflictType = enum {
    another_active_stream,
    domain_not_active,
    cannot_change_speaker_after_enrollment,
    enrollment_already_exists,
    speaker_not_set,
    speaker_opted_out,
    concurrent_changes,
    domain_locked_from_encryption_updates,
    cannot_delete_non_empty_watchlist,
    fraudster_must_belong_to_at_least_one_watchlist,

    pub const json_field_names = .{
        .another_active_stream = "ANOTHER_ACTIVE_STREAM",
        .domain_not_active = "DOMAIN_NOT_ACTIVE",
        .cannot_change_speaker_after_enrollment = "CANNOT_CHANGE_SPEAKER_AFTER_ENROLLMENT",
        .enrollment_already_exists = "ENROLLMENT_ALREADY_EXISTS",
        .speaker_not_set = "SPEAKER_NOT_SET",
        .speaker_opted_out = "SPEAKER_OPTED_OUT",
        .concurrent_changes = "CONCURRENT_CHANGES",
        .domain_locked_from_encryption_updates = "DOMAIN_LOCKED_FROM_ENCRYPTION_UPDATES",
        .cannot_delete_non_empty_watchlist = "CANNOT_DELETE_NON_EMPTY_WATCHLIST",
        .fraudster_must_belong_to_at_least_one_watchlist = "FRAUDSTER_MUST_BELONG_TO_AT_LEAST_ONE_WATCHLIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .another_active_stream => "ANOTHER_ACTIVE_STREAM",
            .domain_not_active => "DOMAIN_NOT_ACTIVE",
            .cannot_change_speaker_after_enrollment => "CANNOT_CHANGE_SPEAKER_AFTER_ENROLLMENT",
            .enrollment_already_exists => "ENROLLMENT_ALREADY_EXISTS",
            .speaker_not_set => "SPEAKER_NOT_SET",
            .speaker_opted_out => "SPEAKER_OPTED_OUT",
            .concurrent_changes => "CONCURRENT_CHANGES",
            .domain_locked_from_encryption_updates => "DOMAIN_LOCKED_FROM_ENCRYPTION_UPDATES",
            .cannot_delete_non_empty_watchlist => "CANNOT_DELETE_NON_EMPTY_WATCHLIST",
            .fraudster_must_belong_to_at_least_one_watchlist => "FRAUDSTER_MUST_BELONG_TO_AT_LEAST_ONE_WATCHLIST",
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
