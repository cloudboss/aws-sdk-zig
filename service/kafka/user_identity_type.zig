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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
