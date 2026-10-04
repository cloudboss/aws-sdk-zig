const std = @import("std");

pub const ShareResourceType = enum {
    /// The share is on a variant store
    variant_store,
    /// The share is on an annotation store
    annotation_store,
    /// The share is on a workflow
    workflow,

    pub const json_field_names = .{
        .variant_store = "VARIANT_STORE",
        .annotation_store = "ANNOTATION_STORE",
        .workflow = "WORKFLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .variant_store => "VARIANT_STORE",
            .annotation_store => "ANNOTATION_STORE",
            .workflow => "WORKFLOW",
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
