const std = @import("std");

/// The type of action to perform on the address. The following are possible
/// values:
///
/// * PUT: add the addresses to the suppression list.
///
/// * DELETE: remove the address from the suppression list.
pub const SuppressionListImportAction = enum {
    delete,
    put,

    pub const json_field_names = .{
        .delete = "DELETE",
        .put = "PUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete => "DELETE",
            .put => "PUT",
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
