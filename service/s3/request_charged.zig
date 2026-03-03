const std = @import("std");

/// If present, indicates that the requester was successfully charged for the
/// request. For more
/// information, see [Using Requester Pays buckets for storage transfers and
/// usage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html) in the *Amazon Simple
/// Storage Service user guide*.
///
/// This functionality is not supported for directory buckets.
pub const RequestCharged = enum {
    requester,

    pub const json_field_names = .{
        .requester = "requester",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requester => "requester",
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
