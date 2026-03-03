const std = @import("std");

pub const RouteMatrixErrorCode = enum {
    no_match,
    no_match_destination,
    no_match_origin,
    no_route,
    out_of_bounds,
    out_of_bounds_destination,
    out_of_bounds_origin,
    other,
    violation,

    pub const json_field_names = .{
        .no_match = "NoMatch",
        .no_match_destination = "NoMatchDestination",
        .no_match_origin = "NoMatchOrigin",
        .no_route = "NoRoute",
        .out_of_bounds = "OutOfBounds",
        .out_of_bounds_destination = "OutOfBoundsDestination",
        .out_of_bounds_origin = "OutOfBoundsOrigin",
        .other = "Other",
        .violation = "Violation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_match => "NoMatch",
            .no_match_destination => "NoMatchDestination",
            .no_match_origin => "NoMatchOrigin",
            .no_route => "NoRoute",
            .out_of_bounds => "OutOfBounds",
            .out_of_bounds_destination => "OutOfBoundsDestination",
            .out_of_bounds_origin => "OutOfBoundsOrigin",
            .other => "Other",
            .violation => "Violation",
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
