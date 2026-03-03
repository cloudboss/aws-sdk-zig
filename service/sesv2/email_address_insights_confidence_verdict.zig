const std = @import("std");

/// The confidence level of SES that the email address meets the validation
/// criteria:
///
/// * `LOW` - Weak or no indication of the speciﬁc check (e.g., LOW for
///   IsRoleAddress means the email is less likely to be a role-based address).
///
/// * `MEDIUM` - Moderate indication of the speciﬁc check (e.g., MEDIUM for
///   IsDisposable means the email might be a disposable address).
///
/// * `HIGH` - Strong indication of the speciﬁc check (e.g., HIGH for
///   IsRandomInput means the email is very likely randomly generated).
pub const EmailAddressInsightsConfidenceVerdict = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
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
