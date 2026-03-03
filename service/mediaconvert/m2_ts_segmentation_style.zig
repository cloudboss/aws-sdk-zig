const std = @import("std");

/// The segmentation style parameter controls how segmentation markers are
/// inserted into the transport stream. With avails, it is possible that
/// segments may be truncated, which can influence where future segmentation
/// markers are inserted. When a segmentation style of "reset_cadence" is
/// selected and a segment is truncated due to an avail, we will reset the
/// segmentation cadence. This means the subsequent segment will have a duration
/// of of $segmentation_time seconds. When a segmentation style of
/// "maintain_cadence" is selected and a segment is truncated due to an avail,
/// we will not reset the segmentation cadence. This means the subsequent
/// segment will likely be truncated as well. However, all segments after that
/// will have a duration of $segmentation_time seconds. Note that EBP lookahead
/// is a slight exception to this rule.
pub const M2tsSegmentationStyle = enum {
    maintain_cadence,
    reset_cadence,

    pub const json_field_names = .{
        .maintain_cadence = "MAINTAIN_CADENCE",
        .reset_cadence = "RESET_CADENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .maintain_cadence => "MAINTAIN_CADENCE",
            .reset_cadence => "RESET_CADENCE",
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
