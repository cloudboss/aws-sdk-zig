const JsonFormatRef = @import("json_format_ref.zig").JsonFormatRef;

/// An object that represents the format for the logs.
pub const LoggingFormat = union(enum) {
    json: ?[]const JsonFormatRef,
    text: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
        .text = "text",
    };
};
