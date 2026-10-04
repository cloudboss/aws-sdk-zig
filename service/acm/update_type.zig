const std = @import("std");

/// The type of certificate update. Valid values:
///
/// * `DOMAIN_VALIDATION_METHOD` – A change to the domain validation method for
///   the certificate.
pub const UpdateType = enum {
    domain_validation_method,

    pub const json_field_names = .{
        .domain_validation_method = "DOMAIN_VALIDATION_METHOD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .domain_validation_method => "DOMAIN_VALIDATION_METHOD",
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
