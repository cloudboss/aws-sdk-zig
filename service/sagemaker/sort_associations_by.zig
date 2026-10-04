const std = @import("std");

pub const SortAssociationsBy = enum {
    source_arn,
    destination_arn,
    source_type,
    destination_type,
    creation_time,

    pub const json_field_names = .{
        .source_arn = "SourceArn",
        .destination_arn = "DestinationArn",
        .source_type = "SourceType",
        .destination_type = "DestinationType",
        .creation_time = "CreationTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_arn => "SourceArn",
            .destination_arn => "DestinationArn",
            .source_type => "SourceType",
            .destination_type => "DestinationType",
            .creation_time => "CreationTime",
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
