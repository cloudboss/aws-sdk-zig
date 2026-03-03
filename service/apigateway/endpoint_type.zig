const std = @import("std");

/// The endpoint type. The valid values are `EDGE` for edge-optimized API setup,
/// most suitable for mobile applications; `REGIONAL` for regional API endpoint
/// setup, most suitable for calling from AWS Region; and `PRIVATE` for private
/// APIs.
pub const EndpointType = enum {
    regional,
    edge,
    private,

    pub const json_field_names = .{
        .regional = "REGIONAL",
        .edge = "EDGE",
        .private = "PRIVATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .regional => "REGIONAL",
            .edge => "EDGE",
            .private => "PRIVATE",
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
