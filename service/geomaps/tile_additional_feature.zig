const std = @import("std");

pub const TileAdditionalFeature = enum {
    /// Map elevation contour lines.
    contour_lines,
    /// Map hillshading details for shading elevation changes.
    hillshade,
    /// Map logistics details, including advanced pois and road networks.
    logistics,
    /// Map transit details.
    transit,

    pub const json_field_names = .{
        .contour_lines = "ContourLines",
        .hillshade = "Hillshade",
        .logistics = "Logistics",
        .transit = "Transit",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contour_lines => "ContourLines",
            .hillshade => "Hillshade",
            .logistics => "Logistics",
            .transit => "Transit",
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
