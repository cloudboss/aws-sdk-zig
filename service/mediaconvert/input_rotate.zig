const std = @import("std");

/// Use Rotate to specify how the service rotates your video. You can choose
/// automatic rotation or specify a rotation. You can specify a clockwise
/// rotation of 0, 90, 180, or 270 degrees. If your input video container is
/// .mov or .mp4 and your input has rotation metadata, you can choose Automatic
/// to have the service rotate your video according to the rotation specified in
/// the metadata. The rotation must be within one degree of 90, 180, or 270
/// degrees. If the rotation metadata specifies any other rotation, the service
/// will default to no rotation. By default, the service does no rotation, even
/// if your input video has rotation metadata. The service doesn't pass through
/// rotation metadata.
pub const InputRotate = enum {
    degree_0,
    degrees_90,
    degrees_180,
    degrees_270,
    auto,

    pub const json_field_names = .{
        .degree_0 = "DEGREE_0",
        .degrees_90 = "DEGREES_90",
        .degrees_180 = "DEGREES_180",
        .degrees_270 = "DEGREES_270",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .degree_0 => "DEGREE_0",
            .degrees_90 => "DEGREES_90",
            .degrees_180 => "DEGREES_180",
            .degrees_270 => "DEGREES_270",
            .auto => "AUTO",
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
