const std = @import("std");

/// Indicates if the approver's MFA device is in-sync with the Identity Source
///
/// * `IN_SYNC`: The approver's MFA device is in-sync with the Identity Source
/// * `OUT_OF_SYNC`: The approver's MFA device is out-of-sync with the Identity
///   Source
pub const MfaSyncStatus = enum {
    in_sync,
    out_of_sync,

    pub const json_field_names = .{
        .in_sync = "IN_SYNC",
        .out_of_sync = "OUT_OF_SYNC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_sync => "IN_SYNC",
            .out_of_sync => "OUT_OF_SYNC",
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
