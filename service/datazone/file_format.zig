const std = @import("std");

/// The file format for a notebook export in Amazon SageMaker Unified Studio.
pub const FileFormat = enum {
    /// Export the notebook as a PDF file.
    pdf,
    /// Export the notebook as a Jupyter notebook (.ipynb) file.
    ipynb,

    pub const json_field_names = .{
        .pdf = "PDF",
        .ipynb = "IPYNB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pdf => "PDF",
            .ipynb => "IPYNB",
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
