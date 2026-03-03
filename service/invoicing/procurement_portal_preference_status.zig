const std = @import("std");

pub const ProcurementPortalPreferenceStatus = enum {
    pending_verification,
    test_initialized,
    test_initialization_failed,
    test_failed,
    active,
    suspended,

    pub const json_field_names = .{
        .pending_verification = "PENDING_VERIFICATION",
        .test_initialized = "TEST_INITIALIZED",
        .test_initialization_failed = "TEST_INITIALIZATION_FAILED",
        .test_failed = "TEST_FAILED",
        .active = "ACTIVE",
        .suspended = "SUSPENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_verification => "PENDING_VERIFICATION",
            .test_initialized => "TEST_INITIALIZED",
            .test_initialization_failed => "TEST_INITIALIZATION_FAILED",
            .test_failed => "TEST_FAILED",
            .active => "ACTIVE",
            .suspended => "SUSPENDED",
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
