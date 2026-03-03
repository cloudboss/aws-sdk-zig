const std = @import("std");

pub const PageBasedWarningCode = enum {
    inferencing_plaintext_with_native_trained_model,
    inferencing_native_document_with_plaintext_trained_model,

    pub const json_field_names = .{
        .inferencing_plaintext_with_native_trained_model = "INFERENCING_PLAINTEXT_WITH_NATIVE_TRAINED_MODEL",
        .inferencing_native_document_with_plaintext_trained_model = "INFERENCING_NATIVE_DOCUMENT_WITH_PLAINTEXT_TRAINED_MODEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inferencing_plaintext_with_native_trained_model => "INFERENCING_PLAINTEXT_WITH_NATIVE_TRAINED_MODEL",
            .inferencing_native_document_with_plaintext_trained_model => "INFERENCING_NATIVE_DOCUMENT_WITH_PLAINTEXT_TRAINED_MODEL",
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
