const std = @import("std");

/// Represents the validation state of an association.
pub const ValidationStatus = enum {
    /// The association has been validated and is functioning correctly.
    valid,
    /// The association has failed validation and requires attention.
    invalid,
    /// The association is awaiting user confirmation before validation can be
    /// completed.
    pending_confirmation,

    pub const json_field_names = .{
        .valid = "valid",
        .invalid = "invalid",
        .pending_confirmation = "pending-confirmation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid => "valid",
            .invalid => "invalid",
            .pending_confirmation => "pending-confirmation",
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
