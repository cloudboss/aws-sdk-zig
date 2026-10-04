const std = @import("std");

/// The format of the S/MIME signature that's applied to a message. The
/// following value is
/// supported:
///
/// * `DETACHED` – The signature is carried in a separate MIME part
/// alongside the signed content.
pub const SignatureFormat = enum {
    detached,

    pub const json_field_names = .{
        .detached = "DETACHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .detached => "DETACHED",
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
