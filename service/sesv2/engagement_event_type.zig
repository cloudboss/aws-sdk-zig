const std = @import("std");

/// The type of delivery events:
///
/// * `OPEN` - Open event for emails including open trackers.
/// Excludes opens for emails addressed to more than one recipient.
///
/// * `CLICK` - Click event for emails including wrapped links.
/// Excludes clicks for emails addressed to more than one recipient.
pub const EngagementEventType = enum {
    open,
    click,

    pub const json_field_names = .{
        .open = "OPEN",
        .click = "CLICK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open => "OPEN",
            .click => "CLICK",
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
