const std = @import("std");

/// The visibility status of a machine learning product. Valid values are:
///
/// * `Limited` - The product is available to a limited set of buyers.
///
/// * `Public` - The product is publicly available to all buyers.
///
/// * `Restricted` - The product has restricted availability.
///
/// * `Draft` - The product is in draft state and not yet available to buyers.
pub const MachineLearningProductVisibilityString = enum {
    limited,
    public,
    restricted,
    draft,

    pub const json_field_names = .{
        .limited = "Limited",
        .public = "Public",
        .restricted = "Restricted",
        .draft = "Draft",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .limited => "Limited",
            .public => "Public",
            .restricted => "Restricted",
            .draft => "Draft",
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
