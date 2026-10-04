const std = @import("std");

/// The identity type of the requester that calls the API operation.
pub const UserIdentityType = enum {
    awsaccount,
    awsservice,

    pub const json_field_names = .{
        .awsaccount = "AWSACCOUNT",
        .awsservice = "AWSSERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .awsaccount => "AWSACCOUNT",
            .awsservice => "AWSSERVICE",
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
